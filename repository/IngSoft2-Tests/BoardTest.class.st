Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'noEffect',
		'effects',
		'effectRoulette'
	],
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #running }
BoardTest >> setUp [
	
	noEffect := NoEffect new.
	effects:=Dictionary  new.
	effects at: noEffect put: 100.
	effectRoulette := EffectRoulette with: effects.

]

{ #category : #tests }
BoardTest >> testIncorrectBoardInicialization [
	
	-1 to: 1 do: [ :number | 
		self
			should: [ Board withLockers: number andLaps: 2 withEffects: effectRoulette]
			raise: InstanceCreationFailed
			withMessageText: 'Board must have at least two lockers' ].
		
		-1 to: 0 do: [ :number | 
		self
			should: [ Board withLockers: 60 andLaps: number withEffects: effectRoulette]
			raise: InstanceCreationFailed
			withMessageText: 'Board must have at least one lap' ].
]

{ #category : #tests }
BoardTest >> testInitializeBoardWithLockers [

	| board |
	board:= Board withLockers: 60 andLaps: 2 withEffects: effectRoulette.
	self assert: board finishLine equals:60.
	
]
