(define (delete-lists-level lst lvl)
   (cond 
    	((null? lst) '())
        ((= lvl 1)
        	(cond 
              ((list? (first lst)) (delete-lists-level (rest lst) lvl))
              ((cons (first lst) (delete-lists-level (rest lst) lvl)))
        	)
        )
        ((atom? (first lst)) (cons (first lst) (delete-lists-level (rest lst) lvl)))
        ((cons (delete-lists-level (first lst) (- lvl 1)) (delete-lists-level (rest lst) lvl)))
   )
)

(delete-lists-level '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 1)
(delete-lists-level '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 2)
(delete-lists-level '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 3)
(delete-lists-level '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 4)