Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
PlayerTest >> testIncorrectPlayerInicialization [

 	| player |
	self
		should: [ Player yourNameIs: 3  ]
		raise: InstanceCreationFailed
		withMessageText: 'Name must be a string'
]

{ #category : #tests }
PlayerTest >> testInitializePlayer [
 	| player |
	player:= Player yourNameIs: 'Juan'.
	self assert: player sayYourName equals: 'Juan'.
]
