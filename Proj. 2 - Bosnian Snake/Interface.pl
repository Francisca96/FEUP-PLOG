final_display([H|T],Row,Col,HorizontalConstraints,VerticalConstraints,MiddleConstraints,Size):-
  nl,
  write('     '),
  display_col(VerticalConstraints,Size,1),nl,
  display_board([H|T],Row,Col,MiddleConstraints,HorizontalConstraints,Size),
  display_line(Size).

display_board([],_,_,_,_,_).
display_board([H|T],Row,Col,MiddleConstraints,HorizontalConstraints,Size):-
  member(Row-Val, HorizontalConstraints),
  display_line(Size),nl,
  write('    |'),
  display_cells(H),nl,
  write('  '),
  write(Val),
  write(' |'),
  display_row(H,Row,Col,MiddleConstraints,MiddleConstraints2),nl,
  write('    |'),
  display_cells(H),nl,
  Row2 is Row+1,
  display_board(T,Row2,Col,MiddleConstraints2,HorizontalConstraints,Size).

display_board([L|Ls],Row,Col,MiddleConstraints,HorizontalConstraints,Size):-
  \+ member(Row-_, HorizontalConstraints),
  display_line(Size),nl,
  write('    |'),
  display_cells(L),nl,
  write('    |'),
  display_row(L,Row,Col,MiddleConstraints,MiddleConstraints2),nl,
  write('    |'),
  display_cells(L),nl,
  Row2 is Row+1,
  display_board(Ls,Row2,Col,MiddleConstraints2,HorizontalConstraints,Size).

display_board([L|Ls],Row,Col,MiddleConstraints,[],Size):-
  display_line(Size),nl,
  write('    |'),
  display_cells(L),nl,
  write('    |'),
  display_row(L,Row,Col,MiddleConstraints,MiddleConstraints2),nl,
  write('    |'),
  display_cells(L),nl,
  Row2 is Row+1,
  display_board(Ls,Row2,Col,MiddleConstraints2,[],Size).

display_col(_,Size,Size).
display_col(VerticalConstraints,Size,N):-
  member(N-Val, VerticalConstraints),
  write(' '),
  write(Val),
  write(' '),
  N1 is N+1,
  display_col(VerticalConstraints,Size,N1).

display_col(VerticalConstraints,Size,N):-
  \+ member(N-_, VerticalConstraints),
  write('    '),
  N1 is N+1,
  display_col(VerticalConstraints,Size,N1).

display_col([],Size,N):-
  write('    '),
  N1 is N+1,
  display_col([],Size,N1).

display_row([],_,_,S,S).
display_row([_|Xs],Row,Col,MiddleConstraints,S):-
  member(Row-Col-Val,MiddleConstraints),
  write(' '),
  write(Val),
  write(' |'),
  Col2 is Col+1,
  display_row(Xs,Row,Col2,MiddleConstraints,S).

display_row([X|Xs],Row,Col,[],S):-
        X==0,
        write('   '),write('|'),
        Col2 is Col+1,
        display_row(Xs,Row,Col2,[],S).

display_row([X|Xs],Row,Col,[],S):-
        X==1,
        write('@@@'),write('|'),
        Col2 is Col+1,
        display_row(Xs,Row,Col2,[],S).

display_row([X|Xs],Row,Col,MiddleConstraints,S):-
        \+ member(Row-Col-_,MiddleConstraints),
        X==0,
        write('   '),write('|'),
        Col2 is Col+1,
        display_row(Xs,Row,Col2,MiddleConstraints,S).

display_row([X|Xs],Row,Col,MiddleConstraints,S):-
      \+ member(Row-Col-_,MiddleConstraints),
      X==1,
      write('@@@'),write('|'),
      Col2 is Col+1,
      display_row(Xs,Row,Col2,MiddleConstraints,S).


display_cells([]).
display_cells([X|Xs]):-
  X==0,
  write('   |'),
  display_cells(Xs).

display_cells([X|Xs]):-
  X==1,
  write('@@@|'),
  display_cells(Xs).

display_line(Size):-
  write('    '),
  display_line_aux(Size).
display_line_aux(0).
display_line_aux(Size):-
  write('----'),
  S is Size-1,
  display_line_aux(S).
