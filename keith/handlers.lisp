;;;handlers.lisp -- a series of handlers for the site
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-handlers)


(defun root-handler ()

  (let ((latest-ts (remove-if-not #'(lambda (s) 
				      (= (parse-number (pd2rs-db::team-struct-timestamp s))
					 pd2rs-db::++max-timestamp++)) pd2rs-db:++team-table++)))
    (let ((sted (sort latest-ts #'(lambda (a b) (> (pd2rs-db::team-struct-rank a)
						   (pd2rs-db::team-struct-rank b))))))
      

      (pd2rs-views:render-in-body sstr
				  (pd2rs-views:render-and-substitute sstr 
								     (merge-pathnames "html/root_body.lhtml"
										      pd2rs:++build-dir++)
								     :navbar  (pd2rs-views:render-navbar-to-string)
								     
				     :team-1 
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 0 sted))) 
				     :team-2
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 1 sted)))  
				     :team-3  
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 2 sted)))
				     :team-4  
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 3 sted)))
				     :team-5  
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 4 sted)))
				     :team-6  
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 5 sted)))
				     :team-7
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 6 sted)))
				     :team-8  
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 7 sted)))
				     :team-9  
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 8 sted)))
				     :team-10 
				     (pd2rs-db::find-team-by-id (pd2rs-db::team-struct-team-id (nth 9 sted))))))))


(defun team-index-handler ( )

  (pd2rs-views:render-in-body sstr
    (pd2rs-views:render-and-substitute sstr
				       (merge-pathnames "html/team_index.lhtml"
							pd2rs:++build-dir++)
				       :navbar   (pd2rs-views:render-navbar-to-string))))

(defun team-handler (name)
  
  (pd2rs-views:render-in-body sstr
    (pd2rs-views:render-and-substitute sstr
			      (merge-pathnames "html/team.lhtml"
					       pd2rs:++build-dir++)
			      :navbar    (pd2rs-views:render-navbar-to-string)
			      :team-name name)))


(defun search-handler (query)

  (pd2rs-views:render-in-body sstr
    (pd2rs-views:render-and-substitute sstr
			      (merge-pathnames "html/search.lhtml"
					       pd2rs:++build-dir++)
			      :navbar  (pd2rs-views:render-navbar-to-string)
			      :query   query)))


(defun about-handler ()

  (pd2rs-views:render-in-body sstr
    (pd2rs-views:render-and-substitute sstr
				       (merge-pathnames "html/about.lhtml"
							pd2rs:++build-dir++)
				       :navbar  (pd2rs-views:render-navbar-to-string))))
						  
						  
							
