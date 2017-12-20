:- include('Constraints.pl').
:- include('Interface.pl').

%puzzle(numero, dimensao, numeros de fora(linha numero), numeros de fora(coluna numero), numeros de dentro(linha coluna numero))
puzzle(1, 6, [2-2, 5-1], [3-4], [5-2-6, 3-5-6]).

%N é o número do puzzle
main(N):-
  puzzle(N, Size, HorizontalConstraints, VerticalConstraints, MiddleConstraints),
  define_board(Size, List),
  constrain_init_final_cells(List, Size),
  constrain_middle_cells(List, Size, MiddleConstraints),
  list_to_matrix(List,Size,Board),
  constrain_horizontal_lines(Board,HorizontalConstraints),
  constrain_vertical_lines(Board,VerticalConstraints),
  labeling([], List),
<<<<<<< HEAD
  write(Board).
=======
  display_board(Board).
>>>>>>> e228e89e8b0d600ee0f24dcdd6bdd188a8b5b092
