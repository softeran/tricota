Class {
	#name : #CancellationTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Cards-Test'
}

{ #category : #running }
CancellationTest >> setUp [

	self setUpCard.


]

{ #category : #tests }
CancellationTest >> testCancellationAfterTwoSpeedCardSelectingOne [

	| game deckBuilder speedThrownByJuan speedThrownByNico cancellationThrownByJuan|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed ;
					add: Cancellation .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: nico.
	game player: juan throw: speedThrownByJuan .
	
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	speedThrownByNico := Speed initializeCardWithTarget: nico.
	game player: nico throw: speedThrownByNico .
	game nextTurn."Nico rolled 9 plus 2 for being the target of two active speed cards "
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	cancellationThrownByJuan := Cancellation initializeCardWithTarget: speedThrownByNico.
	game player: juan throw: cancellationThrownByJuan .
	game nextTurn."Juan rolled 3"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game nextTurn."Nico rolled 7 plus one for being the target of one active speed card. The second one was cancelled"
		self 
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 19.

	
]

{ #category : #tests }
CancellationTest >> testCancellationOfAccelerationCard [

	| game deckBuilder accelerationThrownByJuan cancellationThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Cancellation .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan .
	game nextTurn."Juan rolled 7 plus one for one active acceleration card"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9 plus one for one acive acceleration card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	cancellationThrownByNico := Cancellation initializeCardWithTarget: accelerationThrownByJuan.
	game player: nico throw: cancellationThrownByNico .
	
	game nextTurn."Juan rolled 3 and there's no acceleration card active"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
CancellationTest >> testCancellationOfOverloadCard [

	| game deckBuilder overloadThrownByJuan cancellationThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Overload ;
					add: Cancellation .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico .
	game player: juan throw: overloadThrownByJuan .
	game nextTurn."Juan rolled 7"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9 minus 2 for being target of one active overload Card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
		
	cancellationThrownByNico := Cancellation initializeCardWithTarget: overloadThrownByJuan.
	game player: nico throw: cancellationThrownByNico .
	
	game nextTurn."Juan rolled 3"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
	game nextTurn."Nico rolled 7 , tehre was no overload card active"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 14.
	

	
]

{ #category : #tests }
CancellationTest >> testCancellationOfReversalCard [

	| game deckBuilder reversalThrownByJuan cancellationThrownByNico effectRouletteBuilder |
	die := Die of: 10 rolling: #(7 9 6).
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Reversal ;
					add: Cancellation .
	deck := deckBuilder buildDeterministic.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: WormHole new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 11 laps: 2 effects: effectRoulette and: deck.
	
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 9) .
	game player: juan throw: reversalThrownByJuan .
	game nextTurn."Juan rolled 7 and lands at a locker with wormHole effect"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9 and lands at a wormHole locker with a reversal card applied to it"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 2.
		
	cancellationThrownByNico := Cancellation initializeCardWithTarget: reversalThrownByJuan.
	game player: nico throw: cancellationThrownByNico .
	
	game nextTurn."Juan rolled 3 and there was no reversal card active "
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 2.
	

	
]

{ #category : #tests }
CancellationTest >> testCancellationOfSpeedCard [

	| game deckBuilder speedThrownByJuan cancellationThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed ;
					add: Cancellation .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: juan .
	game player: juan throw: speedThrownByJuan .
	game nextTurn."Juan rolled 7 plus 1 for being target of one active speed card"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	cancellationThrownByNico := Cancellation initializeCardWithTarget: speedThrownByJuan.
	game player: nico throw: cancellationThrownByNico .
	
	game nextTurn."Juan rolled 3 , there was no speedUp card active "
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	

	
]

{ #category : #tests }
CancellationTest >> testCantThrowCancellationCardWhenItsTargetIsntActive [

	| game deckBuilder  accelerationCard cancellationCard  overloadCard redoCard repeatCard  speedCard |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder 	add: Cancellation .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationCard := Acceleration initializeCard .
	cancellationCard := Cancellation initializeCardWithTarget: accelerationCard.
	overloadCard := Overload initializeCardWithTarget: juan.
	redoCard := Redo initializeCard.
	repeatCard := Repeat initializeCardWithTarget: juan.
	speedCard := Speed initializeCardWithTarget: juan.
	
	"Cancellation card can only be thrown if its target is an active permanent card"
	self
		should: [ game player: juan throw: (Cancellation initializeCardWithTarget: accelerationCard )]
		raise: InvalidRequest 
		withMessageText: 'Target isnt an active permanent card'.
	self
		should: [ game player: juan throw: (Cancellation initializeCardWithTarget: cancellationCard )]
		raise: InvalidRequest 
		withMessageText: 'Target isnt an active permanent card'.
	self
		should: [ game player: juan throw: (Cancellation initializeCardWithTarget: overloadCard )]
		raise: InvalidRequest 
		withMessageText: 'Target isnt an active permanent card'.
	self
		should: [ game player: juan throw: (Cancellation initializeCardWithTarget: redoCard )]
		raise: InvalidRequest 
		withMessageText: 'Target isnt an active permanent card'.			
	self
		should: [ game player: juan throw: (Cancellation initializeCardWithTarget: repeatCard  )]
		raise: InvalidRequest 
		withMessageText: 'Target isnt an active permanent card'.

	self
		should: [ game player: juan throw: (Cancellation initializeCardWithTarget: speedCard )]
		raise: InvalidRequest 
		withMessageText: 'Target isnt an active permanent card'.
]
