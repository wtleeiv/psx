;;;; psx.lisp

(in-package #:psx)

(defmacro ps (&body body)
  `(progn
     (shadow :var)
     (use-package :parenscript)
     (ps:ps-to-stream soc:*soc* ,@body)))

(ps:defpsmacro globals ()
  `(progn
     (defvar scene)
     (defvar camera)
     (defvar renderer)))

(ps:defpsmacro set-scene ()
  `(setf scene (ps:new (ps:chain *three* (*scene)))))

(ps:defpsmacro full-canvas-renderer ()
  `(progn
     (let ((*width* (ps:@ window inner-width)) (*height* (ps:@ window inner-height))))
     (setf renderer (ps:new (ps:chain *three* (*web-g-l-renderer (ps:create antialias t)))))
     (ps:chain renderer (set-size *width* *height*))
     (ps:chain document body (append-child (ps:@ renderer dom-element)))))

(ps:defpsmacro add-camera (angle near far x y z)
  `(progn
     (setf camera (ps:new (ps:chain  *three* (*perspective-camera ,angle (/ *width* *height*) ,near ,far))))
     (ps:chain camera position (set ,x ,y ,z))))

(ps:defpsmacro add-window-resize-listener ()
  `(ps:chain window (add-event-listener "resize" (lambda ()
                                                   (let ((*width* (ps:@ window inner-width))
                                                         (*height* (ps:@ window inner-height)))
                                                     (ps:chain renderer (set-size *width* *height*))
                                                     (setf (ps:chain camera aspect) (/ *width* *height*))
                                                     (ps:chain camera (update-projection-matrix)))))))

(ps:defpsmacro add-to-scene (name)
  `(ps:chain scene (add ,name)))

(ps:defpsmacro animate (&body body)
  `(progn
     (request-animation-frame animate)
     ,@body
     (ps:chain renderer (render scene camera))))

(ps:defpsmacro make-box (name)
  `(progn
     (let ((geometry (ps:new (ps:chain *three* (*box-geometry 2 2 2))))
           (material (ps:new (ps:chain *three* (*mesh-basic-material (ps:create color 0xff0000 wireframe t)))))))
     (setf ,name (ps:new (ps:chain *three* (*mesh geometry material))))))
