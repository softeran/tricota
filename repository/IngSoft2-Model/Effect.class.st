Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Effect >> = anObject [ 

	self class = anObject class ifTrue: [ ^true ] ifFalse: [ ^false ].	
	


]

{ #category : #playing }
Effect >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [ 

	Error signal: 'This message should be override'.
]
