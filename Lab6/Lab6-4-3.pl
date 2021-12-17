%≈сли подсписок пустой, то вернуть исходный список
insert_sublist(List1, [], _, List1).
%≈сли исходный список пустой, то вернуть подсписок
insert_sublist([], List2, _, List2).
/*≈сли элемент с которого необходимо вставл€ть список, больше чем количество элементов исходного списка, то подсписок вставить в конец исходного*/
insert_sublist(List1, List2, I, Result) :-
    length(List1, Length),
    Length < I,
    I is Length,
    insert_sublist(List1, List2, I, Result).
%¬ставка подсписка в начало списка.
insert_sublist(List1, [A|B], 1, [A|Result]):- !,
    insert_sublist(List1, B, 1, Result).
%¬ставка подсписка в список, начина€ с i-го элемента
insert_sublist([A|T], List2, I, [A|Result]):-
    I1 is I - 1,
    insert_sublist(T, List2, I1, Result).
