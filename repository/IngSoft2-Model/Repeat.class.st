Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Repeat >> applyTo: playerTargetPosition knowing: lastEffect [ 
	"
	positionWithEffect := lastEffect applyEffectTo: aNumberOfLocker knowing: playersWithPositions and: currentPlayer knowing: lockers.
	(playersWithPositions at: currentPlayer) moveTo: positionWithEffect knowing: lockers."
]
