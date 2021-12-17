%������ ���������
solution(Brand, Color):-
    brand(Brand),
    color(Color),
    statement(1, '������', Brand, ResultI1),
    statement(2, '������', Color, ResultI2),
    /*��� ��� ��������, ��� ������������� �������� ��������� ������ ���� ����� ��� ���� ������, ��, �������������, ���� �� ��������� ������ ���� ������, � ������ ��������.*/
    ResultI1 \= ResultI2,
    statement(1,'������', Brand, ResultP1),
    statement(2,'������', Color, ResultP2),
    ResultP1 \= ResultP2,
    statement(1, '�������', Brand, ResultS1),
    statement(2, '�������', Color, ResultS2),
    ResultS1 \= ResultS2.

%�������� ������������ �������
statement(Number, Surname, Statement, 1) :-
    indication(Number, Surname, Statement).
statement(Number, Surname, Statement, 0) :-
    not(indication(Number, Surname, Statement)).

%��������� �������������
indication(1, '������', '������').
indication(2, '������', '�����').
indication(1, '������', '�����').
indication(2, '������', '������').
indication(1, '�������', '��������').
indication(2, '�������', Color) :-
    Color \= '�����'.

%����� �����
brand('������').
brand('�����').
brand('��������').
brand('�������').

%����� �����
color('�����').
color('������').
color('�����').
color('�������').
