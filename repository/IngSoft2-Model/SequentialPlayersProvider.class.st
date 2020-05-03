Class {
	#name : #SequentialPlayersProvider,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
SequentialPlayersProvider class >> assertOnlyPlayersIn: aSequence [

	(aSequence
		anySatisfy:
			[ :player | (player class) = Player ])
		ifFalse: [ InstanceCreationFailed
				signal: 'Sequence must have only players' ]
]

{ #category : #'instance creation' }
SequentialPlayersProvider class >> providing: aSequence [

	aSequence size < 2
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough players. Need at least 2 players' ].
	self assertOnlyPlayersIn: aSequence.

	^ self new initializeProviding: aSequence
]

{ #category : #playing }
SequentialPlayersProvider >> haveReached: finishLine [ 
	^ sequence haveReached: finishLine 
]

{ #category : #initialization }
SequentialPlayersProvider >> initializeProviding: aSequence [

	sequence := (CircularIterator cyclingOver: aSequence ) 
]

{ #category : #'tests - sequence isempty' }
SequentialPlayersProvider >> isEmpty [
	^ sequence isEmpty .
]

{ #category : #providing }
SequentialPlayersProvider >> nextPlayer [

	| next |
	next := sequence current.
	sequence next.
	^ next
]

{ #category : #playing }
SequentialPlayersProvider >> playersPositions [
	^ sequence playersPositions.
]

{ #category : #reset }
SequentialPlayersProvider >> resetPosition [
	sequence resetPosition.
]
