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
	
  activeCards doWithIndex:[:card :i| (card = selectedCard and: card target = selectedCard target )ifTrue:[activeCards removeAt:i .
		^true]].

]

{ #category : #initialization }
Cancellation >> initializeSelectCard: aCard [
	selectedCard:= aCard.
]

{ #category : #playing }
Cancellation >> isPermanent [
	^false.
]