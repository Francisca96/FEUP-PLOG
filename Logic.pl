p(_, _).

initialize_players(Player1, Player2):-
  Player1=[p1, p2, p3, p4, p5, p6, p7, p8, p9, p31, p32, p33, p34, p35, p36, p37, p38, p39],
  Player2=[p11, p12, p13, p14, p15, p16, p17, p18, p19, p21, p22, p23, p24, p25, p26, p27, p28, p29].

initialize_board(Board):-
  Board=[p(0, 1),p(p2, 2),p(p3, 3),p(p4, 4),
          p(p5, 5),p(p6, 6),p(p7, 7),
          p(p8, 8),p(p9, 9),
          p(p11, 11),p(p21, 21),
          p(p15, 15),p(0, 10),p(p25, 25),
          p(p12, 12),p(p18, 18),p(p28, 28),p(p22, 22),
          p(0, 16),p(p16, 20),p(p1, 50),p(0, 30),p(p26, 26),
          p(p13, 13),p(p19, 19),p(p29, 29),p(p23, 23),
          p(p17, 17),p(0, 40),p(p27, 27),
          p(p14, 14),p(p24, 24),
          p(p38, 38),p(p39, 39),
          p(p35, 35),p(p36, 36),p(p37, 37),
          p(p31, 31),p(p32, 32),p(p33, 33),p(p34, 34)].

% predicado para substituir peças e posiçoes no tabuleiro
substitute(_, _, [], []).
substitute(X, Y, [X|R], [Y|R]).
substitute(X, Y, [Z|R1], [Z|R2]):-
  Y \= Z,
  substitute(X, Y, R1, R2).

displays(Round, Player1, Player2, Board, Turn):-
  display_round(Round, Turn),
  display_players(Player1, Player2),
  display_board(Board).

game(Board, Player1, Player2, Round):-
  Turn is Round mod 2,
  displays(Round, Player1, Player2, Board, Turn),
  Turn == 1 ->
    (Player = Player1,
    play(Board, Player1, Player2, Player, Round, Turn));
    (Player = Player2,
    play(Board, Player1, Player2, Player, Round, Turn)).

% inicio da jogada
play(Board, Player1, Player2, Player, Round, Turn):-
  ask_for_movement(Piece, Position, Player,Board),
  verify_empty_pos(Position, Board),
  verify_next_pos(Board, Piece, Position),
  get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos),
  update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NewBoard),
  update_player(Player1, Player2, CapturedPiece, NewPlayer1, NewPlayer2),
  displays(Round, NewPlayer1, NewPlayer2, NewBoard, Turn),
  (is_game_over(Board,Player1),
  is_game_over(Board,Player2)),
  NewRound is Round+1,
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Score1=0,
  %calculate_score(Board,Player1,Score1),
  possible_moves(Position,PossiblePlays),
  (verify_more_plays(NewBoard,Position,Piece,PossiblePlays) ->
    play_again(NewBoard, Piece, Round, Turn, NewPlayer1, NewPlayer2, NPlayer1, NPlayer2, NBoard);
    game(NewBoard, NewPlayer1, NewPlayer2, NewRound)).




  play_again(NewBoard, Piece, Round, Turn, NewPlayer1, NewPlayer2, NPlayer1, NPlayer2, NBoard):-
    NewRound is Round+1,
    find_pos(NewBoard,Piece,Position),
    possible_moves(Position,PossiblePlays),
    (verify_more_plays(NewBoard,Position,Piece,PossiblePlays) ->
    nl, write('You can make another movement with this piece! Do you want?'), nl,
    write('0 - No/1 - Yes'), nl,
    read(Answer),
  ( Answer == 1 ->
    another_move(NewBoard, Piece, Round, Turn, NewPlayer1, NewPlayer2, NPlayer1, NPlayer2, NBoard),
    play_again(NBoard, Piece, Round, Turn, NPlayer1, NPlayer2, NPlayer1, NPlayer2, NBoard);
  game(NewBoard, NewPlayer1, NewPlayer2, NewRound));
  game(NewBoard, NewPlayer1, NewPlayer2, NewRound)  ).



another_move(Board, Piece, Round, Turn, Player1, Player2, NPlayer1, NPlayer2, NBoard):-
  ask_position(Position),
  verify_empty_pos(Position, Board),
  verify_next_pos(Board, Piece, Position),
  get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos),
  update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NBoard),
  update_player(Player1, Player2, CapturedPiece, NPlayer1, NPlayer2),
  displays(Round, NPlayer1, NPlayer2, NBoard, Turn).

