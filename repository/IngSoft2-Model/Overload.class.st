Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Overload >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	game savePermanentCard: self
]

{ #category : #playing }
Overload >> effect: aPlayer [ 
	(target = aPlayer) ifTrue:[^-2] ifFalse:[^0].
]
