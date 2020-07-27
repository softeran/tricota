Class {
	#name : #Acceleration,
	#superclass : #PermanentTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Acceleration class >> initializeCard [
	^PermanentCard type: self new target: Everyone new.
]

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]
