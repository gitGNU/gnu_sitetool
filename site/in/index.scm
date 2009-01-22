(h2 "DESCRIPTION")
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
 (li "Frontends form the upper layer, each frontend usually translates a "
     "content from its input format to a different output format"))

(p "In order to to transform the frontend output to the common SXML format "
   "a chain of filters get computed automatically. Filters chains are "
   "automatically formed using "
   (a (@ (href "http://www.nongnu.org/fcproc")) FCP) ".")

(h2 "USAGE")

(h3 "Filters")
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
(h3 "Use")
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

(h2 "COPYING")
(p "The project is licensed under the "
   (a (@ (href "http://www.gnu.org/licenses/licenses.html"))
      "GNU General Public License, version 2"))

(h2 "MAINTAINERS")
(p "Francesco Salvestrini <salvestrini AT gmail DOT com>")

(h2 "AUTHORS")
(p "Francesco Salvestrini <salvestrini AT gmail DOT com>")
(p "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>")

(h2 "MAILING LISTS")
(p "The project has a single moderated mailing list, with an archive. "
   "In order to post a message to the mailing list you must be subscribed. "
   "Please consult the "
   (a (@ (href "http://lists.nongnu.org/mailman/listinfo/sitetool-generic") )
      "mailing list page")
   " for more information on subscribing to the mailing list.")

(h2 "REPORT A BUG")
(p "If you think you have found a bug then please send as complete a report "
   "as possible to "
   "<sitetool-generic AT nongnu DOT org>. "
   "An easy way to collect all the required information, such as platform and "
   "compiler, is to include in your report the config.log file available at "
   "the end of the configuration procedure.")
(p "If you have a patch for a bug that hasn't yet been fixed in "
   "the latest repository sources, please be so kind to create it using the "
   "repository sources, not the release sources.")
