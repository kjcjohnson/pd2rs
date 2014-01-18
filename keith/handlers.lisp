;;;handlers.lisp -- a series of handlers for the site
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-handlers)


(defun root-handler ()

  (pd2rs-views:render-in-body sstr
    (pd2rs-views:render-and-substitute sstr 
				       (merge-pathnames "html/root_body.lhtml"
							pd2rs:++build-dir++)
				       :team-1  "The First team"
				       :team-2  "The Second team"
				       :team-3  "The Bitch team"
				       :team-4  "Yo Mama's team"
				       :team-5  "The Ass-hat team"
				       :team-6  "The Underdog team"
				       :team-7  "The Miserable team"
				       :team-8  "The Sucky team"
				       :team-9  "The Ninth team"
				       :team-10 "The Last team")))


(defun team-handler (name)
  
  (pd2rs-views:render-in-body sstr
    (format sstr "<h1>This is the page for team ~a</h1>"
	    name)))


(defun search-handler (query)

  (pd2rs-views:render-in-body sstr
    (format sstr "<h1>You searched for: ~a</h1>"
	    query)))
