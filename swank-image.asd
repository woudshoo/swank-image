;;;; swank-image.asd

(asdf:defsystem #:swank-image
  :description "Describe swank-image here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:swank #:cl-base64 #:flexi-streams)
  :components ((:file "package")
               (:file "swank-image")))
