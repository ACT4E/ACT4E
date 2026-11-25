"""Brute-force checks for the note 'Co-design queries and the Kleisli category of the upper set monad'
(codesign-queries-upper-set-monad.tex).

Usage: python3 codesign-queries-upper-set-monad-check.py [seed] [number of random instances per test]

Everything is checked on randomly generated small finite preorders (not necessarily posets),
with elements represented as tuples so that the strict ("tuple") monoidal product is tuple concatenation.
"""
import itertools, random, sys

random.seed(int(sys.argv[1]) if len(sys.argv) > 1 else 0)

# ---------------------------------------------------------------- preorders
class Pre:
    """A finite preorder. elems: list of hashables; le: set of pairs (x,y) meaning x <= y."""
    def __init__(self, elems, le, width=None):
        self.elems = list(elems)
        self.le = set(le)
        self.width = width  # length of the tuples (for tuple preorders)
    def leq(self, x, y):
        return (x, y) in self.le
    def is_poset(self):
        return all(not (self.leq(x, y) and self.leq(y, x)) or x == y for x in self.elems for y in self.elems)
    def up(self, X):
        return frozenset(y for y in self.elems if any(self.leq(x, y) for x in X))
    def down(self, X):
        return frozenset(y for y in self.elems if any(self.leq(y, x) for x in X))
    def is_upper(self, S):
        return self.up(S) == frozenset(S)
    def uppersets(self):
        if not hasattr(self, "_U"):
            res = set()
            for r in range(len(self.elems) + 1):
                for X in itertools.combinations(self.elems, r):
                    res.add(self.up(X))
            self._U = sorted(res, key=lambda s: (len(s), sorted(map(repr, s))))
        return self._U
    def lowersets(self):
        res = set()
        for r in range(len(self.elems) + 1):
            for X in itertools.combinations(self.elems, r):
                res.add(self.down(X))
        return sorted(res, key=lambda s: (len(s), sorted(map(repr, s))))
    def Min(self, X):
        X = set(X)
        return frozenset(x for x in X if all((not self.leq(y, x)) or self.leq(x, y) for y in X))
    def is_antichain(self, A):
        return all(x == y or not self.leq(x, y) for x in A for y in A)
    def op(self):
        return Pre(self.elems, {(y, x) for (x, y) in self.le}, self.width)

def closure(elems, rel):
    le = {(x, x) for x in elems} | set(rel)
    changed = True
    while changed:
        changed = False
        for (a, b) in list(le):
            for (c, d) in list(le):
                if b == c and (a, d) not in le:
                    le.add((a, d)); changed = True
    return le

def rand_pre(n, name, p=0.3, poset=False):
    """random preorder on 1-tuples (name, i)"""
    elems = [((name, i),) for i in range(n)]
    if poset:
        rel = {(elems[i], elems[j]) for i in range(n) for j in range(i + 1, n) if random.random() < p}
    else:
        rel = {(x, y) for x in elems for y in elems if random.random() < p * 0.6}
    return Pre(elems, closure(elems, rel), 1)

UNIT = Pre([()], {((), ())}, 0)

def tensor(P, Q):
    elems = [a + b for a in P.elems for b in Q.elems]
    le = {(a + b, a2 + b2) for a in P.elems for b in Q.elems for a2 in P.elems for b2 in Q.elems
          if P.leq(a, a2) and Q.leq(b, b2)}
    return Pre(elems, le, P.width + Q.width)

def UPre(P):
    """(U P, reverse inclusion)"""
    U = P.uppersets()
    return Pre(U, {(S, T) for S in U for T in U if S >= T})

def LPre(P):
    L = P.lowersets()
    return Pre(L, {(S, T) for S in L for T in L if S <= T})

# ---------------------------------------------------------------- relations
def is_monrel(P, Q, M):
    for (p, q) in M:
        for p2 in P.elems:
            if P.leq(p2, p) and (p2, q) not in M: return False
        for q2 in Q.elems:
            if Q.leq(q, q2) and (p, q2) not in M: return False
    return True

def rand_monrel(P, Q, dens=0.25):
    R = {(p, q) for p in P.elems for q in Q.elems if random.random() < dens}
    M = frozenset((p2, q2) for (p, q) in R for p2 in P.elems for q2 in Q.elems if P.leq(p2, p) and Q.leq(q, q2))
    assert is_monrel(P, Q, M)
    return M

