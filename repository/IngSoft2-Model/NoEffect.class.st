"
I'm No Effect, if i am chosen by the Effect Roulette, nothing happens.
"
Class {
	#name : #NoEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
NoEffect >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [  
	^ aPosition.
]
