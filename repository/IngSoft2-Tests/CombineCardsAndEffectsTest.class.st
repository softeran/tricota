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
	#category : #'IngSoft2-Tests-Card-Test'
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

	die := Die of: 10 rolling: #(7 9 3 1).
	juan := self juan.
	nico := self nico.
	sofi := self sofi.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico;
		add: sofi.
	
]

{ #category : #accessing }
CombineCardsAndEffectsTest >> sofi [
	^ self playerNamed: 'Sofi'.
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
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
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
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
			
	game nextTurn."Nico rolled 9 minus 2 for being target of one active overload card. He doesnt reach lap 1 and the effect was Atomic bomb so que goes back to lap 0 locker 0"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 0;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
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
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
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
	
	game nextTurn."Juan rolled 7 and the effect was Worm hole so he moves to locker 3 and didnt win"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 3;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
	
	game nextTurn."Nico rolled 9 minus 2 for being target of active speed card and minus 4 becaus the effect was wormhole. He moves to locker 3"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 3;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 3;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.

]

{ #category : #tests }
CombineCardsAndEffectsTest >> testWormHolePlusThreeOverloadCardsDecreasesTwoLapsInOneTurn [

	| effectRouletteBuilder deckBuilder game firstOverloadThrownByNico secondOverloadThrownByNico overloadThrownBySofi |
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
	
	game nextTurn."Juan rolled 7 and increases 2 laps"
		self
			assert: (game lapNumberOf: juan) equals: 2;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
	
	firstOverloadThrownByNico:= Overload initializeCardWithTarget: juan.
	game player: nico throw: firstOverloadThrownByNico.
	secondOverloadThrownByNico:= Overload initializeCardWithTarget: juan.
	game player: nico throw: secondOverloadThrownByNico.
	game nextTurn."Nico rolled 9 and increases 3 laps"
		self
			assert: (game lapNumberOf: juan) equals: 2;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 3;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
			
	overloadThrownBySofi:= Overload initializeCardWithTarget: juan.
	game player: sofi throw: overloadThrownBySofi.
	game nextTurn."Sofi rolled 3 and increases 1 laps"
		self
			assert: (game lapNumberOf: juan) equals: 2;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 3;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 1;
			assert: (game lockerNumberOf: sofi) equals: 0.

	game nextTurn."Juan rolled 1 minus 4 of WormHole effect minus 6 for being target of three active Overload cards"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 1;
			assert: (game lapNumberOf: nico) equals: 3;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 1;
			assert: (game lockerNumberOf: sofi) equals: 0.
	
]
