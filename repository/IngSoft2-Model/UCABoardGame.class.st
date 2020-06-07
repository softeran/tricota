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
		'winner',
		'lockers',
		'laps',
		'effectRoulette',
		'playersWithPositions'
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
UCABoardGame >> assertTheWinnerIs: aPlayer [
	
	((self currentPositionOf: aPlayer) lapNumber == laps)
	ifTrue:[winner:= aPlayer ].
	
	
	
]

{ #category : #playing }
UCABoardGame >> currentPositionOf: aPlayer [ 

	^playersWithPositions at: aPlayer.

]

{ #category : #assertions }
UCABoardGame >> hasFinished [
	
	^ (playersWithPositions values) detect: [ :position | position lapNumber = laps]  				
		ifFound: [true] 				
		ifNone: [false].
	
	
]

{ #category : #initialization }
UCABoardGame >> initializeDictionaryOfPositions: aGroupOfPlayers [

	|players|
	players := Dictionary new.
	aGroupOfPlayers do: [ :player | players at: player put: (CurrentPosition startingAtZero)].
	^ players
]

{ #category : #'instance initialization' }
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps andEffects: anEffectRoulette [
	dice:= aDice.
	playersWithPositions:= self initializeDictionaryOfPositions: aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	lockers:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	winner := 'No Winner'.
]

{ #category : #position }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lapNumber.
]

{ #category : #position }
UCABoardGame >> lockerNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lockerPosition.
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
UCABoardGame >> move: aPlayer whenIsGoingBackwardsTo: nextPosition [  

	
	| finishLine |
	((self currentPositionOf: aPlayer) lockerPosition > nextPosition)
	ifTrue: [
		finishLine := lockers.
		self
			move: aPlayer
			backwardsTo: nextPosition
			changingLapIfCrossing: finishLine]
]

{ #category : #'move forward' }
UCABoardGame >> move: currentPlayer whenIsGoingForwardTo: nextPosition [ 
	
	| finishLine |
	
	((self currentPositionOf: currentPlayer)lockerPosition < nextPosition)
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
	nextPosition := (self currentPositionOf: aPlayer) lockerPosition - aNumberOflockers.
	self moveBackwards: aPlayer to: nextPosition ifDoesNotCross: finishLine.
	self moveBackwards: aPlayer to: nextPosition ifCrosses: finishLine.

	
]

{ #category : #'move backwards' }
UCABoardGame >> moveBackwards: aPlayer to: nextPosition ifCrosses: finishLine [

	| followingPosotion positionOfCurrentPlayer|
	positionOfCurrentPlayer := (self currentPositionOf: aPlayer).
	(nextPosition < 0 and: positionOfCurrentPlayer lapNumber>0 )
		ifTrue: [ 
			followingPosotion := finishLine + nextPosition.
			positionOfCurrentPlayer moveBackwards: followingPosotion.
			positionOfCurrentPlayer decreaseLap].
	(nextPosition < 0 and: (positionOfCurrentPlayer lapNumber == 0 ))
		ifTrue: [ 
			positionOfCurrentPlayer moveBackwards: 0.
			 ].
]

{ #category : #'move backwards' }
UCABoardGame >> moveBackwards: aPlayer to: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >=0)
		ifTrue: [ aPlayer moveBackwards: nextPosition ]
]

{ #category : #'move forward' }
UCABoardGame >> moveForward: aPlayer to: nextPosition ifCrosses: finishLine [

	(nextPosition >= finishLine)
	
		ifTrue: [ (self currentPositionOf: aPlayer) moveForward: (nextPosition - finishLine).
			(self currentPositionOf: aPlayer) increaseLap ].
]

{ #category : #'move forward' }
UCABoardGame >> moveForward: aPlayer to: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >= finishLine)
		ifFalse: [ (self currentPositionOf: aPlayer) moveForward: nextPosition ]
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	| currentPlayer nextPosition positionWithEffect |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	nextPosition := (playersWithPositions at: currentPlayer) lockerPosition + dice roll.
	positionWithEffect := effectRoulette spin applyEffectTo: nextPosition knowing: playersWithPositions and: currentPlayer inThe: self.
	self move: currentPlayer to: positionWithEffect
]

{ #category : #playing }
UCABoardGame >> players [
	^ playersWithPositions keys
]

{ #category : #position }
UCABoardGame >> playersPositions [
	
	^ PositionTable filledWith: playersWithPositions.
]

{ #category : #playing }
UCABoardGame >> winner [

	self assertTheGameHasFinished.
	^ winner 
]
