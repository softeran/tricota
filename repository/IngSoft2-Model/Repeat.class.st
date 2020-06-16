Class {
	#name : #Repeat,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Repeat class >> target: aPlayer [

	^self new initializeTarget: aPlayer.
]

{ #category : #playing }
Repeat >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine [
	
	|actualPosition positionWithEffect|
	self assertSomeoneRolledDice: lastEffect .
	actualPosition:= (self currentPositionOfTargetIn: playersWithPositions)lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions the: target and: finishLine .
	(self currentPositionOfTargetIn: playersWithPositions) moveTo: positionWithEffect knowing: finishLine .
]

{ #category : #assertions }
Repeat >> assertSomeoneRolledDice: lastEffect [ 
	(lastEffect = 'No effect yet')
		ifTrue: [ InvalideRequest signal: 'Nobody rolled the dice yet' ]
]

{ #category : #playing }
Repeat >> currentPositionOfTargetIn: playersWithPositions [
	^ playersWithPositions at: target
]

{ #category : #initialization }
Repeat >> initializeTarget: aTarget [
	target:= aTarget.
]

{ #category : #playing }
Repeat >> isPermanent [
	^false.
]
