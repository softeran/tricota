Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]

{ #category : #playing }
Acceleration >> isPermanent [
	^true.
]

{ #category : #playing }
Acceleration >> redoCardTo: aTarget [
	^self class new.
]

{ #category : #playing }
Acceleration >> target [
	^'Everyone'.
]
