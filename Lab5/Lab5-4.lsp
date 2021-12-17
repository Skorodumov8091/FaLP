(define (сaesar-cipher txt)
  (map (lambda (sentence)
  			(cipher sentence)
		) txt)
)

; переборка всех слов в предложение
(define (cipher sentence)
	(cond
   		((empty? sentence) '())
   		((cons (cipher-word (first sentence) 0 1) (cipher (rest sentence))))
  	)	  
)

; шифрование слова: каждая буква заменяется на следующую 
(define (cipher-word word i shift)
  	(cond 
    	((> i (- (utf8len word) 1)) "" )
     	((and (<= (char (word i)) (char "Я")) (>= (char (word i)) (char "А")))
        	(string (char (+ (char "А") (mod (+ (- (char (word i)) (char "А")) shift) 32))) (cipher-word word (+ i 1) shift))
        )
     	((and (<= (char (word i)) (char "я")) (>= (char (word i)) (char "а")))
            (string (char (+ (char "а") (mod (+ (- (char (word i)) (char "а")) shift) 32))) (cipher-word word (+ i 1) shift))
        ) 
     	(true (string (word i) (cipher-word word (+ i 1) shift)) )
    )
)

(сaesar-cipher '(("А" "Б" "В" "Э" "Ю" "Я")))
(сaesar-cipher '(("а" "б" "в" "э" "ю" "я")))
(сaesar-cipher '(("абракадабра")))
(сaesar-cipher '(("Шифр" "Цезаря" "также" "известный" "как" "шифр" "сдвига") ("Cимвол" "в" "открытом" "тексте" "заменяется" "символом" "находящимся" "на" "некотором" "постоянном" "числе" "позиций" "левее" "или" "правее" "него" "в" "алфавите")))
(сaesar-cipher '(("Диалект" "newLISP")))