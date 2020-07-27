Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'type',
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Card class >> type: aType [  
	^ self type: aType target: NoTarget new.
]

{ #category : #'instance creation' }
Card class >> type: aType target: aTarget [ 
	^ self new initializeType: aType target: aTarget
]

{ #category : #playing }
Card >> applyIn: game [
	Error signal: 'This message should be override'.
]

{ #category : #inicialization }
Card >> initializeType: aType target: aTarget [ 
	type := aType .
	target := aTarget.
]

{ #category : #playing }
Card >> isSameType: aCard [ 
	^ type = aCard type .
]

{ #category : #playing }
Card >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	Error signal: 'This message should be override'.
]

{ #category : #playing }
Card >> type [
	^ type
]
