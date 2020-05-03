Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> testAskForWinnerBeforeFinishing [

	| board game die players player1 player2 |
		
	board := Board initializeWithLockers: 6.
	die := Die of: 4 rolling: #(3 4 3).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	game nextTurn.

	self
		should: [ game theWinnerIs   ]
		raise: InstanceCreationFailed
		withMessageText: 'The game has not finished yet'
]

{ #category : #tests }
GameTest >> testFinalPositions [

	| board game die players player1 player2 positions |
		
	board := Board initializeWithLockers: 6.
	die := Die of: 4 rolling: #(3 4 3).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	positions:= OrderedCollection new.
	positions add:(CurrentPosition initializeOf:'Juan' atLocker:6);
	add:(CurrentPosition initializeOf:'Nico' atLocker: 4).
	
	
	self assert:(game playersPositions =  positions).
	
	
]

{ #category : #tests }
GameTest >> testFirstTurn [

	| board game die players player1 player2|
		
	board := Board initializeWithLockers: 10.
	die := Die of: 4 rolling: #(3 4 1).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	
	self assert: player1 currentPosition equals: 3.
	
	
]

{ #category : #tests }
GameTest >> testGameNotStarted [

	| board game die |
	board := Board initializeWithLockers: 10.
	die := Die of: 4.
	game:= Game initializeRolling: die On: board.

	self assert: (game hasStarted) equals: false.

	
	
]

{ #category : #tests }
GameTest >> testGameStarted [

	| board game die players player1 player2 |
		
	board := Board initializeWithLockers: 10.
	die := Die of: 4.
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players. 
	
	self assert: (game hasStarted) equals: true.
	
	
]

{ #category : #tests }
GameTest >> testIncorrectGameInstanciation [

	| board game die notADie notABoard|
	
	board := Board initializeWithLockers: 10.
	die := Die of: 4.

	self
		should: [ game:= Game initializeRolling: notADie On: board ]
		raise: InstanceCreationFailed
		withMessageText: 'The dice is incorrect'.
	self
		should: [ game:= Game initializeRolling: die On: notABoard  ]
		raise: InstanceCreationFailed
		withMessageText: 'The board is incorrect'.
	self
		should: [ game:= Game initializeRolling: notADie  On: notABoard  ]
		raise: InstanceCreationFailed
		withMessageText: 'The dice is incorrect'
	
	
]

{ #category : #tests }
GameTest >> testInvalidTurn [

	| board game die|
		
	board := Board initializeWithLockers: 10.
	die := Die of: 4 rolling: #(3 4 1).
	game:= Game initializeRolling: die On: board.
	 
	self
		should: [ game nextTurn  ]
		raise: InstanceCreationFailed
		withMessageText: 'The game has not started yet'
]

{ #category : #tests }
GameTest >> testPlayerCantGoFurtherThanFinishLine [

	| board game die players player1 player2 |
		
	board := Board initializeWithLockers: 11.
	die := Die of: 10 rolling: #(3 4 9).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.

	self assert: player1 currentPosition equals: 11.
	
	
]

{ #category : #tests }
GameTest >> testPlayerWon [

	| board game die players player1 player2 |
		
	board := Board initializeWithLockers: 6.
	die := Die of: 4 rolling: #(3 4 3).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	
	self assert: game hasFinished.
	
	
]

{ #category : #tests }
GameTest >> testResetPositions [

	| board game die players player1 player2 positions result |
		
	board := Board initializeWithLockers: 6.
	die := Die of: 4 rolling: #(3 4 3).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	
	game startPlaying: players.
	positions:= OrderedCollection new.
	positions add:(CurrentPosition initializeOf:'Juan' atLocker:0);
	add:(CurrentPosition initializeOf:'Nico' atLocker: 0).
	result:= game playersPositions.
	
	
	self assert:(result =  positions).
	

	
	
]

{ #category : #tests }
GameTest >> testWinnersName [

	| board game die players player1 player2 |
		
	board := Board initializeWithLockers: 6.
	die := Die of: 4 rolling: #(3 4 3).
	game:= Game initializeRolling: die On: board.
	player1:= Player initializeWithName: 'Juan'.
	player2:= Player initializeWithName: 'Nico'.
	players:= OrderedCollection new.
	players add: player1; 
				add: player2.
	game startPlaying: players.
	game nextTurn.
	game nextTurn.
	game nextTurn.
	
	self assert: game theWinnerIs equals: 'Juan'.
	
	
]
