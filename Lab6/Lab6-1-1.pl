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
