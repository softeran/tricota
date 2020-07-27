Class {
	#name : #Overload,
	#superclass : #PermanentTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Overload class >> initializeCard [
	^PermanentCard type: self new.
]

{ #category : #playing }
Overload >> effect: aPlayer [ 
	^ -2.
]
