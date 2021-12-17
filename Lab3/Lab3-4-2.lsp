(define (max-depth-list lst)
  (cond ((null? lst) 0)
        ((atom? (first lst)) (max-depth-list (rest lst)))
        ((max (+ 1 (max-depth-list (first lst))) (max-depth-list (rest lst))))
  )
)

(max-depth-list '(1 2 3))
(max-depth-list '(1 (2) 3))
(max-depth-list '(1 (3 (2)) 3))
(max-depth-list '(1 (2 (2 (3))) ((3 (2 (3))))))