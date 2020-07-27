"
I represent a sequence of players
I am given a sequence of players when created.

 
"
Class {
	#name : #SequentialPlayersProvider,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
SequentialPlayersProvider class >> enoughPlayers: aSequence [

	aSequence size < 2
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough players. Need at least 2 players' ].
]

{ #category : #'instance creation' }
SequentialPlayersProvider class >> providing: aSequence [

	self enoughPlayers: aSequence.

	^ self new initializeProviding: aSequence
]

{ #category : #playing }
SequentialPlayersProvider >> changeCourse [
	sequence changeCourse.
]

{ #category : #initialization }
SequentialPlayersProvider >> initializeProviding: aSequence [

	sequence := (CircularIterator cyclingOver: aSequence ).

]

{ #category : #providing }
SequentialPlayersProvider >> nextPlayer [
	| nextPlayer |
	nextPlayer := sequence current.
	sequence next.
	^ nextPlayer
]

{ #category : #providing }
SequentialPlayersProvider >> nextPlayerWithoutChangingCurrent [

	^ sequence current 
]
