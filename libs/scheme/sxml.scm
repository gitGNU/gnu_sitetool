;;
;; sxml.scm
;;
;; Copyright (C) 2007, 2008 Francesco Salvestrini
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along
;; with this program; if not, write to the Free Software Foundation, Inc.,
;; 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
;;

;; From http://schemecookbook.org/Cookbook/WebExtractingAllLinksFromPage
;(require (planet "htmlprag.ss" ("neil" "htmlprag.plt"))
;         (lib "url.ss" "net")
;         (lib "match.ss"))
;
;; url->sxml : url-string -> sxml
;;  fetch the page with the url url, parse it and return the parse tree
;(define (url->sxml url)
;  (html->sxml (get-pure-port (string->url url))))
;
;; sxml->links : sxml -> (list (list url-string string))
;;  return a list of all links in the parse tree
;(define (sxml->links sxml)
;  (match sxml
;   [('a ('@ ((not 'href ) _) ... ('href url)  . more) text)
;    (list (list url text))]
;   [(item ...)
;    (apply append
;           (map sxml->links sxml))]
;   [else '()]))
