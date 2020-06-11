Class {
	#name : #UcaBoardGameWithEffectRouletteTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players'
	],
	#category : #'IngSoft2-Tests-Effects-Tests'
}

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	"aSequenceOfEffects := OrderedCollection new.
	aSequenceOfEffects add: effect.
	effectRoulette := EffectRouletteBuilder new with: aSequenceOfEffects."
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
UcaBoardGameWithEffectRouletteTest >> setUp [

	
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testAccelerationCard [

	| game effectRoulette effectRouletteBuilder |
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: PickUpCard new;
				add: NoEffect  new;
				add: NoEffect  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game player: juan throw: Acceleration new.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 17.
	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testAtomicBomb [

	| game effectRoulette |
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: AtomicBomb new.
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testMoonWalkaaaaaaaaaaaaaaaaaaaaaaaaaa [

	| game effectRoulette  sofi effectRouletteBuilder|
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: NoEffect new;
				add: NoEffect new;
				add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2 4)).
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	sofi := Player named: 'Sofi'.
	players add: sofi.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	game nextTurn.
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn.
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lockerNumberOf: nico) equals: 7;
		assert: (game lockerNumberOf: sofi) equals: 3.
		
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testMoonWalkbbbbbbbbbbbbbbbbbbbb [

	| game effectRoulette |
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	
	self assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testPickUpCard [

	| game effectRoulette |
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: PickUpCard new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	
	self assert: juan numberOfCards equals: 1.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testRepeatMoonWalk [

	| game effectRoulette effectRouletteBuilder|
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: PickUpCard new;
				add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2));
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	
	game nextTurn.
	self assert: juan numberOfCards equals: 1.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	game player: juan throw: Repeat new to: juan.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.

	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testRepeatNoEffect [

	| game effectRoulette  effectRouletteBuilder|
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
			add: PickUpCard new;
			add: NoEffect new;
			add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	
	game nextTurn.
	self assert: juan numberOfCards equals: 1.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	game player: juan throw: Repeat new to: nico.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testRepeatSpeedUp [

	| game effectRoulette effectRouletteBuilder|

	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add:PickUpCard new;
				add: SpeedUp  new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	
	game nextTurn.
	self assert: juan numberOfCards equals: 1.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.
	game player: juan throw: Repeat new to: juan.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testRepeatWormHole [

	| game effectRoulette effectRouletteBuilder|
	
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add:PickUpCard new;
				add: WormHole   new;
				add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	
	game nextTurn.
	self assert: juan numberOfCards equals: 1.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
	game player: juan throw: Repeat new to: nico.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 1.

	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testSpeedUp [

	| game effectRoulette |
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: SpeedUp  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	
	self assert: (game lockerNumberOf: juan) equals: 11.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testSpeedUpAndWinaaaaaaaaaaaaaaaaaaaaaaaa [

	| game effectRoulette effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
			add: NoEffect new;
			add: NoEffect new;
			add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	game nextTurn.
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 3.
	game nextTurn.
	self assert: game winner equals: juan.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHole [

	| game effectRoulette |
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	
	self assert: (game lockerNumberOf: juan) equals: 3.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHoleDecreasingLap [

	| game effectRoulette |
	
	die := Die of: 10 rolling: #(2).	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 andEffects: effectRoulette.
	game nextTurn.
	
	self assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0.
	
]
