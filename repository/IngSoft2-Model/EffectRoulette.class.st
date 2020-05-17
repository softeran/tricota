Class {
	#name : #EffectRoulette,
	#superclass : #Object,
	#instVars : [
		'collectionOfEffects'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
EffectRoulette class >> with: effects [ 
	^ self new initializeWith: effects.
]

{ #category : #initialization }
EffectRoulette >> initializeWith: effects [
	collectionOfEffects := effects.
]

{ #category : #playing }
EffectRoulette >> spin [
	^ collectionOfEffects atRandom.
]
