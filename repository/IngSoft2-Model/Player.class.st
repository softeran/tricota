"
I'm a PLayer! I can move forwrd and backwards.
I am given a name when created. My position starts on locker zero and lap zero.
"
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

{ #category : #position }
Player >> currentPosition [
	^position .
]

{ #category : #move }
Player >> decreaseLap [
	 position decreaseLap.
]

{ #category : #move }
Player >> increaseLap [
	 position increaseLap.
]

{ #category : #'instance initialization' }
Player >> initializeWithName: aString [ 
	name:= aString.
	position:= CurrentPosition atLocker:0 atLap:0.
	
]

{ #category : #position }
Player >> lapNumber [
	^position lapNumber.
]

{ #category : #position }
Player >> lockerPosition [
	^position lockerPosition .
]

{ #category : #move }
Player >> moveBackwards: moveTo [ 
	
	position moveBackwards: moveTo.
]

{ #category : #move }
Player >> moveForward: moveTo [ 
	
	position moveFoward: moveTo.
]

{ #category : #name }
Player >> name [
	^name.
]
