p(_, _).

initialize_players(Player1, Player2):-
  %Player1=[p1, p2, p3, p4, p5, p6, p7, p8, p9, p31, p32, p33, p34, p35, p36, p37, p38, p39],
  Player1=[p1, p2, p5, p6],
  Player2=[p11, p12, p13, p14, p15, p16, p17, p18, p19, p21, p22, p23, p24, p25, p26, p27, p28, p29].

initialize_board(Board):-
  Board=[p(p1, 1),p(p2, 2),p(0, 3),p(0, 4),
          p(p5, 5),p(p6, 6),p(0, 7),
          p(0, 8),p(0, 9),
          p(p11, 11),p(p21, 21),
          p(p15, 15),p(0, 10),p(p25, 25),
          p(p12, 12),p(p18, 18),p(p28, 28),p(p22, 22),
          p(p16, 16),p(0, 20),p(0, 50),p(0, 30),p(p26, 26),
          p(p13, 13),p(p19, 19),p(p29, 29),p(p23, 23),
          p(p17, 17),p(0, 40),p(p27, 27),
          p(p14, 14),p(p24, 24),
          p(0, 38),p(0, 39),
          p(0, 35),p(0, 36),p(0, 37),
          p(0, 31),p(0, 32),p(0, 33),p(0, 34)].

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
  find_pos(Board, Piece, Pos),
  verify_empty_pos(Position, Board),
  verify_next_pos(Board, Piece, Position),
  get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos),
  update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NewBoard),
  update_player(Player1, Player2, CapturedPiece, NewPlayer1, NewPlayer2),
  displays(Round, NewPlayer1, NewPlayer2, NewBoard, Turn),
 check_game_over(Board, NewPlayer1, NewPlayer2),
  NewRound is Round+1,
  possible_moves(Position,PossiblePlays),
  FirstPos = Pos,
  (verify_more_plays(NewBoard,Position,Piece,PossiblePlays, FirstPos) ->
    play_again(NewBoard, Piece, Round, Turn, NewPlayer1, NewPlayer2, FirstPos);
    game(NewBoard, NewPlayer1, NewPlayer2, NewRound)).


play_vs_bot(Board,Player,Bot,Round, Turn, Level):-
  displays(Round, Player, Bot, Board, Turn),
  check_game_over(Board, Player, Bot),
  ask_for_movement(Piece, Position, Player,Board),
  find_pos(Board, Piece, Pos),
  verify_empty_pos(Position, Board),
  verify_next_pos(Board, Piece, Position),
  get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos),
  update_board(Board, Piece, Position, CapturedPiece, CapturedPiecePos, NewBoard),
  update_player(Player, Bot, CapturedPiece, NewPlayer, NewBot),
  NewRound is Round+2,
  possible_moves(Position,PossiblePlays),
  FirstPos = Pos,
  (verify_more_plays(NewBoard,Position,Piece,PossiblePlays) ->
    displays(Round, NewPlayer, NewBot, NewBoard, Turn),
  play_again_bot(NewBoard, Piece,NewRound, Turn, NewPlayer, NewBot, FirstPos, Level);
  !, bot_play(NewBoard,NewBot,NewPlayer,NewBot,NPlayer,NBot,NBoard, Level),
  play_vs_bot(NBoard, NPlayer, NBot, NewRound,Turn, Level)).

bot_vs_bot(Board, Bot1, Bot2, Level1, Level2, Round, Turn):-
  check_game_over(Board, Bot1, Bot2),
  bot_play(Board, Bot1, Bot2, Bot1, NewBot1, NewBot2, NewBoard, Level1),
  displays(Round, NewBot2, NewBot1, NewBoard, Turn),
  read(Enter),
  NewRound is Round+1,
  NewTurn is NewRound mod 2,
  bot_play(NewBoard, NewBot1, NewBot2, NewBot1, NBot1, NBot2, NBoard, Level2),
  displays(NewRound, NBot1, NBot2, NBoard, NewTurn),
  read(Enter),
  NRound is NewRound+1,
  NTurn is NRound mod 2,
  bot_vs_bot(NBoard, NBot1, NBot2, Level1, Level2, NRound, NTurn).


