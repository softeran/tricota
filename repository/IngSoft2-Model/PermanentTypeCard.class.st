Class {
	#name : #PermanentTypeCard,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
PermanentTypeCard class >> initializeCardWithTarget: aTarget [
	^PermanentCard type: self new target: aTarget .
]

{ #category : #playing }
PermanentTypeCard >> effect: aPlayer [ 
	Error signal: 'This message should be override'.
]
