Class {
	#name : #PickUpCard,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
PickUpCard >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [  
	aCurrentPlayer addCard: Repeat new.
	^aPosition.
]
