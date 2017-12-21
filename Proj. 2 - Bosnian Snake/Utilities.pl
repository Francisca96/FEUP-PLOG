%get_line(Min, Max, LineSize, Line)
%get_col(Min, Max, ColSize, Col)
%get_middle_cells(List, Size, MiddleCells)

get_direct_neighbors(Board, Index, Size, DirectNeighbors):-
  Pos1 is Index-Size,
  Pos2 is Index+Size,
  Pos3 is Index-1,
  Pos4 is Index+1,
  setof(Cell, (nth1(Pos1, Board, Cell);
                nth1(Pos2, Board, Cell);
                nth1(Pos3, Board, Cell);
                nth1(Pos4, Board, Cell)), DirectNeighbors).

get_diagonal_neighbors(Board, Index, Size, DiagonalNeighbors):-
  Pos1 is Index-Size-1,
  Pos2 is Index+Size-1,
  Pos3 is Index-Size+1,
  Pos4 is Index+Size+1,
  setof(Cell, (nth1(Pos1, Board, Cell);
                nth1(Pos2, Board, Cell);
                nth1(Pos3, Board, Cell);
                nth1(Pos4, Board, Cell)), DiagonalNeighbors).
