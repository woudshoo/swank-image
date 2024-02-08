;;;; package.lisp

(defpackage #:swank-image
  (:use #:cl)
  (:export
   #:with-swank-image-stream
   #:write-image-data))
