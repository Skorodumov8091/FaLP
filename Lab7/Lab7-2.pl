game():-
    initial_state(State),
    show(State),
    next_move(State, 0).

%Начальное состояние
initial_state([0,0,0,0,0,0,0,0,0]).

%0 - Незанятое поле
from_symbol_to_digit(0, ' ').
%1 - крестик
from_symbol_to_digit(1, 'x').
%2 - нолик
from_symbol_to_digit(2, 'o').

%Вывод поля игры
show(State) :-
    get_element(State, 0, SymbolA),
    get_element(State, 1, SymbolB),
    get_element(State, 2, SymbolC),
    get_element(State, 3, SymbolD),
    get_element(State, 4, SymbolE),
    get_element(State, 5, SymbolF),
    get_element(State, 6, SymbolG),
    get_element(State, 7, SymbolH),
    get_element(State, 8, SymbolI),
    from_symbol_to_digit(SymbolA, DigitA),
    from_symbol_to_digit(SymbolB, DigitB),
    from_symbol_to_digit(SymbolC, DigitC),
    from_symbol_to_digit(SymbolD, DigitD),
    from_symbol_to_digit(SymbolE, DigitE),
    from_symbol_to_digit(SymbolF, DigitF),
    from_symbol_to_digit(SymbolG, DigitG),
    from_symbol_to_digit(SymbolH, DigitH),
    from_symbol_to_digit(SymbolI, DigitI),
    write("0|"),
    write(DigitA),
    write(DigitB),
    writeln(DigitC),
    write("1|"),
    write(DigitD),
    write(DigitE),
    writeln(DigitF),
    write("2|"),
    write(DigitG),
    write(DigitH),
    writeln(DigitI),
	writeln("  012"),
    writeln("-----------").

%Проверка того, что данное поле свободно
is_free(X, Y, State) :-
    N is (Y * 3 + X),
    get_element(State, N, A),
    A = 0.

%Выполнение хода
make_move(X, Y, State, Symbol, State_next) :-
    is_free(X, Y, State),
    N is (Y * 3 + X),
    delete_element_list(State, N, State1),
    insert_element_list(State1, Symbol, N, State_next),
    show(State_next).

%Проверка того, что победили крестики
check(State) :-
    state_win_x(StateX),
    member(State, [StateX]),
    writeln("Крестики победили"), !.

%Проверка того, что победили нолики
check(State) :-
    state_win_o(StateO),
    member(State, [StateO]),
    writeln("Нолики победили"), !.

%Проверка того, что игра закончилачь ничьей
check(State) :-
    not(member(0, State)),
    writeln("Ничья"), !.

%Ход игрока
next_move(State, N) :-
    I is (N mod 2), I = 0,
    Symbol is 1,
    writeln("Введите номер столбца Вашего хода"),
    read(X),
    writeln("Введите номер строки Вашего хода"),
    read(Y),
    make_move(X, Y, State, Symbol, NewState), !,
    not(check(NewState)),
    N1 is (N + 1),
    next_move(NewState, N1).

%Следующий ход.
next_move(State, N) :-
    I is (N mod 2), I = 1,
    Symbol is 2,
    possible_move_o(State, X, Y),
    make_move(X, Y, State, Symbol, NewState), !,
    not(check(NewState)),
    N1 is (N + 1),
    next_move(NewState, N1).

%Варианты ситуаций игры когда побеждают крестики
state_win_x([1,1,1,_,_,_,_,_,_]).
state_win_x([_,_,_,1,1,1,_,_,_]).
state_win_x([_,_,_,_,_,_,1,1,1]).
state_win_x([1,_,_,1,_,_,1,_,_]).
state_win_x([_,1,_,_,1,_,_,1,_]).
state_win_x([_,_,1,_,_,1,_,_,1]).
state_win_x([1,_,_,_,1,_,_,_,1]).
state_win_x([_,_,1,_,1,_,1,_,_]).

