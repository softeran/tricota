"
I'm a PLayer! I can move forwrd and backwards.
I am given a name when created. My position starts on locker zero and lap zero.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
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

{ #category : #'instance initialization' }
Player >> initializeWithName: aString [ 
	name:= aString.
	
]

{ #category : #name }
Player >> name [
	^name.
]
