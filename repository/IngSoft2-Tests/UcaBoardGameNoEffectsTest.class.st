Class {
	#name : #UcaBoardGameNoEffectsTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'nico',
		'players',
		'die',
		'effectRoulette',
		'effects',
		'noEffect',
		'deck'
	],
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
UcaBoardGameNoEffectsTest >> finish: game [
	self play: game amountOfTurns: 7
]

{ #category : #running }
UcaBoardGameNoEffectsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #running }
UcaBoardGameNoEffectsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #running }
UcaBoardGameNoEffectsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
UcaBoardGameNoEffectsTest >> setUp [
	|effectRouletteBuilder deckBuilder|
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration .
	deck:= deckBuilder buildDeterministic .
	
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic.
	
	die := Die of: 4 rolling: #(3 4 3 1 4 1 4).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testAskForWinnerBeforeFinishing [

	| game |
		
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	
	self
		should: [ game winner   ]
		raise: InvalidRequest
		withMessageText: 'The game has not finished yet'.
		
	self play: game amountOfTurns:2.

	self
		should: [ game winner   ]
		raise: InvalidRequest
		withMessageText: 'The game has not finished yet'
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testGameHasFinished [
	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self finish:game.
	self assert: game hasFinished
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testIncreaseTwoLapsInOneTurn [

	| game |
	game:= UCABoardGame rolling: die with: players lockers: 2 laps: 5 effects: effectRoulette and: deck.
	game nextTurn.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lockerNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: nico) equals:0.
	game nextTurn.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lockerNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:2;
		assert: (game lockerNumberOf: nico) equals:0.
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLapNumberOfPlayer [

	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self play: game amountOfTurns:3.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLapssMustBeGreaterOrEqualToOne [

	-2 to: 0 do: [ :invalidLockers | 
		self
			should: [ UCABoardGame rolling: die with: players lockers: 5 laps: invalidLockers effects: effectRoulette and: deck  ]
			raise: InstanceCreationFailed
			withMessageText: 'Need at least one lap' ]
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLockerNumberOfPlayer [

	| game |
		
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self assert: (game lockerNumberOf: juan) equals: 0.
	game nextTurn.
	self assert: (game lockerNumberOf: juan) equals: 3.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLockersMustBeGreaterOrEqualToOne [

	-2 to: 0 do: [ :invalidLockers | 
		self
			should: [ UCABoardGame rolling: die with: players lockers: invalidLockers laps: 2 effects: effectRoulette and: deck  ]
			raise: InstanceCreationFailed
			withMessageText: 'Need at least one locker' ]
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testPlayerFinishedOneLap [

	| game |
		
	die := Die of: 4 rolling: #(3 4 4).
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self assert: (game lapNumberOf: juan) equals: 0.
	self play: game amountOfTurns:3.
	self assert: (game lapNumberOf: juan) equals: 1.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testPlayersPositionsTable [
		
	| game |
		
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self play:game amountOfTurns:2.
	self assert:(game playersPositionsTable atPosition: 1 ) equals: nico;
		assert:(game playersPositionsTable atPosition: 2 ) equals: juan.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testTryToKeepPlayingAfterGameEnded [

	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self finish: game.
	
	self
		should: [ game nextTurn ]
		raise: InvalidRequest 
		withMessageText: 'The game has finished'
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testWinnersName [
	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	self finish: game.
	self assert: game winner equals: juan
]
