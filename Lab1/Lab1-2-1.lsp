(define (T21 list1 list2 list3 index1 index2 index3)
	(if(and(> (length list1)index1)(> (length list2)index2)(> (length list3)index3))  
	(list (nth index1 list1)(nth index2 list2)(nth index3 list3)) 
	"Fail!"
))

(T21 '(H G (U J) (T R)) '(2 1 (+ 4 5)) '(TYPE CHAR REAL
(H G)) 3 3 3)
(T21 '(H G (U J) (T R)) '(2 1 (+ 4 5) 4) '(TYPE CHAR REAL
(H G)) 3 3 3)

(define (T22 list1 list2 list3 indexlist)
	(if(and(= (length indexlist)3)(> (length list1)(first indexlist))(> (length list2)(first (rest indexlist)))(> (length list3)(last indexlist)))  
	(list (nth (first indexlist) list1)(nth (first(rest indexlist)) list2)(nth (last indexlist) list3)) 
	"Fail!"
))

(T22 '(H G (U J) (T R)) '(2 1 (+ 4 5)) '(TYPE CHAR REAL (H G)) '(3 3 3))
(T22 '(H G (U J) (T R)) '(2 1 (+ 4 5) 4) '(TYPE CHAR REAL (H G)) '(3 3 3))

(define (T23 list1 list2 list3 index1 index2 index3)
	(if (and (> (length list1) index1) (> (length list2) index2) (> (length list3) index3))  
	(cons (nth index1 list1) (cons (nth index2 list2) (cons (nth index3 list3) '())))
	"Fail!"
))

(T23 '(H G (U J) (T R)) '(2 1 (+ 4 5)) '(TYPE CHAR REAL (H G)) 3 3 3) 
(T23 '(H G (U J) (T R)) '(2 1 (+ 4 5) 4) '(TYPE CHAR REAL (H G)) 3 3 3)