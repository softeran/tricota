Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Overload class >> target: aPlayer [ 
	^self new initializeTarget: aPlayer.
]

{ #category : #playing }
Overload >> applyTo: aPlayer within: aCollection knowing: aPickUpCard and: anInteger [ 
	^true.
]

{ #category : #playing }
Overload >> effect: aPlayer [ 
	(target = aPlayer) ifTrue:[^-2] ifFalse:[^0].
]

{ #category : #initialization }
Overload >> initializeTarget: aPlayer [ 
	target:= aPlayer.
]

{ #category : #playing }
Overload >> isPermanent [
	^true.
]
