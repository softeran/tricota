Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
PlayerTest >> testInitializePlayerName [
 	| player |
	player:= Player named: 'Juan'.
	self assert: player nameIs equals: 'Juan'.
]

{ #category : #tests }
PlayerTest >> testPlayerNameMustBeNonEmptyString [

 	
	self
		should: [ Player named: '']
		raise: InstanceCreationFailed
		withMessageText: 'Name must not be an empty string'.
]
