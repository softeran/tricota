Class {
	#name : #EffectRouletteBuilder,
	#superclass : #Object,
	#instVars : [
		'effectsWithProbabilities',
		'sequenceOfEffects'
	],
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #'instance creation' }
EffectRouletteBuilder class >> buildingDeterministicRoulette [
	^self new initializeBuildingDeterministicRoulette.
]

{ #category : #'instance creation' }
EffectRouletteBuilder class >> buildingProbabilisticRoulette [
	^self new initializeBuildingProbabilisticRoulette.
]

{ #category : #building }
EffectRouletteBuilder >> add: anEffect [
	sequenceOfEffects add: anEffect.
]

{ #category : #building }
EffectRouletteBuilder >> add: anEffect withPercentage: aPercentage [

	sequenceOfEffects at: anEffect put: aPercentage.
]

{ #category : #building }
EffectRouletteBuilder >> buildDeterministic [ 
	^EffectRoulette source:(SequentialEffectProvider providing: sequenceOfEffects).
]

{ #category : #building }
EffectRouletteBuilder >> buildProbabilistic [
	^EffectRoulette source:(ProbabilitiesEffectProvider with: (self createDictionaryEffectsAndProbabilities: sequenceOfEffects )).
]

{ #category : #initialization }
EffectRouletteBuilder >> createDictionaryEffectsAndProbabilities: effects [
	| minimum |
	minimum := 1.
	effects
		keysAndValuesDo: [ :key :value | 
			effects at: key put: (Interval from: minimum to: minimum + value - 1).
			minimum := minimum + value ].
	^effects.
]

{ #category : #initialization }
EffectRouletteBuilder >> initializeBuildingDeterministicRoulette [
	sequenceOfEffects := OrderedCollection new.
	
]

{ #category : #initialization }
EffectRouletteBuilder >> initializeBuildingProbabilisticRoulette [
	sequenceOfEffects := Dictionary new. 
]
