(in-package #:cl-style)

(defvar style-map (make-hash-table :test 'equal))

(defun output-style-tags ()
  (loop for key being the hash-keys of style-map
        using (hash-value value)
        collect (loop for val in value
                 collect (format nil "~a " val)
                      into result
                finally (return (format nil "<style> ~{~a~} </style>" result)))))

(defun purge ()
  (setf style-map (make-hash-table :test 'equal)))

(defun handle-media-query (class-name query-modifier css)
  (loop for (key val) on (car (cdr (cadadr css))) by #'cddr
        collect (format nil "~a: ~a;" key (if (symbolp val) (string-downcase val) val))
          into result
        finally (return (format nil "@media (~a: ~apx) {
                                       .~a { ~{~a~^ ~} }
                                     }"
                                (string-downcase query-modifier)
                                (caadr css)
                                class-name
                                result))))

(defun handle-non-media-query (class-name css)
  (loop for (key . val) in css
        collect (format nil "~a: ~a;" key (if (symbolp val) (string-downcase val) val))
          into result
        finally (return (format nil ".~a { ~{~a~^ ~} }" class-name result))))

(defmacro defstyle (name styles)
  (let ((class-name (format nil "cl-style-~A" (sxhash (princ-to-string styles))))
        (non-media-css '())
        (all-css '()))
    (loop for (key val) on styles by #'cddr
          if (or (eql :max-width key)
                 (eql :min-width key))
            do (push (handle-media-query class-name key val) all-css)
          else
            do (push `(,key . ,val) non-media-css))
    (push (handle-non-media-query class-name non-media-css) all-css)
    (setf (gethash class-name style-map) all-css)
    `(defvar ,name
       '(:class ,class-name))))
