Class {
	#name : #EffectRouletteTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #'as yet unclassified' }
EffectRouletteTest >> effectsWithProbabilities [

	| atomicBomb speedUp wormHole moonWalk noEffect effects |
	atomicBomb := AtomicBomb new.
	speedUp := SpeedUp new.
	wormHole := WormHole new.
	moonWalk := MoonWalk maxBackwards: 5.
	noEffect := NoEffect new.
	effects:=Dictionary  new.
	effects at: atomicBomb put: 2.
	effects at: speedUp put: 20.
	effects at: wormHole put: 20.
	effects at: moonWalk put: 10.
	effects at: noEffect put: 48.
	
	^effects.
]

{ #category : #tests }
EffectRouletteTest >> testSpin [

	| effects effectRoulette |
	effects := self effectsWithProbabilities.
	effectRoulette := EffectRouletteBuilder new withProbabilities: effects.

	1 to: 100 do: [ :iteration | self assert: (effects keys includes: effectRoulette spin ) ].
]
