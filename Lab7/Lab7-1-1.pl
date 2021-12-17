:- use_module(library(pce)).

% ������ ���� ���� menu().
menu():-
    new(Main, dialog('����')),
    new(Shell, button('���������� �����', message(@prolog, shell_win))),
    new(Qsort, button('���������� �����', message(@prolog, qsort_win))),
    new(Number, button('����� �� ���������', message(@prolog, number_win))),
    new(DeleteEl, button('������� ��������', message(@prolog, delete_win))),
    new(Exit, button('�����', message(Main, destroy))),

    send(Main, append, Shell),
    send(Main, append, Qsort, below),
    send(Main, append, Number, below),
    send(Main, append, DeleteEl, below),
    send(Main, append, Exit, below),
    send(Main, open).

% ������ ���� ���������� �����
shell_win() :-
    new(Shell, dialog('���������� �����')),
    new(List, text_item('������')),
    new(ButtonSort,button('�����������', message(@prolog, shell_sort_win, List))),

    send(Shell, append, List),
    send(Shell, append, ButtonSort),
    send(Shell, open).

%���������� ���������� ������
shell_sort_win(L) :-
    get(L, value, L1),
    split_string(L1, " ", "", LTemp),
    writeln(LTemp),
    convert(LTemp, ListToSort),
    writeln(ListToSort),
    shell_sort(ListToSort, Result),
    shell_sort_result(Result).

%������ ����-���������� ��� ���������� �����
shell_sort_result(Result) :-
    writeln(Result),
    new(Dialog, dialog("��������������� ������")),
    new(F, text("��������������� ������")),
    new(B, button("X")),
    send(Dialog, append, F),
    send(Dialog, append, B),
    send(Dialog, open),
    p(Result, ResultStr),
    send(B, name, ResultStr).

% ������ ���� ���������� �����
qsort_win() :-
   new(Qsort, dialog('���������� �����')),
   new(List1, text_item('������')),
   new(ButtonSort1,button('�����������', message(@prolog, qsort_s_win, List1))),
   send(Qsort, append, List1),
   send(Qsort, append, ButtonSort1),
   send(Qsort, open).

%���������� ���������� ������
qsort_s_win(L) :-
    get(L, value, L1),
    split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToSort),
    qsort(ListToSort, Result),
    qsort_result(Result).

%������ ����-���������� ���������� �����
qsort_result(Result) :-
    writeln(Result),
    new(Dialog1, dialog("��������������� ������")),
    new(F1, text("��������������� ������")),
    new(B1, button("X")),
    send(Dialog1, append, F1),
    send(Dialog1, append, B1),
    send(Dialog1, open),
    p(Result, ResultStr),
    send(B1, name, ResultStr).

% ������ ����-�������� ��� ������� 3
number_win() :-
    solve(Result),
    writeln(Result),
    new(Dialog2, dialog("������� �����������")),
    new(F2, text("������������������ �����")),
    new(B2, button("X")),
    send(Dialog2, append, F2),
    send(Dialog2, append, B2),
    send(Dialog2, open),
    p(Result, ResultStr),
    send(B2, name, ResultStr).

% ������ ���� ������� 4.
delete_win() :-
    new(DeleteI, dialog('������� ��������')),
    new(List2, text_item('������')),
    new(Dig, text_item('I')),
    new(ButtonSort2,button('�������� ������', message(@prolog, delete_s_win, List2, Dig))),
    send(DeleteI, append, List2),
    send(DeleteI, append, Dig),
    send(DeleteI, append, ButtonSort2),
    send(DeleteI, open).

%�������� �� ������ ��������� �� i*n �������� n = 1, 2, 3 ...
delete_s_win(L, N) :-
    get(L, value, L1),
    split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToWork),
    get(N, value, N1),
    atom_number(N1, NRes),
    delete_n_i_elem(ListToWork, NRes, Result),
    delete_result(Result).

%������ ����-���������� ������� 4.
delete_result(Result) :-
    writeln(Result),
    new(Dialog2, dialog("���������� ������")),
    new(F2, text("����� ������")),
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

/*�������� �� ��, ��� ����� ����� � ������ ������ ������� �� �������� �� �� 3, �� �� 5, �� �� 7.*/
check_solve([A], B):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0.
check_solve([A, B|Tail], �):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0,
    check_solve([B|Tail], �).

solve([Head|Tail]) :-
    %��������� ���������� ��� ���������� � ������������
    permutation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [Head|Tail]),
    check_solve([Head|Tail], Head).

