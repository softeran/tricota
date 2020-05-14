Class {
	#name : #Locker,
	#superclass : #Object,
	#instVars : [
		'position',
		'effect'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
Locker class >> atPosition: anInteger withEffect: aWormHole [ 
	^self new initializeAtPosition: anInteger withEffect: aWormHole .
]

{ #category : #playing }
Locker >> applyEffect [
	effect apply.
]

{ #category : #initialization }
Locker >> initializeAtPosition: anInteger withEffect: aWormHole [ 
	position:= anInteger.
	effect:= aWormHole.
]

{ #category : #playing }
Locker >> position [
	^ position
]
