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

%Удалить элемент по индексу
delete_elem_list([_|T], 0, T).
delete_elem_list([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_elem_list(T, N1, T1).