def comp(M, N):
    return frozenset((a, c) for (a, b) in M for (b2, c) in N if b == b2)

def ident(P):
    return frozenset(P.le)

def companion(P, Q, f):
    return frozenset((p, q) for p in P.elems for q in Q.elems if Q.leq(f[p], q))

def rtensor(M, N):
    return frozenset((a + c, b + d) for (a, b) in M for (c, d) in N)

def braid(P, Q):
    return frozenset((a + b, b2 + a2) for a in P.elems for b in Q.elems for a2 in P.elems for b2 in Q.elems
                     if P.leq(a, a2) and Q.leq(b, b2))

def trace(A, B, C, M):
    return frozenset((a, b) for a in A.elems for b in B.elems if any((a + c, b + c) in M for c in C.elems))

def trace_leq(A, B, C, M):
    return frozenset((a, b) for a in A.elems for b in B.elems
                     if any((a + c, b + c2) in M and C.leq(c2, c) for c in C.elems for c2 in C.elems))

# ---------------------------------------------------------------- Kleisli side
def Phi(P, Q, M):
    return {p: frozenset(q for q in Q.elems if (p, q) in M) for p in P.elems}

def PhiInv(P, Q, f):
    return frozenset((p, q) for p in P.elems for q in f[p])

def is_kleisli(P, Q, f):
    return all(Q.is_upper(f[p]) for p in P.elems) and all(f[p] >= f[p2] for p in P.elems for p2 in P.elems if P.leq(p, p2))

def kcomp(f, g):
    return {p: frozenset().union(*[g[q] for q in f[p]]) for p in f}

def eta(P):
    return {p: P.up([p]) for p in P.elems}

def ktensor(f, g):
    return {a + c: frozenset(b + d for b in f[a] for d in g[c]) for a in f for c in g}

def ktrace(A, B, C, h):
    return {a: frozenset(b for b in B.elems if any((b + c) in h[a + c] for c in C.elems)) for a in A.elems}

# ---------------------------------------------------------------- tests
def test_monad():
    """monad laws for U on Pre, and Kleisli composition formula"""
    P = rand_pre(random.randint(1, 3), "p"); Q = rand_pre(random.randint(1, 3), "q"); R = rand_pre(random.randint(1, 2), "r")
    UP, UQ, UR = UPre(P), UPre(Q), UPre(R)
    assert UP.is_poset()
    # random monotone function f: P -> Q
    for _ in range(50):
        f = {p: random.choice(Q.elems) for p in P.elems}
        if all(Q.leq(f[a], f[b]) for (a, b) in P.le): break
    else:
        f = {p: Q.elems[0] for p in P.elems}
        if not all(Q.leq(f[a], f[b]) for (a, b) in P.le): return
    Uf = {S: Q.up([f[p] for p in S]) for S in UP.elems}
    assert all(UQ.leq(Uf[S], Uf[T]) for (S, T) in UP.le)            # Uf monotone
    e = eta(P)
    assert all(UP.leq(e[a], e[b]) for (a, b) in P.le)               # eta monotone
    assert all(Uf[e[p]] == eta(Q)[f[p]] for p in P.elems)           # eta natural
    UUP = UPre(UP)
    mu = {SS: frozenset().union(*SS) if SS else frozenset() for SS in UUP.elems}
    assert all(P.is_upper(mu[SS]) for SS in UUP.elems)
    assert all(UP.leq(mu[a], mu[b]) for (a, b) in UUP.le)           # mu monotone
    eU = eta(UP)
    assert all(mu[eU[S]] == S for S in UP.elems)                    # unit law 1
    Ue = {S: UP.up([e[p] for p in S]) for S in UP.elems}
    assert all(mu[Ue[S]] == S for S in UP.elems)                    # unit law 2
    # naturality of mu
    UUQ = UPre(UQ)
    muQ = {SS: frozenset().union(*SS) if SS else frozenset() for SS in UUQ.elems}
    UUf = {SS: UQ.up([Uf[S] for S in SS]) for SS in UUP.elems}
    assert all(muQ[UUf[SS]] == Uf[mu[SS]] for SS in UUP.elems)
    # associativity (only if small)
    if len(UUP.elems) <= 9:
        UUUP = UPre(UUP)
        muU = {X: frozenset().union(*X) if X else frozenset() for X in UUUP.elems}
        Umu = {X: UP.up([mu[SS] for SS in X]) for X in UUUP.elems}
        assert all(mu[muU[X]] == mu[Umu[X]] for X in UUUP.elems)
    # Kleisli composition = mu . Ug . f  equals the union formula
    M = rand_monrel(P, Q); N = rand_monrel(Q, R)
    fk, gk = Phi(P, Q, M), Phi(Q, R, N)
    assert is_kleisli(P, Q, fk) and is_kleisli(Q, R, gk)
    UURe = UPre(UR)
    muR = lambda SS: frozenset().union(*SS) if SS else frozenset()
    Ug = {S: UR.up([gk[q] for q in S]) for S in UQ.elems}
    assert all(muR(Ug[fk[p]]) == kcomp(fk, gk)[p] for p in P.elems)
    # free functor vs companion
    assert Phi(P, Q, companion(P, Q, f)) == {p: Q.up([f[p]]) for p in P.elems}

