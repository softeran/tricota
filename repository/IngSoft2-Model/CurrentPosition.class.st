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
CurrentPosition class >> atLocker: number atLap: numberOfLaps [

	^self new initializeAtLocker: number atLap: numberOfLaps.
]

{ #category : #'instance initialization' }
CurrentPosition >> = anObject [ 
	name= anObject getName ifFalse: [ ^false ].
	locker = anObject lockerPosition ifFalse: [ ^false ].
	
 ^true

]

{ #category : #'instance initialization' }
CurrentPosition >> >= aCurrentPosition [ 
	laps > aCurrentPosition lapNumber ifTrue: [ ^true].
	laps < aCurrentPosition lapNumber ifTrue: [ ^false].
	locker >= aCurrentPosition  lockerPosition  ifTrue: [ ^true ].
	
 ^false.

]

{ #category : #playersName }
CurrentPosition >> getName [
	^name
]

{ #category : #lap }
CurrentPosition >> increaseLap [
	laps:= laps+1.
]

{ #category : #'instance initialization' }
CurrentPosition >> initializeAtLocker: number atLap: numberOfLaps [
	locker:= number.
	laps:= numberOfLaps.
]

{ #category : #lap }
CurrentPosition >> lapNumber [
	^laps.
]

{ #category : #position }
CurrentPosition >> locker [
	^ locker
]

{ #category : #playerPosition }
CurrentPosition >> lockerPosition [
	^locker
]

{ #category : #playerPosition }
CurrentPosition >> moveFoward: moveTo [
	
	locker:= moveTo.
	
]
