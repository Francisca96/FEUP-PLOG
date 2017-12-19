:- use_module(library(random)).

place_start_end(Board, TotalSize):-
  I = 7,
  F = 8,
  element(1, Board, I),
  element(TotalSize, Board, F).

place_random_num(_,_,0,_).
place_random_num(Board, TotalSize, Difficulty, UsedCells):-
  random(1, 7, Num),
  TotalSize1 is TotalSize+1,
  random(1, TotalSize1, Index),
  \+ member(Index, UsedCells),
  element(Index, Board, Num),
  Difficulty1 is Difficulty-1,
  place_random_num(Board, TotalSize, Difficulty1, [Index|UsedCells]).

place_random_num(Board, TotalSize, Difficulty, UsedCells):-
  place_random_num(Board, TotalSize, Difficulty, UsedCells).
