"
I'm Worm Hole, if i am chosen by the Effect Roulette, the player who spinned the wheel goes backwards 4 positions.
"
Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
WormHole >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: anUCABoardGame [ 
		^ aPosition - 4.
]
