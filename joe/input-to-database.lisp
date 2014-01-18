(defun pinput ()
	"Gets the next line from the parser, returns as a string"
	(string "Team1 Team2 2003"))

(defun db-newplayer (name)
	"Writes a new player to the database, takes input of the name string.
	Initializes ELO to 1000, sets ranking to -1 (i.e. uninitialized)"
	())
(defun db-newgame (winner loser time)
	"Writes a new game to the database, takes input of three strings")
(defun in-list (testitem testlist)
	"Returns true if testitem is in testlist, otherwise returns NIL
	uses EQUAL as the comparison test"
	(member testitem testlist :test #'EQUAL)
)


(setf *player-list* NIL)
(setf *game-list* NIL)

