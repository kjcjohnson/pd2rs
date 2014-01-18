;;;db.lisp -- implements a simple database
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-db)

(defparameter ++id-team-table++ nil)
(defparameter ++next-team-id++ 0)
(defparameter ++id-tournament-table++ nil)
(defparameter ++next-tournament-id++ 0)
(defparameter ++game-table++ nil)
(defparameter ++team-table++ nil)


(defun add-team ( team-name )
  "Adds a team name to the database at next available id."
  (push (cons ++next-team-id++ team-name)
	++id-team-table++)
  (incf ++next-team-id++))

(defun add-tournament ( tournament-name )
  "Adds a tournament name to the database at next available id."
  (push (cons ++next-tournament-id++ tournament-name)
	      ++id-tournament-table++)
  (incf ++next-tournament-id++))

(defun find-team-by-id ( id )
  "Returns team name from unique id."
  (cdr
   (find id ++id-team-table++ :test #'(lambda (a b)
					(eql a (car b))))))

(defun find-tournament-by-id ( id )
  "Returns tournament name from unique id."
  (cdr
   (find id ++id-tournament-table++ :test #'(lambda (a b)
					(eql a (car b))))))

(defun find-team-by-name ( name )
  "Returns team id from team name."
  (car
   (find name ++id-team-table++ :test #'(lambda (a b)
					(string= a (cdr b))))))

(defun find-tournament-by-name ( name )
  "Returns tournament id from tournament name."
  (car
   (find name ++id-tournament-table++ :test #'(lambda (a b)
					(string= a (cdr b))))))

