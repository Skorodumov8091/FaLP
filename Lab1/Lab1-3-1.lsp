(define (T31 list1 list2)
 	(if(and(> (length list2)3)(> (length list1)0))
	(list (list (first list1)(nth 3 list2)) (list (nth 2 list2) (last list1)) (list))
	"Fail"
))

(T31 '() '(9 8 3 2))
(T31 '(2) '(9 8 3 2))
(T31 '(2, 3) '(9 8 3))
(T31 '(2, 3) '(9 8 3 2))

(define (T32 list1 list2)
 	(if(and(> (length list2)3)(> (length list1)0))
	(cons (cons (first list1)(nth 3 list2)) (cons (cons (nth 2 list2) (last list1)) (cons '() '())))
	"Fail"
))

(T32 '() '(9 8 3 2))
(T32 '(2) '(9 8 3 2))
(T32 '(2, 3) '(9 8 3))
(T32 '(2, 3) '(9 8 3 2))