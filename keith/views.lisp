;;;views.lisp -- implements various page-printing functions
;;;Written by Keith Jens Carl Johnson, January 2014
;;;

(in-package :pd2rs-views)

(defun copy-file-to-stream ( sstr pname )

  (with-open-file (fstream pname)
    (let ((echos (make-echo-stream fstream sstr)))
      (handler-case
	  (loop doing (read-line echos))
	(END-OF-FILE () nil)))))

(defun render-header ( sstr )
  "Copies the standard header to the string stream."
  (copy-file-to-stream sstr (merge-pathnames "html/header.html" pd2rs::++build-dir++)))

(defun render-footer( sstr )
  "Copies the standard footer to the string stream."
  (copy-file-to-stream sstr (merge-pathnames "html/footer.html" pd2rs::++build-dir++)))

(defmacro render-in-body ( sstr-symb &body body )
  "Wraps a page in header and footer."
  `(with-output-to-string (,sstr-symb)
     (render-header ,sstr-symb)
     (progn
       ,@body)
     (render-footer ,sstr-symb)))

(defun mkstr ( &rest args )
  (with-output-to-string ( s )
    (dolist (a args) (princ a s))))

(defmacro to-keyword ( symb )
  `(intern (mkstr ,symb) (find-package :keyword)))

(defun group (source n)
  (if (zerop n) (error "group of Zero Length!"))
  (labels ((rec (source acc)
	     (let ((rest (nthcdr n source)))
	       (if (consp rest)
		   (rec rest (cons 
			      (subseq source 0 n)
			      acc))
		   (nreverse
		    (cons source acc))))))
    (if source (rec source nil) nil)))

(defun render-and-substitute ( os pname &rest keys )
  "Opens, copies, and substitutes a lhtml file."
  (let* ((pname-type (pathname-type pname))
	 (g-keys (group keys 2)))
  (if (string= pname-type "lhtml")
      (progn
	(let ((sstr (make-string-output-stream))
	      (echo nil)
	      (chara nil)
	      (charb nil))
	  (with-open-file (file pname 
				:direction :input)
	    (setf echo (make-echo-stream file sstr))
	    (handler-case
		(loop
		   (setf chara (read-char file))
		   (if (char= chara #\<)
		       (progn
			 (setf charb (read-char file))
			 (if (char= charb #\:)
			     (let ((kwstr (make-string-output-stream)))
			       (loop until (char= (setf chara (read-char file))
						  #\>) doing
				    (write-char chara kwstr))
			       (format os "~a" 
				       (cadr 
					(find (to-keyword (intern 
							   (string-upcase (get-output-stream-string kwstr))))
					      g-keys
					      :test #'(lambda (a b) (eql a (car b)))))))

			     (format os "~c~c" #\< charb)))
		       (write-char chara os)))
	      (END-OF-FILE () t)))))
	  
	  

      (progn
	(with-open-file (file pname
			 :direction :input)
	  (let ((echo (make-echo-stream file os)))
	    (handler-case
		(loop 
		   (read-line echo))
	      (END-OF-FILE () t))))))))
  
