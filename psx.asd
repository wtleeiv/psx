;;;; psx.asd

(asdf:defsystem #:psx
  :description "Describe psx here"
  :author "Tyler Lee wtleeiv@gmail.com"
  :license "MIT License"
  :depends-on (#:parenscript
               #:soc)
  :serial t
  :components ((:file "package")
               (:file "psx")))

