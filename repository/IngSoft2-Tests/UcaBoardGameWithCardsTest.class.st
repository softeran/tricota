Class {
	#name : #UcaBoardGameWithCardsTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players'
	],
	#category : #'IngSoft2-Tests-Effects-Tests'
}

{ #category : #tests }
UcaBoardGameWithCardsTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
UcaBoardGameWithCardsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
UcaBoardGameWithCardsTest >> setUp [
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testAccelerationCard [

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Speed new;
	add: Cancellation new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Cancellation new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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
UcaBoardGameWithCardsTest >> testDeterministicPickUpCardEffect [

	| game effectRoulette pickUpcards gameCards |
	pickUpcards:= OrderedCollection new.
	pickUpcards 
	add: Repeat new;
	add: Overload new.
	gameCards := OrderedCollection new.
	gameCards add: Acceleration new.
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: (PickUpCard withSequence: pickUpcards).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: gameCards.
	
	self assert: juan numberOfCards equals: 2.
	self assert: nico numberOfCards equals: 2.
	
	game nextTurn.
	self assert: juan numberOfCards equals: 3.
	self assert: (juan assertHasCard: Repeat new ).

	game nextTurn.
	self assert: nico numberOfCards equals: 3.
	self assert: (nico assertHasCard: Overload new ).
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testInitializeGameDeterministicDealingCards [
|cards game effectRoulette |
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

|cards game effectRoulette |
	cards:= OrderedCollection new.
	cards 
	add: Repeat new;
	add: Overload new.
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.

	self assert: juan numberOfCards equals: 2.
	self assert: nico numberOfCards equals:2.
	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testOverloadCard [

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Overload new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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
UcaBoardGameWithCardsTest >> testRedoAccelerationCard [

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Redo new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Cancellation new;
	add: Redo new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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
UcaBoardGameWithCardsTest >> testRedoRepeatCard [

	|game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Repeat new;
	add: Redo new.
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: SpeedUp  new.
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
UcaBoardGameWithCardsTest >> testRepeatAtomicBomb [

	| game effectRoulette effectRouletteBuilder cards |
	
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: AtomicBomb new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game player: juan throw: (Repeat target: juan).
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRepeatMoonWalk [

	| game effectRoulette effectRouletteBuilder cards |
	
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2));
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	game player: juan throw: (Repeat target: juan).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRepeatNoEffect [

	| game effectRoulette  effectRouletteBuilder cards|
	
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
			add: (PickUpCard withRandom: cards);
			add: NoEffect new;
			add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards..
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	game player: juan throw: (Repeat target: nico).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRepeatPickUpCard [

	| game effectRoulette effectRouletteBuilder cards |
	
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: juan numberOfCards equals: 3.
		
	game player: juan throw: (Repeat target: juan).
	self
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: juan numberOfCards equals: 3.
	

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRepeatSpeedUp [

	| game effectRoulette effectRouletteBuilder cards|

	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: SpeedUp  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.
	game player: juan throw: (Repeat target: juan).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRepeatWormHole [

	| game effectRoulette effectRouletteBuilder cards|
	
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: WormHole   new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	game player: juan throw: (Repeat target: nico).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 1.

	
	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testSpeedCard [

	| game effectRoulette effectRouletteBuilder cards|
	cards:= OrderedCollection new.
	cards 
	add: Speed new.
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
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
