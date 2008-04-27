;;
;; string.scm
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

(define (char-lower-case char)
  (if (not (char? char))
      (error "Wrong char"))
  (char-downcase char))

(define (string-lower-case str)
  (if (not (string? str))
      (error "Wrong string"))
  (list->string (map-in-order char-lower-case (string->list str))))

(define (char-upper-case char)
  (if (not (char? char))
      (error "Wrong char"))
  (char-upcase char))

(define (string-upper-case str)
  (if (not (string? str))
      (error "Wrong string"))
  (list->string (map-in-order char-upper-case (string->list str))))

(define (char->html c)
  (if (not (char? c))
      (error "This is not a char"))
  (cond
   ((char=? c #\space) (string #\% #\2 #\0 ))
   (else               (string c))
   )
  )

(define (string->html str)
  (let ((s ""))
    (for-each
     (lambda (c) (set! s (string-append s (char->html c))))
     (string->list str))
    s)
  )
