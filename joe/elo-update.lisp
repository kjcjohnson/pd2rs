(in-package :pd2rs-db)

(defstruct team teamid elo rank timestamp)
(defstruct game winningid losingid timestamp)
(defstruct match winningid losingid wins losses)
(defparameter *k-factor* 32
	"k-factor for the elo algorithm")
(defparameter *init-elo* 1000
	"default value for an initial team")
;comment this out before use with database
(defun db-newteam (outteams)
	"Writes a new team to the database"
	())
(defun get-games ()
	"Returns a list of game sturcts with the same next timestamp"
	(let ((games pd2rs-db:++game-table++))
	  ))
(defun get-teams ()
	"Returns a list of the most recent team struts, it also sorts by ranking
	from best to worst"
	(let ((teams pd2rs-db:++team-table++))
	  ))

(defun expected-win (elo1 elo2)
	"Returns the expected win share for a player with elo1 if her oppoent's elo is elo2"
	(/ 1 (+ 1 (expt 10 (/ (- elo2 elo1) 400)))))
(defun elo (winnum losenum wins losses)
	"Is given the winning and losing elos and returns a two element list
	consisting of the new elos"
	(list (+ winnum (* *k-factor* (- wins (* (+ wins losses) (expected-win winnum losenum))))) 
	  (+ losenum (* *k-factor* (- losses (* (+ wins losses) (expected-win losenum winnum)))))))

(defun gameinmatches (testgame matchlist)
	"Does the matchlist have the testgame in it?"
	(loop for m in matchlist do (if (or (and (equal (game-winningid testgame) (match-winningid m)) 
											 (equal (game-losingid testgame) (match-losingid m))
									    (and (equal (game-winningid testgame) (match-losingid m)) 
											 (equal (game-losingid testgame) (match-winningid m))))
									(retrun m)) finally (return NIL)))
(defun makematches (games)
	"Takes in a list of game structs and outputs a list of matches"
	(defparameter *matches* NIL "List of matches")
	(loop for g in games do (let ((x (gameinmatches g *matches*)))
				(if x
					(if (equalp (game-winningid g) (match-winningid x))
						(setf (match-wins x) (+ 1 (match-wins x)))
						(setf (match-losses x) (+ 1 (match-losses x))))
					(setf *matches* (append *matches* (list (make-match :winningid (game-winningid g)
											                            :losingid (game-losingid g)
											                            :wins 1
											                            :losses 0))))))
	finally (return *matches*)))
(defun match-id (id testteam)
	"If testteam has team id id, return T, else return NIL"
	(if (equal id (team-teamid testteam)) (return T) (return NIL)))
(defun elo-input (inteam)
	"returns the old elo of the the team, if it exists
	if not, returns the default elo value"
	(if (inteam)
		(team-elo inteam)
		*init-elo*))
(defun update-elo (teams matches)
	"Uses the matches to update the teams' elos
	if the team dosn't exist it adds it to teams
	returns the teamlist"
	(loop for m in matches do (let* ((t1 (find (match-winningid m) teams #'match-id))
	                                (t2 (find (match-losingid m) teams #'match-id))
	                                (data (elo (elo-input t1) (elo-input t2) (match-wins m) (match-losses m))))
		(if (t1)
			(setf (team-elo t1) (car data))
			(setf teams (cons (make-team :teamid (match-winningid m)
				                         :elo (car data)
				                         :rank 0
				                         :timestamp 0) teams)))
		(if (t2)
			(setf (team-elo t2) (cadr data))
			(setf teams (cons (make-team :teamid (match-losingid m)
				                         :elo (cadr data)
				                         :rank 0
				                         :timestamp 0) teams))))
	finally (return teams)))
;get the teams, games, and matches
(let* ((teams (get-teams))
	  (games (get-games))
	  (matches (makematches games))
	  (curtime (game-timestamp (car games))))
	;update elo and add new teams
	(setf teams (update-elo teams matches))
	;sort by elo
	(sort teams (lambda (x y) (> (team-elo x) (team-elo y))))
	;update rankings and timestamps
	(loop for i from 1 to (length teams) do (let ((x (nth (- i 1) teams)))
												(setf (team-rank x) i)
												(setf (team-rank x) curtime)))
	;write new teams to database
	(db-newteam teams)
	)
