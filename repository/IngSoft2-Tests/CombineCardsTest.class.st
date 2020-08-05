Class {
	#name : #CombineCardsTest,
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
CombineCardsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CombineCardsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
CombineCardsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CombineCardsTest >> setUp [
	| effectRouletteBuilder |
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	sofi := self sofi.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico;
		add: sofi.
	effectRouletteBuilder := EffectRouletteBuilder
		buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette := effectRouletteBuilder buildDeterministic
]

{ #category : #accessing }
CombineCardsTest >> sofi [
	^ self playerNamed: 'Sofi'.
]

{ #category : #tests }
CombineCardsTest >> testCombineAccelerationOverloadAndSpeedCards [
	
	| deckBuilder game accelerationThrownByJuan overloadThrownByJuan  speedThrownByNico accelerationThrownByNico speedThrownBySofi |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration ; 	"Juan has an Acceleration & Overload"
					add: Overload ;			"Nico has a Speed & Acceleration"
					add: Speed.				"Sofi has an Overload & Speed"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	accelerationThrownByJuan := Acceleration initializeCard.
	game player: juan throw: accelerationThrownByJuan .
	overloadThrownByJuan := Overload initializeCardWithTarget: nico.
	game player: juan throw: overloadThrownByJuan .
	
	game nextTurn."Juan rolled 7 plus 1 of active acceleration card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.

	accelerationThrownByNico := Acceleration initializeCard.
	game player: nico throw: accelerationThrownByNico .
	speedThrownByNico := Speed initializeCardWithTarget: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn."Nico rolled 9 minus 2 for being target of one active overload card, plus 3 for 2 active acceleration cards and being target of one speed card"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
			
	speedThrownBySofi := Speed initializeCardWithTarget: sofi.
	game player: sofi throw: speedThrownBySofi .
	
	game nextTurn.
		self"Sofi rolled 3 plus 3 for 2 active acceleration cards and being target of one speed card"
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 6.
]
