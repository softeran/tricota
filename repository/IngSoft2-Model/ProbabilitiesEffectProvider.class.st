Class {
	#name : #ProbabilitiesEffectProvider,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'dictionary',
		'randomValue'
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
	randomValue := Random new.
]

{ #category : #playing }
ProbabilitiesEffectProvider >> nextEffect [

	^ self searchForEffectAt: (randomValue nextInt: 100).
]

{ #category : #playing }
ProbabilitiesEffectProvider >> searchForEffectAt: randomValue [
	dictionary
		keysAndValuesDo: [ :key :value | 
			(value includes: randomValue)
				ifTrue: [ ^ key ] ]
]
