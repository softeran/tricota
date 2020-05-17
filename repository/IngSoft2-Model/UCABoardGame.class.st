Class {
	#name : #UCABoardGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'winner',
		'sequenceOfPlayers',
		'players'
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
	^ players detect: [ :player | player lapNumber = totalLaps]  				
					ifFound: [true] 				
					ifNone: [false].
	
	
]

{ #category : #playing }
UCABoardGame >> hasStarted [
	^ (sequenceOfPlayers isEmpty) not.
]

{ #category : #'instance initialization' }
UCABoardGame >> initializeRolling: aDice on: aBoard with: aGroupOfPlayers [ 
	dice:= aDice.
	board:= aBoard.
	players:= aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	winner := 'No Winner'.
]

{ #category : #lap }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ aPlayer lapNumber.
]

{ #category : #playing }
UCABoardGame >> move: currentPlayer backwardsTo: nextPosition changingLapIfCrossing: finishLine [ 
		
	self moveBackwards: currentPlayer to: nextPosition ifDoesNotCross: finishLine.
	self moveBackwards: currentPlayer to: nextPosition ifCrosses: finishLine.

]

{ #category : #playing }
UCABoardGame >> move: currentPlayer forwardTo: nextPosition changingLapIfCrossing: finishLine [
	
	self move: currentPlayer to: nextPosition ifDoesNotCross: finishLine.
	self move: currentPlayer to: nextPosition ifCrosses: finishLine.
	self assertTheWinnerIs: currentPlayer.
	

	
]

{ #category : #playing }
UCABoardGame >> move: currentPlayer to: nextPosition [

	self move: currentPlayer whenIsGoingForwardTo: nextPosition.
	self move: currentPlayer whenIsGoingBackwardsTo: nextPosition.

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
UCABoardGame >> move: aCurrentPlayer whenIsGoingBackwardsTo: nextPosition [  

	
	| finishLine |
	(aCurrentPlayer lockerPosition > nextPosition)
	ifTrue: [
		finishLine := board finishLine.
		self
			move: aCurrentPlayer
			backwardsTo: nextPosition
			changingLapIfCrossing: finishLine]
]

{ #category : #playing }
UCABoardGame >> move: currentPlayer whenIsGoingForwardTo: nextPosition [ 
	
	| finishLine |
	
	(currentPlayer lockerPosition < nextPosition)
	ifTrue: [
		finishLine := board finishLine.
		self
			move: currentPlayer
			forwardTo: nextPosition
			changingLapIfCrossing: finishLine]
]

{ #category : #playing }
UCABoardGame >> moveBackwards: aPlayer amountOf: lockers [ 
	
	
	| finishLine nextPosition |
	finishLine := board finishLine .
	nextPosition := aPlayer lockerPosition - lockers.
	self moveBackwards: aPlayer to: nextPosition ifDoesNotCross: finishLine.
	self moveBackwards: aPlayer to: nextPosition ifCrosses: finishLine.

	
]

{ #category : #playing }
UCABoardGame >> moveBackwards: aPlayer to: nextPosition ifCrosses: finishLine [

	| followingPosotion |
	(nextPosition < 0)
		ifTrue: [ 
			followingPosotion := finishLine + nextPosition.
			aPlayer moveBackwards: followingPosotion.
			aPlayer decreaseLap].
]

{ #category : #playing }
UCABoardGame >> moveBackwards: aPlayer to: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >=0)
		ifTrue: [ aPlayer moveBackwards: nextPosition ]
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	
	|currentPlayer nextPosition positionWithEffect |
	self assertTheGameHasBegan.
	currentPlayer := sequenceOfPlayers nextPlayer.
	nextPosition := currentPlayer lockerPosition + dice roll.
	positionWithEffect := board applyEffectTo: nextPosition knowing: players and: currentPlayer inThe: self.

	self move: currentPlayer to: positionWithEffect.

	
	
]

{ #category : #playing }
UCABoardGame >> playersPositions [
	
	^ PositionTable filledWith: players.
]

{ #category : #playing }
UCABoardGame >> theWinnerIs [

	self assertTheGameHasFinished.
	^ winner 
]
