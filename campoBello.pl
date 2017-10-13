:-include('Logic.pl').
:-include('Interface.pl').

main:-
  initialize_board(Board),
  display_board(Board).
