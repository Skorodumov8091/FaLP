/*Проверка на то, что суммы чисел в концах любого отрезка не делились ни на 3, ни на 5, ни на 7.*/
check_solve([A], B):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0.
check_solve([A, B|Tail], К):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0,
    check_solve([B|Tail], К).

solve([Head|Tail]) :-
    %Генерации размещений без повторений и перестановок
    permutation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [Head|Tail]),
    check_solve([Head|Tail], Head).
