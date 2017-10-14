symbol(p1,'B1').
symbol(p2,'B2').
symbol(p3,'B3').
symbol(p4,'B4').
symbol(p5,'B5').
symbol(p6,'B6').
symbol(p7,'B7').
symbol(p8,'B8').
symbol(p9,'B9').

symbol(p11,'Y1').
symbol(p12,'Y2').
symbol(p13,'Y3').
symbol(p14,'Y4').
symbol(p15,'Y5').
symbol(p16,'Y6').
symbol(p17,'Y7').
symbol(p18,'Y8').
symbol(p19,'Y9').

symbol(p21,'G1').
symbol(p22,'G2').
symbol(p23,'G3').
symbol(p24,'G4').
symbol(p25,'G5').
symbol(p26,'G6').
symbol(p27,'G7').
symbol(p28,'G8').
symbol(p29,'G9').

symbol(p31,'R1').
symbol(p32,'R2').
symbol(p33,'R3').
symbol(p34,'R4').
symbol(p35,'R5').
symbol(p36,'R6').
symbol(p37,'R7').
symbol(p38,'R8').
symbol(p39,'R9').


symbol(1, '01').
symbol(2, '02').
symbol(3, '03').
symbol(4, '04').
symbol(5, '05').
symbol(6, '06').
symbol(7, '07').
symbol(8, '08').
symbol(9, '09').
symbol(10, '10').
symbol(11, '11').
symbol(12, '12').
symbol(13, '13').
symbol(14, '14').
symbol(15, '15').
symbol(16, '16').
symbol(17, '17').
symbol(18, '18').
symbol(19, '19').
symbol(20, '20').
symbol(21, '21').
symbol(22, '22').
symbol(23, '23').
symbol(24, '24').
symbol(25, '25').
symbol(26, '26').
symbol(27, '27').
symbol(28, '28').
symbol(29, '29').
symbol(30, '30').
symbol(31, '31').
symbol(32, '32').
symbol(33, '33').
symbol(34, '34').
symbol(35, '35').
symbol(36, '36').
symbol(37, '37').
symbol(38, '38').
symbol(39, '39').
symbol(40, '40').
symbol(50, '50').


initialize_board(Board):-
  Board=[[p1,p2,p3,p4],
          [p5,p6,p7],
          [p8,p9],
          [p11,p21],
          [p15,10,p25],
          [p12,p18,p28,p22],
          [p16,20,50,30,p26],
          [p13,p19,p29,p23],
          [p17,40,p27],
          [p14,p24],
          [p38,p39],
          [p35,p36,p37],
          [p31,p32,p33,p34]].
