Class {
	#name : #CurrentPosition,
	#superclass : #Object,
	#instVars : [
		'name',
		'locker'
	],
	#category : #'IS2-Model-Game'
}

{ #category : #'instance creation' }
CurrentPosition class >> of: playerName atLocker: number [ 
	^self new of: playerName atLocker: number.
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
CurrentPosition >> of: playerName atLocker: number [
	name:= playerName.
	locker:= number.
]
