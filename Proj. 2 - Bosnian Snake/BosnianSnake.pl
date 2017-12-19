:- include('Constraints.pl').

%puzzle(numero, dimensao, numeros de fora(linha numero), numeros de fora(coluna numero), numeros de dentro(linha coluna numero))
puzzle(1, 6, [2-2, 5-1], [], [5-2-6, 3-5-6]).

%N é o número do puzzle
main(N):-
  puzzle(N, Size, [ORow1-ONum1, ORow2-ONum2], [], [IRow1-ICol1-INum1, IRow2-ICol2-INum2]),
  define_board(Size, Board),
  constrain_init_final_cells(Board, Size),
  constrain_middle_cells(Board, Size, IRow1, ICol1, INum1),
  %constrain_middle_cells(Board, Size, IRow2, ICol2, INum2),
  labeling([], Board),
  write(Board).
