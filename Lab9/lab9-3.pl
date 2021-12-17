%Список чисел от 1 до 10
cards([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).

%Записанные выигрыши
records([['Петров', 11], ['Cеменов', 4], ['Иванов', 7], ['Сидоров', 16], ['Локтев', 17]]).

% Получение значений реальных выигрышей
solve(Wins) :-
    records(Records),
    cards(Cards),
    wins(Records, Cards, Wins), !.

wins([], [], []).
wins([[Name, Summa]|Tail], Cards, [[Name, Number1, Number2]|Rest]) :-
    remove(Number1, Cards, Cards1),
    remove(Number2, Cards1, Cards2),
    Summa is Number1 + Number2,
    wins(Tail, Cards2, Rest).

% Удалить элемент из списка.
remove(Elem, [Elem|Tail], Tail).
remove(Elem, [Head|Tail], [Head|Rest]) :-
        remove(Elem, Tail, Rest).
