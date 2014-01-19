;;;db.lisp -- implements a simple memory database
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-db)

(defparameter ++id-team-table++ nil)
(defparameter ++next-team-id++ 0)
(defparameter ++id-tournament-table++ nil)
(defparameter ++next-tournament-id++ 0)
(defparameter ++game-table++ nil)
(defparameter ++next-game-id++ 0)
(defparameter ++team-table++ nil)
(defparameter ++next-table-id++ 0)


(defstruct game-struct
  id
  winning-team-id
  losing-team-id
  tournament-id
  timestamp
  processed?)

(defstruct team-struct
  id
  team-id
  tournament-id
  elo
  rank
  timestamp)

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


(defun insert-game ( &key winning-team losing-team (tournament "") (timestamp 0) (processed? nil) )
  
  (if (null (find-team-by-name winning-team)) (add-team winning-team))
  (if (null (find-team-by-name losing-team )) (add-team losing-team ))
  (if (null (find-tournament-by-name tournament)) (add-tournament tournament))

  (push 
   (make-game-struct :id ++next-game-id++ 
		     :winning-team-id (find-team-by-name winning-team)
		     :losing-team-id  (find-team-by-name losing-team )
		     :tournament-id   (find-tournament-by-name tournament)
		     :timestamp       timestamp
		     :processed?      processed?)
   ++game-table++)
  (incf ++next-game-id++))

(defun update-game-processed ( game-struct )

  (setf (game-struct-processed? (find game-struct ++game-table++)) t))

(defun insert-team ( &key team-name (tournament "") (elo 1000) (rank nil) (timestamp 0) )

  (if (null (find-team-by-name team-name)) (add-team team-name))
  (if (null (find-tournament-by-name tournament)) (add-tournament tournament))

  (push
   (make-team-struct :id            ++next-table-id++
		     :team-id       (find-team-by-name team-name)
		     :tournament-id (find-tournament-by-name tournament-name)
		     :elo           elo
		     :rank          rank
		     :timestamp     timestamp)
   ++team-table++)
  (incf ++next-table-id++))

;(defun search ( 
