Class {
	#name : #UcaBoardGameWithCardsTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #tests }
UcaBoardGameWithCardsTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> finish: game [
	self play: game amountOfTurns: 4
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #running }
UcaBoardGameWithCardsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
UcaBoardGameWithCardsTest >> setUp [
|effectRouletteBuilder|
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect  new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 

]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testAccelerationCard [

	| game cards|
	cards:= OrderedCollection new.
	cards add: Acceleration new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7.		
	game player: nico throw: Acceleration new.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10.
	game player: juan throw: Acceleration new.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 12;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 12;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 19.
	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testCancellationAfterTwoSpeedCardSelectingOne [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Speed new;
	add: Cancellation new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: (Speed target: nico).
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	game player: nico throw: (Speed target: nico).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game player: juan throw: (Cancellation selectCard: (Speed target: nico)).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game nextTurn.
		self 
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 19.

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testCancellationOfAccelerationCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Cancellation new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: Acceleration new.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: nico throw: (Cancellation selectCard: Acceleration new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testInitializeGameDeterministicDealingCards [
|cards game |
	cards:= OrderedCollection new.
	cards 
	add: Repeat new;
	add: Overload new;
	add: Acceleration new.
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.

	self assert: juan numberOfCards equals: 2.
	self assert:( juan assertHasCard: Repeat new).
	self assert:( juan assertHasCard: Overload new).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: Acceleration new).
	self assert:( nico assertHasCard: Repeat new).
	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testInitializeGameRandomDealingCards [

|cards game|
	cards:= OrderedCollection new.
	cards 
	add: Repeat new;
	add: Overload new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.

	self assert: juan numberOfCards equals: 2.
	self assert: nico numberOfCards equals:2.
	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testOverloadCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Overload new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	game player: nico throw: (Overload target: juan).
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testPlayerCanNotThrowCardAfterTheGameHasFinished [

	| game  cards|
	
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new.
	
	game:= UCABoardGame rolling: die with: players lockers: 8 laps: 2 effects: effectRoulette andDeterministic: cards.
	self finish: game.
	self 
	should: [ game player: juan throw: Acceleration new ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoAccelerationCard [

	| game  cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Redo new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: Acceleration new.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: juan throw:(Redo ofCard:Acceleration new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoCancellationCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Cancellation new;
	add: Redo new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: Acceleration new.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.
		
	game player: nico throw: Acceleration new.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game player: juan throw: (Cancellation selectCard: Acceleration new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game player: nico throw: (Redo ofCard:(Cancellation selectCard: Acceleration new)).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoRedoCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Redo new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: Acceleration new.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: juan throw:(Redo ofCard:Acceleration new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: nico throw:(Redo ofCard:(Redo ofCard:Acceleration new)).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 20.
	

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoRepeatCard [

	|game  cards effectRouletteBuilder|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Repeat new;
	add: Redo new.
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: (PickUpCard withRandom: cards);
	add: NoEffect new;
	add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
game player: juan throw: (Repeat target: juan).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game player: nico throw: (Redo ofCard:(Repeat target:nico)).
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testSpeedCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Speed new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	game player: nico throw: (Speed target: nico).
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		


	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testTryToThrowRepeatCardBeforeNobodyRolledDice [

	| game cards |
	
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	self 
	should: [ game player: juan throw: (Repeat target: juan) ]
		raise: InvalideRequest
		withMessageText: 'Nobody rolled the dice yet'.
		
	
]
