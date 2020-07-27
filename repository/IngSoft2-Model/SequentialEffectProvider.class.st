Class {
	#name : #SequentialEffectProvider,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #'instance creation' }
SequentialEffectProvider class >> providing: aSequenceOfEffects [ 
	aSequenceOfEffects  size < 1
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough effects, there must be one at least' ].
	^ self new initializeProviding: aSequenceOfEffects 
]

{ #category : #initialization }
SequentialEffectProvider >> initializeProviding: aSequenceOfEffects [ 

	sequence := (CircularIterator cyclingOver: aSequenceOfEffects ).
]

{ #category : #providing }
SequentialEffectProvider >> nextEffect [

	| next |
	next := sequence current.
	sequence next.
	^ next
]
