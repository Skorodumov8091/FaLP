(define (add-letters-in-text txt letters lettersAdd)
  (map (lambda (sentence)
  			(choice-of-words sentence letters lettersAdd)
		) txt)
)

; переборка всех слов в предложение
(define (choice-of-words sentence letters lettersAdd)
	(cond
   		((empty? sentence) '())
   		((cons (add-letters (first sentence) 0 letters lettersAdd) (choice-of-words (rest sentence) letters lettersAdd)))
  	)	  
)

; нахождение в слове заданного 3-х буквенного сочетания и добавление заданного 2-х буквенного сочетания 
(define (add-letters word i letters lettersAdd)
	(cond
    	((> i (- (utf8len word) 3)) (end-word word i))
     	((and (= (word i) (letters 0)) (= (word (+ i 1)) (letters 1)) (= (word (+ i 2)) (letters 2)))
         	(string (word i) (word (+ i 1)) (word (+ i 2)) lettersAdd (add-letters word (+ i 3) letters lettersAdd) ))
     	(true
         	(string (word i) (add-letters word (+ i 1) letters lettersAdd) )) 
    )  
)

(define (end-word word i) 
	(cond
    	((> i (- (utf8len word) 1)) "")
     	( true
         	(string (word i) (end-word word (+ i 1)))
        )
    )  
)

(add-letters-in-text '(("абракадабра")) "абр" "XX")
(add-letters-in-text '(("берег" "беречь" "оберег") ("роббер" "поберу" "бер")) "бер" "ХХ")