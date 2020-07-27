Class {
	#name : #CurrentPositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
CurrentPositionTest >> testEqualsPlayersOnAPosition [

	| position1 position2 |
	position1:= CurrentPosition atLocker: 4 atLap: 2.
	position2:= CurrentPosition  atLocker: 4 atLap: 2.

	self assert: position1 equals: position2.
]
