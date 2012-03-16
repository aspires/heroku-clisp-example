(in-package :example)

;; Database
(unless (postmodern:connected-p postmodern:*database*)
  (postmodern:connect-toplevel "production_test" "postgres" "postgres" "localhost"))

;; Handlers
(hunchentoot:define-easy-handler (hello-db :uri "/hello-db") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "From db: ~A" (postmodern:query (:select '* :from 'accounts))))

(push (hunchentoot:create-folder-dispatcher-and-handler "/static/" "/app/public/")
	 hunchentoot:*dispatch-table*)

(hunchentoot:define-easy-handler (hello-sbcl :uri "/") ()
  (cl-who:with-html-output-to-string (s)
    (:html
     (:head
      (:title "Heroku CL Example App"))
     (:body
      (:h1 "Heroku CL Example App")
      (:h3 "Using")
      (:ul
       (:li (format s "~A ~A" (lisp-implementation-type) (lisp-implementation-version)))
       (:li (format s "Hunchentoot ~A" hunchentoot::*hunchentoot-version*))
       (:li (format s "CL-WHO")))
      (:div
       (:a :href "static/lisp-glossy.jpg" (:img :src "static/lisp-glossy.jpg" :width 100)))
      (:div
       (:a :href "static/hello.txt" "hello"))))))
