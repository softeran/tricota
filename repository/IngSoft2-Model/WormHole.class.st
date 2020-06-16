"
I'm Worm Hole, if i am chosen by the Effect Roulette, the player who spinned the wheel goes backwards 4 positions.
"
Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
WormHole >> applyEffectTo: aPosition knowing: players the: currentPlayer and: finishline [ 
		^ aPosition - 4.
]
