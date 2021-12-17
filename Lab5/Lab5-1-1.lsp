;Делает заглавной первую букву первого слова каждого предложения. 
(define (upper-case-first-letter txt)
  (map (lambda (sentence)
       (cons (title-case (first sentence)) (rest sentence))
  ) txt)
)
 
(upper-case-first-letter  '(("дан" "текст") ("Выполнить" "представленное" "задание") ("представить" "отчет" "выполненной" "работы")))
(upper-case-first-letter '(("лабораторная" "работа")))