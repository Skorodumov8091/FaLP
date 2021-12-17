(define (task lst level)
   (cond 
    	((null? lst) '())
        ((= level 1)
        	(cond 
              ((list? (first lst)) (task (rest lst) level))
              ((cons (first lst) (task (rest lst) level)))
        	)
        )
        ((atom? (first lst)) (cons (first lst) (task (rest lst) level)))
        ((cons (task (first lst) (- level 1)) (task (rest lst) level)))
   )
)

(task '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 1)
(task '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 2)
(task '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 3)
(task '(1 2 3 (1 2 3 (4 5 6) 7 8 (2 (2 4) 3 4) 9) 5) 4)