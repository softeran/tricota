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
Repeat >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine [
		
	| actualPosition positionWithEffect |
	actualPosition:= (playersWithPositions at: target )lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions and: target knowing: finishLine .
	(playersWithPositions at: target) moveTo: positionWithEffect knowing: finishLine .
]

{ #category : #initialization }
Repeat >> initializeTarget: aTarget [
	target:= aTarget.
]

{ #category : #playing }
Repeat >> isPermanent [
	^false.
]
