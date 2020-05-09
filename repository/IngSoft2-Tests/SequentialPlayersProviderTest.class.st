Class {
	#name : #SequentialPlayersProviderTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

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

	self
		should: [ SequentialPlayersProvider providing: #() ]
		raise: InstanceCreationFailed
		withMessageText: 'Not enough players. Need at least 2 players'.
		
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
