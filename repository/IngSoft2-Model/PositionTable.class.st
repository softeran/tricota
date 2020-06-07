"
I'm a Position Table! I display the list of players taking into account the players positions.
If two players or more are in the same lap, i compare their positions to know who is first.
"
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
	
	table:= SortedCollection sortBlock: [:player1 :player2 | (players at: player1) >= (players at: player2) ].
	players keysAndValuesDo: [ :player :position | table add: player ].
	
]
