Class {
	#name : #Cancellation,
	#superclass : #Card,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Cancellation class >> selectCard: aCard [
	^self new initializeSelectCard: aCard.
]

{ #category : #playing }
Cancellation >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	game lastCardPlayed: self.
	^ self removeCardFrom: activeCards.
	
]

{ #category : #initialization }
Cancellation >> initializeSelectCard: aCard [
	selectedCard:= aCard.
]

{ #category : #playing }
Cancellation >> removeCardFrom: activeCards [
	activeCards
		doWithIndex: [ :currentCard :i | 
			(currentCard = selectedCard and: currentCard target = selectedCard target)
				ifTrue: [ activeCards removeAt: i.
					^ true ] ]
]
