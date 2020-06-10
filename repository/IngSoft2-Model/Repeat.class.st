Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Repeat >> applyTo: aPlayerTarget within: playersWithPositions knowing: lastEffect and: finishLine [
		
	| actualPosition positionWithEffect |
	actualPosition:= (playersWithPositions at: aPlayerTarget) lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions and: aPlayerTarget knowing: finishLine .
	(playersWithPositions at: aPlayerTarget) moveTo: positionWithEffect knowing: finishLine .
]
