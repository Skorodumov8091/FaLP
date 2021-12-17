(define (F-let lst n)
  (if (null? lst)
      nil
      (let (x (first lst))
        (cond 
            ((and (= n 1) (atom? x)) x)       
            ((atom? x) (F-let (rest lst) (- n 1)))
            ((F-let (rest lst) n))
        ) 
      )
  )
) 

(F-let '((2) (3) 4 5 а (e r) g) 3)
(F-let '() 3)
(F-let '((2) (3) (e r)) 3)
(F-let '(b) 1)
(F-let '((2) (3) 4 (e r) g) 1)

(define (F-lambda lst n)
  (if (null? lst)
      nil
      ((lambda (x)
          (cond 
            ((and (= n 1) (atom? x)) x)       
            ((atom? x) (F-lambda (rest lst) (- n 1)))
            ((F-lambda (rest lst) n))
        	)        
       ) (first lst) 
      )
  )
) 
 
(F-lambda '((2) (3) 4 5 а (e r) g) 3)
(F-lambda '() 3)
(F-lambda '((2) (3) (e r)) 3)
(F-lambda '(b) 1)
(F-lambda '((2) (3) 4 (e r) g) 1)