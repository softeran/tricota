"
I'm a PLayer! I can move forwrd and backwards.
I am given a name when created. My position starts on locker zero and lap zero.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'cards'
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
Player >> = anObject [ 
	name = anObject name ifFalse: [ ^false ].
 ^true
]

{ #category : #playing }
Player >> addCard: aCard [ 
	cards add: aCard
]

{ #category : #assertions }
Player >> assertHasCard: aCard [ 
	cards detect: [ :card | card  = aCard ] 
			ifFound: [ ^true]
			ifNone: [ InvalideRequest signal: 'Player doesnt have that card']  .
		
]

{ #category : #playing }
Player >> cardPlayed: aCard [

	cards remove: aCard.
	
]

{ #category : #playing }
Player >> hash [
	
	^self species hash bitXor: (self  name hash ).

]

{ #category : #'instance initialization' }
Player >> initializeWithName: aString [ 
	name:= aString.
	cards:= OrderedCollection new.
	
]

{ #category : #name }
Player >> name [
	^name.
]

{ #category : #playing }
Player >> numberOfCards [
	^ cards size.
]
