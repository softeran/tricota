Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'lockers'
	],
	#category : #'IS2-Model-Board'
}

{ #category : #'instance creation' }
Board class >> assertIsGraterThanTwo: aNumberOfLockers [

	aNumberOfLockers > 1
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least two lockers' ]
	
]

{ #category : #'instance creation' }
Board class >> withLockers: numberOfLockers [ 

	self assertIsGraterThanTwo: numberOfLockers.
	^self new withLockers: numberOfLockers.
]

{ #category : #finish }
Board >> finishLine [
	^lockers.
]

{ #category : #'instance initialization' }
Board >> withLockers: numberOfLockers [ 
	lockers:= numberOfLockers.
]
