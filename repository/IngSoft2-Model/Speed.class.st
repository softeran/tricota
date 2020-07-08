Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Speed class >> target: aPlayer [ 
	|orderCollectionPlayer|
	orderCollectionPlayer:= OrderedCollection new .
	orderCollectionPlayer add: aPlayer.
	^self new initializeTarget: orderCollectionPlayer.
]

{ #category : #playing }
Speed >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	game savePermanentCard: self.
	game lastCardPlayed: self.
]

{ #category : #playing }
Speed >> effect: aPlayer [ 
	(target = aPlayer) ifTrue:[^1] ifFalse:[^0].
]

{ #category : #initialization }
Speed >> initializeTarget: aTarget [
	target:= aTarget.
]

{ #category : #playing }
Speed >> target [
	^ target.
]