% pede a peça que se quer mover e a posição de destino
ask_for_movement(Piece, Position, Player,Board):-
repeat,
  ask_piece(Piece),
  find_pos(Board,Piece,Pos),
  possible_moves(Pos,PossiblePlays),
(  verify_more_plays(Board,Position,Piece,PossiblePlays)->
  verify_piece(Piece, Player),
  ask_position(Position);
  nl, write( 'Choose a piece with possible plays!'),nl).

ask_piece(Piece):-
  nl, write('Choose a piece to move: '),
  read(X),
  symbol(Piece, X),!. % Vou buscar o nome da peça através do simbolo
ask_piece(_):-
  nl, write('Invalid piece!'), nl,
  ask_piece(_),!.

ask_position(Position):-
  nl, write('For each position you want to move? '),
  read(Y),
  symbol(Position, Y).
ask_position(_):-
  nl, write('Invalid position!'), nl,
  ask_position(_).

% verifica se a peça é do jogador
verify_piece(Piece, Player):-
  member(Piece, Player),!.
verify_piece(_, _):-
  nl, write('This piece isn\'t yours!'), nl,
  fail.

% verifica se a posição está vazia
verify_empty_pos(Position, Board):-
	member(p(0, Position), Board).

% verifica se as posições não sao adjacentes
verify_next_pos(Board, Piece, Position):-
  find_pos(Board, Piece, Pos),
  possible_moves(Pos, List),
  member(Position, List).

get_piece_between(Board, Piece, 10, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 40,
  member(p(CapturedPiece, 50), Board),
  CapturedPiece \= 0,
  CapturedPiecePos = 50.

get_piece_between(Board, Piece, 20, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 30,
  member(p(CapturedPiece, 50), Board),
  CapturedPiece \= 0,
  CapturedPiecePos = 50.

get_piece_between(Board, Piece, 30, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 20,
  member(p(CapturedPiece, 50), Board),
  CapturedPiece \= 0,
  CapturedPiecePos = 50.

get_piece_between(Board, Piece, 40, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 10,
  member(p(CapturedPiece, 50), Board),
  CapturedPiece \= 0,
  CapturedPiecePos = 50.


% verifica se existe uma peça entre as posições e se sim devolve-a
get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  adj_pos(Pos, List1),
  adj_pos(Position, List2),
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
%a lista [S|E] tem que ser passada usando possible_moves(Position,PossiblePlays),
verify_more_plays(_,_,_,[]):-
  fail.
verify_more_plays(Board,Position,Piece,[S|E]):-
  (verify_empty_pos(S,Board),
  verify_next_pos(Board,Piece,S),
  get_piece_between(Board,Piece,S,_,_));
  verify_more_plays(Board,Position,Piece,E).


  verify_more_plays(_,_,_,[],_):-
    fail.
  verify_more_plays(Board,Position,Piece,[S|E],PosMove):-
    PosMove=S,
    (verify_empty_pos(PosMove,Board),
    verify_next_pos(Board,Piece,PosMove),
    get_piece_between(Board,Piece,PosMove,_,_));
    verify_more_plays(Board,Position,Piece,E,PosMove).

 is_game_over(_,[_|_]):-
   fail.
%recieve a player and verifies if he has any possible play
 is_game_over(Board,[H|T]):-
   (find_pos(Board,H,Position),
   possible_moves(Position,List),
   verify_more_plays(Board,Position,H,List));
   is_game_over(Board,T).

calculate_score([],_,_):-
  fail.
calculate_score([p(Piece, _)|T], Player,Score):-
  member(Piece,Player),
  piece_color(Piece,C1),
  find_pos([p(Piece, _)|T],Piece,Pos),
  color(Pos,C2),
  (C1==C2 -> NewScore is Score + 3;
  NewScore is Score +1),
  calculate_score(T,Player,NewScore).

calculate_score([p(_, _)|T], Player,Score):-
  calculate_score(T,Player,Score).

%recieve bot pieces
dumbot_play(Board,[H|T],Player1,Player2,NewPlayer1,NewPlayer2):-
  (find_pos(Board,H,Position),
  possible_moves(Position,List),
  verify_more_plays(Board,Positon,H,List,PosMove),
  get_piece_between(Board, H, PosMove, CapturedPiece, CapturedPiecePos),
  update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NewBoard),
  update_player(Player1, Player2, CapturedPiece, NewPlayer1, NewPlayer2));
  dumbot_play(Board,T,Player1,Player2,NewPlayer1,NewPlayer2).
