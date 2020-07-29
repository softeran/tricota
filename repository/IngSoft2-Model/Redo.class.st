Class {
	#name : #Redo,
	#superclass : #IstantTypeCard,
	#instVars : [
		'throwedBy',
		'playersTurn'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Redo >> applyIn: game to: aTarget [ 
	^game applyRedoCardTo: aTarget thrownBy: throwedBy inTheTurnOf: playersTurn 
	
]

{ #category : #playing }
Redo >> effect: aPlayer [ 
	^(-1).
]

{ #category : #playing }
Redo >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	throwedBy:= aPlayer.
	playersTurn := playerTurn 
	
]
