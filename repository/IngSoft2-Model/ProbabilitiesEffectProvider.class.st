Class {
	#name : #ProbabilitiesEffectProvider,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'dictionary'
	],
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #'instance creation' }
ProbabilitiesEffectProvider class >> with: aDictionaryOfEffects [
 ^self new initializeWith: aDictionaryOfEffects.
]

{ #category : #initialization }
ProbabilitiesEffectProvider >> initializeWith: aDictionaryOfEffects [ 
	dictionary:= aDictionaryOfEffects.
]

{ #category : #playing }
ProbabilitiesEffectProvider >> nextEffect [

		| randomValue |
	randomValue := Random new nextInt: 100.
	dictionary 
		keysAndValuesDo: [ :key :value | 
			(value includes: randomValue)
				ifTrue: [ ^ key ] ]
]
