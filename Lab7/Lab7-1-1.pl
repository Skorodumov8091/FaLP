:- use_module(library(pce)).

% Запуск окна меню menu().
menu():-
    new(Main, dialog('Меню')),
    new(Shell, button('Сортировка Шелла', message(@prolog, shell_win))),
    new(Qsort, button('Сортировка Хоара', message(@prolog, qsort_win))),
    new(Number, button('Числа по периметру', message(@prolog, number_win))),
    new(DeleteEl, button('Удалить элементы', message(@prolog, delete_win))),
    new(Exit, button('Выход', message(Main, destroy))),

    send(Main, append, Shell),
    send(Main, append, Qsort, below),
    send(Main, append, Number, below),
    send(Main, append, DeleteEl, below),
    send(Main, append, Exit, below),
    send(Main, open).

% Запуск окна сортировки Шелла
shell_win() :-
    new(Shell, dialog('Сортировка Шелла')),
    new(List, text_item('Список')),
    new(ButtonSort,button('Сортировать', message(@prolog, shell_sort_win, List))),

    send(Shell, append, List),
    send(Shell, append, ButtonSort),
    send(Shell, open).

%Сортировка введенного списка
shell_sort_win(L) :-
    get(L, value, L1),
    split_string(L1, " ", "", LTemp),
    writeln(LTemp),
    convert(LTemp, ListToSort),
    writeln(ListToSort),
    shell_sort(ListToSort, Result),
    shell_sort_result(Result).

%Запуск окна-результата для сортировки Шелла
shell_sort_result(Result) :-
    writeln(Result),
    new(Dialog, dialog("Отсортированный список")),
    new(F, text("Отсортированный список")),
    new(B, button("X")),
    send(Dialog, append, F),
    send(Dialog, append, B),
    send(Dialog, open),
    p(Result, ResultStr),
    send(B, name, ResultStr).

% Запуск окна сортировки Хоара
qsort_win() :-
   new(Qsort, dialog('Сортировка Хоара')),
   new(List1, text_item('Список')),
   new(ButtonSort1,button('Сортировать', message(@prolog, qsort_s_win, List1))),
   send(Qsort, append, List1),
   send(Qsort, append, ButtonSort1),
   send(Qsort, open).

%Сортировка введенного списка
qsort_s_win(L) :-
    get(L, value, L1),
    split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToSort),
    qsort(ListToSort, Result),
    qsort_result(Result).

%Запуск окна-результата сортировки Хоара
qsort_result(Result) :-
    writeln(Result),
    new(Dialog1, dialog("Отсортированный список")),
    new(F1, text("Отсортированный список")),
    new(B1, button("X")),
    send(Dialog1, append, F1),
    send(Dialog1, append, B1),
    send(Dialog1, open),
    p(Result, ResultStr),
    send(B1, name, ResultStr).

% Запуск окна-результа для задания 3
number_win() :-
    solve(Result),
    writeln(Result),
    new(Dialog2, dialog("Решение головоломки")),
    new(F2, text("Последовательность чисел")),
    new(B2, button("X")),
    send(Dialog2, append, F2),
    send(Dialog2, append, B2),
    send(Dialog2, open),
    p(Result, ResultStr),
    send(B2, name, ResultStr).

% Запуск окна задания 4.
delete_win() :-
    new(DeleteI, dialog('Удалить элементы')),
    new(List2, text_item('Список')),
    new(Dig, text_item('I')),
    new(ButtonSort2,button('Изменить список', message(@prolog, delete_s_win, List2, Dig))),
    send(DeleteI, append, List2),
    send(DeleteI, append, Dig),
    send(DeleteI, append, ButtonSort2),
    send(DeleteI, open).

%Удаление из списка элементов на i*n позициях n = 1, 2, 3 ...
delete_s_win(L, N) :-
    get(L, value, L1),
    split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToWork),
    get(N, value, N1),
    atom_number(N1, NRes),
    delete_n_i_elem(ListToWork, NRes, Result),
    delete_result(Result).

%Запуск окна-результата задания 4.
delete_result(Result) :-
    writeln(Result),
    new(Dialog2, dialog("Изменненый список")),
    new(F2, text("Новый список")),
    new(B2, button("X")),
    send(Dialog2, append, F2),
    send(Dialog2, append, B2),
    send(Dialog2, open),
    p(Result, ResultStr),
    send(B2, name, ResultStr).

p([]," ").
p([H|T],S):-
    p(T,SS),
    concat(" ",SS,SSS),
    concat(H,SSS,S).

convert([], []).
convert([H|T], [Elm|L]) :-
    atom_number(H, Elm),
    convert(T,L).

/*Проверка на то, что суммы чисел в концах любого отрезка не делились ни на 3, ни на 5, ни на 7.*/
check_solve([A], B):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0.
check_solve([A, B|Tail], К):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0,
    check_solve([B|Tail], К).

solve([Head|Tail]) :-
    %Генерации размещений без повторений и перестановок
    permutation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [Head|Tail]),
    check_solve([Head|Tail], Head).

%Если на входе пустой список, то удалять ничего не нужно
delete_n_i_elem([], _, []).
%Если на вход подается 1 удаляется весь список
delete_n_i_elem(_, 1, []).
%Если длина списка меньше, чем указанный I, то удалять ничего не нужно
delete_n_i_elem(List, I, List) :-
    length(List, Length),
    Length < I.
/*Удаление из списка элементов, находящихся на (i * n) – х местах, где i задается в качестве аргумента, а в n = 1, 2, 3, …*/
delete_n_i_elem(List, I, Result) :-
    length(List, Length),
    get_number_delete(Length, I, 1, ListDelete),
    reverse(ListDelete, ReverseListDelete),
    delete_list_elem(List, ReverseListDelete, Result).

