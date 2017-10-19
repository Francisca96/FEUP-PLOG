initialize_board(Board):-
  Board=[[p(p1, 1),p(p2, 2),p(p3, 3),p(p4, 4)],
          [p(p5, 5),p(p6, 6),p(p7, 7)],
          [p(p8, 8),p(p9, 9)],
          [p(p11, 11),p(p21, 21)],
          [p(p15, 15),p(null, 10),p(p25, 25)],
          [p(p12, 12),p(p18, 18),p(p28, 28),p(p22, 22)],
          [p(p16, 16),p(null, 20),p(null, 50),p(null, 30),p(p26, 26)],
          [p(p13, 13),p(p19, 19),p(p29, 29),p(p23, 23)],
          [p(p17, 17),p(null, 40),p(p27, 27)],
          [p(p14, 14),p(p24, 24)],
          [p(p38, 38),p(p39, 39)],
          [p(p35, 35),p(p36, 36),p(p37, 37)],
          [p(p31, 31),p(p32, 32),p(p33, 33),p(p34, 34)]].

play(Board, BoardPos):-
  write("Choose a piece to move: "),
  read(Piece),
  %verify_piece verificar se a peça é do jogador que ta a jogar
  write("For each position you want to move? "),
  read(Position),
  %verify_position verificar se a posição está vazia
  move_piece(Board, Piece, Position).

move_piece(Board, Piece, Position):-
  p(Piece, Position).
