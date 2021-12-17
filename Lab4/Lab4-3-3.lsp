; Функция, которая находит сумму всех числовых элементов исходного списка с использованием локального определения LET
(define (sum-num-let lst)
  (if (empty? lst)
     0
  	 (let ((x (first lst))(l (rest lst))) 
        (cond 
              ((empty? lst) 0)
              ((list? x) 
                  (+ (sum-num x) (sum-num l)))
              ((number? x)
                  (+ x (sum-num l)))
              (true(sum-num l))
        )
      )
  )  
)

(sum-num-let '(1 2 3))
(sum-num-let '(1 2 3 a b (((c))) (((7 8)))))
(sum-num-let '(1 ((2 3) 4) 5 6))
(sum-num-let '(1 ((2 5 3) 4) 5 6))
(sum-num-let '())
(sum-num-let '(a b))

; Функция, которая находит сумму всех числовых элементов исходного списка с использованием локального определения LAMBDA
(define (sum-num-lambda lst)
  (if (empty? lst)
     0
  	 ((lambda (x l) 
        (cond 
              ((empty? lst) 0)
              ((list? x) 
                  (+ (sum-num x) (sum-num l)))
              ((number? x)
                  (+ x (sum-num l)))
              (true(sum-num l))
        )
      )(first lst) (rest lst))
  )  
)

(sum-num-lambda '(1 2 3))
(sum-num-lambda '(1 2 3 a b (((c))) (((7 8)))))
(sum-num-lambda '(1 ((2 3) 4) 5 6))
(sum-num-lambda '(1 ((2 5 3) 4) 5 6))
(sum-num-lambda '())
(sum-num-lambda '(a b))