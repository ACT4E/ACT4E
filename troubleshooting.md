
This was fixed in kaobook by removing any special footnote treatment:

    I'm using the xr package to cross-reference a label defined in another document, but I get the error:
    ! Argument of \@fifthoffive has an extra }
    This is the same kind of problem as the previous one, but in this case the \label has been defined in a file that doesn't include the hyperref package, but the document referencing it does.

Suspect that the problem is related to the hyperref package at this version:
(from https://github.com/latex3/hyperref/blob/main/ChangeLog.txt)


2022-05-13 Ulrike Fischer/David Carlisle

    * added new interface for package authors to create targets for internal
      links
    * allow to suppress sectioning and footnote patches of hyperref
    * removed loading of memhfixc: memoir handles that now by itself.
    * removed an old patch for KOMA before 2001
    * removed compability code for pdftex 1.14
    * remove a test for amsmath before 1999
    * removed an since 2002 unneeded definition for subfigure
    * various patches in nameref can now be disabled by package authors
      by defining a command.
    * the experimental option localanchorname has been deprecated
    * LaTeX 2020-10-01 is required as hooks are used now.
    * \refstepcounter no longer tests for the slide counter as no reason could be found
      for that test.
    * nameref no longer patches \ifthenelse if kernel support is detected.
    * some support for references is done by tex4ht directly and has been removed from
      hyperref
    * unified reference commands, both nameref and hyperref now support
      \ref, \pageref, \Ref, \nameref and \ref*, \pageref*, \Ref*, \nameref*
    * removed older varioref code, a varioref newer than 2019 is now needed.
    * improved support for showkeys.
    * \theHequation is always defined (an not only if the section
      counter is defined)
    * Removed the \contentsline tests, no longer needed as \contentsline
      has now four arguments also in latex.
    * \MakeUppercase and \MakeLowercase work now in bookmarks if the expl3
    support is detected.
