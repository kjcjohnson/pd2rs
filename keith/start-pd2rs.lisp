;;;start-pd2rs.lisp -- a file that manages starting the server, initing everything
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(load "keith/package.lisp")
(in-package :pd2rs)

(load "keith/qls.lisp")
(load "keith/params.lisp")
(load "keith/handlers.lisp")
(load "keith/routing.lisp")
(load "keith/db.lisp")

(defvar ++acceptor++ (make-instance 'hunchentoot:easy-acceptor :port 80))


(defun data-conv (this) )


(defun start () 
  (hunchentoot:start ++acceptor++))


(defun stop ()
  (hunchentoot:stop ++acceptor++))
