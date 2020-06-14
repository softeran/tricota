Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Redo >> changeTo: aCard [
	
	^aCard redoCard.
]
