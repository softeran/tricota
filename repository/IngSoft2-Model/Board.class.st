Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'lockers',
		'laps',
		'effects'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
Board class >> assertIsGraterThanCero: aNumberOfLaps [

	aNumberOfLaps> 0
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least one lap' ]
	
]

{ #category : #'instance creation' }
Board class >> assertIsGraterThanTwo: aNumberOfLockers [

	aNumberOfLockers > 1
		ifFalse: [ InstanceCreationFailed signal: 'Board must have at least two lockers' ]
	
]

{ #category : #'instance creation' }
Board class >> withLockers: numberOfLockers andLaps: numberOfLaps [

	self assertIsGraterThanTwo: numberOfLockers.
	self assertIsGraterThanCero: numberOfLaps.
	
	^self new initializeWithLockers: numberOfLockers andLaps: numberOfLaps.
]

{ #category : #instanceCreation }
Board class >> withLockers: anInteger andLaps: anInteger2 withEffects: aCollection [ 
	^self new initializeWithLockers: anInteger andLaps: anInteger2 withEffects: aCollection.
]

{ #category : #playing }
Board >> applyEffectOf: aPosition [
	effects detect: [ :lockerWithEffect | lockerWithEffect position  = aPosition ]  				
					ifFound: [:lockerWithEffect | lockerWithEffect applyEffect]  
									
					ifNone: [false].
		
]

{ #category : #playing }
Board >> applyEffectTo: position [  
	^ effects spin applyEffectTo: position .
]

{ #category : #playing }
Board >> applyEffectTo: aPosition knowing: players and: aCurrentPlayer inThe: game [
	^ effects spin applyEffectTo: aPosition  knowing: players  and: aCurrentPlayer inThe: game.
]

{ #category : #finish }
Board >> finishLine [
	^lockers.
]

{ #category : #'instance initialization' }
Board >> initializeWithLockers: numberOfLockers andLaps: numberOfLaps [
	lockers:= numberOfLockers.
	laps:= numberOfLaps.
]

{ #category : #initialization }
Board >> initializeWithLockers: anInteger andLaps: anInteger2 withEffects: lockersWithEffects [
	
	lockers:= anInteger.
	laps:= anInteger2.
	effects:= lockersWithEffects.
]

{ #category : #lap }
Board >> lapsToWin [
	^laps.
]
