Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Redo class >> card: aCard target: aPlayer [
	^ self new initializeCard: aCard target: aPlayer
]

{ #category : #'instance creation' }
Redo class >> ofCard: card [
	^self new initializeOfCard: card.
]

{ #category : #playing }
Redo >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	|lastCard|
	lastCard:= (game lastCardPlayed) class selectCard: card.
	lastCard applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game
]

{ #category : #playing }
Redo >> assertCardIs: aCard [
	(card assertCardIs:aCard)"ifFalse: [ InvalideRequest signal: 'That was not the last card played' ]."
]

{ #category : #initialize }
Redo >> initializeCard: aCard target: aPlayer [ 
	card:= aCard.
	target:= aPlayer 
]

{ #category : #initialization }
Redo >> initializeOfCard: aCard [
	card:= aCard.
	
]

{ #category : #playing }
Redo >> toRedo [
	^ card toRedo.
]