def test_iso():
    P = rand_pre(random.randint(1, 4), "p"); Q = rand_pre(random.randint(1, 4), "q"); R = rand_pre(random.randint(1, 4), "r")
    M = rand_monrel(P, Q); N = rand_monrel(Q, R)
    assert is_monrel(P, R, comp(M, N))
    assert comp(ident(P), M) == M == comp(M, ident(Q))
    assert Phi(P, R, comp(M, N)) == kcomp(Phi(P, Q, M), Phi(Q, R, N))
    assert Phi(P, P, ident(P)) == eta(P)
    assert PhiInv(P, Q, Phi(P, Q, M)) == M
    # all Kleisli maps P -> UQ come from monotone relations (bijection), for tiny cases
    if len(P.elems) <= 2 and len(Q.elems) <= 3:
        U = Q.uppersets()
        cnt_k = 0
        for vals in itertools.product(U, repeat=len(P.elems)):
            f = dict(zip(P.elems, vals))
            if is_kleisli(P, Q, f):
                cnt_k += 1
                assert is_monrel(P, Q, PhiInv(P, Q, f)) and Phi(P, Q, PhiInv(P, Q, f)) == f
        cnt_m = 0
        pairs = [(p, q) for p in P.elems for q in Q.elems]
        for r in range(len(pairs) + 1):
            for X in itertools.combinations(pairs, r):
                if is_monrel(P, Q, frozenset(X)): cnt_m += 1
        assert cnt_k == cnt_m
    # dual: lower sets. Psi(M)(q) = {p | p M q}; contravariant
    def Psi(P, Q, M): return {q: frozenset(p for p in P.elems if (p, q) in M) for q in Q.elems}
    gM, gN = Psi(P, Q, M), Psi(Q, R, N)
    assert all(P.down(gM[q]) == gM[q] for q in Q.elems)
    assert all(gM[q] <= gM[q2] for (q, q2) in Q.le)
    assert Psi(P, R, comp(M, N)) == kcomp(gN, gM)
    assert Psi(P, P, ident(P)) == {p: P.down([p]) for p in P.elems}

