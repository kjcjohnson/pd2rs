;;;handlers.lisp -- a series of handlers for the site
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-handlers)


(defun root-handler ()

  (pd2rs-views:render-in-body sstr
    (pd2rs-views:render-and-substitute sstr 
				       (merge-pathnames "html/root_body.lhtml"
							pd2rs:++build-dir++)
				       :navbar  (pd2rs-views:render-navbar-to-string)
						
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


(defun team-index-handler ()

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
						  
						  
							
