Class {
	#name : #EffectRouletteTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #'as yet unclassified' }
EffectRouletteTest >> effectsWithProbabilities [

	| atomicBomb speedUp wormHole moonWalk noEffect effectRouletteBuilder |
	atomicBomb := AtomicBomb new.
	speedUp := SpeedUp new.
	wormHole := WormHole new.
	moonWalk := MoonWalk maxBackwards: 5.
	noEffect := NoEffect new.
	effectRouletteBuilder:= EffectRouletteBuilder buildingProbabilisticRoulette.
	
	effectRouletteBuilder add: atomicBomb withPercentage:10.
	effectRouletteBuilder add: speedUp withPercentage:20.
	effectRouletteBuilder add: wormHole withPercentage:20.
	effectRouletteBuilder add: moonWalk withPercentage:10.
	effectRouletteBuilder add: noEffect withPercentage:48.
	
	^effectRouletteBuilder buildProbabilistic .
]

{ #category : #tests }
EffectRouletteTest >> testSpin [

	| effectRoulette  effects |
	effectRoulette:= self effectsWithProbabilities.
	effects:= OrderedCollection new.
	effects 
		add: AtomicBomb new ;
		add: SpeedUp new;
		add: WormHole new ;
		add: (MoonWalk maxBackwards: 5); 
		add: NoEffect new.
	1 to: 100 do: [ :iteration | self assert: (effects includes: effectRoulette spin ) ].
]
