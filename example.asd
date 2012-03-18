(asdf:defsystem #:example
  :serial t
  :description "Example cl-heroku application"
  :depends-on (#:hunchentoot
	       #:cl-who)
  :components ((:file "package")
	       (:module :src
			:serial t      
			:components ((:file "hello-world")))))

