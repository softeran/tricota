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
Player class >> assertNameIsAString: aString [ 

	(aString isString)
		ifFalse: [ InstanceCreationFailed signal: 'Name must be a string' ]

]

{ #category : #'instance creation' }
Player class >> yourNameIs: aString [ 

	self assertNameIsAString: aString.
	^self new yourNameIs: aString.
]

{ #category : #playing }
Player >> currentPosition [
	^position
]

{ #category : #playing }
Player >> finalPosition [
	|n p|
	n := self sayYourName.
	p := self currentPosition.
	^#(n p).
]

{ #category : #playing }
Player >> moveForward: moveTo [ 
	
	position := moveTo.
]

{ #category : #reset }
Player >> resetPosition [
	position := 0.
]

{ #category : #hablar }
Player >> sayYourName [
	^name.
]

{ #category : #'instance initialization' }
Player >> yourNameIs: aString [ 
	name:= aString.
	position:= 0.
	
]
