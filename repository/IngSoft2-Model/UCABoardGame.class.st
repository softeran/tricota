"
I'm Uca Board Game!
I am given a die or dice, a board and a collection of players when created.

"
Class {
	#name : #UCABoardGame,
	#superclass : #Object,
	#instVars : [
		'dice',
		'sequenceOfPlayers',
		'players',
		'winner',
		'lockers',
		'laps',
		'effectRoulette'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
UCABoardGame class >> rolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps andEffects: anEffectRoulette [.

	^self new initializeRolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps andEffects: anEffectRoulette.
]

{ #category : #assertions }
UCABoardGame >> assertTheGameHasFinished [
	(self hasFinished)
		ifFalse: [ InvalideRequest signal: 'The game has not finished yet' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheGameHasNotFinished [
	(self hasFinished)
		ifTrue: [ InvalideRequest signal: 'The game has finished' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheWinnerIs: currentPlayer [
	
	(currentPlayer lapNumber == laps)
	ifTrue:[winner:= currentPlayer].
	
	
	
]

{ #category : #assertions }
UCABoardGame >> hasFinished [
	
	^ players detect: [ :player | player lapNumber = laps]  				
					ifFound: [true] 				
					ifNone: [false].
	
	
]

{ #category : #'instance initialization' }
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps andEffects: anEffectRoulette [
	dice:= aDice.
	players:= aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	lockers:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	winner := 'No Winner'.
]

{ #category : #position }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ aPlayer lapNumber.
]

{ #category : #'move backwards' }
UCABoardGame >> move: currentPlayer backwardsTo: nextPosition changingLapIfCrossing: finishLine [ 
		
	self moveBackwards: currentPlayer to: nextPosition ifDoesNotCross: finishLine.
	self moveBackwards: currentPlayer to: nextPosition ifCrosses: finishLine.

]

{ #category : #'move forward' }
UCABoardGame >> move: currentPlayer forwardTo: nextPosition changingLapIfCrossing: finishLine [
	
	self moveForward: currentPlayer to: nextPosition ifDoesNotCross: finishLine.
	self moveForward: currentPlayer to: nextPosition ifCrosses: finishLine.
	self assertTheWinnerIs: currentPlayer.
	

	
]

{ #category : #playing }
UCABoardGame >> move: currentPlayer to: nextPosition [

	self move: currentPlayer whenIsGoingForwardTo: nextPosition.
	self move: currentPlayer whenIsGoingBackwardsTo: nextPosition.

]

{ #category : #'move backwards' }
UCABoardGame >> move: aCurrentPlayer whenIsGoingBackwardsTo: nextPosition [  

	
	| finishLine |
	(aCurrentPlayer lockerPosition > nextPosition)
	ifTrue: [
		finishLine := lockers.
		self
			move: aCurrentPlayer
			backwardsTo: nextPosition
			changingLapIfCrossing: finishLine]
]

{ #category : #'move forward' }
UCABoardGame >> move: currentPlayer whenIsGoingForwardTo: nextPosition [ 
	
	| finishLine |
	
	(currentPlayer lockerPosition < nextPosition)
	ifTrue: [
		finishLine := lockers.
		self
			move: currentPlayer
			forwardTo: nextPosition
			changingLapIfCrossing: finishLine]
]

{ #category : #'move forward' }
UCABoardGame >> moveBackwards: aPlayer amountOf: aNumberOflockers [ 
	
	
	| finishLine nextPosition |
	finishLine := lockers.
	nextPosition := aPlayer lockerPosition - aNumberOflockers.
	self moveBackwards: aPlayer to: nextPosition ifDoesNotCross: finishLine.
	self moveBackwards: aPlayer to: nextPosition ifCrosses: finishLine.

	
]

{ #category : #'move backwards' }
UCABoardGame >> moveBackwards: aPlayer to: nextPosition ifCrosses: finishLine [

	| followingPosotion |
	(nextPosition < 0 and: aPlayer lapNumber>0 )
		ifTrue: [ 
			followingPosotion := finishLine + nextPosition.
			aPlayer moveBackwards: followingPosotion.
			aPlayer decreaseLap].
	(nextPosition < 0 and: (aPlayer lapNumber == 0 ))
		ifTrue: [ 
			aPlayer moveBackwards: 0.
			 ].
]

{ #category : #'move backwards' }
UCABoardGame >> moveBackwards: aPlayer to: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >=0)
		ifTrue: [ aPlayer moveBackwards: nextPosition ]
]

{ #category : #'move forward' }
UCABoardGame >> moveForward: currentPlayer to: nextPosition ifCrosses: finishLine [

	(nextPosition >= finishLine)
	
		ifTrue: [ currentPlayer moveForward: (nextPosition - finishLine).
			currentPlayer increaseLap ].
]

{ #category : #'move forward' }
UCABoardGame >> moveForward: currentPlayer to: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >= finishLine)
		ifFalse: [ currentPlayer moveForward: nextPosition ]
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	
	|currentPlayer nextPosition positionWithEffect |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	nextPosition := currentPlayer lockerPosition + dice roll.
	positionWithEffect := effectRoulette spin applyEffectTo: nextPosition knowing: players and: currentPlayer inThe: self. 

	self move: currentPlayer to: positionWithEffect.

	
	
]

{ #category : #position }
UCABoardGame >> playersPositions [
	
	^ PositionTable filledWith: players.
]

{ #category : #playing }
UCABoardGame >> winner [

	self assertTheGameHasFinished.
	^ winner 
]
