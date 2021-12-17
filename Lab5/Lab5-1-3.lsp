(define (replace-letter-in-text txt letter lettersReplace)
  (map (lambda (sentence)
  			(choice-of-words sentence letter lettersReplace)
		) txt)
)

; переборка всех слов в предложение
(define (choice-of-words sentence letter lettersReplace)
	(cond
   		((empty? sentence) '())
   		((cons (replace-letter (first sentence) 0 letter lettersReplace) (choice-of-words (rest sentence) letter lettersReplace)))
  	)	  
)

; нахождение в слове заданной литеры и замена её заданной литерой (сочетанием литер) 
(define (replace-letter word i letter lettersReplace)
	(cond
    	((> i (- (utf8len word) 1)) "")
     	((= (word i) letter)
         	(string lettersReplace (replace-letter word (+ i 1) letter lettersReplace) ))
     	(true
         	(string (word i) (replace-letter word (+ i 1) letter lettersReplace) )) 
    )  
)

(replace-letter-in-text '(("абракадабра")) "б" "ку")
(replace-letter-in-text '(("Замена" "литеры")("Сочетание" "литер")) "е" "Е")
(replace-letter-in-text '(("Замена" "литеры")("Сочетание" "литер")) "е" "ОУ")