Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'lockers',
		'laps'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
Board class >> assertIsGraterThanCero: aNumberOfLaps [

	aNumberOfLaps> 0
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least one lap' ]
	
]

{ #category : #'instance creation' }
Board class >> assertIsGraterThanTwo: aNumberOfLockers [

	aNumberOfLockers > 1
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least two lockers' ]
	
]

{ #category : #'instance creation' }
Board class >> withLockers: numberOfLockers andLaps: numberOfLaps [

	self assertIsGraterThanTwo: numberOfLockers.
	self assertIsGraterThanCero: numberOfLaps.
	
	^self new initializeWithLockers: numberOfLockers andLaps: numberOfLaps.
]

{ #category : #finish }
Board >> finishLine [
	^lockers.
]

{ #category : #'instance initialization' }
Board >> initializeWithLockers: numberOfLockers andLaps: numberOfLaps [
	lockers:= numberOfLockers.
	laps:= numberOfLaps.
]
