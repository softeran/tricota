Class {
	#name : #CurrentPositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
CurrentPositionTest >> testEqualsPlayersOnAPosition [

| position1 position2 |
position1:=CurrentPosition atLocker: 4 atLap: 2.
position2:= CurrentPosition  atLocker: 4 atLap: 2.

self assert: position1 = position2.
]