play_again_bot(Board, Piece,Round,Turn, Player, Bot, FirstPos, Level):-
  find_pos(Board,Piece,Position),
  possible_moves(Position,PossiblePlays),
  (verify_more_plays(Board,Position,Piece,PossiblePlays, FirstPos) ->
  nl, write('You can make another movement with this piece! Do you want?'), nl,
  write('0 - No/1 - Yes'), nl,
  read(Answer),
  ( Answer == 1 ->
    another_move(Board, Piece, Round, Turn, Player, Bot, NewPlayer, NewBot, NewBoard),
    play_again_bot(NewBoard, Piece, Round, Turn, NewPlayer, NewBot, FirstPos, Level);
    bot_play(Board,Bot,Player,Bot,NPlayer,NBot,NewBoard, Level),
    play_vs_bot(NewBoard, NPlayer, NBot, Round,Turn, Level));
    (bot_play(Board,Bot,Player,Bot,NPlayer,NBot,NewBoard, Level),
    play_vs_bot(NewBoard, NPlayer, NBot, Round,Turn, Level))).


  play_again(NewBoard, Piece, Round, Turn, NewPlayer1, NewPlayer2, FirstPos):-
    NewRound is Round+1,
    find_pos(NewBoard,Piece,Position),
    possible_moves(Position,PossiblePlays),
    (verify_more_plays(NewBoard,Position,Piece,PossiblePlays, FirstPos) ->
    nl, write('You can make another movement with this piece! Do you want?'), nl,
    write('0 - No/1 - Yes'), nl,
    read(Answer),
  ( Answer == 1 ->
    another_move(NewBoard, Piece, Round, Turn, NewPlayer1, NewPlayer2, NPlayer1, NPlayer2, NBoard),
    play_again(NBoard, Piece, Round, Turn, NPlayer1, NPlayer2, FirstPos);
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
  !, CapturedPiece \= 0,
  CapturedPiecePos = 50.

get_piece_between(Board, Piece, 20, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 30,
  member(p(CapturedPiece, 50), Board),
  !, CapturedPiece \= 0,
  CapturedPiecePos = 50.

get_piece_between(Board, Piece, 30, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 20,
  member(p(CapturedPiece, 50), Board),
  !, CapturedPiece \= 0,
  CapturedPiecePos = 50.

get_piece_between(Board, Piece, 40, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  Pos == 10,
  member(p(CapturedPiece, 50), Board),
  !, CapturedPiece \= 0,
  CapturedPiecePos = 50.


% verifica se existe uma peça entre as posições e se sim devolve-a
get_piece_between(Board, Piece, Position, CapturedPiece, CapturedPiecePos):-
  find_pos(Board, Piece, Pos),
  adj_pos(Pos, List1),
  adj_pos(Position, List2),
  member(CapturedPiecePos, List1),
  member(CapturedPiecePos, List2),
  find_pos(Board, CapturedPiece, CapturedPiecePos),
  !, CapturedPiece \= 0.

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
  !,fail.
verify_more_plays(Board,Position,Piece,[S|E]):-
  (verify_empty_pos(S,Board),
  verify_next_pos(Board,Piece,S),
  get_piece_between(Board,Piece,S,_,_));
  verify_more_plays(Board,Position,Piece,E).

verify_more_plays(_,_,_,[], _):-
  !,fail.
verify_more_plays(Board,Position,Piece,[S|E], FirstPos):-
  (S \= FirstPos,
  verify_empty_pos(S,Board),
  verify_next_pos(Board,Piece,S),
  get_piece_between(Board,Piece,S,_,_));
  verify_more_plays(Board,Position,Piece,E, FirstPos).


verify_more_plays(_,_,_,[],_):-
  !,fail.
verify_more_plays(Board,Position,Piece,[S|E],PosMove,_):-
  PosMove=S,
  (verify_empty_pos(PosMove,Board),
  verify_next_pos(Board,Piece,PosMove),
  get_piece_between(Board,Piece,PosMove,_,_));
  verify_more_plays(Board,Position,Piece,E,PosMove,_).

check_game_over(Board, Player1, Player2):-
  ( \+ isnt_game_over(Board,Player1);
  \+ isnt_game_over(Board,Player2)) ->
    (Score = 0,
    write('Player BLUE_RED score: '),
    calculate_score(Board, Player1, Score, FinalScore1),
    nl, write('Player YELLOW_GREEN score: '),
    calculate_score(Board, Player2, Score, FinalScore2),
    !, (FinalScore1 < FinalScore2 ->
      nl, nl, write('PLAYER BLUE_RED WON!!!');
      FinalScore2 < FinalScore1 ->
        nl, nl, write('PLAYER YELLOW_GREEN WON!!!');
        nl, nl, write('IT\'S A TIE!')),
    display_quit,
    abort).
  check_game_over(_, _, _).



isnt_game_over(_,[]):-
  !, nl, write('FINISH!'), nl, nl, fail.

%recieve a player and verifies if he has any possible play
isnt_game_over(Board,[H|T]):-
  (find_pos(Board,H,Position),
  possible_moves(Position,List),
  verify_more_plays(Board,Position,H,List));
  isnt_game_over(Board,T).



calculate_score([],_,Score, FinalScore):-
  FinalScore = Score,
  !, write(Score).
calculate_score([p(Piece, Pos)|T], Player,Score, FinalScore):-
  member(Piece,Player),
  piece_color(Piece,C1),
  color(Pos,C2),
  (C1==C2 -> NewScore is Score + 3;
  NewScore is Score +1),
  calculate_score(T,Player,NewScore, FinalScore).

calculate_score([p(_, _)|T], Player,Score, FinalScore):-
  calculate_score(T,Player,Score, FinalScore).

%dumb
bot_play(Board,[H|T],Player,Bot,NewPlayer,NewBot,NBoard, 0):-
  (find_pos(Board,H,Position),
  possible_moves(Position,List),
  verify_more_plays(Board,Position,H,List,PosMove,0),
  get_piece_between(Board, H, PosMove, CapturedPiece, CapturedPiecePos),
  update_board(Board, H, PosMove, CapturedPiece, CapturedPiecePos, NBoard),
  update_player(Player, Bot, CapturedPiece, NewPlayer, NewBot));
  bot_play(Board,T,Player,Bot,NewPlayer,NewBot,NBoard, 0).

%smart
create_list_plays([],_,_,[],[],[],_,_,_).

create_list_plays([H|T],Board,Bot,List,Values_list,Pieces_list,NewList,NewValues_List,NewPieces_List):-
  find_pos(Board,H,Position),
  possible_moves(Position,PossiblePlays),
  (verify_more_plays(Board,Position,H,PossiblePlays,PosMove,0)->
  append([PosMove],List,NewList),
  get_piece_between(Board, H, PosMove, CapturedPiece, CapturedPiecePos),
  atribute_value_play(Board,H,PosMove,CapturedPiece,Bot,0,NewValue),
  append([NewValue],Values_list,NewValues_List),
  append([H],Pieces_list,NewPieces_List);
  create_list_plays(T,Board,Bot,NewList,NewValues_List,NewPieces_List,_,_,_)).

atribute_value_play(Board,Piece,PositionPlay,CapturedPiece,Bot,Value,NewValue):-
find_pos(Board,Piece,Position),
(member(CapturedPiece,Bot)->
  NewValue is Value +2;
NewValue is Value +1),
piece_color(Piece,C1),
color(PositionPlay,C2),
(C1==C2 -> NewValue is Value + 2;
NewValue is Value +1).

get_max_play([],[],[],[],FinalPosition,Piece).

get_max_play([H|T],[C|F],[X|Y],Values_List,FinalPosition,Piece):-
(max_member(H,Values_List)->FinalPosition=C,
Piece=X;
get_max_play(T,F,Y,Values_List,FinalPosition,Piece)).



bot_play(Board,Pieces,Player,Bot,NewPlayer,NewBot,NewBoard, 1):-
  create_list_plays(Pieces,Board,Bot,[],[],[],NewList,NewValues_list,NewPieces_list),
  get_max_play(NewValues_list,NewList,NewPieces_list,NewValues_list,FinalPosition,Piece),
  get_piece_between(Board,Piece,FinalPosition,CapturedPiece,CapturedPiecePos),
  update_board(Board,Piece,FinalPosition,CapturedPiece,CapturedPiecePos,NewBoard),
  update_player(Player,Bot,CapturedPiece,NewPlayer,NewBot).
