:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('Interface.pl').

main:-
  initialize_board(Board),
  display_board(Board, 6).
