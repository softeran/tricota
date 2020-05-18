"
I'm Board!
I am given an amount of lockers (greater than 1), a number of laps (grearte than 0) and a Effect Roulette when created.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'lockers',
		'laps',
		'effectRoulette'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
Board class >> assertIsGreaterThanOne: aNumberOfLockers [

	aNumberOfLockers > 1
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least two lockers' ]
	
]

{ #category : #'instance creation' }
Board class >> assertIsGreaterThanZero: aNumberOfLaps [

	aNumberOfLaps> 0
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least one lap' ]
	
]

{ #category : #instanceCreation }
Board class >> withLockers: lockers andLaps: laps withEffects: effects [ 
	self assertIsGreaterThanOne: lockers.
	self assertIsGreaterThanZero: laps.
	^self new initializeWithLockers: lockers andLaps: laps withEffects: effects .
]

{ #category : #playing }
Board >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: game [
	^ effectRoulette spin applyEffectTo: aPosition  knowing: players  and: aCurrentPlayer inThe: game.
]

{ #category : #finish }
Board >> finishLine [
	^lockers.
]

{ #category : #initialization }
Board >> initializeWithLockers: anAmountOfLockers andLaps: anAmountOfLaps withEffects: aEffectRoulette [
	
	lockers:= anAmountOfLockers.
	laps:= anAmountOfLaps.
	effectRoulette:= aEffectRoulette.
]

{ #category : #lap }
Board >> lapsToWin [
	^laps.
]
