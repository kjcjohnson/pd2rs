;;;start-pd2rs.lisp -- a file that manages starting the server, initing everything
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(load (merge-pathnames "keith/package.lisp" (truename "/home/ubuntu/pd2rs/")))
(in-package :pd2rs)

(defparameter ++build-dir++ (truename "/home/ubuntu/pd2rs/"))

(load (merge-pathnames "keith/qls.lisp"      ++build-dir++))
(load (merge-pathnames "keith/params.lisp"   ++build-dir++))
(load (merge-pathnames "keith/views.lisp"    ++build-dir++))
(load (merge-pathnames "keith/db.lisp"       ++build-dir++))
(load (merge-pathnames "keith/handlers.lisp" ++build-dir++))
(load (merge-pathnames "keith/routing.lisp"  ++build-dir++))

(format t "Beginning input to database...~%")

(load (merge-pathnames "joe/input-to-database.lisp" ++build-dir++))

(format t "Beginning Elo calculations...~%")

(load (merge-pathnames "joe/elo-update.lisp"        ++build-dir++))

(format t "Elo calculations finished. Launching server...~%")

(defvar ++acceptor++ (make-instance 'hunchentoot:easy-acceptor :port 80))


(defun data-conv (this) 
  (declare (ignore this)))


(defun start () 
  (hunchentoot:start ++acceptor++))


(defun stop ()
  (hunchentoot:stop ++acceptor++))
