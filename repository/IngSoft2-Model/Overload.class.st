Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Overload class >> target: aPlayer [ 
|orderCollectionPlayer|
	orderCollectionPlayer:= OrderedCollection new .
	orderCollectionPlayer add: aPlayer.
	^self new initializeTarget: orderCollectionPlayer.
]

{ #category : #playing }
Overload >> effect: aPlayer [ 
	(target includes: aPlayer) ifTrue:[^-2] ifFalse:[^0].
]

{ #category : #initialization }
Overload >> initializeTarget: aTarget [
	target:= aTarget.
]

{ #category : #playing }
Overload >> isPermanent [
	^true.
]

{ #category : #playing }
Overload >> target [
	^ target.
]
