;;
;; menu.scm
;;
;; Copyright (C) 2008, 2009 Francesco Salvestrini
;;                          Alessandro Massignan
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

(define tree-id->pagemap
  (lambda (p i)
    (map
     (lambda (n)
       (if (null? n)
	   '()
	   (list (node-attributes n)
		 (if (and (null? (find-node (node-children n) i))
			  (not (equal? (node-id n) i)))
		     '()
		     (tree-id->pagemap (node-children n) i)))))
     p)))

(define pagemap-clean-up
  (lambda (p)
    (map
     (lambda (n)
       (if (null? (car (node-children n)))
	   (list (node-attributes n))
	   (list (node-attributes n)
		 (pagemap-clean-up (car (node-children n))))))
     (reverse (cdr (reverse p))))))

(define pagemap->sxml
  (lambda (p)
    `(ul
      ,@(map
	(lambda (n)
	  (if (null? (node-children n))
	      `(li (a (@ (href ,@(cdadar n))) ,(caadar n)))
	      `(li (a (@ (href ,@(cdadar n))) ,(caadar n))
		   ,(pagemap->sxml (car (node-children n))))))
	p))))

(define map->sxml
  (lambda (in-port out-port)
    (let ((s (read in-port)))
      (write (pagemap->sxml
              (pagemap-clean-up
               (tree-id->pagemap (map-tree s) (map-id s)))) out-port))))
