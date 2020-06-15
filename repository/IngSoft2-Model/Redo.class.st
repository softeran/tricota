Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Redo class >> target: aPlayer [ 
	^self new initializeTarget: aPlayer .

]

{ #category : #playing }
Redo >> changeTo: aCard [
	
	^aCard redoCardTo: target.
]
