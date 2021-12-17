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
