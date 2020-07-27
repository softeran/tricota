Class {
	#name : #IstantTypeCard,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
IstantTypeCard class >> initializeCard [
	^InstantCard type: self new.
]

{ #category : #initialization }
IstantTypeCard class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
IstantTypeCard >> applyIn: game to: aCard [ 
	Error signal: 'This message should be override'.
]

{ #category : #playing }
IstantTypeCard >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	Error signal: 'This message should be override'.
]