def test_monoidal():
    A = rand_pre(random.randint(1, 3), "a"); B = rand_pre(random.randint(1, 3), "b")
    C = rand_pre(random.randint(1, 3), "c"); D = rand_pre(random.randint(1, 3), "d")
    A2 = rand_pre(random.randint(1, 2), "a2"); C2 = rand_pre(random.randint(1, 2), "c2")
    M = rand_monrel(A, B); N = rand_monrel(C, D); M2 = rand_monrel(B, A2); N2 = rand_monrel(D, C2)
    AC, BD = tensor(A, C), tensor(B, D)
    assert is_monrel(AC, BD, rtensor(M, N))
    assert rtensor(comp(M, M2), comp(N, N2)) == comp(rtensor(M, N), rtensor(M2, N2))      # interchange
    assert rtensor(ident(A), ident(C)) == ident(AC)
    assert rtensor(M, ident(UNIT)) == M == rtensor(ident(UNIT), M)                           # strict unit
    L = rand_monrel(A2, C2)
    assert rtensor(rtensor(M, N), L) == rtensor(M, rtensor(N, L))                            # strict assoc
    # braiding
    assert comp(rtensor(M, N), braid(B, D)) == comp(braid(A, C), rtensor(N, M))             # naturality
    assert comp(braid(A, C), braid(C, A)) == ident(AC)                                       # symmetry
    assert braid(A, tensor(B, C)) == comp(rtensor(braid(A, B), ident(C)), rtensor(ident(B), braid(A, C)))  # hexagon
    assert braid(A, UNIT) == ident(A)
    # Phi compatibility
    assert Phi(AC, BD, rtensor(M, N)) == ktensor(Phi(A, B, M), Phi(C, D, N))
    assert Phi(AC, tensor(C, A), braid(A, C)) == {a + c: tensor(C, A).up([c + a]) for a in A.elems for c in C.elems}
    # Kleisli side directly
    f, g, f2, g2 = Phi(A, B, M), Phi(C, D, N), Phi(B, A2, M2), Phi(D, C2, N2)
    assert ktensor(kcomp(f, f2), kcomp(g, g2)) == kcomp(ktensor(f, g), ktensor(f2, g2))
    assert ktensor(eta(A), eta(C)) == eta(AC)
    # product of upper sets, Min of products (posets and preorders)
    S = random.choice(A.uppersets()); T = random.choice(C.uppersets())
    ST = frozenset(a + c for a in S for c in T)
    assert AC.is_upper(ST)
    assert AC.Min(ST) == frozenset(a + c for a in A.Min(S) for c in C.Min(T))
    X = frozenset(random.sample(A.elems, random.randint(0, len(A.elems)))); Y = frozenset(random.sample(C.elems, random.randint(0, len(C.elems))))
    assert AC.up([a + c for a in X for c in Y]) == frozenset(a + c for a in A.up(X) for c in C.up(Y))
    # dual
    def Psi(P, Q, M): return {q: frozenset(p for p in P.elems if (p, q) in M) for q in Q.elems}
    assert Psi(AC, BD, rtensor(M, N)) == ktensor(Psi(A, B, M), Psi(C, D, N))

def test_trace():
    A = rand_pre(random.randint(1, 3), "a"); B = rand_pre(random.randint(1, 3), "b"); C = rand_pre(random.randint(1, 3), "c")
    AC, BC = tensor(A, C), tensor(B, C)
    M = rand_monrel(AC, BC, 0.2)
    T = trace(A, B, C, M)
    assert is_monrel(A, B, T)
    assert T == trace_leq(A, B, C, M)
    # naturality in A, B
    A2 = rand_pre(random.randint(1, 3), "a2"); B2 = rand_pre(random.randint(1, 3), "b2")
    N = rand_monrel(A2, A); N2 = rand_monrel(B, B2)
    assert trace(A2, B, C, comp(rtensor(N, ident(C)), M)) == comp(N, T)
    assert trace(A, B2, C, comp(M, rtensor(N2, ident(C)))) == comp(T, N2)
    # dinaturality for all morphisms
    C2 = rand_pre(random.randint(1, 3), "c2")
    Md = rand_monrel(AC, tensor(B, C2), 0.2); Nd = rand_monrel(C2, C, 0.35)
    assert trace(A, B, C, comp(Md, rtensor(ident(B), Nd))) == trace(A, B, C2, comp(rtensor(ident(A), Nd), Md))
    # vanishing I
    M1 = rand_monrel(A, B)
    assert trace(A, B, UNIT, M1) == M1
    # vanishing II
    D = rand_pre(random.randint(1, 2), "d")
    ACD, BCD = tensor(AC, D), tensor(BC, D)
    M3 = rand_monrel(ACD, BCD, 0.15)
    assert trace(A, B, C, trace(AC, BC, D, M3)) == trace(A, B, tensor(C, D), M3)
    # superposing
    E = rand_pre(random.randint(1, 2), "e"); F = rand_pre(random.randint(1, 2), "f")
    G = rand_monrel(E, F, 0.4)
    assert trace(tensor(E, A), tensor(F, B), C, rtensor(G, M)) == rtensor(G, T)
    # yanking
    assert trace(C, C, C, braid(C, C)) == ident(C)
    # Phi compatible with trace; Kleisli formula
    h = Phi(AC, BC, M)
    assert Phi(A, B, T) == ktrace(A, B, C, h)
    # dual
    def Psi(P, Q, M): return {q: frozenset(p for p in P.elems if (p, q) in M) for q in Q.elems}
    k = Psi(AC, BC, M)
    assert Psi(A, B, T) == {b: frozenset(a for a in A.elems if any((a + c) in k[b + c] for c in C.elems)) for b in B.elems}

