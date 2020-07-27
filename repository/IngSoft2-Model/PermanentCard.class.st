Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
PermanentCard >> applyIn: game [ 
	
	game savePermanentCard: self.
	game typeLastCardPlayed: type.
]

{ #category : #playing }
PermanentCard >> effect: aPlayer [ 
	
	|lockers|
	lockers := 0.
	(target is: aPlayer) 
		ifTrue:[lockers:=type effect: aPlayer].
	^lockers
]

{ #category : #playing }
PermanentCard >> thrownBy: aPlayer inTheTurnOf: playerTurn [ 
	aPlayer = playerTurn 
		ifFalse: [ InvalidRequest signal: 'It is not your turn' ]
]
