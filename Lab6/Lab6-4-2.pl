%���� ������ ������
revers([], _, _, []).
%���� i ������, ��� ����� ������
revers(List, I, _, List) :-
    length(List, Length),
    Length < I.
%���� N ������, ��� ����� ������
revers(List, I, N, Result) :-
    length(List, Length),
    Length < N,
    NewN is (Length - I + 1),
    revers(List, I, NewN, Result).
%���� i = 1
revers(List, 1, N, Result):-
   rev(List, N, [], Result), !.
%� ��������� �������
revers([HList|TList], I, N, [HList|Result]):-
   In is I - 1,
   revers(TList, In, N, Result).

cnct([], List, List).
cnct([HeadA|TailA], B, [HeadA|Res]):-
   cnct(TailA, B, Res).

rev(List, 0, R, Res):-
   cnct(R, List, Res).
rev([HList|TList], N, R, Res):-
   Nn is N-1,
   rev(TList, Nn, [HList|R], Res).
