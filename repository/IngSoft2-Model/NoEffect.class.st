"
I'm No Effect, if i am chosen by the Effect Roulette, nothing happens.
"
Class {
	#name : #NoEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
NoEffect >> applyEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [
	^ aPosition.
]
