;;
;; list.scm
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

;;(define (list-position element list)
;;  )

;;(define (list-length l)
;;  (vector-length (list->vector l))
;;  )

(define (list-of-lists? l)
  (if (not (list? l)) (error "I need a list!"))
  (call-with-current-continuation
   (lambda (exit)
     (for-each (lambda (x)
                 (if (list? x)
                     (exit #t)))
               l)
     #f))
  )

;;(define (list-flatten l) 
;;  (if (not (list-of-lists? l)) l)
;;  (let ((t '()))
;;    (for-each
;;     (lambda (x)
;;       (if (list? x)
;;	   (list-flatten x)
;;	   (set! t (append t x)))
;;       l)
;;     t))
;;  )