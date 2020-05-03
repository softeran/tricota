Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'lockers'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
Board class >> assertIsGraterThanTwo: aNumberOfLockers [

	aNumberOfLockers > 1
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least two lockers' ]
	
]

{ #category : #'instance creation' }
Board class >> initializeWithLockers: numberOfLockers [ 

	self assertIsGraterThanTwo: numberOfLockers.
	^self new initializeWithLockers: numberOfLockers.
]

{ #category : #finish }
Board >> finishLine [
	^lockers.
]

{ #category : #'instance initialization' }
Board >> initializeWithLockers: numberOfLockers [ 
	lockers:= numberOfLockers.
]
