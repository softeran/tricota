Class {
	#name : #Speed,
	#superclass : #PermanentTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Speed class >> initializeCard [
	^PermanentCard type: self new.
]

{ #category : #playing }
Speed >> effect: aPlayer [ 
	^1
]
