Class {
	#name : #CurrentPosition,
	#superclass : #Object,
	#instVars : [
		'name',
		'locker'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
CurrentPosition class >> initializeOf: playerName atLocker: number [ 
	^self new initializeOf: playerName atLocker: number.
]

{ #category : #'instance initialization' }
CurrentPosition >> = anObject [ 
	name= anObject getName ifFalse: [ ^false ].
	locker = anObject currentPosition ifFalse: [ ^false ].
 ^true

]

{ #category : #playerPosition }
CurrentPosition >> currentPosition [
	^locker
]

{ #category : #playersName }
CurrentPosition >> getName [
	^name
]

{ #category : #'instance initialization' }
CurrentPosition >> initializeOf: playerName atLocker: number [
	name:= playerName.
	locker:= number.
]
