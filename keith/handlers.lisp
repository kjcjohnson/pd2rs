;;;handlers.lisp -- a series of handlers for the site
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-handlers)


(defun root-handler ()

  (pd2rs-views:render-in-body sstr
    (format sstr "<h1>This is a test heading!</h1>")))


(defun team-handler (name)
  
  (pd2rs-views:render-in-body sstr
    (format sstr "<h1>This is the page for team ~a</h1>"
	    name)))


(defun search-handler (query)

  (pd2rs-views:render-in-body sstr
    (format sstr "<h1>You searched for: ~a</h1>"
	    query)))
