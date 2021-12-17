; Функция, которая удаляет все i+n – е элементы списка с использованием локального определения LET
(define (del-let lst n)
  (if (<= (length lst) n)
      lst
      (let (x (first lst))
        (cond	
         	((zero? n) '()) 
            ((cons x (del-let (rest lst) (- n 1))))   
        )    
      )
   )
)

; Функция, которая удаляет все i+n – е элементы списка с использованием локального определения LAMBDA
(define (del-lambda lst n)
  (if (<= (length lst) n)
      lst
      ((lambda (x)
        (cond	
         	((zero? n) '()) 
            ((cons x (del-lambda (rest lst) (- n 1))))   
        )    
      )(first lst))
   )
)

(del-let '() 3)
(del-let '(2 4) 2)
(del-let '(2 4) 0)
(del-let '(4 3 3 2) 3)
(del-let '(4 3 9 3 8 3 2) 4)
(del-lambda '() 3)
(del-lambda '(2 4) 2)
(del-lambda '(2 4) 0)
(del-lambda '(4 3 3 2) 3)
(del-lambda '(4 3 9 3 8 3 2) 4)