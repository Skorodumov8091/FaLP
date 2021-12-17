;Функция символьного дифференцирования
(define (differential lst)
  (let (element (first lst))
    (cond 
        (
         (= element 'x) 1
        )     
     	(
         (= element '^)
         	(if (and (symbol? (nth 2 lst)) (not (= (nth 2 lst) 'x)) (not (number? (nth 2 lst))))
         		(list '* (nth 2 lst) (list '^ (nth 1 lst) (list '- (nth 2 lst) 1)))
      			(list '* (nth 2 lst) (list '^ (nth 1 lst) (- (nth 2 lst) 1)))
            )
        )     
       	(
         (= element '+)
          	(list '+ (differential (nth 1 lst)) (differential (nth 2 lst)))
        )     
        (
         (= element '-)
        	 (list '- (differential (nth 1 lst)) (differential (nth 2 lst)))
        )     
        (
         (= element '*)
         	(if (and (or (number? (nth 1 lst)) (and (symbol? (nth 1 lst)) (not (= (nth 1 lst) 'x)))) (= (nth 2 lst) 'x))
                (nth 1 lst)
                (if (or (number? (nth 1 lst)) (and (symbol? (nth 1 lst)) (not (= (nth 1 lst) 'x))))
                    (list '* (nth 1 lst) (differential (nth 2 lst))) 
                    (list '+ (list '* (differential (nth 1 lst))(nth 2 lst)) (list '* (differential (nth 2 lst)) (nth 1 lst))))
            )
        )    
        (
         (= element '/)
        	(list '/ (list '- (list '* (differential (nth 1 lst)) (nth 2 lst)) (list '*(differential (nth 2 lst)) (nth 1 lst))) (list '^ (nth 2 lst) 2))
        )
     	(
         (= element 'ln)
        	(list '* (list '^ (nth 1 lst) '-1) (differential (nth 1 lst)))
        )       
     	(
         (or (number? element) (and (symbol? element) (not (= element 'x)))) 0
        )     
     )
  ) 
)

(differential '(4))
(differential '(y))
(differential '(x))
(differential '(+ (x) (3)))
(differential '(^ x 5))
(differential '(+ (^ x 2) (x)))
(differential '(- (* 3 x) (^ x 2)))
(differential '(* 2 x))
(differential '(* (* 2 x) (^ x 5)))
(differential '(/ (* 2 x) (^ x 4)))
(differential '(ln (x)))
(differential '(ln (* 3 x)))
(differential '(* y x))
(differential '(^ x y))
(differential '(* z x))
(differential '(^ x z))