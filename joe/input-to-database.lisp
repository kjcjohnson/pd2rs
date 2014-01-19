(defparameter *in* 
  (open (merge-pathnames "perl/sub_data.csv" pd2rs:++build-dir++)
	:if-does-not-exist nil)
	"Clean input filestream")



'(defparameter *out* (open "c:/Users/joe/Documents/GitHub/pd2rs/perl/data.out" :direction :output :if-exists :supersede)
	"Output filestream")
(defun pinput ()
	"Gets the next line from the parser, returns as a string.
	If no input return NIL"
	(read-line *in* NIL))
(defun db-newgame (winner loser time)
	"Writes a new game to the database, takes input of three strings"
	(setf winner (string-trim " " winner))
	(setf loser (string-trim " " loser))
	(setf time (string-trim " " time))
	(if (equalp winner loser) nil
		;(format t "Error with winner and loser :~a: with timestamp :~a:~%" winner time)
		(pd2rs-db:insert-game :winning-team winner :losing-team loser :timestamp time))
				       ;	(format *out* "~a ~a ~a~%" winner loser time))
	;(format t "Winner:~a:~%Loser:~a:~%Time:~a:~%" winner loser time)
	)

(let ((x NIL))
	(loop while (setf x (pinput)) doing
		(let* ((firstcomma (position #\, x :test #'equal)) 
			   (secondcomma (+ (+ 1 firstcomma) 
			   	               (position #\, (subseq x (+ 1 firstcomma)) :test #'equal))))
			(db-newgame (subseq x 0 firstcomma) 
				        (subseq x (+ 1 firstcomma) secondcomma)
				        (subseq x (+ 1 secondcomma) (length x))))))
(close *in*)
'(close *out*)
