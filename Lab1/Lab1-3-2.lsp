(define (lab1-31 lst)
 	(if (>= (length lst) 7)
       (if (and (number? (nth 0 lst)) (number? (nth 2 lst)) (number? (nth 6 lst)))
       	(+ (nth 0 lst) (+ (nth 2 lst) (nth 6 lst)))  
        (last lst)
       )
       "Error!"
))

(lab1-31 '())
(lab1-31 '(a 3 2 2 3 5 6))
(lab1-31 '(8 3 2 2 3 5 6))
(lab1-31 '(8 3 2 2 3 5 a 4))
(lab1-31 '(8 3 2 2 3 5 4 4))


(define (lab1-32 lst)
 	(if (>= (length lst) 7)
       (if (and (number? (nth 0 lst)) (number? (nth 2 lst)) (number? (nth 6 lst)))
       	(add (nth 0 lst) (nth 2 lst) (nth 6 lst))  
        (last lst)
       )
       "Error!"
))

(lab1-32 '())
(lab1-32 '(a 3 2 2 3 5 6))
(lab1-32 '(8 3 2 2 3 5 6))
(lab1-32 '(8 3 2 2 3 5 a 4))
(lab1-32 '(8 3 2 2 3 5 4 4))