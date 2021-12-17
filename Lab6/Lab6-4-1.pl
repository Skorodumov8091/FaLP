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

%������� ������� �� �������
delete_elem_list([_|T], 0, T).
delete_elem_list([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_elem_list(T, N1, T1).
