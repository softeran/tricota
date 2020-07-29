"
I'm Speed Up, if i am chosen by the Effect Roulette, the player who spinned the wheel goes forward 4 positions.
"
Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
SpeedUp >> applyEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [
	^ aPosition + 4.
]

{ #category : #playing }
SpeedUp >> applyReverseEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [
	^ aPosition - 4.
]
