Class {
	#name : #SequencialEffectProvider,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #providing }
SequencialEffectProvider class >> providing: aSequenceOfEffects [ 
	aSequenceOfEffects  size < 1
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough effects, there must be one at least' ].
	^ self new initializeProviding: aSequenceOfEffects 
]

{ #category : #initialization }
SequencialEffectProvider >> initializeProviding: aSequenceOfEffects [ 

	sequence := (CircularIterator cyclingOver: aSequenceOfEffects ).
]

{ #category : #providing }
SequencialEffectProvider >> nextEffect [
	^ sequence next.
]
