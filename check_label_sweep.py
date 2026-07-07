#!/usr/bin/env python3
"""Pre-push static sweep for LaTeX label problems in ACT4E vol1.

Reports, per CI build (devel / instructors / public):
  A) labels defined 2+ times  -> would trigger the 'multiple references' CI check
  B) unguarded references whose target is defined nowhere -> 'undefined reference'

Models what LaTeX actually compiles:
  - strips comments (preserving line numbers)
  - blanks verbatim/minted/lstlisting bodies (labels/refs there are examples)
  - blanks \iflabelexists / \iflabeldoesnotexist bodies (guarded refs never error)
  - resolves build conditionals \devel \instructors \showslides \codeexercises
    \notproposal \showproofs and \ifbool{<known>}{..}{..} per build booleans
  - expands label-generating macros \classlisting -> lst:X, \codeboilerplate -> ex:TestX
  - follows \subimport / \input from volumes/vol1/complete.tex

Known limitations (may cause rare false results): custom label/ref macros other
than those modeled; \ifbool on non-build booleans (both branches kept).
"""
import os, re
from collections import defaultdict
ROOT=os.path.dirname(os.path.abspath(__file__))

BUILDS={
 "devel":       dict(devel=1,notproposal=1,showslides=0,instructors=0,codeexercises=0,showproofs=0),
 "instructors": dict(devel=0,notproposal=0,showslides=1,instructors=1,codeexercises=1,showproofs=0),
 "public":      dict(devel=0,notproposal=0,showslides=0,instructors=0,codeexercises=0,showproofs=0),
}
COND=["devel","notproposal","showslides","instructors","codeexercises","showproofs"]

def strip_comments(text):
    out=[]
    for line in text.split("\n"):
        s=[];i=0
        while i<len(line):
            c=line[i]
            if c=="\\" and i+1<len(line): s.append(line[i:i+2]); i+=2; continue
            if c=="%": break
            s.append(c); i+=1
        out.append("".join(s))
    return "\n".join(out)

def find_group(text,pos):
    """text[pos]=='{'; return index just after matching '}'."""
    d=0
    for i in range(pos,len(text)):
        if text[i]=="{": d+=1
        elif text[i]=="}":
            d-=1
            if d==0: return i+1
    return len(text)

def blank_env(text):
    """Blank verbatim-like environment bodies, preserving newlines."""
    for env in ("minted","verbatim","lstlisting","Verbatim","comment"):
        pat=re.compile(r"\\begin\{"+env+r"\}(\[[^\]]*\])?\{?[^\n]*\n(.*?)\\end\{"+env+r"\}",re.DOTALL)
        def repl(m):
            return m.group(0).split("\n")[0]+"\n"+re.sub(r"[^\n]","",m.group(2))+"\\end{"+env+"}"
        text=pat.sub(repl,text)
    return text

def blank_guard_bodies(text):
    """Blank the rendered body of \\iflabelexists{X}{BODY} / \\iflabeldoesnotexist{X}{BODY}."""
    for mac in ("iflabelexists","iflabeldoesnotexist"):
        out=[]; i=0; n=len(text); needle="\\"+mac
        while i<n:
            j=text.find(needle,i)
            if j<0: out.append(text[i:]); break
            out.append(text[i:j]); k=j+len(needle)
            while k<n and text[k] in " \t": k+=1
            if k<n and text[k]=="{":
                g1=find_group(text,k)           # {X}
                p=g1
                while p<n and text[p] in " \t\n": p+=1
                if p<n and text[p]=="{":
                    g2=find_group(text,p)       # {BODY}
                    body=text[p+1:g2-1]
                    out.append(text[j:p+1]); out.append(re.sub(r"[^\n]","",body)); out.append("}")
                    i=g2; continue
            out.append(text[j:k]); i=k
        text="".join(out)
    return text

def preprocess(path):
    with open(path,encoding="utf-8",errors="replace") as f: raw=f.read()
    return blank_guard_bodies(blank_env(strip_comments(raw)))

CONDCALL=re.compile(r"\\("+"|".join(COND)+r")\s*\{")
IFBOOL=re.compile(r"\\ifbool\s*\{("+"|".join(COND)+r")\}\s*\{")
def suppression_profile(text, env):
    prof=bytearray(len(text)); i=0; depth=0; stack=[]; n=len(text)
    def supp(): return 1 if any(s for _,s in stack) else 0
    while i<n:
        mb=IFBOOL.match(text,i)
        if mb:
            name=mb.group(1); val=env.get(name,0)
            for k in range(i,mb.end()-1): prof[k]=supp()
            depth+=1; stack.append((depth,(not val))); prof[mb.end()-1]=supp()
            # after true-branch close, a false-branch may follow; mark via sentinel
            i=mb.end(); continue
        mc=CONDCALL.match(text,i)
        if mc:
            cond=mc.group(1); val=env.get(cond,0)
            for k in range(i,mc.end()-1): prof[k]=supp()
            depth+=1; stack.append((depth,(not val))); prof[mc.end()-1]=supp()
            i=mc.end(); continue
        c=text[i]
        if c=="\\" and i+1<n:
            prof[i]=supp(); prof[i+1]=supp(); i+=2; continue
        if c=="{": depth+=1; prof[i]=supp(); i+=1; continue
        if c=="}":
            prof[i]=supp()
            closed=stack and stack[-1][0]==depth
            if closed: was=stack.pop()
            depth-=1; i+=1
            # handle \ifbool false-branch: if a '{' immediately follows, it's the else-arg
            if closed:
                j=i
                while j<n and text[j] in " \t\n": j+=1
                if j<n and text[j]=="{":
                    depth+=1; stack.append((depth, (not was[1]))); # else active = opposite
                    for k in range(i,j+1): prof[k]=supp()
                    i=j+1
            continue
        prof[i]=supp(); i+=1
    return prof

