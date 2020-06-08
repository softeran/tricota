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
		'playersWithPositions',
		'lastEffect'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
UCABoardGame class >> rolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps andEffects: anEffectRoulette [.

	^self new initializeRolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps andEffects: anEffectRoulette.
]

{ #category : #playing }
UCABoardGame >> assertSomeoneRolledDice [
	(lastEffect = 'No effect yet')
		ifTrue: [ InvalideRequest signal: 'Nobody rolled the dice yet' ]
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
	lastEffect := 'No effect yet'.
]

{ #category : #position }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lapNumber.
]

{ #category : #position }
UCABoardGame >> lockerNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lockerPosition.
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	| currentPlayer nextPosition positionWithEffect |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	nextPosition := (playersWithPositions at: currentPlayer) lockerPosition + dice roll.
	lastEffect := effectRoulette spin.
	positionWithEffect := lastEffect applyEffectTo: nextPosition knowing: playersWithPositions and: currentPlayer knowing: lockers.
	(playersWithPositions at: currentPlayer) moveTo: positionWithEffect knowing: lockers.
	self assertTheWinnerIs: currentPlayer.
]

{ #category : #playing }
UCABoardGame >> player: aPlayer throw: cardEffect to: playerTarget [ 
	
	self assertSomeoneRolledDice.
	aPlayer apply: cardEffect to: (playersWithPositions at: playerTarget) knowing: lastEffect
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
