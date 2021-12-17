(define (del lst n)
  (if (< (length lst) n)
      lst
      (cond	((zero? n) '()) 
            ((cons (first lst) (del (rest lst) (- n 1))))   
      )
   )
)

(del '() 3)
(del '(2 4) 3)
(del '(4 3 3 2) 3)
(del '(4 3 9 3 8 3 2) 4)