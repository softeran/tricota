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

{ #category : #playing }
Card >> assertCardIs: aCard [
	self = aCard ifFalse:[ InvalideRequest signal:'That was not the last card played'].
]

{ #category : #initialization }
Card >> initializeCard: aCard target: aPlayer [ 
	card:= aCard.
	target:= aPlayer 
]

{ #category : #playing }
Card >> isPermanent [

	Error signal: 'This message should be override'.
]

{ #category : #playing }
Card >> toRedo [
 ^self.
]
