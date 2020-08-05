Class {
	#name : #CombineCardsAndEffectsTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette',
		'deck',
		'sofi'
	],
	#category : #'IngSoft2-Tests-Cards-Test'
}

{ #category : #accessing }
CombineCardsAndEffectsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CombineCardsAndEffectsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #accessing }
CombineCardsAndEffectsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CombineCardsAndEffectsTest >> setUp [

	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

	
]

{ #category : #accessing }
CombineCardsAndEffectsTest >> sofi [
	^ self playerNamed: 'Sofi'.
]

{ #category : #tests }
CombineCardsAndEffectsTest >> testSpeedUpPlusAccelerationAndReversalCard [

	| effectRouletteBuilder deckBuilder game accelerationThrownByJuan reversalThrownByJuan |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration; 	"Everyon has Acceleration and Reversal card"
					add: Reversal.
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 5 laps: 5 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan .
	reversalThrownByJuan := Reversal initializeCardWithTarget:  (LockerTarget atLocker: 3).
	game player: juan throw: reversalThrownByJuan .
	
	game nextTurn."Juan rolled 7 plus 1 of  active acceleration card. He changes lap, but he lands at locker three where a ReversalCard was applied , so he goes back to lap 0 "
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 4;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
	
]

{ #category : #tests }
CombineCardsAndEffectsTest >> testSpeedUpPlusAccelerationAndSpeedCardIncreasesTwoLapsInOneTurn [

	| effectRouletteBuilder deckBuilder game accelerationThrownByJuan speedThrownByJuan |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration; 	"Everyon has Acceleration and speed card"
					add: Speed.
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 5 laps: 5 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan .
	speedThrownByJuan := Speed initializeCardWithTarget: juan .
	game player: juan throw: speedThrownByJuan .
	
	game nextTurn."Juan rolled 7 plus 4 of SpeedUp effecct plus 2 of one active acceleration card and is target of one active speed card. He increases 2 laps"
		self
			assert: (game lapNumberOf: juan) equals: 2;
			assert: (game lockerNumberOf: juan) equals: 3;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
		
]

{ #category : #tests }
CombineCardsAndEffectsTest >> testWithOverloadCardPlayerDoesntReachNextLapAndEffectAtomicBomb [

	| effectRouletteBuilder deckBuilder game overloadThrownByJuan |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new;
								add: AtomicBomb new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload. 	"Everyon has two Overload cards"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 8 laps: 5 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico .
	game player: juan throw: overloadThrownByJuan .
	
	game nextTurn."Juan rolled 7 and the effect was no effect"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.	
	game nextTurn."Nico rolled 9 minus 2 for being target of one active overload card. He doesnt reach lap 1 and lands at an Atomic bomb effect so que goes back to lap 0 locker 0"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 0;
			assert: (game lapNumberOf: nico) equals: 1;
			assert: (game lockerNumberOf: nico) equals: 0.
	
]

{ #category : #tests }
CombineCardsAndEffectsTest >> testWithTwoAccelerationCardsPlayerReachNextLapAndEffectAtomicBomb [

	| effectRouletteBuilder deckBuilder game firstAccelerationThrownByJuan secondAccelerationThrownByJuan |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: AtomicBomb new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration. 	"Everyon has two Acceleration cards"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 5 effects: effectRoulette and: deck.
	
	firstAccelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: firstAccelerationThrownByJuan .
	secondAccelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: secondAccelerationThrownByJuan .
	
	game nextTurn."Juan rolled 7 plus 2 of two active acceleration cards. He reaches locker 1 of lap 1 and the effect was Atomic Bomb so que goes back to locker 0 of lap 1"
		self
			assert: (game lapNumberOf: juan) equals: 1;
			assert: (game lockerNumberOf: juan) equals: 0;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.

]

{ #category : #tests }
CombineCardsAndEffectsTest >> testWormHolePlusOverloadCardAvoidPlayerToWin [

	| effectRouletteBuilder deckBuilder game overloadThrownByJuan |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: WormHole new;
								add: WormHole new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload . 	"Everyon has two Overload cards"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 4 laps: 1 effects: effectRoulette and: deck.
	
	overloadThrownByJuan:= Overload initializeCardWithTarget: nico.
	game player: juan throw: overloadThrownByJuan.
	
	game nextTurn."Juan rolled 7 and the effect was Worm hole so he moves to locker 3 and dose not win"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 3;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
	
	
	game nextTurn."Nico rolled 9 minus 2 for being target of an active overload card and minus 4 because the effect was wormhole. He moves to locker 3"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 3;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 3.
		

]

{ #category : #tests }
CombineCardsAndEffectsTest >> testWormHolePlusThreeOverloadCardsAndReversalCard [

	| effectRouletteBuilder deckBuilder game reversalThrownByJuan overloadThrownByNico  |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new;
								add: WormHole new.	
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload ;
					add: Reversal.  	"Everyon has an Overload Card and a Reversal one "
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 7 laps: 3 effects: effectRoulette and: deck.
	reversalThrownByJuan:= Reversal initializeCardWithTarget: (LockerTarget atLocker: 2).
	game player: juan throw: reversalThrownByJuan.
	game nextTurn."Juan rolled 7 "
		self
			assert: (game lapNumberOf: juan) equals: 1;
			assert: (game lockerNumberOf: juan) equals: 0;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
		
	
	overloadThrownByNico:= Overload initializeCardWithTarget: juan.
	game player: nico throw: overloadThrownByNico.
	game nextTurn."Nico rolled 9 "
		self
			assert: (game lapNumberOf: juan) equals: 1;
			assert: (game lockerNumberOf: juan) equals: 0;
			assert: (game lapNumberOf: nico) equals: 1;
			assert: (game lockerNumberOf: nico) equals: 6.
	
			
	game nextTurn. "Juan rolled 3 but was target of an overload card, so he goes back 2 "
		self
			assert: (game lapNumberOf: juan) equals: 1;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 1;
			assert: (game lockerNumberOf: nico) equals: 6.
		

	
]

{ #category : #tests }
CombineCardsAndEffectsTest >> testWormHolePlusTwoOverloadCardsDecreasesTwoLapsInOneTurn [

	| effectRouletteBuilder deckBuilder game firstOverloadThrownByNico secondOverloadThrownByNico |
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new;
								add: NoEffect new;
								add: NoEffect new;
								add: WormHole new.	
	effectRoulette := effectRouletteBuilder buildDeterministic.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload . 	"Everyon has two Overload cards"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 3 laps: 5 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7 and doing two laps at once "
		self
			assert: (game lapNumberOf: juan) equals: 2;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.

	
	firstOverloadThrownByNico:= Overload initializeCardWithTarget: juan.
	game player: nico throw: firstOverloadThrownByNico.
	secondOverloadThrownByNico:= Overload initializeCardWithTarget: juan.
	game player: nico throw: secondOverloadThrownByNico.
	game nextTurn."Nico rolled 9 and does 3 laps at once"
		self
			assert: (game lapNumberOf: juan) equals: 2;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 3;
			assert: (game lockerNumberOf: nico) equals: 0.
			
	
		
	
]
