Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardTest >> testIncorrectBoardInicialization [

	-1 to: 1 do: [ :number | 
		self
			should: [ Board initializeWithLockers: number]
			raise: InstanceCreationFailed
			withMessageText: 'Board must have at least two lockers' ]
]

{ #category : #tests }
BoardTest >> testInitializeBoardWithLockers [

	| board |
	board:= Board initializeWithLockers: 60.
	self assert: board finishLine equals:60.
	
]
