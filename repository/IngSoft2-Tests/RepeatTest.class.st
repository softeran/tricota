Class {
	#name : #RepeatTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Cards-Test'
}

{ #category : #playing }
RepeatTest >> buildEffectRouletteWhereSecondEffectIs: anEffect [
| effectRouletteBuilder|
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: PickUpCard new;
				add: anEffect;
				add: NoEffect new.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #running }
RepeatTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Repeat.
	deck := deckBuilder buildDeterministic
]

{ #category : #tests }
RepeatTest >> testRepeatAtomicBomb [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: AtomicBomb new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn."Nico rolled 9 but the effect was atomic bomb, everyone goes to locker 0"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .

	self"Juan throwd repeat of atomic bomb, everyone stays in locker 0"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatMoonWalk [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs:(MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn."Nico rolled 9 and the effect was moonwalk, juan moves 2 lockers backwards"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .
	
	self"Juan threw repeat of moonwalk, nico moves 2 lockers backwards"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatNoEffect [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn."Nico rolled 9 and there was no effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	repeatThrownByJuan := Repeat initializeCardWithTarget: nico.
	game player: juan throw: repeatThrownByJuan .
	
	self"Juan threw repeat of no effect, nothing happens"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatPickUpCard [

	| game repeatThrownByJuan  |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7 and picks up a card"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: juan numberOfCards equals: 3.

	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .
	
	self"Juan threw repeat and picks up another card"
		assert: juan numberOfCards equals: 3.
	

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatSpeedUp [

	| game repeatThrownByJuan |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: SpeedUp  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn."Nico rolled 9 plus 4 for speed up effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .
	
	self"Juan repeats speed up effect and moves 4 lockers forward"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatWormHole [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game nextTurn."Nico rolled 9 minus 4 for wormhole effect"
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	repeatThrownByJuan := Repeat initializeCardWithTarget: nico.
	game player: juan throw: repeatThrownByJuan .
	
	self"Juan repeated wormhole with nico as target, nico moves 4 lockers backwards"
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 1.

	
	
]

{ #category : #tests }
RepeatTest >> testTryToThrowRepeatCardBeforeNobodyRolledDice [

	| game repeatThrownByJuan |

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	
	self "Repeat card cant be throwed if no one roll the dice yet" 
	should: [ game player: juan throw: repeatThrownByJuan ]
		raise: InvalidRequest
		withMessageText: 'Nobody rolled the dice yet'.
		
	
]
