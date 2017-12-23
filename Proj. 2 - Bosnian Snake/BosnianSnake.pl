:-use_module(library(clpfd)).
:-use_module(library(lists)).
:- use_module(library(between)).
:- include('Constraints.pl').
:- include('Interface.pl').
:- include('Utilities.pl').
:- include('Conectivity.pl').
:- include('GenerateBoards.pl').
:-dynamic puzzle/5.

%puzzle(numero, dimensao, numeros de fora(linha numero), numeros de fora(coluna numero), numeros de dentro(linha coluna numero))
puzzle(1, 6, [2-2, 5-1], [], [5-2-6, 3-5-6]).
puzzle(2, 8, [2-2, 5-1], [7-3], [2-2-4, 7-6-5]).
puzzle(3, 13, [2-4, 5-1,6-1], [7-3], [2-2-4, 7-6-5, 10-10-3]).

solve_generated_board(Size,MiddleRestricions,HorizontalRestrictions,VerticalRestrictions):-
  repeat,
  generateBoard(Size,MiddleRestricions,HorizontalRestrictions,VerticalRestrictions,NPuzzle),
  main(NPuzzle),!.

%N é o número do puzzle
main(N):-
  reset_timer,
  puzzle(N, Size, HorizontalConstraints, VerticalConstraints, MiddleConstraints),
  define_board(Size, List),
  constrain_init_final_cells(List, Size),
  constrain_middle_cells(List, Size, MiddleConstraints),
  list_to_matrix(List,Size,Board),
  constrain_horizontal_lines(Board,HorizontalConstraints),
  constrain_vertical_lines(Board,VerticalConstraints),
  conectivity(List, Size),
  labeling([], List),
  print_time,
  fd_statistics,
  display_board(Board).
