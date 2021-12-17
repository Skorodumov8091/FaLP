%������ ������
selection_sort([], []).
%������ �� ������ ��������
selection_sort([H], [H]).
%���������� ������� ������� ������
selection_sort(List, SortList):-
  selection_sort(List, [], SortListTemp),
  reverse(SortListTemp, SortList).

selection_sort([], SortList, SortList) :- !.
selection_sort(UnSortPart, SortPart, SortList):-
  min_list(UnSortPart, MinElement),
  delete_single_element(UnSortPart, MinElement, UnSortTail),
  selection_sort(UnSortTail, [MinElement|SortPart], SortList).

%�������� �������� � �������� ���������
delete_single_element(List, Element, ListWithoutElement):-
    select(Element, List, ListWithoutElement), !.
