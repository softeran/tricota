Class {
	#name : #UcaBoardGameNoEffectsTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'nico',
		'players',
		'board',
		'die',
		'effectRoulette',
		'effects',
		'noEffect'
	],
	#category : #'IngSoft2-Tests-Game-Tests'
}

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

	noEffect := NoEffect new.
	effects:=Dictionary  new.
	effects at: noEffect put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 6 andLaps: 2 withEffects: effectRoulette.
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
		
	game:= UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:2.

	self
		should: [ game theWinnerIs   ]
		raise: InstanceCreationFailed
		withMessageText: 'The game has not finished yet'
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testGameHasFinished [
	| game |
	game := UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:7.
	self assert: game hasFinished
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLapNumberOfPlayer [

	| game |
	game:= UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:3.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testLockerNumberOfPlayer [

	| game |
		
	game:= UCABoardGame rolling: die on: board with:players.
	game nextTurn.
	
	self assert: juan lockerPosition equals: 3.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testPlayerFinishedOneLap [

	| game |
		
	die := Die of: 4 rolling: #(3 4 4).
	game:= UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:3.
	
	self assert: juan lapNumber equals: 1.
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testPlayersPositions [

	|game|
		
	game:= UCABoardGame rolling: die on: board with: players.
	self play:game amountOfTurns:2.
	self assert:((game playersPositions atPosition: 1 ) = nico).
	
	
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testTryToKeepPlayingAfterGameEnded [

	| game |
	game := UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:7.
	
	self
		should: [ game nextTurn ]
		raise: InstanceCreationFailed
		withMessageText: 'The game has finished'
]

{ #category : #tests }
UcaBoardGameNoEffectsTest >> testWinnersName [

	| game |
		
	game:= UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:7.
	
	self assert: game theWinnerIs equals: juan.
	
	
]
