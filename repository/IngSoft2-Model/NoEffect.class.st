Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
NoEffect >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: anUCABoardGame [ 
	^ aPosition.
]
