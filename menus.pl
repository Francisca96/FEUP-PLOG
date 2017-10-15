mainMenu:-nl,nl,
write(' _____________________________________________________________________ '),nl,
write('|                                                                     |'),nl,
write('|                                                                     |'),nl,
write('|                                                                     |'),nl,
write('|      _____                                ____        _ _           |'),nl,
write('|     / ____|                              |  _\\      | | |          |'),nl,
write('|    | |      __ _ _ __ ___  _ __    ___   | |_) | ___ | | | ___      |'),nl,
write('|    | |     / _` | '_ ` _\\| '_ \\ / _ \\ |  _ < / _\\| | |/ _ \\    |'),nl,
write('|    | |___ | (_| | | | | | | |_) || (_) | | |_) |  __/| | | (_) |    |'),nl,
write('|    \\_____ \\___|_| |_| |_| .__/ \\___/  |____/ \\___|_|_|\\___/    |'),nl,
write('|                           | |                                       |'),nl,
write('|                           |_|                                       |'),nl,
write('|                                                                     |'),nl,
write('|                         1 - Player vs Player                        |'),nl,
write('|                          2 - Player vs CPU                          |'),nl,
write('|                           3 - CPU vs CPU                            |'),nl,
write('|                           4 - How To Play                           |'),nl,
write('|                            5 - Exit Game                            |'),nl,
write('|                                                                     |'),nl,
write('|                                                                     |'),nl,
write('|_____________________________________________________________________|'),nl,
nl,nl,
write('Please choose an option: '),
read(R),R1 is R,R1<6,menu(R1).




menu(X):-X==1,nl,
write(' PLAYER(BLACK) VS PLAYER(WHITE) '),nl,nl,
initialize_board(Board),
display_board(Board).