RE_SUBIMPORT=re.compile(r"\\subimport\*?\{([^}]*)\}\{([^}]+)\}")
RE_INPUT=re.compile(r"\\(?:input|include)\{([^}]+)\}")
RE_LABEL=re.compile(r"\\label\{([^}]+)\}")
RE_CLASSLIST=re.compile(r"\\classlisting\{([^}]+)\}")
RE_CODEBP=re.compile(r"\\codeboilerplate\{([^}]+)\}")
REFC=["ref","cref","Cref","pageref","vref","autoref","nameref","eqref","secref","prettyref","chrefplus","partrefplus","refplus"]
RE_REF=re.compile(r"\\("+"|".join(REFC)+r")\{([^}]+)\}")
RE_CREFRANGE=re.compile(r"\\crefrange\{([^}]+)\}\{([^}]+)\}")
# arg-N label definers (handle nested braces via find_group)
ARGDEF=[("\\partfirstb",3),("\\datafilefig",3),("\\margindatafilefig",3),("\\equationsag",2)]

def argdef_labels(text,prof):
    res=[]
    for mac,argn in ARGDEF:
        i=0
        while True:
            j=text.find(mac,i)
            if j<0: break
            i=j+len(mac); k=i; grp=None; start=j
            ok=True
            for a in range(argn):
                while k<len(text) and text[k] in " \t\n": k+=1
                if k>=len(text) or text[k]!="{": ok=False; break
                e=find_group(text,k); grp=text[k+1:e-1]; k=e
            if ok and not prof[start]:
                res.append((grp.strip(), text.count("\n",0,start)+1))
    return res

def resolve_file(rel):
    p=os.path.join(ROOT,rel)
    for c in (p,p+".tex",p+".texi"):
        if os.path.isfile(c): return c
    return None

def analyze(env):
    seen=set(); order=[]
    def walk(ap):
        if not ap or ap in seen: return
        seen.add(ap); order.append(ap); cur=os.path.dirname(ap)
        text=preprocess(ap); prof=suppression_profile(text,env)
        for m in RE_SUBIMPORT.finditer(text):
            if prof[m.start()]: continue
            sub=os.path.normpath(os.path.join(cur,m.group(1),m.group(2)))
            for c in (sub,sub+".tex",sub+".texi"):
                if os.path.isfile(c): walk(c); break
        for m in RE_INPUT.finditer(text):
            if prof[m.start()]: continue
            arg=m.group(1).replace("\\rootdir",ROOT)
            for base in (os.path.normpath(os.path.join(cur,arg)),os.path.normpath(os.path.join(ROOT,arg))):
                f=None
                for c in (base,base+".tex",base+".texi"):
                    if os.path.isfile(c): f=c; break
                if f: walk(f); break
    walk(resolve_file("volumes/vol1/complete.tex"))
    defs=defaultdict(list); live=defaultdict(list)
    for ap in order:
        rel=os.path.relpath(ap,ROOT); text=preprocess(ap); prof=suppression_profile(text,env)
        for m in RE_LABEL.finditer(text):
            if not prof[m.start()]: defs[m.group(1).strip()].append((rel,text.count("\n",0,m.start())+1))
        for m in RE_CLASSLIST.finditer(text):
            if not prof[m.start()]: defs["lst:"+m.group(1).strip()].append((rel,text.count("\n",0,m.start())+1))
        for m in RE_CODEBP.finditer(text):
            if not prof[m.start()]: defs["ex:Test"+m.group(1).strip()].append((rel,text.count("\n",0,m.start())+1))
        for lbl,ln in argdef_labels(text,prof): defs[lbl].append((rel,ln))
        for m in RE_REF.finditer(text):
            if prof[m.start()]: continue
            ln=text.count("\n",0,m.start())+1
            for t in m.group(2).split(","):
                t=t.strip()
                if t: live[t].append((rel,ln,m.group(1)))
        for m in RE_CREFRANGE.finditer(text):
            if prof[m.start()]: continue
            ln=text.count("\n",0,m.start())+1
            for t in (m.group(1),m.group(2)): live[t.strip()].append((rel,ln,"crefrange"))
        for m in RE_CODEBP.finditer(text):
            if prof[m.start()]: continue
            live["lst:"+m.group(1).strip()].append((rel,text.count("\n",0,m.start())+1,"codeboilerplate"))
    return order,defs,live

total=0
for name,env in BUILDS.items():
    order,defs,live=analyze(env); ds=set(defs)
    dups={k:v for k,v in defs.items() if len(v)>1}
    undef={k:v for k,v in live.items() if k not in ds}
    total+=len(dups)+len(undef)
    print("#"*66); print("# BUILD:",name,"(files %d, labels %d)"%(len(order),len(ds))); print("#"*66)
    print("  DUPLICATE LABELS:",len(dups))
    for lbl in sorted(dups):
        print("   !! "+lbl); [print("        "+fp+":"+str(ln)) for fp,ln in dups[lbl]]
    print("  UNDEFINED REFS:",len(undef))
    for lbl in sorted(undef):
        cs=sorted(set(c for _,_,c in undef[lbl]))
        print("   !! "+lbl+"  (via "+", ".join("\\"+c for c in cs)+")  @ "+"; ".join(fp+":"+str(ln) for fp,ln,_ in undef[lbl][:3]))
    print()
print("TOTAL problems across builds:",total)
