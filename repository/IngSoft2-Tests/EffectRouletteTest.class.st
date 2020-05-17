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
EffectRouletteTest >> testAtomicBomb [

	| effects game atomicBomb effectRoulette |
	
	atomicBomb := AtomicBomb new.
	effects:=OrderedCollection new.
	effects add: atomicBomb .
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
	effects:=OrderedCollection new.
	effects add: moonWalk  .
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
	effects:=OrderedCollection new.
	effects add: speedUp .
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
	effects:=OrderedCollection new.
	effects add: wormHole.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lockerPosition equals: 3.
	
]

{ #category : #tests }
EffectRouletteTest >> testWormHoleAAAAAAAAAAAAAAAAAAAAAAAAa [

	| effects game wormHole effectRoulette |
	
	die := Die of: 10 rolling: #(2).
	wormHole := WormHole new.
	effects:=OrderedCollection new.
	effects add: wormHole.
	effectRoulette := EffectRoulette with: effects.
	board := Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lapNumber equals: -1;
		assert: juan lockerPosition equals: 58.
	
]
