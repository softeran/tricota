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
	^self new initializeTarget: aPlayer.
]

{ #category : #playing }
Speed >> effect: aPlayer [ 
	(target = aPlayer) ifTrue:[^1] ifFalse:[^0].
]

{ #category : #initialization }
Speed >> initializeTarget: aPlayer [ 
 target:=aPlayer.
]

{ #category : #playing }
Speed >> isPermanent [
	^true.
]
