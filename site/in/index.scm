(h3 "DESCRIPTION")
(p
 "Sitetool is a "
 (a (@ (href "http://en.wikipedia.org/wiki/Content_management_system")) CMS)
 " that should work with (or without) the "
 (a (@ (href "http://en.wikipedia.org/wiki/Autotools")) autotools)
 "."
 (br)
 "It aims to aid developers building their projects web-sites
 without having to write HTML directly (or via strange machineries)
 while having a \"coding\" approach to the generation of their contents."
 (br)
 "Sitetool is divided in (mainly) two layers: backend and frontends."
 (br)
 "The Backend is the lower layer. It decouples the different frontends
 using " (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML)
 " as common format."
 (br)
 "Frontends form the upper layer (the layer that the common user
 usually should see). Each frontend translates a content from its format to
 a different format. Frontends chains are automatically formed (or manually
 specified) in order to finally transform the content from its input format
 to SXML. This layer is fully expandable with python, perl, shell scripts
 and so on."
 )
(h4 "Copying")
(p
 "Sitetool is licensed under the "
 (a (@ (href "http://www.gnu.org/licenses/licenses.html"))
    "GNU General Public License, version 2")
 )

(h3 "MAINTAINERS")
(p
 "Francesco Salvestrini <salvestrini AT gmail DOT com>"
 )

(h3 "AUTHORS")
(p
 "Francesco Salvestrini <salvestrini AT gmail DOT com>"
 (br)
 "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>"
 )

(h3 "RELEASES")
(p "Sorry, no public release available at the moment.")

(h3 "MAILING LISTS")
;(p
; "Sitetool has several moderated mailing lists, each with an archive.
; For general Sitetool discussions, use <sitetool-user AT nongnu.org>.
; Email bug reports to <sitetool-bug AT nongnu.org>. For more information on
; submitting bugs, please see the section Report a Bug below.
; If you have a patch for a bug in Sitetool that hasn't yet been fixed in the
; latest repository sources, please send the patch (made for the git sources,
; not the release sources) to <sitetool-patch AT nongnu.org>."
; )
(p
 "Sitetool has several moderated mailing lists, each with an archive.
 For general Sitetool discussions, use <sitetool-user AT nongnu.org>.
 Email bug reports to <sitetool-bug AT nongnu.org>. For more information on
 submitting bugs, please see the section Report a Bug below.
 If you have a patch for a bug in Sitetool that hasn't yet been fixed in the
 latest repository sources, please send the patch (made for the git sources,
 not the release sources) to <sitetool-patch AT nongnu.org>."
 )

(h3 "REPORT A BUG")
(p
 "If you think you have found a bug in Sitetool, then please send as complete
 a report as possible to <sitetool-bug AT nongnu.org>. An easy way to collect all
 the required information, such as platform and compiler, is to run make check,
 and include the resulting file tests/testsuite.log to your report.
 Disagreements between the manual and the code are also bugs."
 )

(h3 "DEVELOPMENT")
(h4 "Browsing sources")
(p
 "You can Browse the "
 (a (@ (href "http://git.savannah.nongnu.org/gitweb/?p=sitetool.git"))
    "Git repository")
 " of this project with your web browser. This gives you a good
 picture of the current status of the source files. You may also view
 the complete histories of any file in the repository as well as
 differences among two versions."
 )
(h4 "Getting a Copy of the Git Repository")
(p "Anonymous checkout:")
(br)
(p (a (@ (href "http://savannah.gnu.org/maintenance/UsingGit")) git)
   " clone git://git.savannah.nongnu.org/sitetool.git")
