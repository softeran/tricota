Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'nico',
		'players',
		'board',
		'die'
	],
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #running }
GameTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #running }
GameTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #playing }
GameTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #running }
GameTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
GameTest >> setUp [
	board := Board withLockers: 6 andLaps: 2.
	die := Die of: 4 rolling: #(3 4 3 1 4 1 4).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico
]

{ #category : #tests }
GameTest >> testAskForWinnerBeforeFinishing [

	| game |
		
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	game nextTurn.

	self
		should: [ game theWinnerIs   ]
		raise: InstanceCreationFailed
		withMessageText: 'The game has not finished yet'
]

{ #category : #tests }
GameTest >> testGameHasFinished [
	| game |
	game := UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:8.
	self assert: game hasFinished
]

{ #category : #tests }
GameTest >> testLapNumberOfPlayer [

	| game |
	game:= UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:3.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0.
	
	
]

{ #category : #tests }
GameTest >> testLockerNumberOfPlayer [

	| game |
		
	game:= UCABoardGame rolling: die on: board with:players.
	game nextTurn.
	
	self assert: juan lockerPosition equals: 3.
	
	
]

{ #category : #tests }
GameTest >> testPlayerFinishedOneLap [

	| game |
		
	die := Die of: 4 rolling: #(3 4 4).
	game:= UCABoardGame rolling: die on: board with: players.

	game nextTurn.
	game nextTurn.
	game nextTurn.
	self assert: juan lapNumber equals: 1.
	
	
]

{ #category : #tests }
GameTest >> testPlayersPositions [

	|game|
		
	game:= UCABoardGame rolling: die on: board with: players.
	self play:game amountOfTurns:2.
	self assert:((game playersPositions atPosition: 1 ) = nico).
	
	
]

{ #category : #tests }
GameTest >> testWinnersName [

	| game |
		
	game:= UCABoardGame rolling: die on: board with: players.
	self play: game amountOfTurns:8.
	
	self assert: game theWinnerIs equals: juan.
	
	
]
