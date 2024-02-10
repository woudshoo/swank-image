;;;; swank-image.lisp

(in-package #:swank-image)


(defmacro with-swank-image-stream ((stream &rest extra-args) &body body)
  "STREAM is bound to a binary output stream.
Write the raw image data to stream and the resulting
image is send to emacs to be displayed in the REPL buffer.

See WRITE-IMAGE-DATA"
  `(progn
     (let ((,stream
	     (flexi-streams:make-flexi-stream
	      (flexi-streams:make-in-memory-output-stream))))
       ,@body
       (write-image-data (flexi-streams:get-output-stream-sequence
			  (flexi-streams:flexi-stream-stream,stream))
			 ,@extra-args))))

(defun write-image-data (data &rest extra-args)
  "Sends an image to the slime repls.
DATA should be an usb8 array that is accepted by cl-base65:usb8-...
The content should be a valid image that is in a format supported by emacs
and can be automatically detected.

So typically PNG should be fine.
See the elisp manual about image specs."
  (swank::send-to-emacs 
   (list :write-image
	 (list
	  (append
	   (list
	    :data (cl-base64:usb8-array-to-base64-string data))
	   extra-args))
	 "string")))

