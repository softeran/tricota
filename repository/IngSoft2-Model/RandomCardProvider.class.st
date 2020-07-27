Class {
	#name : #RandomCardProvider,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
RandomCardProvider class >> providing: cards [
	^self new initializeProviding: cards.
]

{ #category : #initialization }
RandomCardProvider >> initializeProviding: collectionOfCards [
  cards:= collectionOfCards.
]

{ #category : #playing }
RandomCardProvider >> nextCard [

   | index |
	index := Random new nextInt: cards size.
	^cards at:index.
]
