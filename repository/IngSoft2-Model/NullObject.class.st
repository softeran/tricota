Class {
	#name : #NullObject,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
NullObject >> = anObject [ 

	self class = anObject class ifTrue: [ ^true ] ifFalse: [ ^false ].	

]
