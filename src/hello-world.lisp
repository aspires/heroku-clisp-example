(in-package :hunchentoot)

(hunchentoot:define-easy-handler (hello-sbcl :uri "/hello-sbcl") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]! ~A ~A" name (lisp-implementation-type) (lisp-implementation-version)))

;(publish :path "/"
;	 :function #'(lambda (req ent)
;		       (with-http-response (req ent)
;			 (with-http-body (req ent)
;			   (html
;			    (:h1 "Hello World")
;			    (:princ "Congratulations, you are running Lisp on Heroku!!!")
;			    :p
;			    ((:img :src "lisp-glossy.jpg"))
;			    )))))
;
;(publish-directory
; :prefix "/"
; :destination "./public/"
; )

		   



