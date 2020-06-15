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
		'cards'
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
	|effectRouletteBuilder|
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.
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
		
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	
	self
		should: [ game winner   ]
		raise: InvalideRequest
		withMessageText: 'The game has not finished yet'.
		
	self play: game amountOfTurns:2.

	self
		should: [ game winner   ]
		raise: InvalideRequest
		withMessageText: 'The game has not finished yet'
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testGameHasFinished [
	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self finish:game.
	self assert: game hasFinished
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testHappyPathNoEffects [

	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn.
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	game nextTurn.
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 4.
		
	game nextTurn.

	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 4.
		
	game nextTurn.
		
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	game nextTurn.
		
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 4;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	game nextTurn.
		
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lockerNumberOf: juan) equals: 4;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	game nextTurn.
		
	self 
		assert: (game lapNumberOf: juan) equals:2;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lockerNumberOf: juan) equals: 2;
		assert: (game lockerNumberOf: nico) equals: 0.
		
		
	self assert: game winner equals: juan
	

	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLapNumberOfPlayer [

	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self play: game amountOfTurns:3.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLockerNumberOfPlayer [

	| game |
		
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self assert: (game lockerNumberOf: juan) equals: 0.
	game nextTurn.
	self assert: (game lockerNumberOf: juan) equals: 3.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testPlayerFinishedOneLap [

	| game |
		
	die := Die of: 4 rolling: #(3 4 4).
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self assert: (game lapNumberOf: juan) equals: 0.
	self play: game amountOfTurns:3.
	self assert: (game lapNumberOf: juan) equals: 1.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testPlayersPositions [
		
	| game |
		
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self play:game amountOfTurns:2.
	self assert:(game playersPositions atPosition: 1 ) equals: nico.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testTryToKeepPlayingAfterGameEnded [

	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self finish: game.
	
	self
		should: [ game nextTurn ]
		raise: InvalideRequest 
		withMessageText: 'The game has finished'
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testWinnersName [
	| game |
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: cards.
	self finish: game.
	self assert: game winner equals: juan
]
