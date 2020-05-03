Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
PlayerTest >> testInitializePlayerName [
 	| player |
	player:= Player initializeWithName: 'Juan'.
	self assert: player named equals: 'Juan'.
]

{ #category : #tests }
PlayerTest >> testPlayerNameMustBeNonEmptyString [

 	
	self
		should: [ Player initializeWithName: '']
		raise: InstanceCreationFailed
		withMessageText: 'Name must not be an empty string'.
]
