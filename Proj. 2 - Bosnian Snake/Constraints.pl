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
  get_direct_neighbors(Board, MiddlePos, Size, DirectNeighbors),
  get_diagonal_neighbors(Board, MiddlePos, Size, DiagonalNeighbors),
  append(DirectNeighbors, DiagonalNeighbors, Neighbors),
  Num1 is 8-Num,
  global_cardinality(Neighbors, [1-Num, 0-Num1]),
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

conectivity(List, Size):-
  constrain_init_final_neighbors(List, Size),
  constrain_vertex(List, Size),
  constrain_first_line(List, Size),
  constrain_last_line(List, Size),
  constrain_first_col(List, Size),
  constrain_last_col(List, Size),
  constrain_middle_connect(List, Size).

constrain_init_final_neighbors(List, Size):-
  TotalSize is Size*Size,
  Pos1 is 2,
  Pos2 is Size+1,
  setof(Cell, (nth1(Pos1, List, Cell);
                nth1(Pos2, List, Cell)), Cells),
  global_cardinality(Cells, [1-1, 0-1]),
  Pos3 is TotalSize-1,
  Pos4 is TotalSize-Size,
  setof(Cell1, (nth1(Pos3, List, Cell1);
                nth1(Pos4, List, Cell1)), Cells1),
  global_cardinality(Cells1, [1-1, 0-1]).

constrain_vertex(List, Size):-
  Vertex1 is Size,
  Vertex2 is Size*Size-(Size-1),
  nth1(Vertex1, List, Elem1),
  nth1(Vertex2, List, Elem2),
  Pos1 is Vertex1-1,
  Pos2 is Vertex1+Size,
  Pos3 is Pos2-1,
  nth1(Pos1, List, Cell1),
  nth1(Pos2, List, Cell2),
  nth1(Pos3, List, DiagonalCell),
  Elem1 #= 1 #=> Cell1 #= 1 #/\ Cell2 #= 1 #/\ DiagonalCell #= 0,
  Pos4 is Vertex2+1,
  Pos5 is Vertex2-Size,
  Pos6 is Pos5+1,
  nth1(Pos4, List, Cell3),
  nth1(Pos5, List, Cell4),
  nth1(Pos6, List, DiagonalCell1),
  Elem2 #= 1 #=> Cell3 #= 1 #/\ Cell4 #= 1 #/\ DiagonalCell1 #= 0.

% constrainBoard([],Size,Size,Size).
%
%
% constrainBoard([H|T],Line,Col,Size):-
%   constrainLine(H,Line,Col,Size)
%
%
% constraiLine(Row,1,1,Size):-
%   constrainLine(Row,1,2,Size).
%
%   constraiLine
%
%
% gelAdjacentElements(Board,Line,Column,Elems):-
%   findall(L-C, adjacent(Line,Column,L,C),Temp),
%   getElem(Board, Temp, Elemns).
%
% getElem(Board,[Line-Column|T],[Head|Tail]):-
%   nth1(Line,Board,Temp),
%   nth1(Colum,Temp,Head),
%   getElem(Board,T,Tail).
%
%
%   getElem(Board, [_,T],Elems):-
%     getElem(Board,T,Elems).
%
%     getElem(_,[],[]).
%
% adjacent(Line,Col,L,C):-
%   L is Line -1,
%   C is Col.
%   adjacent(Line,Col,L,C):-
%     L is Line +1,
%     C is Col.
%
%   adjacent(Line,Col,L,C):-
%       L is Line,
%       C is Col-1.
%
%   adjacent(Line,Col,L,C):-
%         L is Line,
%         C is Col + 1.



constrain_first_col(List, Size):-
  Min is Size+1,
  Max is Size*(Size-2)+1,
  get_col(Min, Max, Size, Col),
  constrain_cells_first_col(List, Col, Size).

constrain_cells_first_col(_, [], _).
constrain_cells_first_col(List, [Elem|Tail], Size):-
  Pos1 is Elem-Size,
  Pos2 is Elem+Size,
  Pos3 is Elem+1,
  setof(Cell, (nth1(Pos1, List, Cell);
                nth1(Pos2, List, Cell);
                nth1(Pos3, List, Cell)), Cells),
  sum(Cells, #=, Sum),
  Elem #= 1 #=> Sum #= 2,
  constrain_cells_first_col(List, Tail, Size).

constrain_last_col(List, Size):-
  Min is 2*Size,
  Max is (Size-1)*Size,
  get_col(Min, Max,Size, Col),
  constrain_cells_last_col(List, Col, Size).

constrain_cells_last_col(_, [], _).
constrain_cells_last_col(List, [Elem|Tail], Size):-
  Pos1 is Elem-Size,
  Pos2 is Elem+Size,
  Pos3 is Elem-1,
  setof(Cell, (nth1(Pos1, List, Cell);
                nth1(Pos2, List, Cell);
                nth1(Pos3, List, Cell)), Cells),
  sum(Cells, #=, Sum),
  Elem #= 1 #=> Sum #= 2,
  constrain_cells_last_col(List, Tail, Size).

constrain_first_line(List, Size):-
  Min is 2,
  Max is Size-1,
  get_line(Min, Max,Line),
  constrain_cells_first_line(List, Line, Size).

constrain_cells_first_line(_, [], _).
constrain_cells_first_line(List, [Elem|Tail], Size):-
  Pos1 is Elem-1,
  Pos2 is Elem+1,
  Pos3 is Elem+Size,
  setof(Cell, (nth1(Pos1, List, Cell);
                nth1(Pos2, List, Cell);
                nth1(Pos3, List, Cell)), Cells),
  sum(Cells, #=, Sum),
  Elem #= 1 #=> Sum #= 2,
  constrain_cells_first_line(List, Tail, Size).

constrain_last_line(List, Size):-
  TotalSize is Size*Size,
  Min is TotalSize-(Size-2),
  Max is Size*Size-1,
  get_line(Min, Max,Line),
  constrain_cells_last_line(List, Line, Size).

constrain_cells_last_line(_, [], _).
constrain_cells_last_line(List, [Elem|Tail], Size):-
  Pos1 is Elem-1,
  Pos2 is Elem+1,
  Pos3 is Elem-Size,
  setof(Cell, (nth1(Pos1, List, Cell);
                nth1(Pos2, List, Cell);
                nth1(Pos3, List, Cell)), Cells),
  sum(Cells, #=, Sum),
  Elem #= 1 #=> Sum #= 2,
  constrain_cells_first_line(List, Tail, Size).

constrain_middle(List, Size):-
  TotalSize is Size * Size,
  Min is 2 + Size,
  Max is TotalSize - Size-1,
  get_middle_cells(Min,Max, Size, MiddleCells),
  constrain_middle_cells(List, MiddleCells, Size).

constrain_middle_cells_connect(_, [], _).
constrain_middle_cells_connect(List, [Elem|Tail], Size):-
  Pos1 is Elem-Size,
  Pos2 is Elem+Size,
  Pos3 is Elem-1,
  Pos4 is Elem+1,
  setof(Cell, (nth1(Pos1, List, Cell);
                nth1(Pos2, List, Cell);
                nth1(Pos3, List, Cell);
                nth1(Pos4, List, Cell)), Cells),
  sum(Cells, #=, Sum),
  Elem #= 1 #=> Sum #= 2,
  constrain_middle_cells_connect(List, Tail, Size).
