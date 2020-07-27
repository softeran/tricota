Class {
	#name : #OverloadTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
OverloadTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Overload .
	deck := deckBuilder buildDeterministic
]

{ #category : #tests }
OverloadTest >> testCantThrowOverloadCardIfItsNotYourTurn [

	| game overloadThrownByJuan overloadThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico.
	overloadThrownByNico := Overload initializeCardWithTarget: juan.
	
	self "Nico tried to throw an Overload card in Juans turn"
		should: [ game player: nico throw: overloadThrownByNico ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self "Juan tried to throw an Overload card in Nicos turn"
		should: [ game player: juan throw: overloadThrownByJuan ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.

	
	
]

{ #category : #tests }
OverloadTest >> testMoveBackwardsAsResultOfOverloadCards [

	| game firstOverloadThrownByNico secondOverloadThrownByNico |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
		
	firstOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: firstOverloadThrownByNico .
	secondOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: secondOverloadThrownByNico .
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn."Juan rolled 3 minus 4 for being target of two overload cards, he moves backwards 1 locker"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 6;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	

	
	
]

{ #category : #tests }
OverloadTest >> testOverloadCardOnlyApllyToItsTarget [

	| game overloadThrownByNico|
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
		
	overloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: overloadThrownByNico .
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn."Juan rolled 3 minus 2 for being target of one overload card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	

	
	
]

{ #category : #tests }
OverloadTest >> testPlayerInLapOneMovesBackwardsAndChangesLapToZero [

	| game firstOverloadThrownByNico secondOverloadThrownByNico |
	die := Die of: 10 rolling: #(7 2 1).
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.

	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	firstOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: firstOverloadThrownByNico  .
	secondOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: secondOverloadThrownByNico .
	game nextTurn."Nico rolled 2"
	self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 2.
	game nextTurn."Juan rolled 1 minus 4 for being target of two speed card, he goes back to lap 0"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 4;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 2.
	

	

	
	
]

{ #category : #tests }
OverloadTest >> testStayInLockerAndLapZeroIfResultOfDiceAndOverloadCardIsNegative [

	| game firstOverloadThrownByJuan secondOverloadThrownByJuan |
	die := Die of: 10 rolling: #(7 2).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	firstOverloadThrownByJuan := Overload initializeCardWithTarget:  nico.
	game player: juan throw: firstOverloadThrownByJuan .
	secondOverloadThrownByJuan := Overload initializeCardWithTarget:  nico.
	game player: juan throw: secondOverloadThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	game nextTurn."Nico rolled 2 minus  4 for being target of two speed cards, he stays in locker 0 lap 0 because no lap -1 doesnt exists"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	

	
	
]

{ #category : #tests }
OverloadTest >> testThrowMoreThanOneOverloadCard [

	| game overloadThrownByJuan firstOverloadThrownByNico secondOverloadThrownByNico |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget:  nico.
	game player: juan throw: overloadThrownByJuan .
	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	firstOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: firstOverloadThrownByNico .
	secondOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: secondOverloadThrownByNico .
	
	game nextTurn."Nico rolled 9 minus 2 for bieng target of one overload card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
		
	game nextTurn."Juan rolled 3 minus 4 for being target of two overload cards"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 6;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
	

	
	
]
