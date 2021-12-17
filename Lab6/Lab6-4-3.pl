%���� ��������� ������, �� ������� �������� ������
insert_sublist(List1, [], _, List1).
%���� �������� ������ ������, �� ������� ���������
insert_sublist([], List2, _, List2).
/*���� ������� � �������� ���������� ��������� ������, ������ ��� ���������� ��������� ��������� ������, �� ��������� �������� � ����� ���������*/
insert_sublist(List1, List2, I, Result) :-
    length(List1, Length),
    Length < I,
    I is Length,
    insert_sublist(List1, List2, I, Result).
%������� ��������� � ������ ������.
insert_sublist(List1, [A|B], 1, [A|Result]):- !,
    insert_sublist(List1, B, 1, Result).
%������� ��������� � ������, ������� � i-�� ��������
insert_sublist([A|T], List2, I, [A|Result]):-
    I1 is I - 1,
    insert_sublist(T, List2, I1, Result).
