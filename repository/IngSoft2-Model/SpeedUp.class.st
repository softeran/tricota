"
I'm Speed Up, if i am chosen by the Effect Roulette, the player who spinned the wheel goes forward 4 positions.
"
Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
SpeedUp >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: anUCABoardGame [ 
	^ aPosition + 4.
]
