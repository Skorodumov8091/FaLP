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
