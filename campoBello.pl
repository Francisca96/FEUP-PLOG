:-include('Logic.pl').
:-include('Interface.pl').
:-include('Menus.pl').

main:-
  initialize_board(Board),
  display_board(Board).
