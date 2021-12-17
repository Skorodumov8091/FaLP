:- use_module(library(pce)).

% Запуск окна меню
menu():-
    new(Main, dialog('Меню')),
    new(Shell, button('Сортировка Шелла', message(@prolog, shell_win))),
    new(Bubble, button('Сортировка пузырьком', message(@prolog, bubble_win))),
    new(Number, button('Задача "Числа по периметру"', message(@prolog, number_result))),
    new(Rever, button('Реверсировать часть списка', message(@prolog, revers_win))),
    new(Exit, button('Выход', message(Main, destroy))),
    send(Main, append, Shell),
    send(Main, append, Bubble, below),
    send(Main, append, Number, below),
    send(Main, append, Rever, below),
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
bubble_win() :-
   new(Bubble, dialog('Сортировка пузырьком')),
   new(List1, text_item('Список')),
   new(ButtonSort1,button('Сортировать', message(@prolog, bubble_result, List1))),
   send(Bubble, append, List1),
   send(Bubble, append, ButtonSort1),
   send(Bubble, open).

%Сортировка введенного списка и вывод результата в новое окно.
bubble_result(L) :-
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
    bubble_sort(ListToSort, Result),
    p(Result, ResultStr),
    send(B1, name, ResultStr));
    (send(B1, name, " "))).

% Запуск окна-результа для решения задачи №3
number_result() :-
    answer(Result),
    new(Dialog2, dialog("Решение задачи")),
    new(F2, text("Полученная последовательность чисел")),
    new(B2, button(" ")),
    send(Dialog2, append, F2),
    send(Dialog2, append, B2),
    send(Dialog2, open),
    p(Result, ResultStr),
    send(B2, name, ResultStr).

% Запуск окна "Реверсировать часть списка"
revers_win() :-
    new(Rever, dialog('Реверсировать часть списка')),
    new(List2, text_item('Список')),
    new(Dig, text_item('I')),
    new(Dig2, text_item('N')),
    new(ButtonAnswer,button('Изменить список', message(@prolog, revers_result, List2, Dig, Dig2))),
    send(Rever, append, List2),
    send(Rever, append, Dig),
    send(Rever, append, Dig2),
    send(Rever, append, ButtonAnswer),
    send(Rever, open).

%Запуск окна-результата задания 4.
revers_result(L, I, N) :-
    get(L, value, L1),
    new(Dialog3, dialog("Изменённый список")),
    new(F3, text("Изменённый список")),
    new(B3, button(" ")),
    send(Dialog3, append, F3),
    send(Dialog3, append, B3),
    send(Dialog3, open),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToWork),
    get(I, value, I1),
    atom_number(I1, IRes),
    get(N, value, N1),
    atom_number(N1, NRes),
    revers(ListToWork, IRes, NRes, Result),
    p(Result, ResultStr),
    send(B3, name, ResultStr));
    (send(B3, name, " "))).

%Сортировка Шелла
%Пустой список
shell_sort([], []).
%Список из 1 элемента
shell_sort([H], [H]).
%Список из 2 элементов, второй элемент меньше
shell_sort([A, B|TAIL], [B, A]) :-
    length_list([A, B|TAIL], Length),
    Length = 2,
    A > B.
%Список из 2 элементов, первый элемент меньше
shell_sort([A, B|T], [A, B]) :-
    length_list([A, B|T], Length),
    Length = 2,
    A < B.
%Сортировка Шелла.
shell_sort(List, Result) :-
    length_list(List, Length),
    list_steps(Length, Steps),
    shell_sort_steps(List, Steps, Result).

%Проход по шагам сортировки
shell_sort_steps(Result, [], Result).
shell_sort_steps(List, [H|T], Result) :-
    shell_sort_step(List, H, TempList),
    shell_sort_steps(TempList, T, Result).

%Шаг сортировки
shell_sort_step(List, Step, Result) :-
    shell_sort_step_value(List, Step, 0, Step, Result).
shell_sort_step_value(Result, Step, N1, _, Result) :-
    length_list(Result, Length),
    Max is (N1 + Step),
    Max >= Length.
shell_sort_step_value(List, Step, N1, N2, Result) :-
    length_list(List, Length),
    N2 >= Length,
    N3 is (N1 + 1),
    N4 is (N3 + 1),
    shell_sort_step_value(List, Step, N3, N4, Result).
shell_sort_step_value(List, Step, N1, N2, Result) :-
    get_element_list(List, N1, Element1),
    get_element_list(List, N2, Element2),
    Element1 > Element2,
    swap_elem(List, N1, N2, NewList),
    N3 is (N2 + Step),
    shell_sort_step_value(NewList, Step, N1, N3, Result).
shell_sort_step_value(List, Step, N1, N2, Result) :-
    get_element_list(List, N1, Element1),
    get_element_list(List, N2, Element2),
    Element1 =< Element2,
    N3 is (N2 + Step),
    shell_sort_step_value(List, Step, N1, N3, Result).

