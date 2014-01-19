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
	"Writes the list of teams (teams) to the database"
	(loop for team in outteams do 
	     (insert-team 
	      :team-id (team-teamid team) 
	      :elo (team-elo team) 
	      :rank (team-rank team)
	      :timestamp (team-timestamp team))))

(defun convert-game (keithgame)
        "Converts a game-stuct (Keith's style) to a game (Joe's Style)"
	(make-game :winningid (game-struct-winning-team-id keithgame)
		   :losingid (game-struct-losing-team-id keithgame) 
		   :timestamp (game-struct-timestamp keithgame)))
(defun get-games ()
	"Returns a list of game sturcts with the same next timestamp"
	(format t "Retriveing games from database... ~%")
	(let* ((games pd2rs-db:++game-table++)
	       (unprocessed (remove-if (lambda (x) (game-struct-processed? x)) games))
	       (mintime (loop for x in unprocessed 
			   minimize (parse-integer (game-struct-timestamp x)) 
			   into b finally (return b)))
	       (toprocess (remove-if-not 
		      (lambda (x) (equal mintime (parse-integer (game-struct-timestamp x)))) 
		      unprocessed)))
	  (mapcar #'update-game-processed toprocess)
	  (format t "Games retrived from dtatbase... ~%")
	  (mapcar #'convert-game toprocess)))

(defun convert-team (keithteam)
        "Converts a team-struct (Keith's style) to a team (Joe's style)"
	(make-team :teamid (team-struct-team-id keithteam)
		   :elo (team-struct-elo keithteam)
		   :rank (team-struct-rank keithteam)
		   :timestamp (team-struct-timestamp keithteam)))
(defun get-teams ()
  "Returns a list of the most recent team struts, it also sorts by ranking
	from best to worst"
  (format t "Retriveing teams from datatbase... ~%")
  (let* ((teams pd2rs-db:++team-table++)
	(maxtime (loop for x in teams 
		    maximize (parse-integer (team-struct-timestamp x)) 
		    into b finally (return b))))
    (format t "Teams retrived from dtatbase... ~%")
    (mapcar #'convert-team
	    (remove-if-not 
	     (lambda (x) (equal maxtime (parse-integer (team-struct-timestamp x))))
	     teams))))

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
					   (equal (game-losingid testgame) (match-losingid m)))
				      (and (equal (game-winningid testgame) (match-losingid m)) 
					   (equal (game-losingid testgame) (match-winningid m))))
				  (return m)) finally (return NIL)))
(defun makematches (games &aux matches)
  "Takes in a list of game structs and outputs a list of matches"
  '(defparameter *matches* NIL "List of matches")
  (loop for g in games do (let ((x (gameinmatches g matches)))
			    (if x
				(if (equalp (game-winningid g) (match-winningid x))
				    (setf (match-wins x) (+ 1 (match-wins x)))
				    (setf (match-losses x) (+ 1 (match-losses x))))
				(setf matches (append matches (list (make-match :winningid (game-winningid g)
										:losingid (game-losingid g)
										:wins 1
										:losses 0))))))
     finally (return matches)))
(defun match-id (id testteam)
  "If testteam has team id id, return T, else return NIL"
  (if (equal id (team-teamid testteam)) t nil))
(defun elo-input (inteam)
  "returns the old elo of the the team, if it exists
	if not, returns the default elo value"
  (if inteam
      (team-elo inteam)
      *init-elo*))
(defun update-elo (teams matches)
  "Uses the matches to update the teams' elos
	if the team dosn't exist it adds it to teams
	returns the teamlist"
  (loop for m in matches do (let* ((t1 (find (match-winningid m) teams :test #'match-id))
				   (t2 (find (match-losingid  m) teams :test #'match-id))
				   (data (elo (elo-input t1) (elo-input t2) (match-wins m) (match-losses m))))
			      (if t1
				  (setf (team-elo t1) (car data))
				  (setf teams (cons (make-team :teamid (match-winningid m)
							       :elo (car data)
							       :rank 0
							       :timestamp "0") teams)))
			      (if t2
				  (setf (team-elo t2) (cadr data))
				  (setf teams (cons (make-team :teamid (match-losingid m)
							       :elo (cadr data)
							       :rank 0
							       :timestamp "0") teams))))
     finally (return teams)))

(defun calc-elos ()

  (loop named looper doing
					;get the teams, games, and matches
       (let* ((teams (get-teams))
	      (games (get-games))
	      (matches (makematches games))
	      (curtime (game-timestamp (car games))))
					;check to see if games is nil (i.e. the the database has been processed
	 (format t "Calculating Elo for timestamp ~a..." curtime)
	 (if (NULL games) (return-from looper) t)
					;update elo and add new teams
	 (setf teams (update-elo teams matches))
					;sort by elo
	 (sort teams (lambda (x y) (> (team-elo x) (team-elo y))))
					;update rankings and timestamps
	 (loop for i from 1 to (length teams) do (let ((x (nth (- i 1) teams)))
						   (setf (team-rank x) i)
						   (setf (team-rank x) curtime)))
					;write new teams to database
	 (db-newteam teams)))
  
(bordeaux-threads:make-thread #'calc-elos)
