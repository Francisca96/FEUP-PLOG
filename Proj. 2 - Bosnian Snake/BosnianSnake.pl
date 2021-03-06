:-use_module(library(clpfd)).
:-use_module(library(lists)).
:- use_module(library(between)).
:-use_module(library(timeout)).
:- include('Constraints.pl').
:- include('Interface.pl').
:- include('Utilities.pl').
:- include('Conectivity.pl').
:- include('GenerateBoards.pl').
:-dynamic puzzle/5.

%puzzle(numero, dimensao, numeros de fora(linha numero), numeros de fora(coluna numero), numeros de dentro(linha coluna numero))
puzzle(1, 6, [5-1, 2-2], [], [5-2-6, 3-5-6]).
puzzle(2, 7, [4-2], [], [3-2-3, 4-3-1]).
puzzle(4, 10, [8-3],[3-6],[8-4-2,8-8-1]).
puzzle(3, 8, [5-2,6-2],[2-4],[2-4-5]).
puzzle(5,15, [7-9,12-7],[2-13],[11-3-4]).

solve_generated_board(Size,MiddleRestricions,HorizontalRestrictions,VerticalRestrictions):-
  repeat,
  generateBoard(Size,MiddleRestricions,HorizontalRestrictions,VerticalRestrictions,NPuzzle),
  time_out(main(NPuzzle),2000,Result),
  nl,write(Result),nl,!,
  (Result = time_out ->solve_generated_board(Size,MiddleRestricions,HorizontalRestrictions,VerticalRestrictions);write('Bye!')).

%N é o número do puzzle
main(N):-
  puzzle(N, Size, HorizontalConstraints, VerticalConstraints, MiddleConstraints),
  define_board(Size, List),
  constrain_init_final_cells(List, Size),
  constrain_middle_cells(List, Size, MiddleConstraints),
  list_to_matrix(List,Size,Board),
  constrain_horizontal_lines(Board,HorizontalConstraints),
  constrain_vertical_lines(Board,VerticalConstraints),
  conectivity(List, Size),
  count(1, List, #=, Count),
  reset_timer,
  labeling([ffc], List),
  print_time,
  fd_statistics,
  final_display(Board, 1, 1, HorizontalConstraints, VerticalConstraints, MiddleConstraints, Size).
