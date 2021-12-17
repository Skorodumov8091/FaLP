((lambda () 
         (list (first '(GOAL FUNCTOR CLAUSE (DATA BASE))) (first '(2 5 (5 4 6) 8)) (first '(L (K (K I) U))))))

((lambda (x y z) 
         (cons (first x) (cons (first y) (cons (first z) '())))) 
 '(GOAL FUNCTOR CLAUSE (DATA BASE)) '(2 5 (5 4 6) 8) '(L (K (K I) U)))