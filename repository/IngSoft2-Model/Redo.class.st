Class {
	#name : #Redo,
	#superclass : #Card,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Redo class >> ofCard: card [
	^self new initializeOfCard: card.
]

{ #category : #accessing }
Redo class >> target: aPlayer [ 
	^self new initializeTarget: aPlayer .

]

{ #category : #playing }
Redo >> assertCardIs: aCard [
	(card = aCard)ifFalse: [ InvalideRequest signal: 'That was not the last card played' ].
]

{ #category : #initialization }
Redo >> initializeOfCard: aCard [
	card:= aCard.
	
]

{ #category : #playing }
Redo >> toRedo [
	^ card
]
