:- use_module(library(pce)).

% Запуск окна меню
menu():-
    new(Main, dialog('Меню')),
    new(Shell, button('Сортировка Шелла', message(@prolog, shell_win))),
    new(Bubble, button('Сортировка прямым выбором', message(@prolog, selection_win))),
    new(Number, button('Задача "Числа по периметру"', message(@prolog, number_result))),
    new(Inser, button('Вставка подсписка в список', message(@prolog, insert_win))),
    new(Exit, button('Выход', message(Main, destroy))),
    send(Main, append, Shell),
    send(Main, append, Bubble, below),
    send(Main, append, Number, below),
    send(Main, append, Inser, below),
    send(Main, append, Exit, below),
    send(Main, open).

% Запуск окна сортировки Шелла
shell_win() :-
    new(Shell, dialog('Сортировка Шелла')),
    new(List, text_item('Список')),
    new(ButtonSort,button('Сортировать', message(@prolog, shell_result, List))),
    send(Shell, append, List),
    send(Shell, append, ButtonSort),
    send(Shell, open).

%Сортировка введенного списка и вывод результата в новое окно.
shell_result(L) :-
    get(L, value, L1),
    new(Dialog, dialog("Отсортированный список")),
    new(F, text("Отсортированный список")),
    new(B, button(" ")),
    send(Dialog, append, F),
    send(Dialog, append, B),
    send(Dialog, open),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToSort),
    shell_sort(ListToSort, Result),
    p(Result, ResultStr),
    send(B, name, ResultStr));
    (send(B, name, " "))).

% Запуск окна сортировки пузырьком
selection_win() :-
   new(Bubble, dialog('Сортировка прямым выбором')),
   new(List1, text_item('Список')),
   new(ButtonSort1,button('Сортировать', message(@prolog, selection_result, List1))),
   send(Bubble, append, List1),
   send(Bubble, append, ButtonSort1),
   send(Bubble, open).

%Сортировка введенного списка и вывод результата в новое окно.
selection_result(L) :-
    get(L, value, L1),
    new(Dialog1, dialog("Отсортированный список")),
    new(F1, text("Отсортированный список")),
    new(B1, button(" ")),
    send(Dialog1, append, F1),
    send(Dialog1, append, B1),
    send(Dialog1, open),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToSort),
    selection_sort(ListToSort, Result),
    p(Result, ResultStr),
    send(B1, name, ResultStr));
    (send(B1, name, " "))).

% Запуск окна-результа для решения задачи №3
number_result() :-
    get_answer(Result),
    new(Dialog2, dialog("Решение задачи")),
    new(F2, text("Решение задачи")),
    new(B2, button(" ")),
    send(Dialog2, append, F2),
    send(Dialog2, append, B2),
    send(Dialog2, open),
    p(Result, ResultStr),
    send(B2, name, ResultStr).

% Запуск окна "Вставка подсписка в список".
insert_win() :-
    new(Rever, dialog('Вставка подсписка в список')),
    new(List2, text_item('Список')),
    new(SubList, text_item('Подсписок')),
    new(Dig2, text_item('I')),
    new(ButtonAnswer,button('Изменить список', message(@prolog, insert_result, List2, SubList, Dig2))),
    send(Rever, append, List2),
    send(Rever, append, SubList),
    send(Rever, append, Dig2),
    send(Rever, append, ButtonAnswer),
    send(Rever, open).

%Запуск окна-результата задания 4.
insert_result(L, S, I) :-
    get(L, value, L1),
    new(Dialog3, dialog("Изменённый список")),
    new(F3, text("Изменённый список")),
    new(B3, button(" ")),
    send(Dialog3, append, F3),
    send(Dialog3, append, B3),
    send(Dialog3, open),
    get(I, value, I1),
    atom_number(I1, IRes),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToWork),
    get(S, value, S1),
    (S1 \= '',
    (split_string(S1, " ", "", STemp),
    convert(STemp, SubListToWork),
    insert_sublist(ListToWork, SubListToWork, IRes, Result),
    p(Result, ResultStr),
    send(B3, name, ResultStr));
    (insert_sublist(ListToWork, [], IRes, Result),
    p(Result, ResultStr),
    send(B3, name, ResultStr))));
    (get(S, value, S1),
    (S1 \= '',
    (split_string(S1, " ", "", STemp),
    convert(STemp, SubListToWork),
    insert_sublist([], SubListToWork, IRes, Result),
    p(Result, ResultStr),
    send(B3, name, ResultStr));
    (send(B3, name, " "))))).

