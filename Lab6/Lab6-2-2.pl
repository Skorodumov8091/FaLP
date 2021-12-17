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