%Варианты ситуаций игры когда побеждают нолики
state_win_o([2,2,2,_,_,_,_,_,_]).
state_win_o([_,_,_,2,2,2,_,_,_]).
state_win_o([_,_,_,_,_,_,2,2,2]).
state_win_o([2,_,_,2,_,_,2,_,_]).
state_win_o([_,2,_,_,2,_,_,2,_]).
state_win_o([_,_,2,_,_,2,_,_,2]).
state_win_o([2,_,_,_,2,_,_,_,2]).
state_win_o([_,_,2,_,2,_,2,_,_]).

%Получение элемента по индексу
get_element([Head|_], 0, Head).
get_element([_|[Head1|Tail]], N, Element) :-
    N1 is (N - 1),
    get_element([Head1|Tail], N1, Element).

%Вставка элемента по индексу
insert_element_list([], Element, 0, [Element]).
insert_element_list([Head|Tail], Element, 0, [Element|[Head|Tail]]).
insert_element_list([Head|Tail], Element, N, [Head|Tail1]) :-
    N1 is (N-1),
    insert_element_list(Tail, Element, N1, Tail1) .

%Удаление элемента по индексу
delete_element_list([_|Tail], 0, Tail).
delete_element_list([Head|Tail], N, [Head|Tail1]) :-
    N1 is (N - 1),
    delete_element_list(Tail, N1, Tail1).

%Если центр не занят, то занимаем его
possible_move_o([_, _,_, _, 0, _, _, _, _], 1, 1) :- !.

%Ситуации, при которых, данный ход является выигрышным, занимаем победную позицию.
possible_move_o([0,2,2,_,_,_,_,_,_], 0, 0) :- !.
possible_move_o([2,0,2,_,_,_,_,_,_], 1, 0) :- !.
possible_move_o([2,2,0,_,_,_,_,_,_], 2, 0) :- !.

possible_move_o([_,_,_,0,2,2,_,_,_], 0, 1) :- !.
possible_move_o([_,_,_,2,0,2,_,_,_], 1, 1) :- !.
possible_move_o([_,_,_,2,2,0,_,_,_], 2, 1) :- !.

possible_move_o([_,_,_,_,_,_,0,2,2], 0, 2) :- !.
possible_move_o([_,_,_,_,_,_,2,0,2], 1, 2) :- !.
possible_move_o([_,_,_,_,_,_,2,2,0], 2, 2) :- !.

possible_move_o([0,_,_,2,_,_,2,_,_], 0, 0) :- !.
possible_move_o([2,_,_,0,_,_,2,_,_], 0, 1) :- !.
possible_move_o([2,_,_,2,_,_,0,_,_], 0, 2) :- !.

possible_move_o([_,0,_,_,2,_,_,2,_], 1, 0) :- !.
possible_move_o([_,2,_,_,0,_,_,2,_], 1, 1) :- !.
possible_move_o([_,2,_,_,2,_,_,0,_], 1, 2) :- !.

possible_move_o([_,_,0,_,_,2,_,_,2], 2, 0) :- !.
possible_move_o([_,_,2,_,_,0,_,_,2], 2, 1) :- !.
possible_move_o([_,_,2,_,_,2,_,_,0], 2, 2) :- !.

possible_move_o([0,_,_,_,2,_,_,_,2], 0, 0) :- !.
possible_move_o([2,_,_,_,0,_,_,_,2], 1, 1) :- !.
possible_move_o([2,_,_,_,2,_,_,_,0], 2, 2) :- !.

possible_move_o([_,_,0,_,2,_,2,_,_], 2, 0) :- !.
possible_move_o([_,_,2,_,0,_,2,_,_], 1, 1) :- !.
possible_move_o([_,_,2,_,2,_,0,_,_], 0, 2) :- !.

%Ситуации, в которой нужно предотвратить выигрыш противника
possible_move_o([0,1,1,_,_,_,_,_,_], 0, 0) :- !.
possible_move_o([1,0,1,_,_,_,_,_,_], 1, 0) :- !.
possible_move_o([1,1,0,_,_,_,_,_,_], 2, 0) :- !.

