; количество подсписков на указанном уровне
(define (count-lists lst n) 
  (cond ((atom? lst) 0)
        ((null? lst) 0)
        ((zero? n) 
        	(cond 
             ((list? (first lst)) (+ 1 (count-lists (rest lst) 0)))
             (true (count-lists (rest lst) 0))
            )
        )
        (true (+ (count-lists (first lst) (- n 1)) (count-lists (rest lst) n)))
  )
)

(define (number-sublists lst)
	(task lst 0)  
)

; формирование результирующего спииска
(define (task lst start)
  (cond
  	((zero? (count-lists lst start)) (list (list start 0)))
   	(true (cons (list start (count-lists lst start)) (task lst (+ start 1))))
  )
)

(number-sublists '())
(number-sublists '(1 3 4 5))
(number-sublists '(1 3 (1 3 4) 4 (1 2 4 5) 5))
(number-sublists '((1 (1 3 4) 2) (3 (1 2 3 4) 4) 5 6))