Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Acceleration >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	game savePermanentCard: self.
	game lastCardPlayed: self.
]

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]
