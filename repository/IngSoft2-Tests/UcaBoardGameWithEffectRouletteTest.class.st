Class {
	#name : #UcaBoardGameWithEffectRouletteTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players'
	],
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> aBoardWith100ProbabilityOf: effect [

	| effects effectRoulette board|
	effects:=Dictionary  new.
	effects at: effect put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	^board.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> setUp [

	
	die := Die of: 10 rolling: #(7 4 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testAtomicBomb [

	| game board |
	
	board := self aBoardWith100ProbabilityOf: AtomicBomb new.
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	
	self assert: juan lockerPosition equals: 0.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testMoonWalk [

	| game board |
	
	board := self aBoardWith100ProbabilityOf: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	
	self assert: nico lapNumber equals: -1;
		assert: nico lockerPosition equals: 58.
		
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testSpeedUp [

	| game board |
	
	board := self aBoardWith100ProbabilityOf: SpeedUp new.
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	
	self assert: juan lockerPosition equals: 11.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHole [

	| game board |
	
	board := self aBoardWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	
	self assert: juan lockerPosition equals: 3.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHoleDecreasingLap [

	| game board |
	
	die := Die of: 10 rolling: #(2).
	board := self aBoardWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	
	self assert: juan lapNumber equals: -1;
		assert: juan lockerPosition equals: 58.
	
]
