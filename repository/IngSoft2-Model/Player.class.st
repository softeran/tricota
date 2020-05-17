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
	^position .
]

{ #category : #lap }
Player >> decreaseLap [
	 position decreaseLap.
]

{ #category : #lap }
Player >> increaseLap [
	 position increaseLap.
]

{ #category : #'instance initialization' }
Player >> initializeWithName: aString [ 
	name:= aString.
	position:= CurrentPosition atLocker:0 atLap:0.
	
]

{ #category : #lap }
Player >> lapNumber [
	^position lapNumber.
]

{ #category : #playing }
Player >> lockerPosition [
	^position lockerPosition .
]

{ #category : #playing }
Player >> moveBackwards: moveTo [ 
	
	position moveBackwards: moveTo.
]

{ #category : #playing }
Player >> moveForward: moveTo [ 
	
	position moveFoward: moveTo.
]

{ #category : #hablar }
Player >> nameIs [
	^name.
]
