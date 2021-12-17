%������ ����� �� 1 �� 10
cards([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).

%���������� ��������
records([['������', 11], ['C������', 4], ['������', 7], ['�������', 16], ['������', 17]]).

% ��������� �������� �������� ���������
solve(Wins) :-
    records(Records),
    cards(Cards),
    wins(Records, Cards, Wins), !.

wins([], [], []).
wins([[Name, Summa]|Tail], Cards, [[Name, Number1, Number2]|Rest]) :-
    remove(Number1, Cards, Cards1),
    remove(Number2, Cards1, Cards2),
    Summa is Number1 + Number2,
    wins(Tail, Cards2, Rest).

% ������� ������� �� ������.
remove(Elem, [Elem|Tail], Tail).
remove(Elem, [Head|Tail], [Head|Rest]) :-
        remove(Elem, Tail, Rest).
