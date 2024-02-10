(in-package #:swank-image/examples)


;;; copied from vecto

(defun feedlike-icon-to-stream (stream)
  "Example copied from vecto, except output is to stream instead of file."
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
    (save-png-stream stream)))


(defun show-feedlike-icon-in-repl ()
  (with-swank-image-stream (s)
    (feedlike-icon-to-stream s)))


;;; copied from cl-svg

(defun one-of (list)
  (nth (random (length list)) list))

(defvar *groovy-test-colors*
  (list
   "rgb(252, 229, 105)"
   "rgb(228, 174, 60)"
   "rgb(212, 228, 164)"
   "rgb(196, 234, 212)"
   "rgb(124, 218, 156)"
   "rgb(244, 128, 20)"
   "rgb(212, 229, 190)"))

(defun svg-elliptical (stream)
  (let ((scene (make-svg-toplevel 'svg-1.1-toplevel :height 500 :width 500)))
    (title scene "Eliptical Grooviness")
    (dotimes (i 310)
      (draw scene (:ellipse :cx (random 500)
                            :cy (random 500)
                            :rx (+ 10 (random 65))
                            :ry (+ 10 (random 65)))
            :stroke "rgb(232, 229, 148)"
            :fill (one-of *groovy-test-colors*)))
    (stream-out stream scene)))

(defun show-svg-elliptical ()
  (with-swank-image-stream (s)
    (svg-elliptical s)))