%���� �� ����� ������ ������, �� ������� ������ �� �����
delete_n_i_elem([], _, []).
%���� �� ���� �������� 1 ��������� ���� ������
delete_n_i_elem(_, 1, []).
%���� ����� ������ ������, ��� ��������� I, �� ������� ������ �� �����
delete_n_i_elem(List, I, List) :-
    length(List, Length),
    Length < I.
/*�������� �� ������ ���������, ����������� �� (i * n) � � ������, ��� i �������� � �������� ���������, � � n = 1, 2, 3, �*/
delete_n_i_elem(List, I, Result) :-
    length(List, Length),
    get_number_delete(Length, I, 1, ListDelete),
    reverse(ListDelete, ReverseListDelete),
    delete_list_elem(List, ReverseListDelete, Result).

%��������� ������ �������� ��� ��������
get_number_delete(Length, I, N, ListDelete) :-
    Length >= (I * N), !,
    Value is (I * N - 1),
    NewN is (N + 1),
    get_number_delete(Length, I, NewN, ListDeleteTail),
    ListDelete = [Value|ListDeleteTail];
    ListDelete = [].

%������� �������� �� ������ ��������
delete_list_elem(Result, [], Result).
delete_list_elem(List, [H|T], Result) :-
    delete_elem_list(List, H, TempList),
    delete_list_elem(TempList, T, Result).

%�� ���� �������� ������ ������.
qsort([], []).
%�� ���� �������� ������ �� ������ ��������.
qsort([Elem], [Elem]).
%���������� �����
qsort([Head|Tail], ListSort):-
	divide(Tail, Head, GrList, SmList),
	qsort(GrList, GrListSort),
	qsort(SmList, SmListSort), !,
	append(SmListSort, [Head|GrListSort], ListSort).

%���������� ������ �� 2 ������������ �������� ��������
divide([], _, [], []):-!.
divide([Head|Tail], Elem, [Head|GrList], SmList):-
	Head >= Elem, !,
    divide(Tail, Elem, GrList, SmList).
divide([Head|Tail], Elem, GrList, [Head|SmList]):-
  divide(Tail, Elem, GrList, SmList).

%�� ���� �������� ������ ������
shell_sort([], []).
%�� ���� �������� ������ �� 1 ��������
shell_sort(List, List) :-
    length(List, Length),
    Length = 1.
%�� ���� �������� ������ �� 2 ���������, ������ ������� ������
shell_sort([ELEM1, ELEM2|TAIL], [ELEM1, ELEM2]) :-
    length([ELEM1, ELEM2|TAIL], Length),
    Length = 2,
    ELEM1 < ELEM2.
%�� ���� �������� ������ �� 2 ���������, ������ ������� ������
shell_sort([ELEM1, ELEM2|TAIL], [ELEM2, ELEM1]) :-
    length([ELEM1, ELEM2|TAIL], Length),
    Length = 2,
    ELEM1 > ELEM2.
/*���������� �����. ���������� ������������������ ����� ���������� ������������ �������, ������������ ��������� ������. */
shell_sort(List, SortList) :-
    length(List, Length),
    list_steps(Length, Steps),
    shell_sort_steps(List, Steps, SortList).

%���� ����������
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

%������������ ���������
swap_elem(List, N1, N2, NewList) :-
    get_elem(List, N1, Elem1),
    get_elem(List, N2, Elem2),
    delete_elem_list(List, N1, List1),
    insert_list(List1, Elem2, N1, List2),
    delete_elem_list(List2, N2, List3),
    insert_list(List3, Elem1, N2, NewList).

%�������� ������� � ������
insert_list([], Elem, 0, [Elem]).
insert_list([H|T], Elem, 0, [Elem|[H|T]]).
insert_list([H|T], Elem, N, [H|T1]) :-
    N1 is (N - 1),
    insert_list(T, Elem, N1, T1).

%������� ������� �� ������
delete_elem_list([_|T], 0, T).
delete_elem_list([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_elem_list(T, N1, T1).

%�������� �������� �������� �� �������
get_elem([H|_], 0, H).
get_elem([_|[H1|T]], N, Elem) :-
    N1 is (N - 1),
    get_elem([H1|T], N1, Elem).

%��������� ������������������ �����
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

%���������� ����� ����������
count_steps(Length, Start, Steps) :-
    Steps is Start - 2,
	Length < 3 ^ Start;
    NextStart is Start + 1,
    count_steps(Length, NextStart, Steps).

%�������� ����� ����������
value_step(0, 1).
value_step(Step, Value) :-
    Step1 is Step - 1,
    value_step(Step1, Value1),
    Value is 3 * Value1 + 1.




