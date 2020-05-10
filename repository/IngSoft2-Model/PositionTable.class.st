Class {
	#name : #PositionTable,
	#superclass : #Object,
	#instVars : [
		'table'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
PositionTable class >> filledWith: players [ 
	
	^ PositionTable new initializeFilledWith: players.
	
]

{ #category : #index }
PositionTable >> atPosition: anIndex [
	^ table at: anIndex.
]

{ #category : #initialization }
PositionTable >> initializeFilledWith: players [
	
	table:= SortedCollection sortBlock: [:player1 :player2 | player1 currentPosition >= player2 	currentPosition ].
	players do: [ :player | table add: player ].
]
