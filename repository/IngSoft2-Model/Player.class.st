Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #'IngSoft2-Model-Player'
}

{ #category : #'instance creation' }
Player class >> assertNameIsANonEmptyString: aString [ 

	(aString isEmpty)
		ifTrue: [ InstanceCreationFailed signal: 'Name must not be an empty string' ]

]

{ #category : #'instance creation' }
Player class >> named: aString [ 

	self assertNameIsANonEmptyString: aString.
	^self new initializeWithName: aString.
]

{ #category : #playing }
Player >> currentPosition [
	^position
]

{ #category : #'instance initialization' }
Player >> initializeWithName: aString [ 
	name:= aString.
	position:= 0.
	
]

{ #category : #playing }
Player >> moveForward: moveTo [ 
	
	position := moveTo.
]

{ #category : #hablar }
Player >> nameIs [
	^name.
]

{ #category : #reset }
Player >> resetPosition [
	position := 0.
]
