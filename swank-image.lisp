;;;; swank-image.lisp

(in-package #:swank-image)


(defmacro with-swank-image-stream ((stream &rest extra-args) &body body)
  "STREAM is bound to a binary output stream.
Write the raw image data to stream and the resulting
image is send to emacs to be displayed in the REPL buffer.

See WRITE-IMAGE-DATA"
  `(progn
     (let ((,stream (flexi-streams:make-in-memory-output-stream)))
       ,@body
       (write-image-data (flexi-streams:get-output-stream-sequence ,stream) ,@extra-args))))

(defun write-image-data (data &rest extra-args)
  "Sends an image to the slime repls.
DATA should be an usb8 array that is accepted by cl-base65:usb8-...
The content should be a valid image that is in a format supported by emacs
and can be automatically detected.

So typically PNG should be fine.
See the image manual about image specs."
  (swank::send-to-emacs 
   (list :write-image
	 (list
	  (append
	   (list
	    :data (cl-base64:usb8-array-to-base64-string data))
	   extra-args))
	 "string")))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
(use-package :vecto)
(defun radiant-lambda (file)
  (with-canvas (:width 90 :height 90)
    (let ((font (get-font "times.ttf"))
          (step (/ pi 7)))
      (set-font font 40)
      (translate 45 45)
      (draw-centered-string 0 -10 #(#x3BB))
      (set-rgb-stroke 1 0 0)
      (centered-circle-path 0 0 35)
      (stroke)
      (set-rgba-stroke 0 0 1.0 0.5)
      (set-line-width 4)
      (dotimes (i 14)
        (with-graphics-state
          (rotate (* i step))
          (move-to 30 0)
          (line-to 40 0)
          (stroke)))
      (save-png-stream file))))


(defun feedlike-icon (file)
  (with-canvas (:width 100 :height 100)
    (set-rgb-fill 1.0 0.65 0.3)
    (rounded-rectangle 0 0 100 100 10 10)
    (fill-path)
    (set-rgb-fill 1.0 1.0 1.0)
    (centered-circle-path 20 20 10)
    (fill-path)
    (flet ((quarter-circle (x y radius)
             (move-to (+ x radius) y)
             (arc x y radius 0 (/ pi 2))))
      (set-rgb-stroke 1.0 1.0 1.0)
      (set-line-width 15)
      (quarter-circle 20 20 30)
      (stroke)
      (quarter-circle 20 20 60)
      (stroke))
    (rounded-rectangle 5 5 90 90 7 7)
    (set-gradient-fill 50 90
                       1.0 1.0 1.0 0.7
                       50 20
                       1.0 1.0 1.0 0.0)
    (set-line-width 2)
    (set-rgba-stroke 1.0 1.0 1.0 0.1)
    (fill-and-stroke)
    (save-png-stream file)))


(defun star-clipping (file)
  (with-canvas (:width 200 :height 200)
    (let ((size 100)
          (angle 0)
          (step (* 2 (/ (* pi 2) 5))))
      (translate size size)
      (move-to 0 size)
      (dotimes (i 5)
        (setf angle (+ angle step))
        (line-to (* (sin angle) size)
                 (* (cos angle) size)))
      (even-odd-clip-path)
      (end-path-no-op)
      (flet ((circle (distance)
               (set-rgba-fill distance 0 0
                              (- 1.0 distance))
               (centered-circle-path 0 0 (* size distance))
               (fill-path)))
        (loop for i downfrom 1.0 by 0.05
              repeat 20 do
              (circle i)))
      (save-png-stream file))))
|#
