Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> = anObject [ 

	self class = anObject class ifTrue: [ ^true ] ifFalse: [ ^false ].	
]