(define (sum-num lst)
  (cond 
   		((empty? lst) 
         	0)
        ((list? (first lst)) 
         	(+ (sum-num (first lst)) (sum-num (rest lst))))
        ((number? (first lst))
         	(+ (first lst) (sum-num (rest lst))))
        ((sum-num (rest lst)))
        
  )
)

(sum-num '(1 2 3 a b (((c))) (((7 8)))))
(sum-num '(1 ((2 3) 4) 5 6))
(sum-num '(1 ((2 5 3) 4) 5 6))
(sum-num '())
(sum-num '(a b))