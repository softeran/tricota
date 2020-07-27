Class {
	#name : #TypeOfCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
TypeOfCard class >> initializeCard [
	Error signal: 'This message should be override'.
]

{ #category : #initialization }
TypeOfCard class >> initializeCardWithTarget: aTarget [
	Error signal: 'This message should be override'.
]

{ #category : #comparing }
TypeOfCard >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #comparing }
TypeOfCard >> hash [
	
	^self class hash
]
