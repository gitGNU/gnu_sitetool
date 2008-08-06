(h3 "DESCRIPTION")
(p
 "Sitetool is a "
 (a (@ (href "http://en.wikipedia.org/wiki/Content_management_system")) CMS)
 " that should work with (or without) the "
 (a (@ (href "http://en.wikipedia.org/wiki/Autotools")) autotools)
 "."
 (br)
 (br)
 "The project should aid developers building their projects web-sites "
 "without having to write HTML directly (or via strange machineries) "
 "while having a \"coding\" approach to the generation of their contents."
 (br)
 (br)
 "Sitetool content production is divided in two layers: backend and "
 "frontends."
 (br)
 (br)
 "The backend is the lower layer, it decouples the different frontends "
 "using " (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML) " "
 "as common format."
 (br)
 (br)
 "Frontends form the upper layer, each frontend translates a content from "
 "its format to the backend format using a chain of filters. "
 "Filters chains are automatically formed (or manually specified) in order "
 "to transform each content from its input format to the backend "
 "format. "
 (br))
(h4 "Filters")
(p
 "A filter is nothing more than a program which takes an input file and "
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
(p "Examples:")
(ul
 (li "The filters chain used to transform a ChangeLog file to a backend "
     "content is changelog-wikitext -> wikitext-sxml -> sxml-sxml")
 (li "In order to use SXML directly in a content, the pass-through chain "
     "sxml-sxml is used")
 (li "A wikitext content get translated to SXML using the "
     "wikitext-sxml -> sxml-sxml chain")
 )
(p
 "In order to use third-party filters or your own filters, the "
 (samp "sitetool-config") " script should be used to find the filters "
 "installation directory:")
(pre "
     Usage: sitetool-config [OPTIONS]

     OPTIONS:
	[-h|--help]
	[--version]
	[--filters-dir]
	[--styles-dir]
")
(p
 "Simply place additional filters into the filters directory: "
 (kbd "cp my-filter `sitetool-config --filters-dir`"))

(h4 "Use")
(p
 "Sitetool is composed by a bunch of utilities. Each utility could be "
 "invoked manually or by the main program " (samp "sitetool") " via the "
 (samp "--mode") " option. The main program invocation has the advantage of "
 "handling the inter-utility dependencies automatically. A common set of "
 "parameters are available to each utility.")
(pre "
     Usage: sitetool [OPTION]... [-- [MODE-ARG]...]

     Options:
	-M, --mode=MODE            Running mode is MODE

     [COMMON-PARAMETERS]
")

(p
 "Current available modes are:"
 (br))

(h5 "parse")
(pre "
     Usage: sitetool-parse [OPTIONS]

	    -i, --input=FILE            use FILE as input file
	    -o, --output=FILE           use FILE as output file

     [COMMON-PARAMETERS]
")

(h5 "initialize")
(pre "
     Usage: sitetool-initialize [OPTIONS]

	    -w, --work-dir=DIR          working directory is DIR
	    -o, --output-dir=DIR        output directory is DIR

     [COMMON-PARAMETERS]
")

(h5 "clean")
(pre "
     Usage: sitetool-clean [OPTIONS]

	  -c, --configuration=FILE    configuration file is FILE
	  -w, --work-dir=DIR          use DIR as a working directory
	  -o, --output-dir=DIR        place output into directory DIR

     [COMMON-PARAMETERS]
")

(h5 "build")
(pre "
     Usage: sitetool-build [OPTIONS]

	    -c, --configuration=FILE    configuration file is FILE
	    -w, --work-dir=DIR          use DIR as a working directory
	    -o, --output-dir=DIR        place output into directory DIR

    [COMMON-PARAMETERS]
")

(h5 "check")
(pre "
     Usage: sitetool-check [OPTIONS]

	    -c, --configuration=FILE    configuration file is FILE
	    -o, --output-dir=DIR        use DIR as output directory

    [COMMON-PARAMETERS]
")

(h5 "digest")
(pre "
     Usage: sitetool-digest [OPTIONS]

	    -c, --configuration=FILE    configuration file is FILE
	    -o, --output-dir=DIR        use DIR as output directory

    [COMMON-PARAMETERS]
")

(h5 "preprocess")
(pre "
     Usage: sitetool-preprocess [OPTIONS]

	    -D, --define=VAR=VALUE      define variable VAR to value VALUE
	    -U, --undefine=VAR          undefine variable VAR
	    -i, --input=FILE            use FILE as input file
	    -o, --output=FILE           use FILE as output file

    [COMMON-PARAMETERS]
")

(h5 "validate")
(pre "
     Usage: sitetool-validate [OPTIONS]

	    -c, --configuration=FILE    configuration file is FILE
	    -o, --output-dir=DIR        use DIR as output directory

    [COMMON-PARAMETERS]

")

(h3 "COPYING")
(p
 "Sitetool is licensed under the "
 (a (@ (href "http://www.gnu.org/licenses/licenses.html"))
 "GNU General Public License, version 2"))

(h3 "MAINTAINERS")
(p
 "Francesco Salvestrini <salvestrini AT gmail DOT com>")

(h3 "AUTHORS")
(p
 "Francesco Salvestrini <salvestrini AT gmail DOT com>"
 (br)
 "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>")

(h3 "RELEASES")
(p
 "Sorry, no public release available at the moment.")

(h3 "MAILING LISTS")
(p
 "Sitetool has a single moderated mailing list, with an archive. "
 "In order to post a message to the mailing list you must be subscribed. "
 "Please consult the "
 (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic") )
  "Sitetool mailing list page")
 " for more information on subscribing to the mailing list.")

(h3 "REPORT A BUG")
(p
 "If you think you have found a bug in Sitetool then please send as "
 "complete a report as possible to <sitetool AT nongnu DOT org>. An easy "
 "way to collect all the required information, such as platform and "
 "compiler, is to include in your report the config.log file available at "
 "the end of the configuration procedure. "
 (br)
 (br)
 "If you have a patch for a bug in Sitetool that hasn't yet been fixed in "
 "the latest repository sources, please be so kind to create it using the "
 "repository sources, not the release sources.")

(h3 "DEVELOPMENT")
(h4 "Browsing sources")
(p
 "You can browse the "
 (a (@ (href "http://git.savannah.nongnu.org/gitweb/?p=sitetool.git"))
  "Git repository")
 " of this project with your web browser. This gives you a good "
 "picture of the current status of the source files. You may also view "
 "the complete histories of any file in the repository as well as "
 "differences among two versions.")

(h4 "Getting a copy of the Git Repository")
(p
 "Anonymous checkout: "
 (kbd (a (@ (href "http://savannah.gnu.org/maintenance/UsingGit")) git)
 " clone git://git.savannah.nongnu.org/sitetool.git"))

(h4 "Contribute")
(p
 "If you have time and programming skills, you can help us by developing "
 "missing features, regression tests or bug-fixing the present codebase. "
 "Subscribe to the "
 (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic"))
  "mailing list")
 ", drop us a mail and start coding. Send your code to the "
 "mailing list under the form of patches for the current revision system."
 (br)
 (br)
 "If you have time but no programming skills, you can help with "
 "documentation,  packaging, tests before releases etc ...")