%Получение последовательности шагов
list_steps(Length, Steps) :-
    number_steps(Length, 2, NumberSteps),
	list_steps_temp(NumberSteps, Steps).

list_steps_temp(NumberSteps, Steps) :-
    NumberSteps > -1, !,
    step_value(NumberSteps, Value),
    NewNumberSteps is (NumberSteps - 1),
    list_steps_temp(NewNumberSteps, StepsTail),
    Steps = [Value|StepsTail];
    Steps = [].

%Количество шагов сортировки
number_steps(Length, Start, Steps) :-
    Steps is Start - 2,
	Length < 3 ^ Start;
    NextStart is Start + 1,
    number_steps(Length, NextStart, Steps).

%Значение шагов сортировки
step_value(0, 1).
step_value(Step, Value) :-
    Step1 is Step - 1,
    step_value(Step1, Value1),
    Value is 3 * Value1 + 1.

%Длина списка
length_list(List, Length):-
	length_list_temp(List, Length, 0).

length_list_temp([], Length, Length).
length_list_temp([_|T], Length, Length1) :-
  Length2 is (Length1 + 1),
  length_list_temp(T, Length, Length2).

%Получить значение элемента по индексу
get_element_list([H|_], 0, H).
get_element_list([_|[H1|T]], N, Element) :-
    N1 is (N - 1),
    get_element_list([H1|T], N1, Element).

%Перестановка элементов
swap_elem(List, N1, N2, NewList) :-
    get_element_list(List, N1, Element1),
    get_element_list(List, N2, Element2),
    delete_element_list(List, N1, List1),
    insert_element_list(List1, Element2, N1, List2),
    delete_element_list(List2, N2, List3),
    insert_element_list(List3, Element1, N2, NewList).

%Вставить элемент в список по индексу
insert_element_list([], Element, 0, [Element]).
insert_element_list([H|T], Element, 0, [Element|[H|T]]).
insert_element_list([H|T], Element, N, [H|T1]) :-
    N1 is (N - 1),
    insert_element_list(T, Element, N1, T1).

%Удалить элемент из списка по индексу
delete_element_list([_|T], 0, T).
delete_element_list([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_element_list(T, N1, T1).

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
%Если список пуст
bubble_sort([], []).
%Если список из 1-го элемента
bubble_sort([H], [H]).

%Сортировка методом пузырька
bubble_sort(SortList, SortList):-
  move_max_to_end(SortList, DoubleSortList),
  SortList = DoubleSortList, !.
bubble_sort(List, SortList):-
  move_max_to_end(List, SortPart),
  bubble_sort(SortPart, SortList).

move_max_to_end([], []):-!.
move_max_to_end([Head], [Head]):-!.
move_max_to_end([First, Second|Tail], [Second|ListWithMaxEnd]):-
  First > Second, !,
  move_max_to_end([First|Tail], ListWithMaxEnd).
move_max_to_end([First, Second|Tail], [First|ListWithMaxEnd]):-
  move_max_to_end([Second|Tail], ListWithMaxEnd).


answer([HeadAnswer|TailAnswer]) :-
    list_number_1_10(L),
    permutation(L, [HeadAnswer|TailAnswer]),
    check_answer([HeadAnswer|TailAnswer], HeadAnswer).

%Список чисел от 1 до 10
list_number_1_10([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).

%Проверка на то, что суммы соседних чисел не делятся ни на 3, ни на 5, ни на 7.
check_answer([A], B):-
    SumAB is A + B,
    X is SumAB mod 3, X > 0,
    Y is SumAB mod 5, Y > 0,
    Z is SumAB mod 7, Z > 0.
check_answer([A, B|Tail], К):-
    SumAB is A + B,
    X is SumAB mod 3, X > 0,
    Y is SumAB mod 5, Y > 0,
    Z is SumAB mod 7, Z > 0,
    check_answer([B|Tail], К).

%Если список пустой
revers([], _, _, []).
%Если i больше, чем длина списка
revers(List, I, _, List) :-
    length(List, Length),
    Length < I.
%Если N больше, чем длина списка
revers(List, I, N, Result) :-
    length(List, Length),
    Length < N,
    NewN is (Length - I + 1),
    revers(List, I, NewN, Result).
%Если i = 1
revers(List, 1, N, Result):-
   rev(List, N, [], Result), !.
%В остальных случаях
revers([HList|TList], I, N, [HList|Result]):-
   In is I - 1,
   revers(TList, In, N, Result).

cnct([], List, List).
cnct([HeadA|TailA], B, [HeadA|Res]):-
   cnct(TailA, B, Res).

rev(List, 0, R, Res):-
   cnct(R, List, Res).
rev([HList|TList], N, R, Res):-
   Nn is N-1,
   rev(TList, Nn, [HList|R], Res).







