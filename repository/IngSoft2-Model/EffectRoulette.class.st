"
I'm Effect Roulette! When spinning me i give an effect in return, based on probabilities.
I am given a dictionary that has effects as keys and probabilities as values when created.

"
Class {
	#name : #EffectRoulette,
	#superclass : #Object,
	#instVars : [
		'effectsWithProbabilities',
		'effectProvider'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
EffectRoulette class >> source: aEffectProvider [

	^ self new initializeSource: aEffectProvider.
]

{ #category : #'instance creation' }
EffectRoulette class >> with: effects [ 
	^ self new initializeWith: effects.
]

{ #category : #playing }
EffectRoulette >> chooseEffectAccordingToProbabilities [
	| randomValue |
	randomValue := Random new nextInt: 100.
	effectsWithProbabilities
		keysAndValuesDo: [ :key :value | 
			(value includes: randomValue)
				ifTrue: [ ^ key ] ]
]

{ #category : #initialization }
EffectRoulette >> initializeSource: aEffectProvider [ 

	effectProvider:= aEffectProvider.
]

{ #category : #initialization }
EffectRoulette >> initializeWith: effects [
	
	effectsWithProbabilities := self createDictionaryEffectsAndProbabilities: effects.
]

{ #category : #playing }
EffectRoulette >> spin [
	^ effectProvider nextEffect.
]
