%������ ���������
get_answer(Moves) :-
	initial_state(State),
	solve(State, Moves).

%��������� ���������
initial_state([state(3, 3, '����� �����')]).
%������� ���������
final_state([state(0, 0, '������ �����')|_]).

%��������� ������ ���������
solve(State, []):-
    final_state(State).

solve([NewState|ListState], [LastMove|TailMove]) :-
    new_state(NewState, NextState),
    not(my_member(NextState, ListState)),
    move(NewState, NextState, LastMove),
    solve([NextState, NewState|ListState], TailMove).

%��������� �������� ���������� ���������� � ����������� �� �����
able_move(Mission, Cannibals):-
    member(Mission, [0, 1, 2]),
    member(Cannibals, [0, 1, 2]),
    (Mission + Cannibals) =< 2, (Mission + Cannibals) > 0.

/*�������� ����, ��� �� ������ �������� �� ������ ����������, ��� ����������� � ��������*/
able_state(X, Y) :-
    X == Y; X == 0; Y == 0.

%����� ��������� ��� ����������� �� ������ �����
new_state(state(Mission1, Cannibals1, '����� �����'), state(Mission2, Cannibals2, '������ �����')) :-
    able_move(Mission, Cannibals),
    Mission =< Mission1, Cannibals =< Cannibals1,
    Mission2 is (Mission1 - Mission), 
    Cannibals2 is (Cannibals1 - Cannibals),
    able_state(Mission2, Cannibals2).

%����� ��������� ��� ����������� �� ����� �����
new_state(state(Mission1, Cannibals1, '������ �����'), state(Mission2, Cannibals2, '����� �����')) :-
    able_move(Mission, Cannibals),
    Mission2 is (Mission1 + Mission), Cannibals2 is (Cannibals1 + Cannibals),
    Mission2 =< 3, Cannibals2 =< 3,
    MissionR is (3 - Mission2), CannibalsR is (3 - Cannibals2),
    able_state(MissionR, CannibalsR).

%�������� � ������ ������ �� ������
move(state(Mission1, Cannibals1, '����� �����'), state(Mission2, Cannibals2, '������ �����'), state(Mission, Cannibals, '�� ������ �����')) :-
    Mission is (Mission1 - Mission2),
    Cannibals is (Cannibals1 - Cannibals2).

%�������� � ������� ������ �� �����
move(state(Mission1, Cannibals1, '������ �����'), state(Mission2, Cannibals2, '����� �����'), state(Mission, Cannibals, '�� ����� �����')) :-
    Mission is (Mission2 - Mission1),
    Cannibals is (Cannibals2 - Cannibals1).

my_member(Head,[Head|_]).
my_member(Head,[_|Tail]):-
    member(Head,Tail).
