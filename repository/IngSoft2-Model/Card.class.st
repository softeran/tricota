Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'card',
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Card class >> card: aCard target: aPlayer [
	^ self new initializeCard: aCard target: aPlayer
]

{ #category : #comparing }
Card >> = anObject [ 

	self class = anObject class ifTrue: [ ^true ] ifFalse: [ ^false ].	
]

{ #category : #initialization }
Card >> initializeCard: aCard target: aPlayer [ 
	card:= aCard.
	target:= aPlayer 
]

{ #category : #playing }
Card >> target [
	^target.
]
