(use posix files utils)

(define create-subdirectory
  (lambda ()
    (let ((dir (normalize-pathname (current-directory))))
      (create-directory (make-pathname dir "readme"))
      (change-directory (make-pathname dir "readme")))))

(define copy-readme
  (lambda ()
    (file-copy "../README.markdown" "README.markdown")))

(define commit-all
  (lambda ()
    (system* "git add .")
    (system* "git commit -m 'add readme'")))

(define create-one
  (lambda ()
    (create-subdirectory)
    (copy-readme)
    (commit-all)))

(define repeat-it
  (lambda (counter)
    (cond ((= 0 counter) (create-one))
          (else
           (create-one)
           (repeat-it (sub1 counter))))))
