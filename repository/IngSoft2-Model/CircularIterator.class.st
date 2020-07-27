"
I'm a circular iterator allowing to cycle between a number of options.

Implementation Notes:
	To ease the rollover I keep the current index in a zero-based fashion to use module arithmetics to perform the rollover.
"
Class {
	#name : #CircularIterator,
	#superclass : #Object,
	#instVars : [
		'options',
		'currentIndex',
		'course'
	],
	#category : #'IngSoft2-Model-Dice'
}

{ #category : #'instance creation' }
CircularIterator class >> cyclingOver: aSequentiableCollection [

	aSequentiableCollection notEmpty
		ifFalse: [ InstanceCreationFailed
				signal: 'It makes no sense to iterate in a cyclic way an empty collection' ].

	^ self new initializeCyclingOver: aSequentiableCollection asArray
]

{ #category : #course }
CircularIterator >> changeCourse [
	course := course * -1.
]

{ #category : #accessing }
CircularIterator >> current [

	^options at: currentIndex.
]

{ #category : #testing }
CircularIterator >> includes: anObject [

	^options includes: anObject  
]

{ #category : #initialization }
CircularIterator >> initializeCyclingOver: anArray [

	options := anArray.
	course := 1.
	self reset
]

{ #category : #iterating }
CircularIterator >> next [

	currentIndex := (currentIndex + course) \\ (options size + 1).
	self outOfBounds.
	^self current 
]

{ #category : #iterating }
CircularIterator >> outOfBounds [
	( currentIndex = 0 )
	ifTrue: [ (course = 1) 
		ifTrue: [ currentIndex := 1 ] 
		ifFalse: [ currentIndex := options size ] ]
]

{ #category : #iterating }
CircularIterator >> reset [

	currentIndex := 1
]
