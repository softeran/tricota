Class {
	#name : #CurrentPosition,
	#superclass : #Object,
	#instVars : [
		'name',
		'locker',
		'laps'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
CurrentPosition class >> of: playerName atLocker: number atLap: numberOfLaps [

	^self new initializeOf: playerName atLocker: number atLap: numberOfLaps.
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
CurrentPosition >> initializeOf: playerName atLocker: number atLap: numberOfLaps [
	name:= playerName.
	locker:= number.
	laps:= numberOfLaps.
]

{ #category : #position }
CurrentPosition >> locker [
	^ locker
]

{ #category : #playerPosition }
CurrentPosition >> moveFoward: moveTo [
	
	locker:= moveTo.
	
]
