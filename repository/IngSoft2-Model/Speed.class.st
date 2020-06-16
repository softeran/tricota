Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
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

{ #category : #initialization }
Speed >> initializeTarget: aTarget [
	target:= aTarget.
]

{ #category : #playing }
Speed >> isPermanent [
	^true.
]

{ #category : #playing }
Speed >> target [
	^ target.
]
