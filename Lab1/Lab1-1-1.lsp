((lambda (x y z) 
         (list (first x) (first y) (first z))) 
 '(H G (U J) (T R)) '(2 1 (+ 4 5)) '(TYPE CHAR REAL (H G)))

((lambda (x y z) 
         (cons (first x) (cons (first y) (cons (first z) '())))) 
 '(H G (U J) (T R)) '(2 1 (+ 4 5)) '(TYPE CHAR REAL (H G)))


((lambda () 
         (list (first '(H G (U J) (T R))) (first '(2 1 (+ 4 5))) (first '(TYPE CHAR REAL (H G))))))