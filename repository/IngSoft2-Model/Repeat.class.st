Class {
	#name : #Repeat,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Repeat class >> target: aPlayer [

	^self new initializeTarget: aPlayer.
]

{ #category : #playing }
Repeat >> applyTo: aPlayerTarget within: playersWithPositions knowing: lastEffect and: finishLine [
		
	| actualPosition positionWithEffect |
	actualPosition:= (playersWithPositions at: aPlayerTarget) lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions and: aPlayerTarget knowing: finishLine .
	(playersWithPositions at: aPlayerTarget) moveTo: positionWithEffect knowing: finishLine .
]

{ #category : #playing }
Repeat >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine [
		
	| actualPosition positionWithEffect |
	actualPosition:= (playersWithPositions at: target )lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions and: target knowing: finishLine .
	(playersWithPositions at: target) moveTo: positionWithEffect knowing: finishLine .
]

{ #category : #playing }
Repeat >> isPermanent [
	^false.
]

{ #category : #playing }
Repeat >> redoCard [
	self shouldBeImplemented.
]

{ #category : #playing }
Repeat >> redoCardTo: aPlayer [ 
	^self class target: aPlayer.
]
