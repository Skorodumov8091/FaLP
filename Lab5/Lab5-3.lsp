(define (gossip-language txt word)
	(if (empty? txt)
		"empty"
		(func-language (parse (nth 0 (in-sentence txt 0))"-") (parse (nth 0 (in-sentence word 0))"-") 0 (in-sentence txt 0))	
	)
)

;Перевод предложения русского языка на "язык сплетен". Первое слово есть конкатенация первого слога ключего слова и части переводимого слова, оставшейся после отделения от него первого слога. Второе слово есть конкатенация первого слога переводимого слова и части ключевого слова, оставшейся после отделения от него первого слога. 
(define (func-language txtLst wordLst  i sentence)
	(if (< (+ 1 i) (length sentence))
        (flat(list (join(flat(list (nth 0 txtLst) (rest wordLst))))
			(join(flat(list (nth 0 wordLst) (rest txtLst))))
			(func-language (parse (nth (+ 1 i) sentence)"-") wordLst (+ 1 i) sentence)))               
		
        (flat(list (join(flat(list (nth 0 txtLst) (rest wordLst))))
			(join(flat(list (nth 0 wordLst) (rest txtLst)))))) 
	) 
)

(define (in-sentence txt i)
	(chop (in-word (nth i txt) 0))
)

(define (in-word sentence i)
	(if (< i (length sentence))
		(cons (join (add-flag (join (translation-number (nth i sentence) 0)) (join (break-into-letter (nth i sentence) 0)) 0)) (in-word sentence (+ i 1))
        )
	)
)

;Перевод слова в цифры
(define (translation-number word)
  (map letter-to-number (break-into-letter word 0))
)

;Разбиваем слова на буквы
(define (break-into-letter word i)
	(if (< i (utf8len word))
		(flat (list (nth i word) (break-into-letter word (+ i 1))))
        '()
	)
)

;Задаём каждой букве цифру 1-4 (1 - Шумные согласные, 2 - Сонорные согласные, 3 - Гласные, 4 - Й)
(define (letter-to-number letter)
	(cond
    	(
         (or (= letter "п")(= letter "ф")(= letter "т")(= letter "с")(= letter "ш")(= letter "к")(= letter "ц")(= letter "х")(= letter "б")(= letter "в")(= letter "г")(= letter "д")(= letter "ж")(= letter "з")(= letter "щ")(= letter "ч")) 
         "1"
        )
        (
         (or (= letter "м")(= letter "н")(= letter "л")(= letter "р")) 
         "2"
        )
        (
         (or (= letter "а")(= letter "о")(= letter "у")(= letter "ы")(= letter "и")(= letter "э")(= letter "е")(= letter "я")(= letter "ё")(= letter "ю")) 
         "3"
        )   
        (
         (or (= letter "й")) 
         "4"
        )    
	)
)

;Функция, которая добавляет тире при деление слова на слоги
(define (add-flag numberLst letterLst i)
	(if (< i (length numberLst))
        ;Если гласная
		(if (= (nth i numberLst) "3")
			(if (> (+ i 3) (length numberLst)) 	
				(if (= (+ i 1) (length numberLst))   
					(flat(list(nth i letterLst) (add-flag numberLst letterLst (+ i 1))))
					(flat(list (nth i letterLst) (add-flag numberLst letterLst (+ i 1))))
            	)																						
                ;Сочетание двух шумных или двух сонорных согласных отходит к последующему слогу       
				(if  (and(= (nth (+ i 1) numberLst) "1")(= (nth (+ i 2) numberLst) "1"))
                    (if (= (+ i 3) (length numberLst))
                        (flat(list (nth i letterLst) (add-flag numberLst letterLst (+ i 1)))) 
                        (flat(list (nth i letterLst) "-" (add-flag numberLst letterLst (+ i 1))))
                     )
                    ;Сочетание шумного и сонорного отходит к последующему слогу
					(if (and(= (nth (+ i 1) numberLst) "1")(= (nth (+ i 2) numberLst) "2"))  
						(flat(list (nth i letterLst) "-" (add-flag numberLst letterLst (+ i 1))))
                        ;Сочетание сонорного и шумного имеет раздел посередине сочетания.
						(if (and(= (nth (+ i 1) numberLst) "2")(= (nth (+ i 2) numberLst) "1")) 
                            (if (= (+ i 3) (length numberLst))
                       			 (flat(list (nth i letterLst) (add-flag numberLst letterLst (+ i 1)))) 
                       			 (flat(list (nth i letterLst) (nth (+ i 1) letterLst) "-" (add-flag numberLst letterLst (+ i 2))))
                     		)
                            ;Случая с Й
							(if (or (and(= (nth (+ i 1) numberLst) "4") (= (nth (+ i 2) numberLst) "2")) (and (= (nth (+ i 1) numberLst) "4") (= (nth (+ i 2) numberLst) "1"))) 
(flat(list (nth i letterLst) (nth (+ i 1) letterLst) "-" (add-flag numberLst letterLst (+ i 2))))
(flat(list (nth i letterLst) "-" (add-flag numberLst letterLst (+ i 1)))) 
    						)
						)
					)    
				)  
			)
		(flat(list (nth i letterLst) (add-flag numberLst letterLst (+ i 1)))) 
		)
		'()
	)
)

(gossip-language '(("сплетня")) '(("слово")))
(gossip-language '(("фляга")) '(("песня")))
(gossip-language '(("тендер" "бригантина")) '(("волна")))
(gossip-language '(("сбережение" "недруг" "птенец")) '(("зеркало")))