Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Speed class >> target: aPlayer [ 
	|orderCollectionPlayer|
	orderCollectionPlayer:= OrderedCollection new .
	orderCollectionPlayer add: aPlayer.
	^self new initializeTarget: orderCollectionPlayer.
]

{ #category : #playing }
Speed >> effect: aPlayer [ 
	(target includes: aPlayer) ifTrue:[^1] ifFalse:[^0].
]

{ #category : #playing }
Speed >> isPermanent [
	^true.
]
