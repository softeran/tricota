Class {
	#name : #EffectRouletteBuilder,
	#superclass : #Object,
	#instVars : [
		'effectsWithProbabilities'
	],
	#category : #'IngSoft2-Model-Effects'
}

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

{ #category : #building }
EffectRouletteBuilder >> with: aSequenceOfEffects [ 
	^ EffectRoulette source:(SequencialEffectProvider providing: aSequenceOfEffects).
	
]

{ #category : #'as yet unclassified' }
EffectRouletteBuilder >> withProbabilities: dictionaryEffectsProbabilities [
	^ EffectRoulette source:( ProbabilitiesEffectProvider with:(self createDictionaryEffectsAndProbabilities: dictionaryEffectsProbabilities)).
]