%Получение списка индексов для удаления
get_number_delete(Length, I, N, ListDelete) :-
    Length >= (I * N), !,
    Value is (I * N - 1),
    NewN is (N + 1),
    get_number_delete(Length, I, NewN, ListDeleteTail),
    ListDelete = [Value|ListDeleteTail];
    ListDelete = [].

%Удалить элементы по списку индексов
delete_list_elem(Result, [], Result).
delete_list_elem(List, [H|T], Result) :-
    delete_elem_list(List, H, TempList),
    delete_list_elem(TempList, T, Result).

%На вход подается пустой список.
qsort([], []).
%На вход подается список из одного элемента.
qsort([Elem], [Elem]).
%Сортировка Хоара
qsort([Head|Tail], ListSort):-
	divide(Tail, Head, GrList, SmList),
	qsort(GrList, GrListSort),
	qsort(SmList, SmListSort), !,
	append(SmListSort, [Head|GrListSort], ListSort).

%Разделение списка на 2 относительно опорного элемента
divide([], _, [], []):-!.
divide([Head|Tail], Elem, [Head|GrList], SmList):-
	Head >= Elem, !,
    divide(Tail, Elem, GrList, SmList).
divide([Head|Tail], Elem, GrList, [Head|SmList]):-
  divide(Tail, Elem, GrList, SmList).

%На вход подается пустой список
shell_sort([], []).
%На вход подается список из 1 элемента
shell_sort(List, List) :-
    length(List, Length),
    Length = 1.
%На вход подается список из 2 элементов, первый элемент меньше
shell_sort([ELEM1, ELEM2|TAIL], [ELEM1, ELEM2]) :-
    length([ELEM1, ELEM2|TAIL], Length),
    Length = 2,
    ELEM1 < ELEM2.
%На вход подается список из 2 элементов, второй элемент меньше
shell_sort([ELEM1, ELEM2|TAIL], [ELEM2, ELEM1]) :-
    length([ELEM1, ELEM2|TAIL], Length),
    Length = 2,
    ELEM1 > ELEM2.
/*Сортировка Шелла. Вычисление последовательности шагов сортировки производится методом, предложенным Дональдом Кнутом. */
shell_sort(List, SortList) :-
    length(List, Length),
    list_steps(Length, Steps),
    shell_sort_steps(List, Steps, SortList).

%Шаги сортировки
shell_sort_steps(SortList, [], SortList).
shell_sort_steps(List, [H|T], SortList) :-
    shell_sort_step(List, H, TempList),
    shell_sort_steps(TempList, T, SortList).

shell_sort_step(List, ValueStep, Result) :-
    shell_sort_step_value(List, ValueStep, 0, ValueStep, Result).

shell_sort_step_value(Result, ValueStep, N1, _, Result) :-
    length(Result, Length),
    Max is (N1 + ValueStep),
    Max >= Length.

shell_sort_step_value(List, ValueStep, N1, N2, Result) :-
    length(List, Length),
    N2 >= Length,
    N3 is (N1 + 1),
    N4 is (N3 + 1),
    shell_sort_step_value(List, ValueStep, N3, N4, Result).

shell_sort_step_value(List, ValueStep, N1, N2, Result) :-
    get_elem(List, N1, Elem1),
    get_elem(List, N2, Elem2),
    Elem1 > Elem2,
    swap_elem(List, N1, N2, NewList),
    N3 is (N2 + ValueStep),
    shell_sort_step_value(NewList, ValueStep, N1, N3, Result).

shell_sort_step_value(List, ValueStep, N1, N2, Result) :-
    get_elem(List, N1, Elem1),
    get_elem(List, N2, Elem2),
    Elem1 =< Elem2,
    N3 is (N2 + ValueStep),
    shell_sort_step_value(List, ValueStep, N1, N3, Result).

%Перестановка элементов
swap_elem(List, N1, N2, NewList) :-
    get_elem(List, N1, Elem1),
    get_elem(List, N2, Elem2),
    delete_elem_list(List, N1, List1),
    insert_list(List1, Elem2, N1, List2),
    delete_elem_list(List2, N2, List3),
    insert_list(List3, Elem1, N2, NewList).

%Вставить элемент в список
insert_list([], Elem, 0, [Elem]).
insert_list([H|T], Elem, 0, [Elem|[H|T]]).
insert_list([H|T], Elem, N, [H|T1]) :-
    N1 is (N - 1),
    insert_list(T, Elem, N1, T1).

%Удалить элемент из списка
delete_elem_list([_|T], 0, T).
delete_elem_list([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_elem_list(T, N1, T1).

%Получить значение элемента по индексу
get_elem([H|_], 0, H).
get_elem([_|[H1|T]], N, Elem) :-
    N1 is (N - 1),
    get_elem([H1|T], N1, Elem).

%Получение последовательности шагов
list_steps(Length, Steps) :-
    count_steps(Length, 2, CountSteps),
	list_steps_temp(CountSteps, Steps).

list_steps_temp(CountSteps, Steps) :-
    CountSteps > -1, !,
    value_step(CountSteps, Value),
    NewCountSteps is (CountSteps - 1),
    list_steps_temp(NewCountSteps, StepsTail),
    Steps = [Value|StepsTail];
    Steps = [].

%Количество шагов сортировки
count_steps(Length, Start, Steps) :-
    Steps is Start - 2,
	Length < 3 ^ Start;
    NextStart is Start + 1,
    count_steps(Length, NextStart, Steps).

%Значение шагов сортировки
value_step(0, 1).
value_step(Step, Value) :-
    Step1 is Step - 1,
    value_step(Step1, Value1),
    Value is 3 * Value1 + 1.




