(defparameter *in* (open "c:/Users/joe/Documents/GitHub/pd2rs/clean_data.csv" :if-does-not-exist nil)
	"Clean input filestream")
(defun pinput ()
	"Gets the next line from the parser, returns as a string.
	If no input return NIL"
	(read-line *in*))
(defun db-newgame (winner loser time)
	"Writes a new game to the database, takes input of three strings"
	(format t "Pushing data to the database!~%Winner: ~a~%Loser: ~a~%Time: ~a~%" winner loser time))

(let ((x NIL))
	(loop while (setf x (pinput)) doing
		(let* ((firstcomma (position #\, x :test #'equal)) 
			   (secondcomma (+ (+ 1 firstcomma) 
			   	               (position #\, (subseq x (+ 1 firstcomma)) :test #'equal))))
			(db-newgame (subseq x 0 firstcomma) 
				        (subseq x (+ 1 firstcomma) secondcomma)
				        (subseq x (+ 1 secondcomma) (+ (length x) -1))))))
(close *in*)