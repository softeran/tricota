Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #comparing }
Card >> = anObject [ 

	self class = anObject class ifTrue: [ ^true ] ifFalse: [ ^false ].	
]

{ #category : #playing }
Card >> assertCardIs: aCard [
	self = aCard ifFalse:[ InvalideRequest signal:'That was not the last card played'].
]

{ #category : #playing }
Card >> isPermanent [

	Error signal: 'This message should be override'.
]

{ #category : #playing }
Card >> toRedo [
 ^self.
]
