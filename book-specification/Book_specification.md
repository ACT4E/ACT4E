
# Book specification

## Introduction/context

We are writing a book called "Categories and Compositionality, with a view to Applications"

### Related works

(list of books and notes about what we want to be similar or not)

- "Category Theory for the Sciences", by David Spivak
  - Similarities: 
  - Dissimilarities: 
- "An Invitation to Applied Category Theory", by Brendan Fong and David Spivak
  - Similarities: 
  - Dissimilarities: 
- "The Joy of Abstraction" by Eugenia Cheng
  - Similarities: 
  - Dissimilarities: 

### Constraints

It must cover these topics:

- categories
- functors
- natural transformations
- symmetric monoidal categories
- monads
- adjunctions

### Audience

Its audience is as follows:

- (primary) ...
- (primary) ...
- (secondry) ...
- (secondary)...

### Prerequireiste for reading

We assume that the audiecne already knows:

- Linear algebra at the level of a bachelor student in Engineering
- Familiarity with mathematical logic and reasoning at the level of a bachelor student in Engineering
- ...

### Style

The style we chose: ...

### Tone

#### Definition of tones

| | |
|---|---|
| formal | Formal mathematics but not stuffy |
| informal | ... |

## Book structure

The book is divided in parts, parts are divided into chapters, and chapters are divided into sections. Sometimes, but not always, we use subsections or the latex command for paragraphs. 

A part typically contains 4-8 chapters. A chapter typically contains 2-10 sections. Each section is typically 1-7 pages.

There are various types and subtypes of chapters:
- intuition chapter
- mathematical chapter
  - definition chapter
  - constructions chapter
  - commentary chapter
- applications chapter


Each type of chapter has a respective goal, tone, and scope, as specified in the following table: 


| type of chapter | goal | tone | in scope | out of scope |
|---|---|---|---|---|
| Definition chapter | Provide formal mathematical content. | formal | Formal defintiions | Intuition/motivation |
| Intuition chapter | Provide intuition for why the theme is important. | informal | | Formal definitions |
| Constructions chapter | Describe constructions as in: getting new from old | formal | | |
| Applications chapter | Show how domain things can be defined using CT or do something with CT results | formal | | |
| Commentary chapter | Communicate, and comment on, the categorcal way of thinking on a meta-level; ground this content in specific concepts and examples| formal | | |
| One level up chapter | | | | |

## Principles

- [hard] P_TH-MOTIV-APP: All theory is motivated from the point of view of applications.
  - Rationale: this validates that the thoery is used for something
  - Exception: dual concepts only need one of the pair used.
- [hard] P_TH-SELF-CONTAINED: The theory is self-contained, up to prerequisite knowledge.
- [soft] P_BOOK-FUNCTIONS: Overall, the book the main function of the book is to serve as a pedagogical introduction that may be used for self-study or as an aide for teaching courses. It should not be thought of mainly as a reference text, even though it is intended, secondarily, to serve as a reference. The structure of the book should not become too rigid in any attempt to be systematic or exhaustive; on the other hand, we want to avoid obscuring inherent systematic structures in category theory (and generally in our covered topics) that are helpful or even essential for readers to see and understand.

- [soft] Keep in mind and include where relevant: underscore the 'why' of why we care about using categories. This will be addressed squarely in the introduction to the book, however it should also appear sporadically, where relevant, throughout the book. 
-
- [hard] P_SIMP-EX-ACC: The Simple Examples chapters are understanbale easily with minimum prerequiresites met
- [soft] P_ONE-MESSAGE: In general, on any given page or short sequence of pages there are not too many main messages being communicated at once. The main point should be clear, and larger distractions from the main line of storytelling and explanation should be avoided. 

### Consequences.

- P_TH-SELF-CONTAINED => Removing all the applications chapters keeps the book readable.
- P_TH-SELF-CONTAINED => no dependece of non-applications to applications chapters
- [soft] Every theory construction is recalled/used in either 1) an applied example or 2) an application chapter.
- [soft] P_TH-MOTIV-APP: => Whenever we supply ``simple mathematical examples'' these should also be illustrated with a "subexample" that is more concrete and applied -- in order to spell out the more concrete implications and possible applied uses of the mathematical examples. These additional concrete examples should be small enough that readers can easily chew on them, but insightful enough to be relevant. Even if the applied examples are relatively simple, this step from generic math to context specific use is often a gap that is valuable (and often nontrivial) to bridge).
-   




## Structure of a part

The order is usually:

- Intuition chapter
- Definition chapter
- Constructions chapter (new from old)
- Applications chapter(s)
  - ideally: every theory part is recalled in some application chater
- "one level up" chapter
  - e.g. after algerba, morphisms/ actions
  - e.g. after orders, monotone functions
  -
- Commentary chapter

## Structure of a mathematical chapter

- Section: Motivating mathematical examples before definition
- Section: Mathematical definition
  - Subsection: Formal definition
  - Subsection: Non-examples
    - goal: to show that the defintiion is non trivial (not always satsified)

  - Subsection: Simple mathematical examples already known
     - constraint: accessbile only with basic prerequreists
     - example: semigroup of positive reals
       - applied subexample: modeling some kind of error

  - Subsection: Applied examples
     - example: ...

  - Subsection: Canonical examples
     - example: identity as example of eveyrhing, constant functions, singleon sets and
  - Subsection: Canonical constructions
     - example: list construction in the monoid examples
     - example: end construction in the monoid examples

  - Subsection: mathematical remarks, consequencies, fragments of relevant theory
     - example: in groups, statement that an inverse, if exists, is unique

  - Interspersed:

    - Exercises (with solutions appearing at the end of the chapter)

    - Graded exercises (no solutions in the book)

- Section: more complex mathematical examples
  - Goal: ...
  - Note: this might need more than the basic prerequeistes.
  - example: Hom Functor section
  - example: Linear algebra material in the Actions chapter
- Section: application-inspired examples
  - Goal: show how iefintions capture some real workld phenomeon
  - How: long discussion
  - example: morse code
- Section: Further theory
  - example:


## Structure of an applications chapter


  Note: For some applications that would go beyond the scope of the book but are nice to mention, we can still describe them briefly in a short paragraph and point the reader to relevant references.
