"
I'm Moon Walk, if i am chosen by the Effect Roulette, everybody, except the player who spinned the wheel, goes backwards N positions.

N is a random number between 1 and a number that it's given me when i'm created.
"
Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'maxNumberOfLockersBackwards',
		'numberProvider'
	],
	#category : #'IngSoft2-Model-Effects'
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
MoonWalk >> applyEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [
	
	self moveAll: players except: currentPlayer knowing: finishline.
	^ aPosition.
]

{ #category : #initialization }
MoonWalk >> initializeMaxBackwards: aNumberOfLockers source: aNumberProvider [

	maxNumberOfLockersBackwards := aNumberOfLockers.
	numberProvider := aNumberProvider.
]

{ #category : #playing }
MoonWalk >> moveAll: players except: currentPlayer knowing: finishline [

	| lockers |
	lockers := self moveBackwards.
	players keysAndValuesDo: [:player :position | player ~= currentPlayer ifTrue: [ position moveBackwardsAmountOf: lockers knowing: finishline] ] .
]

{ #category : #playing }
MoonWalk >> moveBackwards [

	^ numberProvider nextInt: maxNumberOfLockersBackwards. 
]
