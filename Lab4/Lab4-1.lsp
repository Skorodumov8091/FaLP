(define (factorial-let n)
  (let (x (- n 1))
    (if (= n 1) 1 
    	(* n (factorial-let x))
    )
  )
)

(define (factorial-lambda n)
  ((lambda (x)
      (if (= n 1) 1 
      	(* n (factorial-lambda x))
      )
    ) (- n 1)
  )
)

(factorial-let 1)
(factorial-let 3)
(factorial-let 5)
(factorial-lambda 1)
(factorial-lambda 3)
(factorial-lambda 5)