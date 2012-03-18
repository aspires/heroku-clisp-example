(in-package :example)

;; Utils
(defun heroku-getenv (target)
  #+ccl (getenv target)
  #+sbcl (sb-posix:getenv target))

;; Database
(defvar *database-url* (heroku-getenv "DATABASE_URL"))

(defun db-params ()
  (let* ((url (second (cl-ppcre:split "//" *database-url*)))
	 (user (first (cl-ppcre:split ":" (first (cl-ppcre:split "@" url)))))
	 (password (second (cl-ppcre:split ":" (first (cl-ppcre:split "@" url)))))
	 (host (first (cl-ppcre:split "/" (second (cl-ppcre:split "@" url)))))
	 (database (second (cl-ppcre:split "/" (second (cl-ppcre:split "@" url))))))
    (list database user password host)))

;; Handlers
(hunchentoot:define-easy-handler (hello-db :uri "/hello-db") (name)
  (cl-who:with-html-output-to-string (s)
    (:html
     (:head
      (:title "Heroku Database"))
     (:body
      (:h1 "Heroku Database")
      (:div
       (:pre "SELECT version();"))
      (:div (format s "~A" (postmodern:with-connection (db-params)
			     (postmodern:query "select version()"))))))))

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
