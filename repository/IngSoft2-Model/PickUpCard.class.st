Class {
	#name : #PickUpCard,
	#superclass : #Effect,
	#instVars : [
		'cardsProvider'
	],
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
PickUpCard >> applyEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [
	currentPlayer addCard: deck handCard.
	^aPosition.
]
