Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Speed >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	game savePermanentCard: self.
	game lastCardPlayed: self.
]

{ #category : #playing }
Speed >> effect: aPlayer [ 
	(target = aPlayer) ifTrue:[^1] ifFalse:[^0].
]
