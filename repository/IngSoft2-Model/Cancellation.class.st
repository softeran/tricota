Class {
	#name : #Cancellation,
	#superclass : #Card,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Cancellation class >> selectCard: aCard [
	^self new initializeSelectCard: aCard.
]

{ #category : #playing }
Cancellation >> applyWithin: aPlayersWithPositions  knowing: activeCards  the: lastEffect and: finishLine [ 
	
  activeCards remove: selectedCard.
]

{ #category : #initialization }
Cancellation >> initializeSelectCard: aCard [
	selectedCard:= aCard.
]

{ #category : #playing }
Cancellation >> isPermanent [
	^false.
]

{ #category : #playing }
Cancellation >> redoCardTo: aCard [

	^self class selectCard: selectedCard.
]
