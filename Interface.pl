show_piece(p(Piece, Position)):-
  Piece == null ->
  symbol(Position, Val),
  write(Val);
  symbol(Piece, Val),
  write(Val).


display_board([L|T]):-
  write('________________________________________________'),
  nl,
  write('|                                               |'),
  nl,
  write('|                                               |'),
  nl,
  write('|             '),
  display_elems_line_1(L,T).
display_board([]).

display_elems_line_1([S|E],T):-
  show_piece(S),
  write('    '),
  display_elems_line_1(E, T).
display_elems_line_1([], T):-
  write('          |'),
  nl,
  write('|                                               |'),
  nl,
  display_line_2(T).

display_line_2([S|E]):-
  write('|                '),
  display_elems_line_2(S,E).
display_elems_line_2([S|E],T):-
  show_piece(S),
  write('    '),
  display_elems_line_2(E, T).
display_elems_line_2([], T):-
  write('             |'),
  nl,
  write('|                                               |'),
  nl,
  display_line_3(T).

display_line_3([S|E]):-
  write('|                   '),
  display_elems_line_3(S,E).
display_elems_line_3([S|E],T):-
  show_piece(S),
  write('    '),
  display_elems_line_3(E, T).
display_elems_line_3([], T):-
    write('                |'),
    nl,
    display_line_4(T).

display_line_4([S|E]):-
  write('|   '),
  display_elems_line_4(S,E).
display_elems_line_4([S|E],T):-
  show_piece(S),
  display_elems_line_4_1(E, T).
display_elems_line_4_1([S|E], T):-
  write('                                     '),
  show_piece(S),
  display_elems_line_4_1(E, T).
display_elems_line_4_1([], T):-
  write('   |'),
  nl,
  display_line_5(T).

display_line_5([S|E]):-
  write('|        '),
  display_elems_line_5(S,E).
display_elems_line_5([S|E],T):-
  show_piece(S),
  display_elems_line_5_1(E, T).
display_elems_line_5_1([S|E], T):-
  write('            '),
  show_piece(S),
  display_elems_line_5_1(E, T).
display_elems_line_5_1([], T):-
  write('         |'),
  nl,
  display_line_6(T).

display_line_6([S|E]):-
  write('|   '),
  display_elems_line_6(S,E).
display_elems_line_6([S|E],T):-
  show_piece(S),
  write('         '),
  display_elems_line_6_1(E, T).
display_elems_line_6_1([S|E],T):-
  show_piece(S),
  write('               '),
  display_elems_line_6_2(E, T).
display_elems_line_6_2([S|E], T):-
  show_piece(S),
  write('         '),
  display_elems_line_6_3(E, T).
display_elems_line_6_3([S|E], T):-
  show_piece(S),
  display_elems_line_6(E, T).
display_elems_line_6([], T):-
  write('   |'),
  nl,
  display_line_7(T).

display_line_7([S|E]):-
  write('|        '),
  display_elems_line_7(S,E).
display_elems_line_7([S|E],T):-
  show_piece(S),
  write('        '),
  display_elems_line_7_1(E, T).
display_elems_line_7_1([S|E],T):-
  show_piece(S),
  write('  '),
  display_elems_line_7_2(E, T).
display_elems_line_7_2([S|E],T):-
  show_piece(S),
  write('  '),
  display_elems_line_7(E, T).
display_elems_line_7_2([], T):-
  write('       |'),
    nl,
    display_line_8(T).

display_line_8([S|E]):-
  write('|   '),
  display_elems_line_8(S,E).
display_elems_line_8([S|E],T):-
  show_piece(S),
  write('         '),
  display_elems_line_8_1(E, T).
display_elems_line_8_1([S|E],T):-
  show_piece(S),
  write('               '),
  display_elems_line_8_2(E, T).
display_elems_line_8_2([S|E], T):-
  show_piece(S),
  write('         '),
  display_elems_line_8_3(E, T).
display_elems_line_8_3([S|E], T):-
  show_piece(S),
  display_elems_line_8(E, T).
display_elems_line_8([], T):-
  write('   |'),
  nl,
  display_line_9(T).

display_line_9([S|E]):-
  write('|        '),
  display_elems_line_9(S,E).
display_elems_line_9([S|E],T):-
  show_piece(S),
  display_elems_line_9_1(E, T).
display_elems_line_9_1([S|E], T):-
  write('            '),
  show_piece(S),
  display_elems_line_9_1(E, T).
display_elems_line_9_1([], T):-
  write('         |'),
  nl,
  display_line_10(T).

  display_line_10([S|E]):-
    write('|   '),
    display_elems_line_10(S,E).
  display_elems_line_10([S|E],T):-
    show_piece(S),
    display_elems_line_10_1(E, T).
  display_elems_line_10_1([S|E], T):-
    write('                                     '),
    show_piece(S),
    display_elems_line_10_1(E, T).
  display_elems_line_10_1([], T):-
    write('   |'),
    nl,
    display_line_11(T).

display_line_11([S|E]):-
  write('|                   '),
  display_elems_line_11(S,E).
display_elems_line_11([S|E],T):-
  show_piece(S),
  write('    '),
  display_elems_line_11(E, T).
display_elems_line_11([], T):-
  write('                |'),
    nl,
    write('|                                               |'),
    nl,
    display_line_12(T).

display_line_12([S|E]):-
  write('|                '),
  display_elems_line_12(S,E).
display_elems_line_12([S|E],T):-
  show_piece(S),
  write('    '),
  display_elems_line_12(E, T).
display_elems_line_12([], T):-
  write('             |'),
    nl,
    write('|                                               |'),
    nl,
    display_line_13(T).

display_line_13([S|E]):-
  write('|             '),
  display_elems_line_13(S,E).
display_elems_line_13([S|E],T):-
  show_piece(S),
  write('    '),
  display_elems_line_13(E, T).
  display_elems_line_13([], T):-
    write('          |'),
    nl,
    write('|                                               |'),
    nl,
    write('|_______________________________________________|').
