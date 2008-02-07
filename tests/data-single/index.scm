(h3 "DESCRIPTION")
(p "Sitetool is a (static) CMS that should work with (or without) 
     the autotools."
    (br)
    "It aims to aid developers building their projects web-sites 
     without having to write HTML directly (or via m4) while having a 
     \"coding\" approach to the generation of their contents." 
     (br) (br)
    "Sitetool is divided in (mainly) two layers: backend and frontends."
    (br) (br)
    "The backend is the lower layer. It decouples the different frontends 
     using a common language: SXML. "
    (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML)
    " is Scheme-XML."
    (br)
    "In other words we use Scheme to build XML/HTML pages. Using this 
     approach pages are \"code\", not only mindless ASCII files. The 
     user will be able to \"code\" its pages..."
    (br)
    "The frontends form the upper layer (the layer that the common user 
     usually see). Each frontends translate contents to the common 
     backend language (SXML)."
    (br) (br)
    "Each frontend understands different input: wikitext-like syntax,
     structured-text, m4, SXML-pass-through, ChangeLog, NEWS ..."
    (br)
    "The upper layer is fully expandable with python, perl, shell 
     scripts and so on."
    (br) (br)
    "Using this approach users (package developers) are not required to 
     write their sites using scheme directly. Their contents get 
     translated from the choosen frontend to the backend via 
     filters-chain: the user writes its contents by choosing one (or 
     more) of the filters available then the content get translated to 
     SXML, from SXML to scheme and finally to HTML."
 )
(h3 "AUTHORS")
(p
 "Francesco Salvestrini <salvestrini AT gmail DOT com>"
 (br)
 "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>"
 )
(h3 "RELEASE")
(p
 "No public release for now... We're working hard :-)"
 (br)
 "Stay tuned!"
 )
