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
  `(with-output-to-string (,sstr-symb)
     (render-header ,sstr-symb)
     (progn
       ,@body)
     (render-footer ,sstr-symb)))
