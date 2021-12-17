(define (shell-sort lst)
	(if (< (length lst) 1) 
        lst
		(shell-sort-step lst (count-steps lst)) 
    )
)

(define (shell-sort-step lst step)
	(if	(and (= step -1) (!= (length lst) 2))
        lst
        (if (= (length lst) 2) 
         	(if (< (nth 1 lst) (nth 0 lst))
                (swapping lst 0 1)
                lst
            )
         	(sort-shell-the-list step lst (value-step '() step) (value-step '() step) (value-step '() step))
        )
    	
    )  
)

(define (count-steps lst)
	(- (log (length lst) 3) 1)  
)

(define (value-step lst n)
  (cond
    ((= (length lst) 0) (value-step '(1) n))
   	((> (length lst) n) (nth n lst))
   	((value-step (flat(list lst (+ (* 3 (nth (- (length lst) 1) lst)) 1))) n))
   ) 
)


(define (sort-shell-the-list step lst stepValue start currentIndex)
	(cond 
           	((= start (length lst)) 
                (shell-sort-step lst (- step 1)))
            ((< (- currentIndex stepValue) 0) 
                (sort-shell-the-list step lst stepValue (+ start 1) (+ start 1)))
            ((< (nth currentIndex lst) (nth (- currentIndex stepValue) lst))
   				(sort-shell-the-list step (swapping lst (- currentIndex stepValue) currentIndex) stepValue start (- currentIndex stepValue)))
          	( true (sort-shell-the-list step lst stepValue (+ start 1) (+ start 1)))
    ) 
)

(define (swapping lst index1 index2)
 	(flat (list (fill-list lst '() 0 index1) (nth index2 lst) (fill-list lst '() (+ index1 1) index2) (nth index1 lst) (fill-list lst '() (+ index2 1) (length lst))) )
)

(define (fill-list lst newlst index1 index2)
  (cond 
   	((= index1 index2) newlst)
    ( true (fill-list lst (add-element-list newlst (nth index1 lst)) (+ index1 1) index2))
   ) 
)

(define (add-element-list lst element)
	(cons lst element)	  
)

(shell-sort '())
(shell-sort '(5))
(shell-sort '(10 -2))
(shell-sort '(-2 1 -6 0))
(shell-sort '(3 6 2 9 1 6 0 4 -2 40 -3 1 7 0 -13 34 74 23 84 -34 12 4 8 34 64 22 -66 32))