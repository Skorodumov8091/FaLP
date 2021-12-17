:- use_module(library(pce)).

%Окно старта игры
menu():-
    new(Main, dialog('Крестики нолики')),
    new(Start,button('Начать игру', message(@prolog, init))),
    new(Exit,button('Выход', message(Main, destroy))),

    send(Main, append, Start),
    send(Main, append, Exit, below),
    send(Main, open).

%Окно игры
init() :-
    new(Game, dialog('Игра')),
    new(GameField1, button('X')),
    new(GameField2, button('X')),
    new(GameField3, button('X')),

    new(GameField4, button('X')),
    new(GameField5, button('X')),
    new(GameField6, button('X')),

    new(GameField7, button('X')),
    new(GameField8, button('X')),
    new(GameField9, button('X')),

    new(ClickField1,button('1', message(@prolog, change, GameField1, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField2,button('2', message(@prolog, change, GameField2, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField3,button('3', message(@prolog, change, GameField3, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField4,button('4', message(@prolog, change, GameField4, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField5,button('5', message(@prolog, change, GameField5, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField6,button('6', message(@prolog, change, GameField6, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField7,button('7', message(@prolog, change, GameField7, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField8,button('8', message(@prolog, change, GameField8, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),
    new(ClickField9,button('9', message(@prolog, change, GameField9, GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9))),

    send(Game, append, ClickField1),
    send(Game, append, ClickField2, right),
    send(Game, append, ClickField3, right),
    send(Game, append, GameField1, right),
    send(Game, append, GameField2, right),
    send(Game, append, GameField3, right),

    send(Game, append, ClickField4, below),
    send(Game, append, ClickField5, right),
    send(Game, append, ClickField6, right),
    send(Game, append, GameField4, right),
    send(Game, append, GameField5, right),
    send(Game, append, GameField6, right),

    send(Game, append, ClickField7, below),
    send(Game, append, ClickField8, right),
    send(Game, append, ClickField9, right),
    send(Game, append, GameField7, right),
    send(Game, append, GameField8, right),
    send(Game, append, GameField9, right),

    send(Game, open),
    game1([GameField1, GameField2, GameField3, GameField4, GameField5, GameField6, GameField7, GameField8, GameField9]).

%Начально состояние
game1(ListField) :-
    change_field(ListField, [0,0,0,0,0,0,0,0,0]).

%0 - Незанятое поле
from_symbol_to_digit(0, ' ').
%1 - крестик
from_symbol_to_digit(1, 'X').
%2 - нолик
from_symbol_to_digit(2, 'O').

%Изменение состояния полей GameFieldN
change_field(ListField, State) :-
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
    get_element(ListField, 0, A),
    get_element(ListField, 1, B),
    get_element(ListField, 2, C),
    get_element(ListField, 3, D),
    get_element(ListField, 4, E),
    get_element(ListField, 5, F),
    get_element(ListField, 6, G),
    get_element(ListField, 7, H),
    get_element(ListField, 8, I),
    send(A, name, DigitA),
    send(B, name, DigitB),
    send(C, name, DigitC),
    send(D, name, DigitD),
    send(E, name, DigitE),
    send(F, name, DigitF),
    send(G, name, DigitG),
    send(H, name, DigitH),
    send(I, name, DigitI).

change(X, A, B, C, D, E, F, J, H, I) :-
    get(X, name, X1),
    from_symbol_to_digit(N, X1),
    N = 0,
    send(X, name, 'X'),
    get_state([A, B, C, D, E, F, J, H, I], State), !,
    not(check(State)),
    Symbol is 2,
    possible_move_o(State, X0, Y0),
    make_move(X0, Y0, State, Symbol, NewState), !,
    change_field([A, B, C, D, E, F, J, H, I], NewState),
    not(check(NewState)).

%Проверка того, что поле свободно.
is_free(X, Y, State) :-
    N is (Y * 3 + X),
    get_element(State, N, A),
    A = 0.

%Выполнение хода
make_move(X, Y, State, Symbol, State_next) :-
    is_free(X, Y, State),
    N is Y*3+X,
    delete_element_list(State, N, State1),
    insert_element_list(State1, Symbol, N, State_next).

%Проверка того, что победили крестики
check(State) :-
    state_win_x(StateX),
    member(State, [StateX]),
    new(Dialog, dialog("Крестики победили")),
    new(F, text("Крестики победили")),
    send(Dialog, append, F),
    send(Dialog, open), !.

%Проверка того, что победили нолики
check(State) :-
    state_win_o(StateO),
    member(State, [StateO]),
    new(Dialog, dialog("Нолики победили")),
    new(F, text("Нолики победили")),
    send(Dialog, append, F),
    send(Dialog, open), !.

%Проверка того, что игра закончилась ничьей
check(State) :-
    not(member(0, State)),
    new(Dialog, dialog("Ничья")),
    new(F, text("Ничья")),
    send(Dialog, append, F),
    send(Dialog, open),!.

%Варианты ситуаций игры, когда побеждают крестики
state_win_x([1,1,1,_,_,_,_,_,_]).
state_win_x([_,_,_,1,1,1,_,_,_]).
state_win_x([_,_,_,_,_,_,1,1,1]).
state_win_x([1,_,_,1,_,_,1,_,_]).
state_win_x([_,1,_,_,1,_,_,1,_]).
state_win_x([_,_,1,_,_,1,_,_,1]).
state_win_x([1,_,_,_,1,_,_,_,1]).
state_win_x([_,_,1,_,1,_,1,_,_]).

%Варианты ситуаций игры, когда побеждают нолики
state_win_o([2,2,2,_,_,_,_,_,_]).
state_win_o([_,_,_,2,2,2,_,_,_]).
state_win_o([_,_,_,_,_,_,2,2,2]).
state_win_o([2,_,_,2,_,_,2,_,_]).
state_win_o([_,2,_,_,2,_,_,2,_]).
state_win_o([_,_,2,_,_,2,_,_,2]).
state_win_o([2,_,_,_,2,_,_,_,2]).
state_win_o([_,_,2,_,2,_,2,_,_]).

%Получение состояния
get_state(ListField, [A, B, C, D, E, F, G, H, I]) :-
    get_element(ListField, 0, A2),
    get_element(ListField, 1, B2),
    get_element(ListField, 2, C2),
    get_element(ListField, 3, D2),
    get_element(ListField, 4, E2),
    get_element(ListField, 5, F2),
    get_element(ListField, 6, G2),
    get_element(ListField, 7, H2),
    get_element(ListField, 8, I2),
    get(A2, name, A1),
    get(B2, name, B1),
    get(C2, name, C1),
    get(D2, name, D1),
    get(E2, name, E1),
    get(F2, name, F1),
    get(G2, name, G1),
    get(H2, name, H1),
    get(I2, name, I1),
    from_symbol_to_digit(A, A1),
    from_symbol_to_digit(B, B1),
    from_symbol_to_digit(C, C1),
    from_symbol_to_digit(D, D1),
    from_symbol_to_digit(E, E1),
    from_symbol_to_digit(F, F1),
    from_symbol_to_digit(G, G1),
    from_symbol_to_digit(H, H1),
    from_symbol_to_digit(I, I1).

%Получение элемента по индексу
get_element([Head|_], 0, Head).
get_element([_|[Head1|Tail]], N, Element) :-
    N1 is (N - 1),
    get_element([Head1|Tail], N1, Element).

%Вставка элемента по индексу
insert_element_list([], Element, 0, [Element]).
insert_element_list([Head|Tail], Element, 0, [Element|[Head|Tail]]).
insert_element_list([Head|Tail], Element, N, [Head|Tail1]) :-
    (N1 is N - 1),
    insert_element_list(Tail, Element, N1, Tail1).

%Удаление элемента по индексу
delete_element_list([_|Tail], 0, Tail).
delete_element_list([Head|Tail], N, [Head|Tail1]) :-
    N1 is (N - 1),
    delete_element_list(Tail, N1, Tail1).

%Если центр не занят, то занимаем его
possible_move_o([_, _,_, _, 0, _, _, _, _], 1, 1) :- !.

%Ситуация при которой, данный ход является выигрышным
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

%Если центр занят, то занимает левый правый угл.
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










