"
I'm Moon Walk, if i am chosen by the Effect Roulette, everybody, except the player who spinned the wheel, goes backwards N positions.

N is a random number between 1 and a number that it's given me when i'm created.
"
Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'maxNumberOfLockersBackwards',
		'numberProvider'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> assertMaxBackwardsGreaterThanZero: aNumber [

	aNumber > 0
		ifFalse: [ InstanceCreationFailed signal: 'MoonWalk must at least be greater than 0' ]
]

{ #category : #'instance creation' }
MoonWalk class >> maxBackwards: aNumberOfLockers [ 
	^ self maxBackwards: aNumberOfLockers source: Random new.

]

{ #category : #'instance creation' }
MoonWalk class >> maxBackwards: aNumberOfLockers aNumberOfLockersSequence: aSequence [ 
	^ self 
		maxBackwards: aNumberOfLockers 
		source: (SequentialNaturalNumberProvider providing: aSequence).

]

{ #category : #'instance creation' }
MoonWalk class >> maxBackwards: aNumberOfLockers source: aNumberProvider [  

	self assertMaxBackwardsGreaterThanZero: aNumberOfLockers .

	^ self new
		initializeMaxBackwards: aNumberOfLockers 
		source: aNumberProvider.

]

{ #category : #playing }
MoonWalk >> applyEffectTo: aPosition  knowing: players and: currentPlayer inThe: game [
	
	self moveAll: players except: currentPlayer inThe: game.
	^ aPosition.
]

{ #category : #'as yet unclassified' }
MoonWalk >> initializeMaxBackwards: aNumberOfLockers source: aNumberProvider [

	maxNumberOfLockersBackwards := aNumberOfLockers.
	numberProvider := aNumberProvider.
]

{ #category : #'as yet unclassified' }
MoonWalk >> moveAll: players except: currentPlayer inThe: game [

	| lockers |
	lockers := self moveBackwards.
	players do: [:player | player ~= currentPlayer ifTrue: [ game moveBackwards: player amountOf: lockers  ] ] .
]

{ #category : #playing }
MoonWalk >> moveBackwards [

	^ numberProvider nextInt: maxNumberOfLockersBackwards. 
]
