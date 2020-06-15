Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Acceleration class >> target: players [

	^self new initializeTarget: players.
]

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]

{ #category : #playing }
Acceleration >> isPermanent [
	^true.
]

{ #category : #playing }
Acceleration >> redoCard [
	^self class new
]

{ #category : #playing }
Acceleration >> redoCardTo: aTarget [
	^self class new.
]