%Сортировка Шелла
%Пустой список
shell_sort([], []).
%Список из одного элемента
shell_sort([H], [H]).
shell_sort([H, H1|Tail], [H1, H]) :-
    length([H, H1|Tail], Length),
    Length = 2,
    H1 < H.
%Сортировка Шелла
shell_sort(List, Result) :-
    get_steps(List, Steps),
    shell_sort_steps(List, Steps, Result).

%Получение списка шагов
get_steps(List, Result) :-
    length_list(List, Length),
    get_steps_temp(Length, Result, [], 1, 1).
get_steps_temp(Length, Result, Result, _, Element) :-
    (Element * 3) > Length.
get_steps_temp(Length, Result, List, N, Element) :-
    get_step(N, Element1),
    N1 is (N + 1),
    insert_element_in_list(List, Element, 0, List3),
    get_steps_temp(Length, Result, List3, N1, Element1).

%Значение одного шага по методу Р. Седжвика
get_step(N, Result) :-
    get_step_temp(1, Result, 0, N).
get_step_temp(0, Result, Result, _).
get_step_temp(Length, Result, 0, N) :-
     Y is (N mod 2),
     Y = 1,
     pow_element(2, N, Result1),
     N3 is ((N+1) div 2),
     pow_element(2, N3, Result2),
     H is (8 * Result1 - 6 * Result2 + 1),
     Length1 is (Length - 1),
     get_step_temp(Length1, Result, H, N).
get_step_temp(Length, Result, 0, N) :-
     Y is (N mod 2),
     Y = 0,
     pow_element(2, N, Result1),
     N3 is (N div 2),
     pow_element(2, N3, Result2),
     H is (9 * Result1 - 9 * Result2 + 1),
     Length1 is (Length - 1),
     get_step_temp(Length1, Result, H, N).

%Проход по списку шагов
shell_sort_steps(Result, [], Result).
shell_sort_steps(List, [H|T], Result) :-
    shell_sort_step(List, H, List1),
    shell_sort_steps(List1, T, Result).

%Шаг сортировки Шелла
shell_sort_step(List, Step, Result) :-
    shell_sort_step_temp(List, Step, 0, Step, Result).

shell_sort_step_temp(Result, Step, N1, _, Result) :-
length_list(Result, Length),
    Maximum is (N1 + Step),
    Maximum >= Length.
shell_sort_step_temp(List, Step, N1, N2, Result) :-
length_list(List, Length),
    N2 >= Length,
    N3 is (N1 + 1),
    N4 is (N3 + Step),
    shell_sort_step_temp(List, Step, N3, N4, Result).
shell_sort_step_temp(List, Step, N1, N2, Result) :-
    element_n(List, N1, Element1),
    element_n(List, N2, Element2),
    Element1 > Element2,
    swap_elements(List, N1, N2, List1),
    N3 is (N2 + Step),
    shell_sort_step_temp(List1, Step, N1, N3, Result).
shell_sort_step_temp(List, Step, N1, N2, Result) :-
    element_n(List, N1, Element1),
    element_n(List, N2, Element2),
    Element1 =< Element2,
    N3 is (N2 + Step),
    shell_sort_step_temp(List, Step, N1, N3, Result).

%Получить элемент по индексу
element_n([H|_], 0, H).
element_n([_|[H1|T]], N, Element) :-
    N1 is (N - 1),
    element_n([H1|T], N1, Element).

%Вставка элемента в список
insert_element_in_list([], Element, 0, [Element]).
insert_element_in_list([H|T], Element, 0, [Element|[H|T]]).
insert_element_in_list([H|T], Element, N, [H|T1]) :-
    N1 is (N - 1),
    insert_element_in_list(T, Element, N1, T1) .

