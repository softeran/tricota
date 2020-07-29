Class {
	#name : #Reversal,
	#superclass : #PermanentTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Reversal class >> initializeCard [
	^PermanentCard type: self new target: LockerTarget  new.
]

{ #category : #playing }
Reversal >> effect: aPlayer [
	^0.
]

{ #category : #playing }
Reversal >> effectLocker: aTarget [

^ aTarget number. 
	
]
