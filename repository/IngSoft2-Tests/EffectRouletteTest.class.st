Class {
	#name : #EffectRouletteTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Effects-Tests'
}

{ #category : #'as yet unclassified' }
EffectRouletteTest >> effectsWithProbabilities [

	| atomicBomb speedUp wormHole moonWalk noEffect effectRouletteBuilder pickUpCard |
	atomicBomb := AtomicBomb new.
	speedUp := SpeedUp new.
	wormHole := WormHole new.
	moonWalk := MoonWalk maxBackwards: 5.
	pickUpCard:= PickUpCard new.
	noEffect := NoEffect new.
	effectRouletteBuilder:= EffectRouletteBuilder buildingProbabilisticRoulette.
	
	effectRouletteBuilder add: atomicBomb withPercentage:10.
	effectRouletteBuilder add: speedUp withPercentage:20.
	effectRouletteBuilder add: wormHole withPercentage:20.
	effectRouletteBuilder add: moonWalk withPercentage:10.
	effectRouletteBuilder add: pickUpCard  withPercentage:10.
	effectRouletteBuilder add: noEffect withPercentage:38.
	
	^effectRouletteBuilder buildProbabilistic .
]

{ #category : #tests }
EffectRouletteTest >> testSpinEffectRouletteDeterministic [

	| effectRoulette effectRouletteBuilder|
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new;
								add: AtomicBomb new;
								add: PickUpCard new;
								add: AtomicBomb new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	
	self assert: effectRoulette spin equals: NoEffect new;
		assert: effectRoulette spin equals: AtomicBomb new;
		assert: effectRoulette spin equals: PickUpCard new;
		assert: effectRoulette spin equals: AtomicBomb new;
		assert: effectRoulette spin equals: NoEffect new;
		assert: effectRoulette spin equals: AtomicBomb new.
	
]

{ #category : #tests }
EffectRouletteTest >> testSpinEffectRouletteWithProbabilities [

	| effectRoulette  effects |
	effectRoulette:= self effectsWithProbabilities.
	effects:= OrderedCollection new.
	effects 
		add: AtomicBomb new ;
		add: SpeedUp new;
		add: WormHole new ;
		add: (MoonWalk maxBackwards: 5); 
		add: PickUpCard new;
		add: NoEffect new.
	1 to: 100 do: [ :iteration | self assert: (effects includes: effectRoulette spin ) ].
]
