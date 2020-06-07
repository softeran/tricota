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

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
SequentialPlayersProvider >> initializeProviding: aSequence [

	sequence := (CircularIterator cyclingOver: aSequence ) 
]

{ #category : #providing }
SequentialPlayersProvider >> nextPlayer [

	| next |
	next := sequence current.
	sequence next.
	^ next
]
