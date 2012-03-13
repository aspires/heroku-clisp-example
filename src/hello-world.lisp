(in-package :hunchentoot)

(hunchentoot:define-easy-handler (hello-sbcl :uri "/hello-sbcl") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]! ~A ~A, Hunchentoot ~A" name (lisp-implementation-type) (lisp-implementation-version) hunchentoot::*hunchentoot-version*))		   