def test_antichains():
    """antichain presentation on finite posets"""
    A = rand_pre(random.randint(1, 4), "a", poset=True); B = rand_pre(random.randint(1, 4), "b", poset=True)
    C = rand_pre(random.randint(1, 3), "c", poset=True)
    assert A.is_poset()
    # bijection upper sets <-> antichains
    U = A.uppersets()
    anti = [frozenset(X) for r in range(len(A.elems) + 1) for X in itertools.combinations(A.elems, r) if A.is_antichain(X)]
    assert len(U) == len(anti)
    assert sorted(map(sorted, (A.Min(S) for S in U))) == sorted(map(sorted, anti))
    assert all(A.up(A.Min(S)) == S for S in U) and all(A.Min(A.up(X)) == X for X in anti)
    X = frozenset(random.sample(A.elems, random.randint(0, len(A.elems))))
    assert A.Min(A.up(X)) == A.Min(X)
    # composition in antichain form
    M = rand_monrel(A, B); N = rand_monrel(B, C)
    f, g = Phi(A, B, M), Phi(B, C, N)
    h = {a: B.Min(f[a]) for a in A.elems}; k = {b: C.Min(g[b]) for b in B.elems}
    fg = kcomp(f, g)
    assert all(C.Min(fg[a]) == C.Min(frozenset().union(*[k[b] for b in h[a]])) for a in A.elems)
    # trace in antichain form
    AC, BC = tensor(A, C), tensor(B, C)
    Mt = rand_monrel(AC, BC, 0.2)
    ht = {x: BC.Min(s) for x, s in Phi(AC, BC, Mt).items()}
    Tk = ktrace(A, B, C, Phi(AC, BC, Mt))
    wB = B.width
    for a in A.elems:
        cand = {bc[:wB] for c in C.elems for bc in ht[a + c] if C.leq(bc[wB:], c)}
        assert B.Min(Tk[a]) == B.Min(cand)
        assert Tk[a] == B.up(cand)
        # exact fixed points on the antichains suffice (C well-founded)
        Xa = {bc[:wB] for c in C.elems for bc in ht[a + c] if bc[wB:] == c}
        assert Tk[a] == B.up(Xa) and B.Min(Tk[a]) == B.Min(Xa)
    # product in antichain form
    D = rand_pre(random.randint(1, 3), "d", poset=True)
    N2 = rand_monrel(C, D)
    k2 = {c: D.Min(s) for c, s in Phi(C, D, N2).items()}
    BD = tensor(B, D)
    prod = ktensor(f, Phi(C, D, N2))
    assert all(BD.Min(prod[a + c]) == frozenset(b + d for b in h[a] for d in k2[c]) for a in A.elems for c in C.elems)

def test_nonantisym():
    """in a preorder that is not a poset, upper closure is not injective on antichains"""
    P = Pre([("x",), ("y",)], closure([("x",), ("y",)], {(("x",), ("y",)), (("y",), ("x",))}), 1)
    assert P.is_antichain([("x",)]) and P.is_antichain([("y",)])
    assert P.up([("x",)]) == P.up([("y",)])


