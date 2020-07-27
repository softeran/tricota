Class {
	#name : #InstantCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
InstantCard >> applyIn: game [
	
	|typeLastCard|
	typeLastCard := type applyIn: game to: target.
	game typeLastCardPlayed: typeLastCard .

]

{ #category : #playing }
InstantCard >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	type thrownBy: aPlayer inTheTurnOf: playerTurn 
]
