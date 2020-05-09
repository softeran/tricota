Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardTest >> testIncorrectBoardInicialization [

	-1 to: 1 do: [ :number | 
		self
			should: [ Board withLockers: number andLaps: 2]
			raise: InstanceCreationFailed
			withMessageText: 'Board must have at least two lockers' ].
		
		-1 to: 0 do: [ :number | 
		self
			should: [ Board withLockers: 60 andLaps: number]
			raise: InstanceCreationFailed
			withMessageText: 'Board must have at least one lap' ].
]

{ #category : #tests }
BoardTest >> testInitializeBoardWithLockers [

	| board |
	board:= Board withLockers: 60 andLaps: 2.
	self assert: board finishLine equals:60.
	
]
