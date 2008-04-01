(h3 "DESCRIPTION")
(p "Sitetool is a CMS that should work with (or without) the autotools."
   (br)
   "It aims to aid developers building their projects web-sites
    without having to write HTML directly (or via strange machineries)
    while having a \"coding\" approach to the generation of their contents."
   (br)
   "Sitetool is divided in (mainly) two layers: backend and frontends.
    The backend is the lower layer. It decouples the different frontends
    using a common format: "
    (a (@ (href "http://okmij.org/ftp/Scheme/xml.html")) SXML)
   ". "
   (br)
   "Frontends form the upper layer (the layer that the common user
    usually should see). Each frontend translates a content to a different
    format. Frontends chains are automatically formed (or manually specified)
   in order to transform the content from its input format to the backend
    format."
   (br)
   "The upper layer is fully expandable with python, perl, shell scripts
    and so on."
 )
(h3 "AUTHORS")
(p "Francesco Salvestrini <salvestrini AT gmail DOT com>"
   (br)
   "Alessandro Massignan <ff0000 DOT it AT gmail DOT com>"
 )
(h3 "RELEASE")
(p "Sorry, no public release available at the moment.")
(h3 "DEVELOPMENT")
(p "You can Browse the "
   (a (@ (href "http://git.savannah.nongnu.org/gitweb/?p=sitetool.git"))
      "Git repository")
   " of this project with your web browser. This gives you a good
    picture of the current status of the source files. You may also view
    the complete histories of any file in the repository as well as
    differences among two versions."
 )
