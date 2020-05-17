Class {
	#name : #EffectRoulette,
	#superclass : #Object,
	#instVars : [
		'effectsWithProbabilities'
	],
	#category : #'IngSoft2-Model-Board'
}

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
EffectRoulette >> createDictionaryEffectsAndProbabilities: effects [
	| minimum |
	minimum := 1.
	effects
		keysAndValuesDo: [ :key :value | 
			effects at: key put: (Interval from: minimum to: minimum + value - 1).
			minimum := minimum + value ].
	^effects.
]

{ #category : #initialization }
EffectRoulette >> initializeWith: effects [
	
	effectsWithProbabilities := self createDictionaryEffectsAndProbabilities: effects.
]

{ #category : #playing }
EffectRoulette >> spin [
	^ self chooseEffectAccordingToProbabilities
]
