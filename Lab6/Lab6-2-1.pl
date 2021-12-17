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
