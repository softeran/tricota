Class {
	#name : #RedoTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Cards-Test'
}

{ #category : #running }
RedoTest >> setUp [

	self setUpCard.


]

{ #category : #tests }
RedoTest >> testCantRedoASpeedCardIfIsNotYourTurn [

	| game  deckBuilder speedThrownByJuan |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: juan .
	game player: juan throw: speedThrownByJuan.
	self "Nico cant Redo a permanent card if its not his turn"
	should: [ game player: nico throw: (Redo initializeCardWithTarget: nico)]
		raise: InvalidRequest
		withMessageText: 'It is not your turn'.

	
]

{ #category : #tests }
RedoTest >> testCantRedoAnAccelerationCardIfIsNotYourTurn [

	| game  deckBuilder accelerationThrownByJuan |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan.
	self "Nico cant Redo a permanent card if its not his turn"
	should: [ game player: nico throw: (Redo initializeCardWithTarget: Everyone new)]
		raise: InvalidRequest
		withMessageText: 'It is not your turn'.

	
]

{ #category : #tests }
RedoTest >> testCantRedoAnOverloadCardIfIsNotYourTurn [

	| game  deckBuilder overloadThrownByJuan |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Overload ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico .
	game player: juan throw: overloadThrownByJuan.
	self "Nico cant Redo a permanent card if its not his turn"
	should: [ game player: nico throw: (Redo initializeCardWithTarget: juan)]
		raise: InvalidRequest
		withMessageText: 'It is not your turn'.

	
]

{ #category : #tests }
RedoTest >> testRedoAccelerationCard [

	| game  deckBuilder accelerationThrownByJuan redoThrownByJuan|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan.
	game nextTurn."Juan rolled 7 plus one for the acceleration card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9 plus one for the acceleration card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	redoThrownByJuan := Redo initializeCardWithTarget: Everyone new.
	game player: juan throw: redoThrownByJuan .
	game nextTurn."Juan rolled 3 plus 2 for two active acceleration cards (One was redoed)"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
RedoTest >> testRedoCancellationCard [

	| game  deckBuilder accelerationThrownByJuan accelerationThrownByNico cancellationThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Cancellation ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan .
	game nextTurn. "Juan rolled 7 plus 1 for active acceleration card"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	accelerationThrownByNico := Acceleration initializeCard .
	game player: nico throw: accelerationThrownByNico .
	game nextTurn."Nico rolled 9 plus 2 for two active acceletarion cards"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	cancellationThrownByJuan := Cancellation initializeCardWithTarget: accelerationThrownByJuan.
	game player: juan throw: cancellationThrownByJuan .
	game nextTurn."Juan rolled 3 plus one for one active acceleration card (the other one was cancelled)"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	redoThrownByNico := Redo initializeCardWithTarget: accelerationThrownByNico.
	game player: nico throw: redoThrownByNico .
	game nextTurn."Nico rolled 7 and now ther is no acceleration card because it was cancelled with a redo card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.

	
]

{ #category : #tests }
RedoTest >> testRedoOverloadCard [

	| game  deckBuilder overloadThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Overload ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico.
	game player: juan throw: overloadThrownByJuan.
	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	redoThrownByNico := Redo initializeCardWithTarget: juan.
	game player: nico throw: redoThrownByNico .
	game nextTurn."Nico rolled 9 minus 2 for being target of one overloa card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
		
	game nextTurn."Juan rolled 3 minus 2 for being target of an active overload card (it was redoed)"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
	

	
]

{ #category : #tests }
RedoTest >> testRedoRedoCard [

	| game  deckBuilder accelerationThrownByJuan redoThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCardWithTarget: Everyone new.
	game player: juan throw: accelerationThrownByJuan.
	game nextTurn."Juan rolled 7 plus 1 for an active acceleration card"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	game nextTurn."Nico rolled 9 plus 1 for an active acceleration card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	redoThrownByJuan := Redo initializeCardWithTarget: Everyone new.
	game player: juan throw: redoThrownByJuan .
	game nextTurn."Juan rolled 3 plus 2 because of two active acceleation cards (the second one was redoed)"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	redoThrownByNico := Redo initializeCardWithTarget: Everyone new.
	game player: nico throw: redoThrownByNico .
	game nextTurn."Nico rolled 7 plus 3 for three active acceleration cards, the third was redoed from the redo card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 20.
	

	
]

{ #category : #tests }
RedoTest >> testRedoRepeatCard [

	|game deckBuilder effectRouletteBuilder repeatThrownByJuan redoThrownByNico |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Repeat ;
					add: Redo .
	deck := deckBuilder buildDeterministic.

	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: PickUpCard new;
								add: NoEffect new;
								add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn."Juan rolled 7 and pick up one card"
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	self assert: juan numberOfCards equals: 3.
	
	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan ."Juan picks another card"
	
	self assert: juan numberOfCards equals: 3.
	
	game nextTurn."Nico rolled 9"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn."Juan rolled 3 plus 4 for speed up effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	redoThrownByNico := Redo initializeCardWithTarget: nico.
	game player: nico throw: redoThrownByNico . "Nico moves forward 4 lockers"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
]

{ #category : #tests }
RedoTest >> testRedoReversalCard [

	| game  deckBuilder reversalThrownByJuan redoThrownByNico effectRouletteBuilder |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Reversal ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	reversalThrownByJuan := Reversal initializeCardWithTarget: (LockerTarget atLocker: 7).
	game player: juan throw: reversalThrownByJuan.
	game nextTurn."Juan rolled 7 but landed at a SpeedUp locker with a Reversal Card applied to it"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	redoThrownByNico := Redo initializeCardWithTarget: (LockerTarget atLocker: 9) .
	game player: nico throw: redoThrownByNico .
	game nextTurn."Nico rolled 9 but landed at a SpeedUp locker with a Reversal Card applied to it"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	

	
]

{ #category : #tests }
RedoTest >> testRedoSpeedCard [

	| game  deckBuilder speedThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: juan.
	game player: juan throw: speedThrownByJuan.
	game nextTurn."Juan rolled 7 plus 1 for being taget of one active speed card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	redoThrownByNico := Redo initializeCardWithTarget: nico.
	game player: nico throw: redoThrownByNico .
	game nextTurn."Nico rolled 9 plus one because que redoed Speed card with him as target"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game nextTurn."Juan rolled 3 plus one for being target of one active Speed card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
RedoTest >> testTryToThrowRedoCardBeforeNobodyThrewAnyCard [

	| game deckBuilder|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
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

	"Nobody threw any card, nobody can throw a Redo card"
	self 
	should: [ game player: juan throw: Redo initializeCard ]
		raise: InvalidRequest
		withMessageText: 'Nobody threw a card yet'.
	self 
	should: [ game player: nico throw: Redo initializeCard ]
		raise: InvalidRequest
		withMessageText: 'Nobody threw a card yet'.
		
	
]
