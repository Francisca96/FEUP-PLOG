:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('Interface.pl').

main:-
  initialize_board(36, Board),
  display_board(Board, 6).
