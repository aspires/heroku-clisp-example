(in-package :example)

(defvar *database-url* "postgres://sjxorekfoz:AGMva3s8HwDwtaCqXE7m@ec2-107-20-191-127.compute-1.amazonaws.com/sjxorekfoz")

(defun db-params ()
  (let* ((url (second (cl-ppcre:split "//" *database-url*)))
	 (user (first (cl-ppcre:split ":" (first (cl-ppcre:split "@" url)))))
	 (password (second (cl-ppcre:split ":" (first (cl-ppcre:split "@" url)))))
	 (host (first (cl-ppcre:split "/" (second (cl-ppcre:split "@" url)))))
	 (database (second (cl-ppcre:split "/" (second (cl-ppcre:split "@" url))))))
    (list database user password host)))

;; Database
(unless (postmodern:connected-p postmodern:*database*)
  (apply #'postmodern:connect-toplevel (db-params)))

;; Handlers
(hunchentoot:define-easy-handler (hello-db :uri "/hello-db") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Heroku Database: ~A" (postmodern:query "select version()")))

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
