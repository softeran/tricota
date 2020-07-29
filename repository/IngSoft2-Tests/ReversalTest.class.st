Class {
	#name : #ReversalTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Cards-Test'
}

{ #category : #running }
ReversalTest >> setUp [
| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Reversal .
	deck := deckBuilder buildDeterministic



]

{ #category : #tests }
ReversalTest >> testApplyReversalCardToMooWalkLocker [
| game reversalThrownByNico effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	effectRoulette := effectRouletteBuilder buildDeterministic.

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
"	reversalThrownByNico := Reversal initializeCardWithTarget:10."
	reversalThrownByNico := Reversal initializeCardWithTarget: (LockerTarget atLocker: 8).
	game player: nico throw: reversalThrownByNico .
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn."Juan rolled 3, and lands at locker 8 with reversal effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
	
]

{ #category : #tests }
ReversalTest >> testApplyReversalCardToPickUpCardLocker [
| game reversalThrownByJuan effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: PickUpCard  new.
	effectRoulette := effectRouletteBuilder buildDeterministic.

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 9).
	game player: juan throw: reversalThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		self assert: juan numberOfCards equals: 2.
		self assert: nico numberOfCards equals: 2.
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		self assert: juan numberOfCards equals: 2.
		self assert: nico numberOfCards equals: 2.
		

	
]

{ #category : #tests }
ReversalTest >> testApplyReversalCardToSpeedUpLocker [
| game reversalThrownByNico effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new.
	effectRoulette := effectRouletteBuilder buildDeterministic.

	reversalThrownByNico := Reversal initializeCardWithTarget: (LockerTarget atLocker: 14).
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
"	reversalThrownByNico := Reversal initializeCardWithTarget:10."
	game player: nico throw: reversalThrownByNico .
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.
		
	game nextTurn."Juan rolled 3, and lands at locker 14 with reversal effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.
	
]

{ #category : #tests }
ReversalTest >> testApplyReversalCardToWormHoleLocker [
| game reversalThrownByNico effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: WormHole new.
	effectRoulette := effectRouletteBuilder buildDeterministic.

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
"	reversalThrownByNico := Reversal initializeCardWithTarget:10."
	reversalThrownByNico := Reversal initializeCardWithTarget: (LockerTarget atLocker: 6).
	game player: nico throw: reversalThrownByNico .
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	game nextTurn."Juan rolled 3, and lands at locker 14 with reversal effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
	
]

{ #category : #tests }
ReversalTest >> testCantThrowReversalCardIfItsNotYourTurn [

	| game reversalThrownByJuan reversalThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 8 ).
	reversalThrownByNico := Reversal initializeCardWithTarget: (LockerTarget atLocker: 1 ).
	
	self "Nico tried to throw an Reversal card in Juans turn"
		should: [ game player: nico throw: reversalThrownByNico ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
	
]

{ #category : #tests }
ReversalTest >> testMoveBackwardsToZeroAsResultOfReversalCardApplyToSpeedUpLockerResultinInANegativePosition [
| game reversalThrownByJuan effectRouletteBuilder|
	die := Die of: 10 rolling: #(7 3 3).
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new.
	effectRoulette := effectRouletteBuilder buildDeterministic.

	reversalThrownByJuan:= Reversal initializeCardWithTarget: (LockerTarget atLocker: 3).
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
		game player: juan throw: reversalThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	game nextTurn."Nico rolled 3 lands at locker 3 with reversal effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		

]

{ #category : #tests }
ReversalTest >> testPlayerChangesLapBecauseTheReversalCardAppliedToAMoonWalkLocker [

| game reversalThrownByNico effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(5)).
	effectRoulette := effectRouletteBuilder buildDeterministic.

	game:= UCABoardGame rolling: die with: players lockers: 11 laps: 2 effects: effectRoulette and: deck.

	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	reversalThrownByNico := Reversal initializeCardWithTarget: (LockerTarget atLocker: 9).
	game player: nico throw: reversalThrownByNico.
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
"	game nextTurn.Juan rolled 3, and lands at locker 8 with reversal effect
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		"
	
]

{ #category : #tests }
ReversalTest >> testPlayerChangesLapBecauseTheReversalCardAppliedToASpeedUpLocker [

| game reversalThrownByNico effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new.
	effectRoulette := effectRouletteBuilder buildDeterministic.

	reversalThrownByNico := Reversal initializeCardWithTarget: (LockerTarget atLocker: 3).
	
	game:= UCABoardGame rolling: die with: players lockers: 11 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
"	reversalThrownByNico := Reversal initializeCardWithTarget:10."
	game player: nico throw: reversalThrownByNico .
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 2.
		
	game nextTurn."Juan rolled 3, and lands at locker 14 with reversal effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 2.
]

{ #category : #tests }
ReversalTest >> testPlayerChangesLapBecauseTheReversalCardAppliedToAWormHoleLocker [

| game reversalThrownByJuan effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: WormHole new.
	effectRoulette := effectRouletteBuilder buildDeterministic.

	game:= UCABoardGame rolling: die with: players lockers: 11 laps: 2 effects: effectRoulette and: deck.
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 9).
	game player: juan throw: reversalThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 2.
		
	
]

{ #category : #tests }
ReversalTest >> testReversalCardDoseNothingWhenAppliedToAnAtomicBombLocker [
| game reversalThrownByJuan effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new;
								add: AtomicBomb new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 9).
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game player: juan throw: reversalThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	
]

{ #category : #tests }
ReversalTest >> testReversalCardDoseNothingWhenAppliedToAnNoEffectLocker [
| game reversalThrownByJuan effectRouletteBuilder|

	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 7).
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game player: juan throw: reversalThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		

]
