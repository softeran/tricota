Class {
	#name : #HappyPathTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'nico',
		'players',
		'die',
		'effectRoulette',
		'effects',
		'noEffect',
		'cards',
		'sofi',
		'deck'
	],
	#category : #'IngSoft2-Tests-Happy-Test'
}

{ #category : #accessing }
HappyPathTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
HappyPathTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
HappyPathTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
HappyPathTest >> setUp [
	|effectRouletteBuilder deckBuilder|
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration  ;
					add: Cancellation ;
					add: Speed ;
					add: Overload ;
					add: Repeat ;
					add: Reversal ;
					add: Redo ;
					add: Redo .
	deck:= deckBuilder buildDeterministic .
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new;
								add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(3));
								add: NoEffect new;
								add: PickUpCard new;
								add: PickUpCard new;
								add: AtomicBomb new;
								add: WormHole new;
								add: NoEffect new;
								add: PickUpCard new;
								add: PickUpCard new;
								add: PickUpCard new;
								add: WormHole new.
	effectRoulette:= effectRouletteBuilder buildDeterministic.
	
	die := Die of: 11 rolling: #(7 9 10 4 5 7 8 3 9 10 10 2 ).
	juan := self juan.
	nico := self nico.
	sofi:= self sofi.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico;
		add: sofi.

]

{ #category : #accessing }
HappyPathTest >> sofi [
	^ self playerNamed: 'Sofi'.
]

{ #category : #tests }
HappyPathTest >> testHappyPath [

| game accelerationCardThrownByJuan speedCardThrownByNico  reversalCardThrownBySofi|
	
	game:= UCABoardGame rolling: die with: players lockers: 15 laps: 2 effects: effectRoulette and: deck.
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	game nextTurn.	"In this Turn Juan rolled 7 and the effect was speed up"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	game player: sofi throw: (Repeat initializeCardWithTarget: sofi). "Sofi threw a Repeat Card and the last effect was SpeedUp"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 4.
		
	game nextTurn. "In this Turn Nico rolled 9 and the effect was MoonWalk. Everyone except Nico goes three lockers backwards"

	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 1.
		
	game nextTurn."In this Turn Sofi rolled 10 and the effect was No effect"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 11.
	
	accelerationCardThrownByJuan := Acceleration initializeCard .
	game player: juan throw: (accelerationCardThrownByJuan).
	game nextTurn. "In this Turn Juan rolled 4 and the effect was Pick Up card. He picked up a Reversal Card. As the Acceleration Card is active, he moves 5 lockers forward"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:0;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lockerNumberOf: nico) equals: 9;
		assert: (game lockerNumberOf: sofi) equals: 11.
	
	speedCardThrownByNico := Speed initializeCardWithTarget: nico.
	game player: nico throw: speedCardThrownByNico.
	game player: nico throw:(Overload initializeCardWithTarget: juan).
	game nextTurn. "In this Turn Nico rolled 5 and the effect was Pick Up card. He picked up a Redo Card. Nico moves 7 lockers forward because of the speed card and the acceleration card"
		
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lockerNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: sofi) equals: 11.
		
	game nextTurn. "In this Turn Sofi rolled 7 and the effect was Atomic Bomb. Sofi moves 8 lockers forward because of the acceleration card and changes lap to 1. But then she moves to locker zero at lap 1 because of the atomic bomb effect"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
		
	game player: juan throw:(Cancellation initializeCardWithTarget: speedCardThrownByNico) .
	game nextTurn. "In this Turn Juan rolled 8 and the effect was WormHole.As the Acceleration card and an Overload Card are active he only endsup moving 3 lockers forward "
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game nextTurn. "In this Turn Nico rolled 3 and the effect was No effect. As there is an acceleration card active , he moves 4 lockers forward"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 4;
		assert: (game lockerNumberOf: sofi) equals: 0.
	game player: nico throw:(Redo initializeCardWithTarget: accelerationCardThrownByJuan)."Cancellation of Acceleration"
		
	game nextTurn. "In this Turn Sofi rolled 9 and the effect was Pick Up card. She picked up a Reversal Card."
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals: 3;
		assert: (game lockerNumberOf: nico) equals: 4;
		assert: (game lockerNumberOf: sofi) equals: 9.
		
	game nextTurn. "In this Turn Juan rolled 10 and the effect was Pick Up card. He picked up a Reversal Card. As tehre is an Overload card active , he moves forward 8 lockers"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals:11;
		assert: (game lockerNumberOf: nico) equals: 4;
		assert: (game lockerNumberOf: sofi) equals: 9.
		
	game nextTurn. "In this Turn Nico rolled 10 and the effect was Pick Up card."
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:1;
		assert: (game lockerNumberOf: juan) equals:11;
		assert: (game lockerNumberOf: nico) equals: 14;
		assert: (game lockerNumberOf: sofi) equals: 9.
		
		reversalCardThrownBySofi := Reversal initializeCardWithTarget: (LockerTarget atLocker: 11).
		game player: sofi throw: reversalCardThrownBySofi.
		game nextTurn. "In this Turn Sofi rolled 2 and the effect was WormHole with a Reversal Card applied to it.So she moves 4 more lockers forwards and wins de game"
	self 
		assert: (game lapNumberOf: juan) equals:0;
		assert: (game lapNumberOf: nico) equals:1;
		assert: (game lapNumberOf: sofi) equals:2;
		assert: (game lockerNumberOf: juan) equals:11;
		assert: (game lockerNumberOf: nico) equals: 14;
		assert: (game lockerNumberOf: sofi) equals: 0;
		assert: game winner equals: sofi.

	
	




	
]
