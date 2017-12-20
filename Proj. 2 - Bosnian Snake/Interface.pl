display_board([]).
display_board([H|T]):-
  write(H), nl,
  display_board(T).
