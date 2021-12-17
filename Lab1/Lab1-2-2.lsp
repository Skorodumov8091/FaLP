(define (lab1-21 lst1 lst2 lst3 n1 n2 n3)
	(if (and (>= (length lst1) n1) (>= (length lst2) n2) (>= (length lst3) n3))  
      (list (nth (- n1 1) lst1) (nth (- n2 1) lst2) (nth (- n3 1) lst3)) 
      "Error!"
	)
)

(lab1-21 '(GOAL FUNCTOR CLAUSE (DATA BASE)) '(2 5 (5 4 6) 8) '(L (K (K I) U)) 4 3 2)


(define (lab1-22 lst1 lst2 lst3 n1 n2 n3)
	(if (and (>= (length lst1) n1) (>= (length lst2) n2) (>= (length lst3) n3))  
	(cons (nth (- n1 1) lst1) (cons (nth (- n2 1) lst2) (cons (nth (- n3 1) lst3) '())))
	"Error!"
))

(lab1-22 '(GOAL FUNCTOR CLAUSE (DATA BASE)) '(2 5 (5 4 6) 8) '(L (K (K I) U)) 4 3 2)
