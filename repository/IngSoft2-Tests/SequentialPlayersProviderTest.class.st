Class {
	#name : #SequentialPlayersProviderTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Test'
}

{ #category : #tests }
SequentialPlayersProviderTest >> collectionWithOnePlayer [
	| players juan |
	juan := Player named: 'Juan'.
	players := OrderedCollection new.
	players add: juan.
	^ players
]

{ #category : #tests }
SequentialPlayersProviderTest >> players [

	| players juan nico |
	juan := Player named: 'Juan'.
	nico := Player named: 'Nico'.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	^players.
	
]

{ #category : #tests }
SequentialPlayersProviderTest >> testCreationFailsWithLessThanTwoPlayersSequence [
	| onlyOnePlayer|
	onlyOnePlayer := self collectionWithOnePlayer.
	self
		should: [ SequentialPlayersProvider providing: #() ]
		raise: InstanceCreationFailed
		withMessageText: 'Not enough players. Need at least 2 players'.
	self
		should: [ SequentialPlayersProvider providing: onlyOnePlayer ]
		raise: InstanceCreationFailed
		withMessageText: 'Not enough players. Need at least 2 players'
]

{ #category : #tests }
SequentialPlayersProviderTest >> testProvidingPlayers [

	| provider players |

	players:= self players.
	provider := SequentialPlayersProvider providing: players.
	self assert: (provider nextPlayer) equals: (players at:1);
		assert: (provider nextPlayer ) equals: (players at:2);
		assert: (provider nextPlayer ) equals: (players at:1).
		
]
