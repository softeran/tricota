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

{ #category : #playing }
Acceleration >> redoCardTo: aTarget [
	^self class new.
]

{ #category : #playing }
Acceleration >> target [
	^'Everyone'.
]
