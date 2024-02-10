;;;; swank-image.asd

(asdf:defsystem #:swank-image
  :description "Helper library to show images in the slime repl."
  :author "Wim Oudshoorn <woudshoo@xs4all.nl>"
  :license  "LLGPL"
  :version "0.0.1"
  :serial t
  :depends-on (#:swank #:cl-base64 #:flexi-streams)
  :components ((:file "package")
               (:file "swank-image")))


(asdf:defsystem #:swank-image/examples
  :description "Examples for swank-image"
  :depends-on (#:swank-image #:vecto #:cl-svg)
  :serial t
  :pathname "examples/"
  :components ((:file "package")
	       (:file "examples")))