def examples():
    """the worked examples of the note (natural numbers are truncated to finite chains)"""

    def chain(n, name):  # {0..n-1} as 1-tuples (k,)
        el=[(k,) for k in range(n)]
        return Pre(el, {(x,y) for x in el for y in el if x[0]<=y[0]}, 1)

    # ---- Example: coins, then purse.  (truncated naturals)
    NA=10; NC=11; NW=120
    A=chain(NA,'a'); X=chain(NC,'x'); Y=chain(NC,'y'); W=chain(NW,'w')
    XY=tensor(X,Y)
    pay=frozenset((a,xy) for a in A.elems for xy in XY.elems if a[0] <= xy[0]+2*xy[1])
    purse=frozenset((xy,w) for xy in XY.elems for w in W.elems if 5*xy[0]+8*xy[1] <= w[0])
    assert is_monrel(A,XY,pay) and is_monrel(XY,W,purse)
    hp={a: XY.Min(s) for a,s in Phi(A,XY,pay).items()}
    print("h_pay(3) =", sorted(hp[(3,)]), " h_pay(4) =", sorted(hp[(4,)]))
    for a in range(0,9):
        exp={(a-2*j,j) for j in range(a//2+1)} | ({(0,(a+1)//2)} if a%2 else set())
        assert hp[(a,)]==frozenset(exp), (a, hp[(a,)])
    hw={xy: W.Min(s) for xy,s in Phi(XY,W,purse).items()}
    comp_h={a: W.Min(frozenset().union(*[hw[xy] for xy in hp[a]])) for a in A.elems}
    comp_direct={a: W.Min(s) for a,s in Phi(A,W,comp(pay,purse)).items()}
    for a in range(0,9):
        assert comp_h[(a,)]==comp_direct[(a,)]=={(4*a + (a%2),)}, (a, comp_h[(a,)])
    print("composite h(3) =", comp_h[(3,)], [5*x+8*y for (x,y) in sorted(hp[(3,)])])
    # parallel
    pp=ktensor(Phi(A,XY,pay),Phi(A,XY,pay))
    XYXY=tensor(XY,XY)
    m=XYXY.Min(pp[(3,2)])
    print("(h_pay x h_pay)(3;2) =", sorted(m), len(m))
    assert m==frozenset(u+v for u in hp[(3,)] for v in hp[(2,)])

    # ---- Example: battery modules (book): A=N, C={0..3}, B=unit; M={(a;c, c') : a+c <= 2c'}
    A=chain(9,'a'); C=chain(4,'c')
    AC=tensor(A,C)
    M=frozenset((ac,c2) for ac in AC.elems for c2 in C.elems if ac[0]+ac[1] <= 2*c2[0])
    assert is_monrel(AC,C,M)   # B (x) C = C
    T=trace(A,UNIT,C,M)
    print("modules: Tr =", sorted(a for (a,b) in T))
    assert T==frozenset((a,()) for a in A.elems if a[0]<=3)
    f=Phi(AC,C,M); h={x: C.Min(s) for x,s in f.items()}
    for a in range(9):
        for c in range(4):
            k=-(-(a+c)//2)
            assert h[(a,c)]==(frozenset({(k,)}) if k<=3 else frozenset())
    fix={a:[c for c in C.elems if c in h[a+c]] for a in A.elems}
    print("modules: exact fixed points c in h(a;c):", {a[0]:[c[0] for c in v] for a,v in fix.items()})

    # ---- Example: two kinds of modules. A=N payload, C=<{0..3},{0..3}>, B=<N,N> (price, co2)
    NP=12; NE=14
    A=chain(9,'a'); C1=chain(4,'c1'); C2=chain(4,'c2'); Pp=chain(NP,'p'); E=chain(NE,'e')
    C=tensor(C1,C2); B=tensor(Pp,E); AC=tensor(A,C); BC=tensor(B,C)
    M=frozenset((x,y) for x in AC.elems for y in BC.elems
                if x[0]+x[1]+x[2] <= 2*(y[2]+y[3]) and x[1]+2*x[2] <= y[0] and 3*x[1]+x[2] <= y[1])
    assert is_monrel(AC,BC,M)
    T=trace(A,B,C,M)
    fT=Phi(A,B,T)
    hT={a: B.Min(s) for a,s in fT.items()}
    for a in range(9):
        print("two modules: h_Tr(%d) ="%a, sorted(hT[(a,)]))
        exp={(c1+2*c2, 3*c1+c2) for c1 in range(4) for c2 in range(4) if c1+c2==a}
        assert hT[(a,)]==frozenset(exp)
    f=Phi(AC,BC,M); h={x: BC.Min(s) for x,s in f.items()}
    print("h(2;1;0) =", sorted(h[(2,1,0)]))
    print("h(2;1;1) =", sorted(h[(2,1,1)]))
    print("h(2;2;1) =", sorted(h[(2,2,1)]))
    for a in range(9):
        Xa={bc[:2] for c in C.elems for bc in h[(a,)+c] if bc[2:]==c}
        assert B.Min(Xa)==hT[(a,)] and B.up(Xa)==fT[(a,)]
        if a==2: print("X_2 =", sorted(Xa))
        exp={(c1+2*c2, 3*c1+c2) for c1 in range(4) for c2 in range(4) if c1+c2 in (a,a+1)}
        assert Xa==exp, (a, Xa, exp)
    print("all examples ok")

tests = [test_monad, test_iso, test_monoidal, test_trace, test_antichains, test_nonantisym]
n = int(sys.argv[2]) if len(sys.argv) > 2 else 300
for t in tests:
    for i in range(n if t is not test_nonantisym else 1):
        t()
    print("ok", t.__name__)

examples()
