:-use_module(library(clpfd)).
:-use_module(library(lists)).

define_board(Size, Board):-
  Length is Size*Size,
  length(Board, Length),
  domain(Board, 0, 1).

constrain_init_final_cells(Board, Size):-
  Length is Size*Size,
  nth1(1, Board, 1),
  nth1(Length, Board, 1).

constrain_middle_cells(_, _, []).
constrain_middle_cells(Board, Size, [Row-Col-Num|T]):-
  MiddlePos is (Row-1)*Size+Col,
  Pos1 is MiddlePos-Size,
  Pos2 is MiddlePos+Size,
  Pos3 is MiddlePos-1,
  Pos4 is MiddlePos+1,
  Pos5 is Pos1-1,
  Pos6 is Pos1+1,
  Pos7 is Pos2-1,
  Pos8 is Pos2+1,
  setof(Cell, (nth1(Pos1, Board, Cell);
                nth1(Pos2, Board, Cell);
                nth1(Pos3, Board, Cell);
                nth1(Pos4, Board, Cell);
                nth1(Pos5, Board, Cell);
                nth1(Pos6, Board, Cell);
                nth1(Pos7, Board, Cell);
                nth1(Pos8, Board, Cell)), AdjCells),
  Num1 is 8-Num,
  global_cardinality(AdjCells, [1-Num, 0-Num1]),
  constrain_middle_cells(Board, Size, T).

list_to_matrix([], _,[]).
list_to_matrix(List, Size,[Row|Matrix]):-
  list_to_matrix_row(List,Size,Row,Tail),
  list_to_matrix(Tail,Size,Matrix).

list_to_matrix_row(Tail,0,[],Tail).
list_to_matrix_row([Item|List], Size, [Item|Row],Tail):-
  NSize is Size-1,
  list_to_matrix_row(List,NSize,Row,Tail).

rowN([H|_],1,H):-!.
rowN([_|T],I,X) :-
  I1 is I-1,
  rowN(T,I1,X).

columnN([],_,[]).
columnN([H|T], I, [R|X]):-
  rowN(H, I, R),
  columnN(T,I,X).

constrain_vertical_lines(_,[]).
constrain_vertical_lines(Board,[Col-Num|T]):-
  columnN(Board,Col,ColElems),
  sum(ColElems,#=,Num),
  constrain_vertical_lines(Board,T).

constrain_horizontal_lines(_,[]).
constrain_horizontal_lines(Board,[Row-Num|T]):-
  nth1(Row,Board,Line),
  sum(Line,#=,Num),
  constrain_horizontal_lines(Board,T).
