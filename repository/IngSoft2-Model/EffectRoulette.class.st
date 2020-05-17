Class {
	#name : #EffectRoulette,
	#superclass : #Object,
	#instVars : [
		'collectionOfEffects',
		'dictionaryOfEffects'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
EffectRoulette class >> with: effects [ 
	^ self new initializeWith: effects.
]

{ #category : #initialization }
EffectRoulette >> initializeWith: effects [
	"collectionOfEffects := effects."
	| cont |
	cont :=1.
	effects keysAndValuesDo: [ :key :value | 
			effects at: key put: (Interval from: cont to: (cont + value -1)). 
			cont := cont + value].
	dictionaryOfEffects := effects.
]

{ #category : #playing }
EffectRoulette >> spin [
	
	| randomValue |
	randomValue := Random new nextInt: 100.
	dictionaryOfEffects keysAndValuesDo: [ :key :value |
			(value includes: randomValue) ifTrue: [ ^ key ] ].
]
