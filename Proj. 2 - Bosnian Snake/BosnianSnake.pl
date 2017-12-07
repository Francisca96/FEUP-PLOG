:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('Interface.pl').
:- include('Board.pl').


main(Size, Difficulty):-
  TotalSize is Size*Size,
  length(Board, TotalSize),
  place_start_end(Board, TotalSize),
  UsedCells = [1, TotalSize],
  place_random_num(Board, TotalSize, Difficulty, UsedCells),
  display_board(Board, Size).
