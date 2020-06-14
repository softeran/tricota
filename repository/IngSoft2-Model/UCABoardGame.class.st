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
		'activeCards'
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

{ #category : #playing }
UCABoardGame >> deal: cards [ 
|random index|
	random:= Random new.
	playersWithPositions keysDo: [ :player | 
		index:= random nextInt: cards size.
		player addCard: (cards at: index).
	index:= random nextInt: cards size.
		player addCard: (cards at: index)]

]

{ #category : #playing }
UCABoardGame >> deterministicDeal: cards [ 
| aaa sizeOfCards|
	aaa:=1.
	sizeOfCards:= cards size.
		playersWithPositions keysDo: [ :player | 
		player addCard: (cards at: aaa).
		"(aaa = sizeOfCards ) ifTrue:[aaa:=1] ifFalse:[aaa:= aaa+1]".
		aaa:= self following: aaa lowerThan: sizeOfCards.
		player addCard: (cards at: aaa).
		"(aaa = sizeOfCards ) ifTrue:[aaa:=1] ifFalse:[aaa:= aaa+1]"
		aaa:= self following: aaa lowerThan: sizeOfCards]
	


]

{ #category : #playing }
UCABoardGame >> deterministicDeal: cards and: aGroupOfPlayers [ 
| aaa sizeOfCards|
	aaa:=1.
	sizeOfCards:= cards size.
		aGroupOfPlayers  do: [ :player | 
		player addCard: (cards at: aaa).
		aaa:= self following: aaa lowerThan: sizeOfCards.
		player addCard: (cards at: aaa).
		aaa:= self following: aaa lowerThan: sizeOfCards.]
	


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

{ #category : #'instance initialization' }
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

{ #category : #position }
UCABoardGame >> lockerNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lockerPosition.
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	| currentPlayer nextPosition positionWithEffect positionWithEffectAndCards |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	nextPosition := (playersWithPositions at: currentPlayer) lockerPosition + dice roll.
	lastEffect := effectRoulette spin.
	positionWithEffect := lastEffect applyEffectTo: nextPosition knowing: playersWithPositions and: currentPlayer knowing: finishLine.
	positionWithEffectAndCards:=0.
	(activeCards size > 0 )
	ifTrue:[positionWithEffectAndCards:= (activeCards sum:[ :card | card effect: currentPlayer ])].
	
	(playersWithPositions at: currentPlayer) moveTo: (positionWithEffectAndCards + positionWithEffect) knowing: finishLine.
	self assertTheWinnerIs: currentPlayer.
]

{ #category : #playing }
UCABoardGame >> player: aPlayer throw: cardEffect [ 
 	
	aPlayer assertIHaveCard: cardEffect.
	self savePermanentCard: cardEffect.
	aPlayer cardPlayed: cardEffect.
	
	
]

{ #category : #playing }
UCABoardGame >> player: aPlayer throw: cardEffect to: playerTarget [ 
	
	self assertSomeoneRolledDice.
	aPlayer apply: cardEffect to: playerTarget within: playersWithPositions  knowing: lastEffect and: finishLine.
	
	self savePermanentCard: cardEffect.
	self assertTheWinnerIs: playerTarget .

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
UCABoardGame >> savePermanentCard: aCard [

	aCard isPermanent ifTrue: [ activeCards add: aCard ].
]

{ #category : #playing }
UCABoardGame >> winner [

	self assertTheGameHasFinished.
	^ winner 
]
