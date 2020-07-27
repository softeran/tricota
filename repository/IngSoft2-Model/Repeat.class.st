Class {
	#name : #Repeat,
	#superclass : #IstantTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Repeat >> applyIn: game to: aPlayer [ 
	game applyRepeatCardTo: aPlayer.
	^self
]

{ #category : #playing }
Repeat >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
