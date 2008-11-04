(h3 "DESCRIPTION")
(p "Sitetool is an extendable "
   (a (@ (href "http://en.wikipedia.org/wiki/Content_management_system")) CMS)
   " that should aid developers building their projects web-sites "
   "without having to write HTML directly (or via strange machineries) "
   "while having a \"programming\" approach to the generation of their "
   "contents.")
(p "Sitetool site/contents generation is divided in two layers: "
   (i "backend") " and " (i "frontends") ".")
(ul
 (li "The backend is the lower layer, it decouples the different frontends "
     "using " (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML) " "
     "as common file format")
 (li "Frontends form the upper layer, each frontend translates a content "
     "from its format to the backend format using a chain of filters. "
     "Filters chains are automatically formed (or manually specified) in "
     "order to transform each content from its input format to the backend "
     "format"))

(h3 "INSTALLATION")

(h4 "Prerequisites")
(p "In order to install Sitetool into your system you will need:")
(ul
 (li (a (@ (href "http://www.perl.org"))               "Perl"     ) )
 (li (a (@ (href "http://www.gnu.org/software/guile")) "Guile"    ) )
 (li (a (@ (href "http://home.gna.org/guile-lib/"))    "guile-lib") )
 )

(h4 "Installation")
(p "FCP uses the autotools facilities. The simplest way to install "
   "the package in your system is:")
(ul
 (li (kbd "cd") " to the directory containing the package's source code "
     "and type " (kbd "./configure") " to configure the package for your "
     "system."
     "Running " (kbd "configure") " might take a while. While running, "
     "it prints some messages telling which features it is checking for")
 (li "Type " (kbd "make") " to compile the package")
 (li "Optionally, type " (kbd "make check") " to run any self-tests that "
     "come with the package")
 (li "Type " (kbd "make install") " to install the programs and any data "
     "files and documentation"))
(p "Use " (kbd "./configure --help") " to get a brief help of all "
   "configuration tweaks available.")
(p "You can remove the program binaries and object files from the "
   "source code directory by typing " (kbd "make clean") ". "
   "To also remove the files that " (samp "configure") " created (so you "
   "can compile the package for a different architecture), type "
   (kbd "make distclean") ".")
(p "You can also type " (kbd "make uninstall") " to remove the installed "
   "files.")
(p "Note that the " (samp "--prefix") " option allows installation using "
   "different paths than the default ones, this option enables sandbox "
   "installations.")

(h3 "USAGE")

(h4 "Filters")
(p "A filter is nothing more than a program which takes an input file and "
   "traslates it to an output file, usually in a different format. "
   "Sitetool comes with a set of filters:")
(ul
 (li "changelog-wikitext")
 (li "map-sxml")
 (li "news-wikitext")
 (li "svnlog-wikitext")
 (li "sxml-sxml")
 (li "wikitext-sxml")
 )
(p "Filter chains examples:")
(ul
 (li "The filters chain used to transform a ChangeLog file to a backend "
     "content is changelog-wikitext -> wikitext-sxml -> sxml-sxml")
 (li "In order to use SXML directly in a content, the pass-through chain "
     "sxml-sxml could be used")
 )
(p "In order to use third-party filters or your own filters, the "
   (samp "sitetool-config") " script should be used to find the filters "
   "installation directory:")
(pre (@ class "terminal")
     "

     Usage: sitetool-config [OPTIONS]

     OPTIONS:
	[-h|--help]
	[--version]
	[--filters-dir]
	[--styles-dir]

")
(p "To use external filters ... simply copy them  into the filters directory.")

(h4 "Use")
(p "Sitetool is composed by a bunch of utilities. Each utility could be "
   "invoked manually or by using the main program " (samp "sitetool") " via "
   "the " (samp "--mode") " option. The main program invocation has the "
   "advantage of handling the inter-utility dependencies automatically.")
(p "The complete input " (a (@ (href "./grammar.html")) "grammar") " "
   "is available.")
(p "Current available modes are:")
(ul
 (li "parse")
 (li "initialize")
 (li "clean")
 (li "build")
 (li "check")
 (li "digest")
 (li "preprocess")
 (li "validate")
 )

(h3 "COPYING")
(p "The project is licensed under the "
   (a (@ (href "http://www.gnu.org/licenses/licenses.html"))
      "GNU General Public License, version 2"))

(h3 "MAINTAINERS")
(p "Francesco Salvestrini <salvestrini AT gmail DOT com>")

(h3 "AUTHORS")
(p "Francesco Salvestrini <salvestrini AT gmail DOT com>")
(p "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>")

(h3 "RELEASES")
(p "Sorry, no public release available at the moment.")

(h3 "MAILING LISTS")
(p "The project has a single moderated mailing list, with an archive. "
   "In order to post a message to the mailing list you must be subscribed. "
   "Please consult the "
   (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic") )
      "mailing list page")
   " for more information on subscribing to the mailing list.")

(h3 "REPORT A BUG")
(p "If you think you have found a bug then please send as complete a report "
   "as possible to "
   "<sitetool-generic AT nongnu DOT org>. "
   "An easy way to collect all the required information, such as platform and "
   "compiler, is to include in your report the config.log file available at "
   "the end of the configuration procedure.")
(p "If you have a patch for a bug that hasn't yet been fixed in "
   "the latest repository sources, please be so kind to create it using the "
   "repository sources, not the release sources.")

(h3 "DEVELOPMENT")

(h4 "Browsing sources")
(p "You can browse the "
   (a (@ (href "http://git.savannah.nongnu.org/gitweb/?p=sitetool.git"))
      "Git repository")
   " of this project with your web browser. This gives you a good "
   "picture of the current status of the source files. You may also view "
   "the complete histories of any file in the repository as well as "
   "differences among two versions.")

(h4 "Getting a copy of the Git Repository")
(p "Anonymous checkout:")
(pre (@ class "terminal")
     (a (@ (href "http://savannah.gnu.org/maintenance/UsingGit")) "git")
     " clone git://git.savannah.nongnu.org/sitetool.git")

(h4 "Contribute")
(p "If you have time and programming skills, you can help us by developing "
   "missing features, regression tests or bug-fixing the present codebase. "
   "Subscribe to the "
   (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic"))
      "mailing list")
   ", drop us a mail and start coding. Send your code to the "
   "mailing list under the form of patches for the current revision system.")
(p "If you have time but no programming skills, you can help with "
   "documentation,  packaging, tests before releases etc ...")