possible_move_o([_,_,_,0,1,1,_,_,_], 0, 1) :- !.
possible_move_o([_,_,_,1,0,1,_,_,_], 1, 1) :- !.
possible_move_o([_,_,_,1,1,0,_,_,_], 2, 1) :- !.

possible_move_o([_,_,_,_,_,_,0,1,1], 0, 2) :- !.
possible_move_o([_,_,_,_,_,_,1,0,1], 1, 2) :- !.
possible_move_o([_,_,_,_,_,_,1,1,0], 2, 2) :- !.

possible_move_o([0,_,_,1,_,_,1,_,_], 0, 0) :- !.
possible_move_o([1,_,_,0,_,_,1,_,_], 0, 1) :- !.
possible_move_o([1,_,_,1,_,_,0,_,_], 0, 2) :- !.

possible_move_o([_,0,_,_,1,_,_,1,_], 1, 0) :- !.
possible_move_o([_,1,_,_,0,_,_,1,_], 1, 1) :- !.
possible_move_o([_,1,_,_,1,_,_,0,_], 1, 2) :- !.

possible_move_o([_,_,0,_,_,1,_,_,1], 2, 0) :- !.
possible_move_o([_,_,1,_,_,0,_,_,1], 2, 1) :- !.
possible_move_o([_,_,1,_,_,1,_,_,0], 2, 2) :- !.

possible_move_o([0,_,_,_,1,_,_,_,1], 0, 0) :- !.
possible_move_o([1,_,_,_,0,_,_,_,1], 1, 1) :- !.
possible_move_o([1,_,_,_,1,_,_,_,0], 2, 2) :- !.

possible_move_o([_,_,0,_,1,_,1,_,_], 2, 0) :- !.
possible_move_o([_,_,1,_,0,_,1,_,_], 1, 1) :- !.
possible_move_o([_,_,1,_,1,_,0,_,_], 0, 2) :- !.

%Если центр занят, то занимает левый правый угол.
possible_move_o([0, _,_, _, 1, _, _, _, _], 0, 0):- !.

%Если центр заняли мы (o), а игрок занял одну из угловых позиций
possible_move_o([0, _, _, _, 2, _, _, _, 1], 0, 0):- !.
possible_move_o([_, _, 1, _, 2, _, 0, _, _], 0, 2):- !.
possible_move_o([_, _, 0, _, 2, _, 1, _, _], 2, 0):- !.
possible_move_o([1, _, _, _, 2, _, _, _, 0], 2, 2):- !.


%В остальных случаях возможны следующие ходы
possible_move_o(_, 0, 0).
possible_move_o(_, 0, 2).
possible_move_o(_, 2, 0).
possible_move_o(_, 2, 2).
possible_move_o(_, 0, 1).
possible_move_o(_, 1, 0).
possible_move_o(_, 1, 1).
possible_move_o(_, 1, 2).
possible_move_o(_, 2, 1).

%Если центр заняли мы (o), а игрок занял одну из угловых позиций
possible_move_o([0, _, _, _, 2, _, _, _, 1], 0, 0):- !.
possible_move_o([_, _, 1, _, 2, _, 0, _, _], 0, 2):- !.
possible_move_o([_, _, 0, _, 2, _, 1, _, _], 2, 0):- !.
possible_move_o([1, _, _, _, 2, _, _, _, 0], 2, 2):- !.

possible_move_o([_, 0,_, _, 2, _, _, _, 1], 1, 0) :- !.
possible_move_o([_, 0,1, _, 2, _, _, _, _], 1, 0) :- !.
possible_move_o([_, 0,_, _, 2, _, 1, _, _], 1, 0) :- !.
possible_move_o([1, 0,_, _, 2, _, _, _, _], 1, 0) :- !.

%В остальных случаях возможны следующие ходы
possible_move_o(_, 0, 0).
possible_move_o(_, 1, 0).
possible_move_o(_, 2, 0).
possible_move_o(_, 1, 0).
possible_move_o(_, 1, 1).
possible_move_o(_, 1, 2).
possible_move_o(_, 2, 0).
possible_move_o(_, 2, 1).
possible_move_o(_, 2, 2).


