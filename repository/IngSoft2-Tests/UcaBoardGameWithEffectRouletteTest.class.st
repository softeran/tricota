Class {
	#name : #UcaBoardGameWithEffectRouletteTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'deck'
	],
	#category : #'IngSoft2-Tests-Effects-Test'
}

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
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

	|deckBuilder|

	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Speed ;
					add: Acceleration ;
					add: Speed ;
					add: Repeat ;
					add: Overload .
	deck:= deckBuilder buildDeterministic .
	
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testAtomicBombMaintaningLaps [

	| game effectRoulette |
	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: AtomicBomb new.
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	game nextTurn."Juan rolled 7, changes to lap 1. The effect was Atomic bomb so everyone goes to locker 0"
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testDeterministicPickUpCardEffect [

	| game effectRoulette |

	effectRoulette := self aEffectRouletteWith100ProbabilityOf: (PickUpCard new).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2;
		assert: (juan assertHasCard: Acceleration initializeCard );
		assert: (juan assertHasCard: Speed initializeCard );
	 	assert: nico numberOfCards equals: 2;
		assert: (juan assertHasCard: Acceleration initializeCard );
		assert: (juan assertHasCard: Speed initializeCard ).
	
	game nextTurn. "The effect of this turn was PickUpCard. The card juan picked up was Repeat"
	self assert: juan numberOfCards equals: 3.
	self assert: (juan assertHasCard: Repeat initializeCard ).

	game nextTurn. "The effect of this turn was PickUpCard. The card nico picked up was Repeat"
	self assert: nico numberOfCards equals: 3.
	self assert: (nico assertHasCard: Overload initializeCard ).
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testMoonWalkMovesEveryoneExceptCurrentPlayer [

	| game effectRoulette sofi effectRouletteBuilder |

	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: NoEffect new;
				add: NoEffect new;
				add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2 4)).
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	sofi := Player named: 'Sofi'.
	players add: sofi.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn."Juan rolled 7 and the effect was no effect"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn."Nico rolled 9 and the effect was no effect"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn."Sofi rolled 3 and the effect was Moonwalk, everyone except sofi moves 2 lockers backwards"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lockerNumberOf: nico) equals: 7;
		assert: (game lockerNumberOf: sofi) equals: 3.
		
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testMoonWalkMovesEveryoneExceptCurrentPlayerChangingLapIfPlayerIsInLapOneOrMore [

	| game effectRoulette sofi effectRouletteBuilder |

	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: NoEffect new;
				add: NoEffect new;
				add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2 4)).
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	sofi := Player named: 'Sofi'.
	players add: sofi.
	game:= UCABoardGame rolling: die with: players lockers: 8 laps: 2 effects: effectRoulette and: deck.
	game nextTurn."Juan rolled 7 and the effect was no effect"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn."Nico rolled 9 and the effect was no effect. He changes lap to 1"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lockerNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn."Sofi rolled 3 and the effect was Moonwalk, everyone except sofi moves 2 lockers backwards. Nico that was in lap 1 changes to lap 0"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lockerNumberOf: nico) equals: 7;
		assert: (game lockerNumberOf: sofi) equals: 3.
		
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testMoonWalkNoNegativeLap [

	| game effectRoulette |

	effectRoulette := self aEffectRouletteWith100ProbabilityOf: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
	
	self "Juan rolled 7 and the effect was Moonwalk, everyone except juan moves 2 lockers backwards. Nico that was in lap 0 locker 0, stays there because lap -1 doesnt exists"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testSpeedUp [

	| game effectRoulette |

	effectRoulette := self aEffectRouletteWith100ProbabilityOf: SpeedUp  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
	
	self "Juan rolled 7 and the effect was SpeedUp so he moves 11 lockers forward"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWinGameAfterSpeedUpEffect [

	| game effectRoulette effectRouletteBuilder |

	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
			add: NoEffect new;
			add: NoEffect new;
			add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
	self "Juan rolled 7 and changes lap to 1"
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn."Nico rolled 9 and changes lap to 1"
	self 
		assert: (game lapNumberOf: juan) equals:1;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 3.
	game nextTurn.
	self "Juan rolled 3 and the effect was Speed Up. Moves 7 lockers forward and win the game due to SpeedUp effect"
		assert: (game lapNumberOf: juan) equals:2;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lockerNumberOf: juan) equals: 2;
		assert: (game lockerNumberOf: nico) equals: 3.
	self assert: game winner equals: juan.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHole [

	| game effectRoulette |

	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
	
	self "Juan rolled 7 and the effect was WormHole. He moves forward 3 lockers"
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 0.
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHoleChangingLapIfPlayerIsInLapOneOrMore [

	| game effectRoulette |

	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 5 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
	
	self "Juan rolled 7 and he would be in lap 1 locker 2, but the effect was Worm hole so he move backwards 4 lockers and is back in lap 0"
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	
]

{ #category : #tests }
UcaBoardGameWithEffectRouletteTest >> testWormHoleNoNegativeLap [

	| game effectRoulette |

	die := Die of: 10 rolling: #(2).	
	effectRoulette := self aEffectRouletteWith100ProbabilityOf: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
	
	self "Juan rolled 2 and the effect is wormhole. No one can further back than lap 0 locker 0 so he stays there"
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
]
