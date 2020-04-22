Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'players',
		'winner'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
Game class >> assertTheFirstElementIsADice: aDice [
	
	((aDice class = Die) | (aDice class = Dice))
		ifFalse: [ InstanceCreationFailed signal: 'The dice is incorrect' ]
]

{ #category : #'instance creation' }
Game class >> assertTheSecondElementIsABoard: aBoard [
	
	(aBoard class = Board)
		ifFalse: [ InstanceCreationFailed signal: 'The board is incorrect' ]
]

{ #category : #'instance creation' }
Game class >> setElements: aDice and: aBoard [  

	self assertTheFirstElementIsADice: aDice.
	self assertTheSecondElementIsABoard: aBoard.
	
	^self new setElements: aDice and: aBoard.
]

{ #category : #playing }
Game >> assertTheGameHasBegan [
	
	(self hasStarted )
		ifFalse: [ InstanceCreationFailed signal: 'The game has not started yet' ]
]

{ #category : #playing }
Game >> assertTheGameHasFinished [
	(self hasFinished)
		ifFalse: [ InstanceCreationFailed signal: 'The game has not finished yet' ]
]

{ #category : #displaying }
Game >> hasFinished [
	
	| finishLine return |
	finishLine := board finishLine.
	^ players haveReached: finishLine
	
]

{ #category : #playing }
Game >> hasStarted [
	^ (players isEmpty) not.
]

{ #category : #playing }
Game >> move: currentPlayer to: nextPosition [
	
	|finishLine |
	finishLine := board finishLine .
	(nextPosition >= finishLine) 
		ifTrue: [currentPlayer moveForward: (finishLine).
					winner := currentPlayer sayYourName ]
		ifFalse: [currentPlayer moveForward: (nextPosition)].
	 
	
]

{ #category : #playing }
Game >> nextTurn [
	
	|currentPlayer nextPosition |
	self assertTheGameHasBegan.
	currentPlayer := players nextPlayer.
	nextPosition := currentPlayer currentPosition + dice roll.
	self move: currentPlayer to: nextPosition.
	
	
]

{ #category : #playing }
Game >> playersPositions [
	^ players playersPositions
]

{ #category : #'instance initialization' }
Game >> setElements: aDice and: aBoard [ 
	dice:= aDice.
	board:= aBoard.
	players:= #().
]

{ #category : #playing }
Game >> startPlaying: aSequenceOfPlayers [
	players:= (SequentialPlayersProvider providing: aSequenceOfPlayers).
	players resetPosition.
	winner := 'No Winner'.
]

{ #category : #playing }
Game >> theWinnerIs [

	self assertTheGameHasFinished.
	^ winner 
]
