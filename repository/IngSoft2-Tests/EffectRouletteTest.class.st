Class {
	#name : #EffectRouletteTest,
	#superclass : #TestCase,
	#instVars : [
		'board',
		'die',
		'juan',
		'nico',
		'players'
	],
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #accessing }
EffectRouletteTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
EffectRouletteTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #accessing }
EffectRouletteTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
EffectRouletteTest >> setUp [

	
	die := Die of: 10 rolling: #(7 4 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
EffectRouletteTest >> testAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA [

	| effects atomicBomb effectRoulette speedUp wormHole moonWalk noEffect |
	
	atomicBomb := AtomicBomb new.
	speedUp := SpeedUp new.
	wormHole := WormHole new.
	moonWalk := MoonWalk maxBackwards: 5.
	noEffect := NoEffect new.
	effects:=Dictionary  new.
	effects at: atomicBomb put: 2.
	effects at: speedUp put: 20.
	effects at: wormHole put: 20.
	effects at: moonWalk put: 10.
	effects at: noEffect put: 48.
	effectRoulette := EffectRoulette with: effects.

	self assert: effectRoulette spin equals: atomicBomb.
	
]

{ #category : #tests }
EffectRouletteTest >> testAtomicBomb [

	| effects game atomicBomb effectRoulette |
	
	atomicBomb := AtomicBomb new.
	effects:=Dictionary  new.
	effects at: atomicBomb put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lockerPosition equals: 0.
	
]

{ #category : #tests }
EffectRouletteTest >> testMoonWalk [

	| effects game moonWalk  effectRoulette |
	
	moonWalk := MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2).
	effects:=Dictionary  new.
	effects at: moonWalk put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: nico lapNumber equals: -1;
		assert: nico lockerPosition equals: 58.
		
	
]

{ #category : #tests }
EffectRouletteTest >> testSpeedUp [

	| effects game speedUp effectRoulette |
	
	speedUp := SpeedUp new.
	effects:=Dictionary  new.
	effects at: speedUp put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lockerPosition equals: 11.
	
]

{ #category : #tests }
EffectRouletteTest >> testWormHole [

	| effects game wormHole effectRoulette |
	
	wormHole := WormHole new.
	effects:=Dictionary  new.
	effects at: wormHole put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lockerPosition equals: 3.
	
]

{ #category : #tests }
EffectRouletteTest >> testWormHoleDecreasingLap [

	| effects game wormHole effectRoulette |
	
	die := Die of: 10 rolling: #(2).
	wormHole := WormHole new.
	effects:=Dictionary  new.
	effects at: wormHole put: 100.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lapNumber equals: -1;
		assert: juan lockerPosition equals: 58.
	
]
