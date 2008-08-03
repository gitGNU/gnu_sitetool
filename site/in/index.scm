(h3 "DESCRIPTION")
(p
 "Sitetool is a "
 (a (@ (href "http://en.wikipedia.org/wiki/Content_management_system")) CMS)
 " that should work with (or without) the "
 (a (@ (href "http://en.wikipedia.org/wiki/Autotools")) autotools)
 ".")
(br)
(p "The project should aid developers building their projects web-sites "
   "without having to write HTML directly (or via strange machineries) "
   "while having a \"coding\" approach to the generation of their contents.")
(br)
(p "Sitetool is divided in (mainly) two layers: backend and frontends.")
(br)
(p "The backend is the lower layer. It decouples the different frontends "
   "using " (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML) " "
   "as common format.")
(br)
(p "Frontends form the upper layer. "
   "Each frontend translates a content from its format original format to "
   "a different format. "
   "Frontends chains are automatically formed (or manually specified) in order "
   "to finally transform the content from its input format to the backend "
   "format. "
   "This layer is fully expandable with python, perl, shell scripts and so on.")

(h4 "Use")
(pre
 "Usage: sitetool [OPTION]... [-- [MODE-ARG]...]" (br)
 "" (br)
 "Options:" (br)
 "  -M, --mode=MODE            Running mode is MODE" (br)
 "  -n, --dry-run              display commands without modifying any files" (br)
 "  -f, --force                consider all files obsolete" (br)
 "  -W, --warnings=CATEGORY    report the warnings falling in CATEGORY" (br)
 "  -d, --debug                enable debugging traces" (br)
 "  -v, --verbose              verbosely report processing" (br)
 "  -h, --help                 print this help, then exit" (br)
 "  -V, --version              print version number, then exit" (br)
 "" (br)
 "Warning categories include:" (br)
 "  `all'                      all the warnings" (br)
 "  `none'                     turn off all the warnings" (br)
 "" (br)
 "MODE must be one of the following:" (br)
 "        auths                manage authorizations" (br)
 "        install              install previously built site" (br)
 "        parse                parse" (br)
 "        initialize           initialize" (br)
 "        uninstall            uninstall site from remote host" (br)
 "        clean                remove built files" (br)
 "        build                build site" (br)
 "        check                check links in a previously built site" (br)
 "        digest               compute digest for each previously built page" (br)
 "        preprocess           preprocess" (br)
 "        validate             validate previously built site" (br)
 "" (br)
 )

(h3 "COPYING")
(p "Sitetool is licensed under the "
   (a (@ (href "http://www.gnu.org/licenses/licenses.html"))
      "GNU General Public License, version 2"))

(h3 "MAINTAINERS")
(p "Francesco Salvestrini <salvestrini AT gmail DOT com>")

(h3 "AUTHORS")
(p
 "Francesco Salvestrini <salvestrini AT gmail DOT com>"
 (br)
 "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>"
 )

(h3 "RELEASES")
(p "Sorry, no public release available at the moment.")

(h3 "MAILING LISTS")
(p "Sitetool has a single moderated mailing list, with an archive. "
   "In order to post a message to the mailing list you must be subscribed. "
   "Please consult the "
   (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic") )
      "Sitetool mailing list page")
   " for more information on subscribing to the mailing list.")

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
 "You can browse the "
 (a (@ (href "http://git.savannah.nongnu.org/gitweb/?p=sitetool.git"))
    "Git repository")
 " of this project with your web browser. This gives you a good
 picture of the current status of the source files. You may also view
 the complete histories of any file in the repository as well as
 differences among two versions."
 )
(h4 "Getting a copy of the Git Repository")
(p "Anonymous checkout:")
(br)
(p (a (@ (href "http://savannah.gnu.org/maintenance/UsingGit")) git)
   " clone git://git.savannah.nongnu.org/sitetool.git")

(h4 "Contribute")
(p "If you have time and programming skills, you can help us by developing "
   "missing features, regression tests or bug-fixing the present codebase. "
   "Subscribe to the "
   (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic") )
      "mailing list")
   ", drop us a mail and start coding. Send your code to the "
   "mailing list under the form of patches for the current revision system.")
(br)
(p "If you have time but no programming skills, you can help with "
   "documentation,  packaging, tests before releases etc ...")
