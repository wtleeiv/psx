;;;; package.lisp

(defpackage #:psx
  (:use #:cl)
  (:export #:ps
           #:globals
           #:set-scene
           #:full-canvas-renderer
           #:add-camera
           #:add-window-resize-listener
           #:add-to-scene
           #:animate
           #:make-sphere
           #:make-box
           ))

