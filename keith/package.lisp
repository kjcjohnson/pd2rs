;;;package.lisp -- defines packages for the backend et al.
;;;Written by Keith Jens Carl Johnson, January 2014

(defpackage #:pd2rs
  (:use #:cl)
  (:export #:start
	   #:stop))

(defpackage #:pd2rs-handlers
  (:use #:cl)
  (:export #:root-handler
	   #:team-handler
	   #:search-handler))

(defpackage #:pd2rs-db
  (:use #:cl))

(defpackage #:pd2rs-views
  (:use #:cl)
  (:export #:render-header
	   #:render-footer
	   #:render-in-body))

