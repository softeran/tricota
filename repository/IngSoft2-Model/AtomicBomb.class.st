"
I'm Atomic Bomb, if i am chosen by the Effect Roulette, everybody goes back to position Zero.
"
Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [ 

	(aPosition >= finishline) ifTrue: [ (players at: aCurrentPlayer) increaseLap].
	players do: [:player | player moveBackwards: 0] .

	^ 0.
]
