Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Effect >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer knowing: finishline [ 

	Error signal: 'This message should be override'.
]
