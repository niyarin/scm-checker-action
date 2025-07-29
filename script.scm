(import (scheme process-context)
        (scheme base)
        (scheme write)
        (only (srfi 1) append-map)
        (prefix (scm-check code-warning) w/)
        (prefix (scm-check reader) schk-rdr/)
        (prefix (scm-check checkers) checkers/))

(define (check-file filename)
  (let-values (((code debug-info) (schk-rdr/read-super filename)))
    (append-map
      checkers/check-code
      code
      debug-info)))

(define (print-warn warn)
  (let ((pos-pair (schk-rdr/position->pair (w/code-warning->pos warn)))
        (filename (schk-rdr/position->filename (w/code-warning->pos warn))))
    (display "::warning file=")
    (display filename)
    (display ",line=")
    (display (car pos-pair))
    (display ",col=")
    (display (cdr pos-pair))
    (display " ")
    (display (w/code-warning->message warn))
    (display " ")
    (write (w/code-warning->code warn))
    (display " =>")
    (for-each (lambda (x) (write x)) (w/code-warning->suggestion warn))
    (newline)))

(define (main)
  (let ((args (command-line)))
    (for-each
      (lambda (filename)
        (for-each
          (lambda (warn) (print-warn warn))
          (check-file filename)))
      (cdr args))))

(main)
