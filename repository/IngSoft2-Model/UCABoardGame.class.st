Class {
	#name : #UCABoardGame,
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
UCABoardGame class >> assertTheFirstElementIsADice: aDice [
	
	((aDice class = Die) | (aDice class = Dice))
		ifFalse: [ InstanceCreationFailed signal: 'The dice is incorrect' ]
]

{ #category : #'instance creation' }
UCABoardGame class >> assertTheSecondElementIsABoard: aBoard [
	
	(aBoard class = Board)
		ifFalse: [ InstanceCreationFailed signal: 'The board is incorrect' ]
]

{ #category : #'instance creation' }
UCABoardGame class >> rolling: aDice on: aBoard with: aGroupOfPlayers [

	self assertTheFirstElementIsADice: aDice.
	self assertTheSecondElementIsABoard: aBoard.
	
	^self new initializeRolling: aDice on: aBoard with: aGroupOfPlayers.
]

{ #category : #playing }
UCABoardGame >> assertTheGameHasBegan [
	
	(self hasStarted )
		ifFalse: [ InstanceCreationFailed signal: 'The game has not started yet' ]
]

{ #category : #playing }
UCABoardGame >> assertTheGameHasFinished [
	(self hasFinished)
		ifFalse: [ InstanceCreationFailed signal: 'The game has not finished yet' ]
]

{ #category : #asserting }
UCABoardGame >> assertTheWinnerIs: currentPlayer [
	
	(currentPlayer lapNumber == board lapsToWin)
	ifTrue:[winner:= currentPlayer].
	
	
	
]

{ #category : #displaying }
UCABoardGame >> hasFinished [
	
	| totalLaps |
	totalLaps  := board lapsToWin.
	
	^ players haveCompleted: totalLaps.
	
]

{ #category : #playing }
UCABoardGame >> hasStarted [
	^ (players isEmpty) not.
]

{ #category : #'instance initialization' }
UCABoardGame >> initializeRolling: aDice on: aBoard with: aGroupOfPlayers [ 
	dice:= aDice.
	board:= aBoard.
	players:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	winner := 'No Winner'.
]

{ #category : #playing }
UCABoardGame >> move: currentPlayer forwardTo: nextPosition changingLapIfCrossing: finishLine [
	
	self move: currentPlayer to: nextPosition ifDoesNotCross: finishLine.
	self move: currentPlayer to: nextPosition ifCrosses: finishLine.
	self assertTheWinnerIs: currentPlayer.
	

	
]

{ #category : #playing }
UCABoardGame >> move: currentPlayer to: nextPosition [
	| finishLine |
	finishLine := board finishLine.
	self
		move: currentPlayer
		forwardTo: nextPosition
		changingLapIfCrossing: finishLine
]

{ #category : #'as yet unclassified' }
UCABoardGame >> move: currentPlayer to: nextPosition ifCrosses: finishLine [

	(nextPosition >= finishLine)
	
		ifTrue: [ currentPlayer moveForward: (nextPosition - finishLine).
			currentPlayer increaseLap ].
]

{ #category : #'as yet unclassified' }
UCABoardGame >> move: currentPlayer to: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >= finishLine)
		ifFalse: [ currentPlayer moveForward: nextPosition ]
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	
	|currentPlayer nextPosition |
	self assertTheGameHasBegan.
	currentPlayer := players nextPlayer.
	nextPosition := currentPlayer lockerPosition + dice roll.
	self move: currentPlayer to: nextPosition.
	
	
]

{ #category : #playing }
UCABoardGame >> playersPositions [
	
	^ PositionTable filledWith: players asACollection.
]

{ #category : #playing }
UCABoardGame >> theWinnerIs [

	self assertTheGameHasFinished.
	^ winner 
]
