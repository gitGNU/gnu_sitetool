;;
;; struct.scm
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

;;(define-macro define-struct
;;  (lambda (s . ff)
;;    (let ((s-s (symbol->string s)) (n (length ff)))
;;      (let* ((n+1 (+ n 1))
;;             (vv (make-vector n+1)))
;;        (let loop ((i 1) (ff ff))
;;          (if (<= i n)
;;	      (let ((f (car ff)))
;;		(vector-set! vv i 
;;			     (if (pair? f) (cadr f) '(if #f #f)))
;;		(loop (+ i 1) (cdr ff)))))
;;        (let ((ff (map (lambda (f) (if (pair? f) (car f) f))
;;                       ff)))
;;          `(begin
;;             (define ,(string->symbol 
;;                       (string-append "make-" s-s))
;;               (lambda fvfv
;;                 (let ((st (make-vector ,n+1)) (ff ',ff))
;;                   (vector-set! st 0 ',s)
;;                   ,@(let loop ((i 1) (r '()))
;;                       (if (>= i n+1) r
;;                           (loop (+ i 1)
;;                                 (cons `(vector-set! st ,i 
;;						     ,(vector-ref vv i))
;;                                       r))))
;;                   (let loop ((fvfv fvfv))
;;                     (if (not (null? fvfv))
;;                         (begin
;;                           (vector-set! st 
;;					(+ (list-position (car fvfv) ff)
;;					   1)
;;					(cadr fvfv))
;;                           (loop (cddr fvfv)))))
;;                   st)))
;;             ,@(let loop ((i 1) (procs '()))
;;                 (if (>= i n+1) procs
;;                     (loop (+ i 1)
;;                           (let ((f (symbol->string
;;                                     (list-ref ff (- i 1)))))
;;                             (cons
;;                              `(define ,(string->symbol 
;;                                         (string-append
;;                                          s-s "." f))
;;                                 (lambda (x) (vector-ref x ,i)))
;;                              (cons
;;                               `(define ,(string->symbol
;;                                          (string-append 
;;                                           "set!" s-s "." f))
;;                                  (lambda (x v) 
;;                                    (vector-set! x ,i v)))
;;                               procs))))))
;;             (define ,(string->symbol (string-append s-s "?"))
;;               (lambda (x)
;;                 (and (vector? x)
;;                      (eqv? (vector-ref x 0) ',s))))))))))
