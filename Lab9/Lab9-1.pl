%Запуск программы
solution(Brand, Color):-
    brand(Brand),
    color(Color),
    statement(1, 'Иванов', Brand, ResultI1),
    statement(2, 'Иванов', Color, ResultI2),
    /*Так как известно, что подозреваемые называют правильно только лишь марку или цвет машины, то, следовательно, одно из показаний должно быть ложным, а другое истинным.*/
    ResultI1 \= ResultI2,
    statement(1,'Петров', Brand, ResultP1),
    statement(2,'Петров', Color, ResultP2),
    ResultP1 \= ResultP2,
    statement(1, 'Сидоров', Brand, ResultS1),
    statement(2, 'Сидоров', Color, ResultS2),
    ResultS1 \= ResultS2.

%Проверка допустимости решения
statement(Number, Surname, Statement, 1) :-
    indication(Number, Surname, Statement).
statement(Number, Surname, Statement, 0) :-
    not(indication(Number, Surname, Statement)).

%Показание подозреваемых
indication(1, 'Иванов', 'Жигули').
indication(2, 'Иванов', 'синий').
indication(1, 'Петров', 'Волга').
indication(2, 'Петров', 'черный').
indication(1, 'Сидоров', 'Мерседес').
indication(2, 'Сидоров', Color) :-
    Color \= 'синий'.

%Марки машин
brand('Жигули').
brand('Волга').
brand('Мерседес').
brand('Лимузин').

%Цвета машин
color('синий').
color('черный').
color('белый').
color('красный').
