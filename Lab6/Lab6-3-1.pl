/*�������� �� ��, ��� ����� ����� � ������ ������ ������� �� �������� �� �� 3, �� �� 5, �� �� 7.*/
check_solve([A], B):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0.
check_solve([A, B|Tail], �):-
    C is A + B,
    X is C mod 3, X > 0,
    Y is C mod 5, Y > 0,
    Z is C mod 7, Z > 0,
    check_solve([B|Tail], �).

solve([Head|Tail]) :-
    %��������� ���������� ��� ���������� � ������������
    permutation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [Head|Tail]),
    check_solve([Head|Tail], Head).
