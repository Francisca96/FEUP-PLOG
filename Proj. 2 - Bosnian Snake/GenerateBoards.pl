:- use_module(library(random)).

generateBoard(Size,MiddleRestricions,HorizontalRestrictions,VerticalRestrictions,NPuzzle):-
      generateMR(Size,MiddleRestricions,MiddleList),
      generateHR(Size,HorizontalRestrictions,HorizontalList),
      generateVR(Size,VerticalRestrictions,VerticalList),
      random(10,100,NPuzzle),
      assert(puzzle(NPuzzle,Size,HorizontalList,VerticalList,MiddleList)).

generateHR(_,0,[]).
generateHR(Size,HorizontalRestrictions,[L-X|HorizontalList]):-
  NSize is Size -1,
  random(2,NSize,L),
  random(2,NSize,X),
  N is HorizontalRestrictions -1,
  generateHR(Size,N,HorizontalList).

generateVR(_,0,[]).
generateVR(Size,VerticalRestrictions,[C-X|VerticalList]):-
  NSize is Size -1,
  random(2,NSize,C),
  random(2,NSize,X),
  N is VerticalRestrictions -1,
  generateVR(Size,N,VerticalList).

generateMR(_,0,[]).
generateMR(Size,MiddleRestricions,[L-C-X|MiddleList]):-
  NSize is Size -1,
  random(2,NSize,L),
  random(2,NSize,C),
  random(1,7,X),
  N is MiddleRestricions -1,
  generateMR(Size,N,MiddleList).
