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
(p "Sitetool content production is divided in two layers: backend and "
   "frontends.")
(br)
(p "The backend is the lower layer. It decouples the different frontends "
   "using " (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML) " "
   "as common format.")
(br)
(p "Frontends form the upper layer. "
   "Each frontend translates a content from its format original format to "
   "a different format using a chain of filters. "
   "Filters chains are automatically formed (or manually specified) in order "
   "to transform each content from its input format to the backend "
   "format. ")
(br)
(p "Available filters:")
(ul
 (li "changelog-wikitext")
 (li "map-sxml")
 (li "news-wikitext")
 (li "svnlog-wikitext")
 (li "sxml-sxml")
 (li "wikitext-sxml")
 )
(br)
(p "Examples:")
(ul
 (li "The filters chain used to transform a ChangeLog file to a backend "
     "content is changelog-wikitext -> wikitext-sxml -> sxml-sxml")
 (li "In order to use SXML directly in a content, the pass-through chain "
     "sxml-sxml is used")
 (li "A wikitext content get translated to SXML using the "
     "wikitext-sxml -> sxml-sxml chain")
 )

(h4 "Use")
(p "Sitetool is composed by a bunch of utilities. Each utility could be "
   "invoked manually or by the main program " (tt "sitetool") " via the "
   (tt "--mode") " option. The main program invocation has the advantage of "
   "handling the inter-utility dependencies automatically. A common set of "
   "parameters are available to each utility.")
(pre
 "Usage: sitetool [OPTION]... [-- [MODE-ARG]...]" (br)
 "" (br)
 "Options:" (br)
 "  -M, --mode=MODE            Running mode is MODE" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(p "Current available modes are:")
(h4 "auths")
(pre
 "Usage: sitetool-auths [OPTIONS]" (br)
 "" (br)
 "  -i, --initialize            initialize the authorizations DB" (br)
 "  -A, --add=HOST,LOGIN,PSWD   add a DB entry" (br)
 "  -D, --delete=HOST,LOGIN     remove a DB entry" (br)
 "  -S, --show                  show all DB entries" (br)
 "  -C, --clear                 clear all DB entries" (br)
 "" (br)
 "    HOST  is host=HOSTNAME" (br)
 "    LOGIN is login=LOGINNAME" (br)
 "    PSWD  is password=PASSWORD" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "install")
(pre
 "Usage: sitetool-install [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -i, --input-dir=DIR         source directory is DIR" (br)
 "  -H, --hname=HOST            destination host is HOST" (br)
 "  -P, --hpassword=PASSWD      password for host HOST is PASSWD" (br)
 "  -U, --huser=USER            user for host HOST is USER" (br)
 "  -o, --hdir=DIR              destination directory is DIR" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "parse")
(pre
 "Usage: sitetool-parse [OPTIONS]" (br)
 "" (br)
 "  -i, --input=FILE            use FILE as input file" (br)
 "  -o, --output=FILE           use FILE as output file" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "initialize")
(pre
 "Usage: sitetool-initialize [OPTIONS]" (br)
 "" (br)
 "  -w, --work-dir=DIR          working directory is DIR" (br)
 "  -o, --output-dir=DIR        output directory is DIR" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "uninstall")
(pre
 "Usage: sitetool-uninstall [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -i, --input-dir=DIR         source directory is DIR" (br)
 "  -H, --hname=HOST            destination host is HOST" (br)
 "  -P, --hpassword=PASSWD      password for host HOST is PASSWD" (br)
 "  -U, --huser=USER            user for host HOST is USER" (br)
 "  -o, --hdir=DIR              destination directory is DIR" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "clean")
(pre
 "Usage: sitetool-clean [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -w, --work-dir=DIR          use DIR as a working directory" (br)
 "  -o, --output-dir=DIR        place output into directory DIR" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "build")
(pre
 "Usage: sitetool-build [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -w, --work-dir=DIR          use DIR as a working directory" (br)
 "  -o, --output-dir=DIR        place output into directory DIR" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "check")
(pre
 "Usage: sitetool-check [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -o, --output-dir=DIR        use DIR as output directory" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "digest")
(pre
 "Usage: sitetool-digest [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -o, --output-dir=DIR        use DIR as output directory" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "preprocess")
(pre
 "Usage: sitetool-preprocess [OPTIONS]" (br)
 "" (br)
 "  -D, --define=VAR=VALUE      define variable VAR to value VALUE" (br)
 "  -U, --undefine=VAR          undefine variable VAR" (br)
 "  -i, --input=FILE            use FILE as input file" (br)
 "  -o, --output=FILE           use FILE as output file" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
 )

(h4 "validate")
(pre
 "Usage: sitetool-validate [OPTIONS]" (br)
 "" (br)
 "  -c, --configuration=FILE    configuration file is FILE" (br)
 "  -o, --output-dir=DIR        use DIR as output directory" (br)
 "" (br)
 "[COMMON-PARAMETERS]" (br)
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
