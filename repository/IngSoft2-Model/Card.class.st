Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> = anObject [ 

	self class = anObject class ifTrue: [ ^true ] ifFalse: [ ^false ].	
]

{ #category : #initialization }
Card >> initializeTarget: aTarget [
	target:= aTarget.
]
