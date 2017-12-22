get_line(Min, Max,Line):-
    Count is Max - Min +1,
    To is Min + Count - 1,
    findall(I, (between(Min, To, I)), Line).


get_col(Min,Max,Size,Col):-
  Min is Size +1,
  findall(I,( between(Min, Max, I), 0 is (I-1) mod Size),Col).

get_col(Min, Max, Size,  Col):-
  findall(I,( between(Min, Max, I), 0 is I mod Size),Col).


  get_middle_cells(Min,Max, Size, MiddleCells):-
    findall(I, (between(Min, Max,I),\+ 0 is I mod Size, \+ 0 is (I-1) mod Size),MiddleCells).

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



                reset_timer :- statistics(walltime,_).

                print_time :-
                	statistics(walltime,[_,T]),
                	TS is ((T//10)*10)/1000,
                  nl, write('Solution Time: '), write(TS), write('s'), nl, nl.
                  
