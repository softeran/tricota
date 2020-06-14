Class {
	#name : #PickUpCard,
	#superclass : #Effect,
	#instVars : [
		'cardsProvider'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
PickUpCard class >> withRandom: cards [
	^self new initializeWithRandom: cards.
]

{ #category : #'instance creation' }
PickUpCard class >> withSequence: aSequenceOfCards [
	^self new initializeWithSequence: aSequenceOfCards.
]

{ #category : #playing }
PickUpCard >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [  
	aCurrentPlayer addCard: cardsProvider nextCard.
	^aPosition.
]

{ #category : #initialization }
PickUpCard >> initializeWithRandom: cards [
   cardsProvider:= RandomCardProvider providing: cards.
]

{ #category : #initialization }
PickUpCard >> initializeWithSequence: aSequenceOfCards [ 

	cardsProvider:= SequentialCardProvider providing: aSequenceOfCards.
		
]

{ #category : #playing }
PickUpCard >> nextCard [
	^cardsProvider nextCard.
]
