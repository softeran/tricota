Class {
	#name : #Cancellation,
	#superclass : #IstantTypeCard,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Cancellation >> applyIn: game to: aCard [ 
	game applyCancellationCardTo: aCard.
	^self 
]

{ #category : #playing }
Cancellation >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
