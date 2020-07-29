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
