"
I'm Atomic Bomb, if i am chosen by the Effect Roulette, everybody goes back to position Zero.
"
Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
AtomicBomb >> applyEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [

	(aPosition >= finishline) ifTrue: [ (players at: currentPlayer) increaseLap: aPosition //finishline ].
	players do: [:player | player moveBackwards: 0] .

	^ 0.
]

{ #category : #playing }
AtomicBomb >> applyReverseEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [

	(aPosition >= finishline) ifTrue: [ (players at: currentPlayer) increaseLap: aPosition //finishline ].
	players do: [:player | player moveBackwards: 0] .

	^ 0.
]
