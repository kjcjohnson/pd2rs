;;;package.lisp -- defines packages for the backend et al.
;;;Written by Keith Jens Carl Johnson, January 2014

(defpackage #:pd2rs
  (:use #:cl)
  (:export #:start
	   #:stop
	   #:++build-dir++))

(defpackage #:pd2rs-handlers
  (:use #:cl)
  (:export #:root-handler
	   #:team-handler
	   #:search-handler
	   #:about-handler
	   #:team-index-handler))

(defpackage #:pd2rs-db
  (:use #:cl)
  (:export #:++game-table++
	   #:++team-table++
	   #:insert-game
	   #:update-game-processed
	   #:insert-team))

(defpackage #:pd2rs-views
  (:use #:cl)
  (:export #:render-header
	   #:render-footer
	   #:render-in-body
	   #:render-and-substitute
	   #:render-navbar
	   #:render-navbar-to-string))

