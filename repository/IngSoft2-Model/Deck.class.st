Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardProvider'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Deck class >> source: aCardProvider [

	^ self new initializeSource: aCardProvider.
]

{ #category : #deal }
Deck >> dealTwoCardsToEachPlayerFrom: aGruopOfPLayers [

	aGruopOfPLayers do: [ :player | 
			player addCard: self handCard .
			player addCard: self handCard ]
]

{ #category : #deal }
Deck >> handCard [
	^ cardProvider nextCard.
]

{ #category : #initialization }
Deck >> initializeSource: aCardProvider [ 

	cardProvider:= aCardProvider.
]
