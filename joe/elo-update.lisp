;Assuming definition of team sturct (team id teamid elo rank timestamp)
; and                   game sturct (game id winningid losingid timestamp processed)

;comment this out before use with database
; (defun db-newteam (teamid elo rank timestamp)
; 	"Writes a new team to the database"
; 	())
; (defun get-uninitialized-list ()
; 	"Returns a list of game sturcts with the same timestamp"
; 	())
; (defun get-team-list ()
; 	"Returns a list of the most recent team struts, it also sorts by ranking
; 	from best to worst"
; 	())
; (defun update-team-elo (team elo timestamp)
; 	"returns an updated team struct with the elo and timestamp changed"
; 	())
; (defun make-ranking (teamlist)
; 	"Takes in a list of players and assigns rankings in order"
; 	())
; (defun update-ranking (teamlist)
; 	""
; 	())
(defun expected-win (elo1 elo2)
	"Returns the expected win share for a player with elo1 if her oppoent's elo is elo2"
	(/ 1 (+ 1 (expt 10 (/ (- elo2 elo1) 400)))))
(defparameter *k-factor* 32
	"k-factor for the elo algorithm")
(defun elo (winnum losenum wins losses)
	"Is given the winning and losing elos and returns a two element list
	consisting of the new elos"
	(list (+ winnum (* *k-factor* (- wins (* (+ wins losses) (expected-win winnum losenum))))) 
	  (+ losenum (* *k-factor* (- losses (* (+ wins losses) (expected-win losenum winnum)))))))
; (defun in-list (testitem testlist)
; 	"Returns true if testitem is in testlist, otherwise returns NIL
; 	uses EQUAL as the comparison test"
; 	(member testitem testlist :test #'EQUAL)
; )
(format t "win-p: ~a~%" (expected-win 1500 1200))
(format t "win-p: ~a~%" (expected-win 1200 1500))
(format t "T1: ~a T2: ~a~%" (car (elo 1500 1200 7 6)) (cadr (elo 1500 1200 7 6 )))
(format t "T1: ~a T2: ~a~%" (car (elo 1500 1200 1 22)) (cadr (elo 1500 1200 1 22)))