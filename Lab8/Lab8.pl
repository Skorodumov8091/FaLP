%Запуск программы
get_answer(Moves) :-
	initial_state(State),
	solve(State, Moves).

%Начальное состояние
initial_state([state(3, 3, 'Левый берег')]).
%Целевое состояние
final_state([state(0, 0, 'Правый берег')|_]).

%Окончание работы программы
solve(State, []):-
    final_state(State).

solve([NewState|ListState], [LastMove|TailMove]) :-
    new_state(NewState, NextState),
    not(my_member(NextState, ListState)),
    move(NewState, NextState, LastMove),
    solve([NextState, NewState|ListState], TailMove).

%Возможный варианты размещение каннибалов и мессионеров на лодке
able_move(Mission, Cannibals):-
    member(Mission, [0, 1, 2]),
    member(Cannibals, [0, 1, 2]),
    (Mission + Cannibals) =< 2, (Mission + Cannibals) > 0.

/*Проверка того, что на берегу осталось не больше каннибалов, чем миссионеров и наоборот*/
able_state(X, Y) :-
    X == Y; X == 0; Y == 0.

%Новое состояние при отправлении на правый берег
new_state(state(Mission1, Cannibals1, 'Левый берег'), state(Mission2, Cannibals2, 'Правый берег')) :-
    able_move(Mission, Cannibals),
    Mission =< Mission1, Cannibals =< Cannibals1,
    Mission2 is (Mission1 - Mission), 
    Cannibals2 is (Cannibals1 - Cannibals),
    able_state(Mission2, Cannibals2).

%Новое состояние при отправлении на левый берег
new_state(state(Mission1, Cannibals1, 'Правый берег'), state(Mission2, Cannibals2, 'Левый берег')) :-
    able_move(Mission, Cannibals),
    Mission2 is (Mission1 + Mission), Cannibals2 is (Cannibals1 + Cannibals),
    Mission2 =< 3, Cannibals2 =< 3,
    MissionR is (3 - Mission2), CannibalsR is (3 - Cannibals2),
    able_state(MissionR, CannibalsR).

%Движение с левого берега на правый
move(state(Mission1, Cannibals1, 'Левый берег'), state(Mission2, Cannibals2, 'Правый берег'), state(Mission, Cannibals, 'На правый берег')) :-
    Mission is (Mission1 - Mission2),
    Cannibals is (Cannibals1 - Cannibals2).

%Движение с правого берега на левый
move(state(Mission1, Cannibals1, 'Правый берег'), state(Mission2, Cannibals2, 'Левый берег'), state(Mission, Cannibals, 'На левый берег')) :-
    Mission is (Mission2 - Mission1),
    Cannibals is (Cannibals2 - Cannibals1).

my_member(Head,[Head|_]).
my_member(Head,[_|Tail]):-
    member(Head,Tail).
