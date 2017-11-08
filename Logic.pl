p(Piece, Position).

initialize_players(Player1, Player2):-
  Player1=[p1, p2, p3, p4, p5, p6, p7, p8, p9, p31, p32, p33, p34, p35, p36, p37, p38, p39],
  Player2=[p11, p12, p13, p14, p15, p16, p17, p18, p19, p21, p22, p23, p24, p25, p26, p27, p28, p29].

initialize_board(Board):-
  Board=[p(p1, 1),p(p2, 2),p(p3, 3),p(p4, 4),
          p(p5, 5),p(p6, 6),p(p7, 7),
          p(p8, 8),p(p9, 9),
          p(p11, 11),p(p21, 21),
          p(p15, 15),p(0, 10),p(p25, 25),
          p(p12, 12),p(p18, 18),p(p28, 28),p(p22, 22),
          p(p16, 16),p(0, 20),p(0, 50),p(0, 30),p(p26, 26),
          p(p13, 13),p(p19, 19),p(p29, 29),p(p23, 23),
          p(p17, 17),p(0, 40),p(p27, 27),
          p(p14, 14),p(p24, 24),
          p(p38, 38),p(p39, 39),
          p(p35, 35),p(p36, 36),p(p37, 37),
          p(p31, 31),p(p32, 32),p(p33, 33),p(p34, 34)].

% predicado para substituir peças e posiçoes no tabuleiro
substitute(X, Y, [], []).
substitute(X, Y, [X|R], [Y|R]).
substitute(X, Y, [Z|R1], [Z|R2]):-
  Y \= Z,
  substitute(X, Y, R1, R2).

game(Board, Player1, Player2, Round):-
  Turn is Round mod 2,
  Turn == 1 ->
    (Player = Player1,
    play(Board, Player1, Player2, Player, Round));
    (Player = Player2,
    play(Board, Player1, Player2, Player, Round)).

% inicio da jogada
play(Board, Player1, Player2, Player, Round):-
  ask_for_movement(Piece, Position, Player),
  verify_empty_pos(Position, Board),
  verify_piece_between(Board, Piece, Position),
  get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos),
  update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NewBoard),
%  position(Position,PossiblePlays),
%  verify_more_plays(Board,Position,Piece,PossiblePlays),
  is_game_over(Board,Player1),
  update_player(Player1, Player2, CapturedPiece, NewPlayer1, NewPlayer2),
  display_players(NewPlayer1, NewPlayer2),
  display_board(NewBoard),
  NewRound is Round+1,
  game(NewBoard, NewPlayer1, NewPlayer2, NewRound).


% pede a peça que se quer mover e a posição de destino
ask_for_movement(Piece, Position, Player):-
  ask_piece(Piece),
  verify_piece(Piece, Player),
  ask_position(Position).

ask_piece(Piece):-
  nl, write('Choose a piece to move: '),
  read(X),
  symbol(Piece, X). % Vou buscar o nome da peça através do simbolo
ask_piece(_):-
  nl, write('Invalid piece!'), nl,
  ask_piece(Piece).

ask_position(Position):-
  nl, write('For each position you want to move? '),
  read(Y),
  symbol(Position, Y).
ask_position(_):-
  nl, write('Invalid position!'), nl,
  ask_position(Position).

% verifica se a peça é do jogador
verify_piece(Piece, Player):-
  member(Piece, Player).
verify_piece(_, Player):-
  nl, write('This piece isn\'t yours!'), nl,
  ask_for_movement(_, _, Player).

% verifica se a posição está vazia
verify_empty_pos(Position, Board):-
	member(p(0, Position), Board).

% verifica se as posições não sao adjacentes
verify_piece_between(Board, Piece, Position):-
  find_pos(Board, Piece, Pos),
  pos(Pos, List),
  !, \+ member(Position, List).

% verifica se existe uma peça entre as posições e se sim devolve-a
get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  pos(Pos, List1),
  pos(Position, List2),
  member(CapturedPiecePos, List1),
  member(CapturedPiecePos, List2),
  find_pos(Board, CapturedPiece, CapturedPiecePos),
  CapturedPiece \= 0.

% altera a posição que tinha peça e a posição para onde foi a peça
update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NewBoard):-
  find_pos(Board, Piece, Pos1),
  substitute(p(Piece, Pos1), p(0, Pos1), Board, NewBoard1),
  substitute(p(0, Position), p(Piece, Position), NewBoard1, NewBoard2),
  substitute(p(CapturedPiece, CapturedPiecePos), p(0, CapturedPiecePos), NewBoard2, NewBoard).

% altera arrays dos jogadores
update_player(Player1, Player2, CapturedPiece, NewPlayer1, NewPlayer2):-
  member(CapturedPiece, Player1) ->
  delete(Player1, CapturedPiece, NewPlayer1),
  NewPlayer2 = Player2;
  delete(Player2, CapturedPiece, NewPlayer2),
  NewPlayer1 = Player1.

% devolve a posição onde está a peça
find_pos(Board, Piece, Position):-
  member(p(Piece,Position), Board).

%verifica se com umda dada peça ainda existem mais jogadas possíveis
%a lista [S|E] tem que ser passada usando position(Position,PossiblePlays),
verify_more_plays(Board,Position,Piece,[]):-
  fail.
verify_more_plays(Board,Position,Piece,[S|E]):-
  (verify_empty_pos(S,Board),
  get_piece_between(Board,Piece,Position,C,C_P)
);
  verify_more_plays(Board,Position,Piece,E).



 is_game_over(Board,[H|T]):-
   fail.
%recieve a player and verifies if he has any possible play
 is_game_over(Board,[H|T]):-
   (find_pos(Board,H,Position),
   position(Position,List),
   verify_more_plays(Board,Position,H,List));
   is_game_over(Board,T).
