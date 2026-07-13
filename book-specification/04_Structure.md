


## Book structure

The book is divided in parts, parts are divided into chapters, and chapters are divided into sections. Sometimes, but not always, we use subsections or the latex command for paragraphs. 

A part typically contains 4-8 chapters. A chapter typically contains 2-10 sections. Each section is typically 1-7 pages.

Rem: avoid numbers; rather we have a hierarchy and a size of a section/chapter should be comparable across the book... (after all, pages number depends on size of paper). Define instead more instrinsically -- e.g. a section should be a 'module' in a lecture -- something that has a self-contained shape and is the unit of what one could put in a lecture or not.

### Types of chapters

There are various types and subtypes of chapters: (prescriptive or descriptive?? -> prescriptively define)
One can also be descriptive about "note, the current state is...", but...

- intuition chapter
- mathematical chapter
  - definition chapter
  - constructions chapter
  - commentary chapter
- applications chapter

Examples of each type of chapter:

- Intuition chapter
   - Example: the chapter "Intro: Series composition" at the beginning of the book part on Categories
   - Example: the chapter "Intro: Structuralism" at the beginning of the book part on "Categorical constructions"

- Definitions chapter
   - Example: the chapter "Sets with operations" in the book part on Algebra

- Definitions chapter "one level up" (a variant of definitions chapters)
  - Note: most parts don't need to have such a chapter; so far, there are only two parts in the book where there is a pattern of "Definitions chapter and then later in the same part a chapter on definitions that are one level up". 
  - Example: the chapter "Morphisms" in the book part on algebra (it discusses definitions that are  "one level up" from the definitions of semigroup, monoid, and group that are discussed in the earlier chapter "Sets with operations" in the same book part on "Algebra")
  - Example: the chapters "Monotone functions" and "Monotone relations" in the book part on Order

- Constructions chapter (new from old)
  - Example: the chapter "New posets from old" in the book part on Order
  - Example: the chapter "New from old" in the book part on Algebra
  - Example: the chapter "New categories from old" in the book part on Categories

- Commentary chapter
  - Example: the chapter "Categorical ways of thinking, I" at the end of the book part on "Categorical constructions"
  - Example: the chapter "Categorical ways of thinking, II" at the end of the book part on "Functors"


- Applications chapter
  - Goal: convey meta-thinking and advanced intuition about the material
  - Example: the chapter "Modelling with categories" in the book part on Categories
  - Example: the chapter "Application: System behaviors" in the book part on Functors
  - Example: the chapter "Application: Databases" in the book part on "Higher structures"





Each type of chapter has a respective goal, tone, and scope, as specified in the following table: 


| type of chapter | goal | tone | in scope | out of scope |
|---|---|---|---|---|
| Definition chapter | Provide formal mathematical content. | formal | Formal defintiions | Intuition/motivation |
| Intuition chapter | Provide intuition for why the theme is important. | informal | | Formal definitions |
| Constructions chapter | Describe constructions as in: getting new from old | formal | Formal definitions | |
| Applications chapter | Show how domain things can be defined using CT or do something with CT results | formal | | Essential theory|
| Commentary chapter | Communicate, and comment on, the categorcal way of thinking on a meta-level; ground this content in specific concepts and examples| formal | | Formal definitions|


### Types of sections in a mathematical chapter

This is a non-exhaustive list of some types of sections that may appear in a mathematical chapter:
- #Sec_Math_Moti: Motivating mathematical examples before definition
  - Goal:
  - Dxample: 
- #Sec_Math_Def: Mathematical definition
  - Goal:
  - Dxample:
- #Sec_Appl_Exa: Application-inspired examples
  - Goal: show how defintions capture some real world phenomeon
  - How: examples that are accompanied by discussion
  - Example: morse code
- #Sec_Comp_Math: Complex mathematical examples
  - Goal: Explain more complex examples; illustrate the richness of the theory; indirectly introduce further theory that is non-essential to the main storyline of the book
  - Note: this might need more than the basic prerequeistes.
  - Example: Hom Functor section
  - Example: Linear algebra material in the Actions chapter
- #Sec_Fur_Theo: Further theory
  - Goal: Discuss any theory that we think is worth including, but would distract from the main message in a "Mathematical defintion" section  
  - Dxample:
- #Sec_Trailhead: 
  - Goal: Briefly and informally introduce a topic that we choose to not cover formally in the book, but that we wish the reader to be aware of; we explain (and teaser) the basic idea and we provide references where one can learn more
  - Dxample: Multicategories and polycategories (this might be made into a chapter though instead of just a section)


### Typical structure of a part

The structure is often something like this:

- Intuition chapter
  - when relevant
   
- Definitions chapter
  - sometimes multiple definitions chapters are needed
   
- Constructions chapter 
  - when relevant
  
- Definitions chapter "one level up" (or simply another definitions chapter) 
  - when relevant

- Applications chapter(s)
  - when reveleant; not every part needs to have such a chapter
   
- Commentary chapter
  - when relevant

### Typical structure of a *mathematical chapter*

- #Sec_Math_Moti: Motivating mathematical examples before definition
- #Sec_Math_Def: Mathematical definitions 
   - note: there maybe be several *mathematical defintion* sections in a row, not just one; however there is usual at least one such section.
- #Sec_Appl_Exa: Application-inspired examples
  - note: there is typicaly one or two such sections in a row
- #Sec_Comp_Math: More complex mathematical examples
  - note: sometimes there is no such section, sometimes there is one
- #Sec_Fur_Theo: Further theory
  - note: sometimes there is no such section, sometimes there is one


### Typical structure of a mathematical definition section (#Sec_Math_Def) inside a mathematical chapter

- Definition: a #Sec_Math_Def is... (ToDo)

  - Subsection: Formal definition

  - Subsection: Non-examples
    - Goal: to show that the definition is non-trivial (not always satsified) and show the various ways that it can fail (sometimes there is more than one type of way)

  - Subsection: Simple mathematical examples already known
     - Constraint: accessbile only with basic prerequisits
     - Example: semigroup of positive reals
       - applied subexample: modeling some kind of error

  - Subsection: Applied examples
     - Example: ...

  - Subsection: Canonical examples
     - Example (identity things): the identity function between underlying sets is a morphism for many algebraic structures
     - Example (constant things): any constant function betweeen underlying sets is a morphism of semigroups
     - Example (small things): there is a canonical monoid structure on any singleton set
  - Subsection: Canonical constructions
     - Example: list construction in the monoid examples
     - Example: endormorphism construction in the monoid examples

  - Subsection: Theory snippets
    - Goal: have a place for mathematical remarks, fragments of relevant theory, commentary on consequences
     - Example: in groups, statement that an inverse, if exists, is unique

  - Interspersed:
    - Exercises (with solutions appearing at the end of the chapter)
    - Graded exercises (no solutions in the book)


### Typical structure of an applications chapter

  Note: For some applications that would go beyond the scope of the book but are nice to mention, we can still describe them briefly in a short paragraph and point the reader to relevant references.

  TBD


