(in-package :hunchentoot)

(format t "Am I alive??")
(format t "Dispatch ~A~%" *dispatch-table*)

(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))

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

		   



