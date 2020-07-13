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
		'laps',
		'effectRoulette',
		'playersWithPositions',
		'lastEffect',
		'finishLine',
		'activeCards',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
UCABoardGame class >> rolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette and: cards [

	^self new initializeRolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette and: cards.
]

{ #category : #'as yet unclassified' }
UCABoardGame class >> rolling: aDie with: players lockers: numberOfLockers laps: numberOfLaps effects: anEffectRoulette andDeterministic: sequenceOfCards [ 
	^self new initializeRolling: aDie with: players lockers: numberOfLockers  laps: numberOfLaps  effects: anEffectRoulette andDeterministic: sequenceOfCards.
]

{ #category : #playing }
UCABoardGame >> amountOfLockersThatActiveCardsMove: currentPlayer [
|amountOfLockers|
	amountOfLockers:=0.
	(activeCards isEmpty)
	ifFalse:[amountOfLockers:= (activeCards sum:[ :card | card effect: currentPlayer ])].
	^amountOfLockers.
]

{ #category : #playing }
UCABoardGame >> applyEffectTo: positionAfterRollingDice of: currentPlayer [

	lastEffect := effectRoulette spin.
	
	^lastEffect applyEffectTo: positionAfterRollingDice	knowing: playersWithPositions the: currentPlayer and: finishLine.
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

{ #category : #position }
UCABoardGame >> currentPositionOf: aPlayer [ 

	^playersWithPositions at: aPlayer.

]

{ #category : #cards }
UCABoardGame >> deal: deck [
	self dealTwoCardsToEachPlayerFrom: deck.
]

{ #category : #cards }
UCABoardGame >> dealTwoCardsInOrderToEachPlayerIn: aGroupOfPlayers from: cards [
	| index sizeOfCards |
	index := 1.
	sizeOfCards := cards size.
	aGroupOfPlayers
		do: [ :player | 
			player addCard: (cards at: index).
			index := self following: index lowerThan: sizeOfCards.
			player addCard: (cards at: index).
			index := self following: index lowerThan: sizeOfCards ]
]

{ #category : #cards }
UCABoardGame >> dealTwoCardsToEachPlayerFrom: cards [
	| random index |
	random := Random new.
	playersWithPositions
		keysDo: [ :player | 
			index := random nextInt: cards size.
			player addCard: (cards at: index).
			index := random nextInt: cards size.
			player addCard: (cards at: index) ]
]

{ #category : #cards }
UCABoardGame >> deterministicDeal: deck and: aGroupOfPlayers [
	self dealTwoCardsInOrderToEachPlayerIn: aGroupOfPlayers from: deck.
]

{ #category : #playing }
UCABoardGame >> following: index lowerThan: sizeOfCards [.

	(index = sizeOfCards ) ifTrue:[^1] ifFalse:[^(index +1)].

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

{ #category : #initialization }
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: anEffectRoulette and: cards [
	dice:= aDice.
	playersWithPositions:= self initializeDictionaryOfPositions: aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	finishLine:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	activeCards := OrderedCollection new.
	winner := 'No Winner'.
	lastEffect := 'No effect yet'.
	lastCardPlayed:= 'No card has been played yet'.
	self deal: cards.
]

{ #category : #initialization }
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers  laps: aNumberOfLaps  effects: anEffectRoulette andDeterministic: sequenceOfCards [
	
	dice:= aDice.
	playersWithPositions:= self initializeDictionaryOfPositions: aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	finishLine:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	activeCards := OrderedCollection new.
	winner := 'No Winner'.
	lastEffect := 'No effect yet'.
	self deterministicDeal: sequenceOfCards and: aGroupOfPlayers.
]

{ #category : #position }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lapNumber.
]

{ #category : #cards }
UCABoardGame >> lastCardPlayed [
	^ lastCardPlayed
]

{ #category : #cards }
UCABoardGame >> lastCardPlayed: aCard [
	lastCardPlayed := aCard
]

{ #category : #position }
UCABoardGame >> lockerNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lockerPosition.
]

{ #category : #playing }
UCABoardGame >> nextTurn [

	| currentPlayer positionAfterRollingDice positionAfterCards positionAfterEffectAndCards currentPlayerPosition |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	currentPlayerPosition:= playersWithPositions at: currentPlayer.
	positionAfterRollingDice := (self currentPositionOf: currentPlayer)lockerPosition + dice roll.
	positionAfterCards := (self amountOfLockersThatActiveCardsMove: currentPlayer)+ positionAfterRollingDice .
	positionAfterEffectAndCards := self applyEffectTo: positionAfterCards of: currentPlayer.
	currentPlayerPosition moveTo: positionAfterEffectAndCards knowing: finishLine.
	self assertTheWinnerIs: currentPlayer
]

{ #category : #playing }
UCABoardGame >> player: aPlayer throw: card [

	self assertTheGameHasNotFinished.
	aPlayer assertHasCard: card.
	card applyWithin: playersWithPositions knowing: activeCards the: lastEffect and: finishLine of: self.
	aPlayer cardPlayed: card.
]

{ #category : #playing }
UCABoardGame >> players [
	^ playersWithPositions keys
]

{ #category : #position }
UCABoardGame >> playersPositions [
	
	^ PositionTable filledWith: playersWithPositions.
]

{ #category : #cards }
UCABoardGame >> savePermanentCard: aCard [

	activeCards add: aCard
]

{ #category : #playing }
UCABoardGame >> winner [

	self assertTheGameHasFinished.
	^ winner 
]