%Удалить элемент из списка по индексу
delete_element([_|T], 0, T).
delete_element([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_element(T, N1, T1).

%Перестановка элементов
swap_elements(List, N1, N2, NewList) :-
    element_n(List, N1, Element1),
    element_n(List, N2, Element2),
    delete_element(List, N1, List1),
    insert_element_in_list(List1, Element2, N1, List2),
    delete_element(List2, N2, List3),
    insert_element_in_list(List3, Element1, N2, NewList).

%Возвести число в степень
pow_element(Number, Degree, Result) :-
   pow_element_temp(Number, Degree, Result, 0, 1).

pow_element_temp(_, Degree, Result, Degree, Result).
pow_element_temp(Number, Degree, Result, Degree1, Result1) :-
    Degree2 is (Degree1 + 1),
    Result2 is (Result1 * Number),
    pow_element_temp(Number, Degree, Result, Degree2, Result2).

%Длина списка
length_list(List, Length):-
    length_list_temp(List, Length, 0).

length_list_temp([], Length, Length).
length_list_temp([_|T], Length, Length1) :-
    Length2 is (Length1 + 1),
    length_list_temp(T, Length, Length2).

p([]," ").
p([H|T],S):-
    p(T,SS),
    concat(" ",SS,SSS),
    concat(H,SSS,S).

convert([], []).
convert([H|T], [Elm|L]) :-
    atom_number(H, Elm),
    convert(T,L).

%Сортировка пузырьком
%Пустой список
selection_sort([], []).
%Список из одного элемента
selection_sort([H], [H]).
%Сортировка методом прямого выбора
selection_sort(List, SortList):-
  selection_sort(List, [], SortListTemp),
  reverse(SortListTemp, SortList).

selection_sort([], SortList, SortList) :- !.
selection_sort(UnSortPart, SortPart, SortList):-
  min_list(UnSortPart, MinElement),
  delete_single_element(UnSortPart, MinElement, UnSortTail),
  selection_sort(UnSortTail, [MinElement|SortPart], SortList).

%Удаления элемента с заданным значением
delete_single_element(List, Element, ListWithoutElement):-
    select(Element, List, ListWithoutElement), !.

get_answer([H|T]) :-
    my_permutation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [H|T]),
    check([H|T], H).

%Генерации размещений без повторений и перестановок
my_permutation(List, Permutation):-
  length(List, Length),
  permutation_temp(List, Length, Permutation).

permutation_temp(_List, 0, []):-!.
permutation_temp(List, PermutationLength, [H|PermutationTail]):-
  member(H, List),
  delete(List, H, ListTail),
  PermutationTailLength is (PermutationLength - 1),
  permutation_temp(ListTail, PermutationTailLength, PermutationTail).

/*Проверка на то, что суммы соседних чисел не делились ни на 3, ни на 5, ни на 7.*/
check([A], B):-
    Sum is A + B,
    X is Sum mod 3, X > 0,
    Y is Sum mod 5, Y > 0,
    Z is Sum mod 7, Z > 0.
check([A, B|T], К):-
    Sum is A + B,
    X is Sum mod 3, X > 0,
    Y is Sum mod 5, Y > 0,
    Z is Sum mod 7, Z > 0,
    check([B|T], К).


%Если подсписок пустой, то вернуть исходный список
insert_sublist(List1, [], _, List1).
%Если исходный список пустой, то вернуть подсписок
insert_sublist([], List2, _, List2).
/*Если элемент с которого необходимо вставлять список, больше чем количество элементов исходного списка, то подсписок вставить в конец исходного*/
insert_sublist(List1, List2, I, Result) :-
    length(List1, Length),
    Length < I,
    I is Length,
    insert_sublist(List1, List2, I, Result).
%Вставка подсписка в начало списка.
insert_sublist(List1, [A|B], 1, [A|Result]):- !,
    insert_sublist(List1, B, 1, Result).
%Вставка подсписка в список, начиная с i-го элемента
insert_sublist([A|T], List2, I, [A|Result]):-
    I1 is I - 1,
    insert_sublist(T, List2, I1, Result).








