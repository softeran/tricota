"
I'm Worm Hole, if i am chosen by the Effect Roulette, the player who spinned the wheel goes backwards 4 positions.
"
Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
WormHole >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [ 
		^ aPosition - 4.
]
