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
GameTest >> setUp [

	board := Board withLockers: 6.
	die := Die of: 4 rolling: #(3 4 3).
	juan:= Player named: 'Juan'.
	nico:= Player named: 'Nico'.
		players:= OrderedCollection new.
		players 
				add: juan; 
				add: nico.
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
GameTest >> testFinalPositions [

	|game positions|
		
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	positions:= OrderedCollection new.
	positions add:(CurrentPosition of:'Juan' atLocker:6);
	add:(CurrentPosition of:'Nico' atLocker: 4).
	
	self assert:(game playersPositions =  positions).
	
	
]

{ #category : #tests }
GameTest >> testFirstTurn [

	| game |
		
	game:= UCABoardGame rolling: die on: board with:players.
	game nextTurn.
	
	self assert: juan currentPosition equals: 3.
	
	
]

{ #category : #tests }
GameTest >> testGameHasFinished [

	| game |
		
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	
	self assert: game hasFinished.
	
	
]

{ #category : #tests }
GameTest >> testIncorrectGameInstanciation [

	"|game notADie notABoard|
	
	self
		should: [ game:= UCABoardGame rolling: notADie On: board ]
		raise: InstanceCreationFailed
		withMessageText: 'The dice is incorrect'.
	self
		should: [ game:= UCABoardGame rolling: die On: notABoard  ]
		raise: InstanceCreationFailed
		withMessageText: 'The board is incorrect'.
	self
		should: [ game:= UCABoardGame rolling: notADie  On: notABoard  ]
		raise: InstanceCreationFailed
		withMessageText: 'The dice is incorrect'"
	
	
]

{ #category : #tests }
GameTest >> testPlayerCantGoFurtherThanFinishLine [

	| game |
		
	die := Die of: 4 rolling: #(3 4 4).
	game:= UCABoardGame rolling: die on: board with: players.

	game nextTurn.
	game nextTurn.
	game nextTurn.
	self assert: juan currentPosition equals: 6.
	
	
]

{ #category : #tests }
GameTest >> testResetPositionsWhenRestartingGame [

"| game positions |
	game:= UCABoardGame rolling: die on: board with: players.
	
	game nextTurn.
	game nextTurn.
	game nextTurn.
	
	game startPlaying: players.
	positions:= OrderedCollection new.
	positions add:(CurrentPosition of:'Juan' atLocker:0);
	add:(CurrentPosition of:'Nico' atLocker: 0).
	
	self assert:(game playersPositions =  positions)."
	

	
	
]

{ #category : #tests }
GameTest >> testWinnersName [

	| game |
		
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	
	self assert: game theWinnerIs equals: 'Juan'.
	
	
]
