;;;init-view.lisp -- handles views and rendering
(in-package #:loon)

(defparameter +++views+++ (make-hash-table))

(defmacro defview (name &key serves)
  `(setf (gethash (to-keyword (quote ,name)) +++views+++) 
	 (merge-pathnames ,serves +++build-dir+++)))

(defmacro! render-view-to-string (name &rest keys)

  `(let ((,g!str-str (make-string-output-stream)))
     (render-view ,g!str-str ,name ,@keys)
     (get-output-stream-string ,g!str-str)))


(defun render-view (os name &rest keys)

  (let* ((pname (gethash name +++views+++))
	 (pname-type (pathname-type pname))
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