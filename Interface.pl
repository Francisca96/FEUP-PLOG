display_board([L|T]):-
  write('             '),
  display_elems_line_1(L,T).
display_board([]).

display_elems_line_1([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_1(E, T).
display_elems_line_1([], T):-
  nl,
  nl,
  display_line_2(T).

display_line_2([S|E]):-
  write('                '),
  display_elems_line_2(S,E).
display_elems_line_2([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_2(E, T).
display_elems_line_2([], T):-
  nl,
  nl,
  display_line_3(T).

display_line_3([S|E]):-
  write('                  '),
  display_elems_line_3(S,E).
display_elems_line_3([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_3(E, T).
display_elems_line_3([], T):-
    nl,
    display_line_4(T).

display_line_4([S|E]):-
  write(''),
  display_elems_line_4(S,E).
display_elems_line_4([S|E],T):-
  piece(S,Val),
  write(Val),
  write('                                       '),
  display_elems_line_4(E, T).
display_elems_line_4([], T):-
  nl,
  display_line_5(T).

display_line_5([S|E]):-
  write('      '),
  display_elems_line_5(S,E).
display_elems_line_5([S|E],T):-
  piece(S,Val),
  write(Val),
  write('             '),
  display_elems_line_5(E, T).
display_elems_line_5([], T):-
    nl,
    display_line_6(T).

display_line_6([S|E]):-
  write(''),
  display_elems_line_6(S,E).
display_elems_line_6([S|E],T):-
  piece(S,Val),
  write(Val),
  write('          '),
  display_elems_line_6(E, T).
display_elems_line_6([], T):-
    nl,
    display_line_7(T).

display_line_7([S|E]):-
  write('      '),
  display_elems_line_7(S,E).
display_elems_line_7([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_7(E, T).
display_elems_line_7([], T):-
    nl,
    display_line_8(T).

display_line_8([S|E]):-
  write(''),
  display_elems_line_8(S,E).
display_elems_line_8([S|E],T):-
  piece(S,Val),
  write(Val),
  write('          '),
  display_elems_line_8(E, T).
display_elems_line_8([], T):-
    nl,
    display_line_9(T).

display_line_9([S|E]):-
  write('      '),
  display_elems_line_9(S,E).
display_elems_line_9([S|E],T):-
  piece(S,Val),
  write(Val),
  write('             '),
  display_elems_line_9(E, T).
display_elems_line_9([], T):-
    nl,
    display_line_10(T).

display_line_10([S|E]):-
  write(''),
  display_elems_line_10(S,E).
display_elems_line_10([S|E],T):-
  piece(S,Val),
  write(Val),
  write('                                       '),
  display_elems_line_10(E, T).
display_elems_line_10([], T):-
    nl,
    display_line_11(T).

display_line_11([S|E]):-
  write('                  '),
  display_elems_line_11(S,E).
display_elems_line_11([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_11(E, T).
display_elems_line_11([], T):-
    nl,
    nl,
    display_line_12(T).

display_line_12([S|E]):-
  write('                '),
  display_elems_line_12(S,E).
display_elems_line_12([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_12(E, T).
display_elems_line_12([], T):-
    nl,
    nl,
    display_line_13(T).

display_line_13([S|E]):-
  write('              '),
  display_elems_line_13(S,E).
display_elems_line_13([S|E],T):-
  piece(S,Val),
  write(Val),
  write('   '),
  display_elems_line_13(E, T).
  display_elems_line_13([], T):-
    nl.
