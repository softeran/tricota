Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette'
	],
	#category : #'IngSoft2-Tests-Dice-Tests'
}

{ #category : #accessing }
DeckTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
DeckTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #accessing }
DeckTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
DeckTest >> setUp [
	| effectRouletteBuilder |
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	effectRouletteBuilder := EffectRouletteBuilder
		buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette := effectRouletteBuilder buildDeterministic

]

{ #category : #tests }
DeckTest >> testInitializeGameDeterministicDealingCards [
	|game deck deckBuilder |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder 	add: Repeat ;
					add: Overload ;
					add: Acceleration ;
					add: Speed .
	deck:= deckBuilder buildDeterministic .
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert:( juan assertHasCard: (InstantCard type: Repeat new)).
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (PermanentCard type: Acceleration new)).
	self assert:( nico assertHasCard: (PermanentCard type: Speed new)).
	
	
]

{ #category : #tests }
DeckTest >> testInitializeGameRandomDealingCards [

	|deck deckBuilder game |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder 	add: Acceleration  ;
					add: Speed .
	deck:= deckBuilder buildRandom .
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert: nico numberOfCards equals:2.
	
	
]
