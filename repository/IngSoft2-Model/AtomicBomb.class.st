"
I'm Atomic Bomb, if i am chosen by the Effect Roulette, everybody goes back to position Zero.
"
Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
AtomicBomb >> applyEffectTo: aPosition knowing: players the: currentPlayer and: finishline [ 

	(aPosition >= finishline) ifTrue: [ (players at: currentPlayer) increaseLap].
	players do: [:player | player moveBackwards: 0] .

	^ 0.
]
