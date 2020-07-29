Class {
	#name : #SpeedTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Cards-Test'
}

{ #category : #running }
SpeedTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed .
	deck := deckBuilder buildDeterministic

]

{ #category : #tests }
SpeedTest >> testCantThrowSpeedCardIfItsNotYourTurn [

	| game speedThrownByJuan speedThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: juan.
	speedThrownByNico := Speed initializeCardWithTarget: nico.
	
	self "Nico tried to throw an Speed card in Juans turn"
		should: [ game player: nico throw: speedThrownByNico ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self "Juan tried to throw an Overload card in Nicos turn"
		should: [ game player: juan throw: speedThrownByJuan ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
		


	
	
]

{ #category : #tests }
SpeedTest >> testPlayerChangesLapBecauseOfTheExtraLockersOfSpeedCard [

	| game speedThrownByNico speedThrownByJuan  |
	
	game:= UCABoardGame rolling: die with: players lockers: 10 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := PermanentCard type: Speed new target: nico.
	game player: juan throw: speedThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	speedThrownByNico := PermanentCard type: Speed new target: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn."Nico rolled 9 plus 2 for being target of two active speed cards. With these extra lockers he changes lap"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 1.
]

{ #category : #tests }
SpeedTest >> testSpeedCardOnlyApllyToItsTarget [

	| game speedThrownByNico |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
		self"Juan rolled 7"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	speedThrownByNico := PermanentCard type: Speed new target: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn."Nico rolled 9 plus 1 for bieng target of one active speed card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.


	
	
]

{ #category : #tests }
SpeedTest >> testThrowMoreThanOneSpeedCard [ 

	| game speedThrownByNico firstSpeedThrownByJuan secondSpeedThrownByJuan |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	firstSpeedThrownByJuan := PermanentCard type: Speed new target: juan.
	game player: juan throw: firstSpeedThrownByJuan .
	game nextTurn."Juan rolled 7 plus 1 for being target of one active speed card"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	speedThrownByNico := PermanentCard type: Speed new target: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn."Nico rolled 9 plus 1 for being target of one active speed card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	
	secondSpeedThrownByJuan := PermanentCard type: Speed new target: juan.
	game player: juan throw: secondSpeedThrownByJuan .
	game nextTurn."Juan rolled 3 plus 2 for being target of two active speed cards "
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	game nextTurn."Nico rolled 7 plus 1 for being target of one of one speed card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.


	
	
]
