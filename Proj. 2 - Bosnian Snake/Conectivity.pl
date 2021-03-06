conectivity(List, Size):-
  constrain_init_final_neighbors(List, Size),
  constrain_vertex(List, Size),
  constrain_last_line(List, Size),
  constrain_first_line(List, Size),
  constrain_first_col(List, Size),
  constrain_last_col(List, Size),
  constrain_middle(List, Size).

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
  nth1(Elem,List,Cell1),
  Cell1 #= 1 #=> Sum #= 2,
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
  nth1(Elem,List,Cell1),
  Cell1 #= 1 #=> Sum #= 2,
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
  nth1(Elem,List,Cell1),
  Cell1 #= 1 #=> Sum #= 2,
  constrain_cells_first_line(List, Tail, Size).

constrain_last_line(List, Size):-
  TotalSize is Size*Size,
  Min is TotalSize-(Size-2),
  Max is TotalSize-1,
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
  nth1(Elem,List,Cell1),
  Cell1 #= 1 #=> Sum #= 2,
  constrain_cells_last_line(List, Tail, Size).

constrain_middle(List, Size):-
  TotalSize is Size * Size,
  Min is 2 + Size,
  Max is TotalSize - Size-1,
  get_middle_cells(Min,Max, Size, MiddleCells),
  constrain_middle_cells_connect(List, MiddleCells, Size).

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
  nth1(Elem,List,Cell1),
  Cell1 #= 1 #=> Sum #= 2,
  constrain_middle_cells_connect(List, Tail, Size).
