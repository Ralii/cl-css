(asdf:defsystem #:cl-style
  :description "Common lisp styles"
  :homepage "https://github.com/ralii/cl-css"
  :author "Lari Saukkonen"
  :license  "Private"
  :pathname #.*default-pathname-defaults*
  :version "0.0.1"
  :serial t
  :build-operation program-op
  :build-pathname "cl-style"
  :entry-point "CL-STYLE::MAIN"
  :depends-on (#:arrow-macros)
  :components ((:file "package")
               (:file "cl-css")))
