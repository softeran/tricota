"
I'm No Effect, if i am chosen by the Effect Roulette, nothing happens.
"
Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
NoEffect >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: anUCABoardGame [ 
	^ aPosition.
]
