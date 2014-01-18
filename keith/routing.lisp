;;;routing.lisp -- a file containing all the dispatch routing info
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs)

(hunchentoot:define-easy-handler (post-new-data :uri "/post/data") 
    ((data :request-type :both) (auth :request-type :both))

  (if (null (string= auth ++auth-token++))
      (progn
        (setf (hunchentoot:return-code*) hunchentoot:+http-forbidden+)
	(hunchentoot:send-headers))
      (progn
	(bordeaux-threads:make-thread #'(lambda () (data-conv data)))
	(format nil "Post processing"))))


(hunchentoot:define-easy-handler (root-view :uri "/") ()
  (pd2rs-handlers:root-handler))

(hunchentoot:define-easy-handler (team-view :uri "/team") (name)
  (pd2rs-handlers:team-handler name))

(hunchentoot:define-easy-handler (search-view :uri "/search") (query)
  (pd2rs-handlers:seach-handler query))