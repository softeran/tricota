Class {
	#name : #AccelerationTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
AccelerationTest >> setUp [
	|deckBuilder|
	self setUpCard.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration.
	deck:= deckBuilder buildDeterministic .

]

{ #category : #tests }
AccelerationTest >> testAccelerationCardApplysToEveryone [

	| game accelerationThrownByJuan |

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan .
	
	game nextTurn. "Juan rolled 7 plus one for Acceleration card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn. "Nico rolled 9 plus one for Acceleration card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10.
			
	game nextTurn."Juan rolled 3 plus one for Acceleration card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 12;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10.
	game nextTurn. "Nico rolled 7 plus one for Acceleration card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 12;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 18.
	
	
]

{ #category : #tests }
AccelerationTest >> testCantThrowAccelerationCardIfItsNotYourTurn [

	| game accelerationThrownByJuan accelerationThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	accelerationThrownByNico := Acceleration initializeCard .
	
	self "Nico tried to throw an Acceleration card in Juans turn"
		should: [ game player: nico throw: accelerationThrownByNico ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self "Juan tried to throw an Acceleration card in Nicos turn"
		should: [ game player: juan throw: accelerationThrownByJuan ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
]

{ #category : #tests }
AccelerationTest >> testThrowMoreThanOneAccelerationCard [

	| game firstAccelerationThrownByJuan secondAccelerationThrownByJuan accelerationThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	firstAccelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: firstAccelerationThrownByJuan .
	game nextTurn. "Juan rolled 7 plus one for acceleration card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.	
					
	accelerationThrownByNico := Acceleration initializeCard .
	game player: nico throw: accelerationThrownByNico.
	game nextTurn. "Nico rolled 9 plus 2 for two active acceleration cards"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 11.
			
	secondAccelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	game player: juan throw: secondAccelerationThrownByJuan .
	game nextTurn."Juan rolled 3 plus 3 for three active acceleration cards"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 14;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 11.
	game nextTurn. "Nico rolled 7 plus 3 for three active acceleration cards"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 14;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 21.
	
	
]
