Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardTest >> testIncorrectBoardInicialization [

	-1 to: 1 do: [ :number | 
		self
			should: [ Board withLockers: number]
			raise: InstanceCreationFailed
			withMessageText: 'Board must have at least two lockers' ]
]

{ #category : #tests }
BoardTest >> testInitializeBoardWithLockers [

	| board |
	board:= Board withLockers: 60.
	self assert: board finishLine equals:60.
	
]
