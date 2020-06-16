Class {
	#name : #HappyPathTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'nico',
		'players',
		'die',
		'effectRoulette',
		'effects',
		'noEffect',
		'cards',
		'sofi',
		'deck'
	],
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
HappyPathTest >> finish: game [
	self play: game amountOfTurns: 7
]

{ #category : #accessing }
HappyPathTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
HappyPathTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
HappyPathTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #running }
HappyPathTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
HappyPathTest >> setUp [
	|effectRouletteBuilder  pickUpCards |
	pickUpCards := OrderedCollection new.
	pickUpCards add: Redo new.
	deck:= OrderedCollection new.
	deck
	add: Acceleration  new;
	add: Cancellation new;
	add: Speed new;
	add: Overload new;
	add: Repeat new.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new;
	add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(3));
	add: NoEffect new;
	add: NoEffect new;
	add: (PickUpCard withSequence: pickUpCards);
	add: AtomicBomb new;
	add: WormHole new;
	add: NoEffect new;
	add: NoEffect new;
	add: NoEffect new;
	add: NoEffect new;
	add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic.
	
	die := Die of: 10 rolling: #(7 9 10 4 5 7 8 3 9 10 10 2).
	juan := self juan.
	nico := self nico.
	sofi:= self sofi.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico;
		add: sofi.

]

{ #category : #accessing }
HappyPathTest >> sofi [
	^ self playerNamed: 'Sofi'.
]

{ #category : #tests }
HappyPathTest >> testHappyPath [

| game tableOfFinalPositions |
	
	game:= UCABoardGame rolling: die with: players lockers: 15 laps: 2 effects: effectRoulette andDeterministic: deck.
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	game nextTurn.	"In this Turn Juan rolled 7 and the effect was speed up"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	game player: sofi throw: (Repeat target: sofi). "Sofi threw Repeat Card and the last effect was SpeedUp"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 4.
		
	game nextTurn. "In this Turn Nico rolled 9 and the effect was MoonWalk. Everyone except Nico went three lockers backwards"

	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 1.
		
	game nextTurn."In this Turn Sofi rolled 10 and the effect was No effect"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 11.
		
	game player: juan throw: Acceleration new.
	game nextTurn. "In this Turn Juan rolled 4 and the effect was no effect. As the Acceleration Card was active, he moves 5 lockers forward"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 11.
		
	game player: nico throw: (Speed target: nico).
	game player: nico throw:(Overload target:juan ).
	game nextTurn. "In this Turn Nico rolled 5 and the effect was Pick Up card. He picked up a Redo Card. Nico moves 7 lockers forward because of the speed card and the acceleration card"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lockerNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: sofi) equals: 11.
		
	game nextTurn. "In this Turn Sofi rolled 7 and the effect was Atomic Bomb. Sofi moves 8 lockers forward because of the acce;eration card and changes lap to 1. But then she moves to locker zero at lap 1 because of the atomic bomb effect"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	game player: juan throw:(Cancellation selectCard:( Speed target: nico) ).
	game nextTurn. "In this Turn Juan rolled 8 and the effect was WormHole.As he had an Acceleration card and an Overload Card he only ended up moving 3 lockers forward "
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn. "In this Turn Nico rolled 3 and the effect was No effect. As he had the acceleration card, he moves 4 lockers forward"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 4;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game player: nico throw:(Redo ofCard:( Cancellation selectCard: Acceleration new)).
		
	game nextTurn. "In this Turn Sofi rolled 9 and the effect was No effect."
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 4;
		assert: (game lockerNumberOf: sofi) equals: 9.
		
	game nextTurn. "In this Turn Juan rolled 10 and the effect was No effect. As he had the Overload card, he moved forward 8 lockers"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals:11;
		assert: (game lockerNumberOf: nico) equals: 4;
		assert: (game lockerNumberOf: sofi) equals: 9.
		
	game nextTurn. "In this Turn Nico rolled 10 and the effect was No effect."
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals:11;
		assert: (game lockerNumberOf: nico) equals: 14;
		assert: (game lockerNumberOf: sofi) equals: 9.
		
		game nextTurn. "In this Turn Sofi rolled 2 and the effect was SpeedUp.So she moved 6 lockers forward and won the game:)!!!!"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:2;
		assert: (game lockerNumberOf: juan) equals:11;
		assert: (game lockerNumberOf: nico) equals: 14;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	self 
		assert: game winner equals: sofi.
		tableOfFinalPositions:= game playersPositions.
		self assert:(tableOfFinalPositions atPosition: 1 ) equals: sofi.
		self assert:(tableOfFinalPositions  atPosition: 2 ) equals: nico.
		self assert:(tableOfFinalPositions  atPosition: 3 ) equals: juan.
		
		
		

		

]
