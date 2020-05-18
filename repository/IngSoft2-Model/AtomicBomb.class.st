"
I'm Atomic Bomb, if i am chosen by the Effect Roulette, everybody goes back to position Zero.
"
Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: anUCABoardGame [ 

	players do: [:player | player moveBackwards: 0] .

	^ 0.
]
