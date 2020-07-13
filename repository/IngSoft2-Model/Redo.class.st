Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Redo >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	|lastCard|
	lastCard := (game lastCardPlayed) class card: card target: target .
	lastCard applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game
]
