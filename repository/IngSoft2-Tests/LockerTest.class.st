Class {
	#name : #LockerTest,
	#superclass : #TestCase,
	#instVars : [
		'board',
		'die',
		'juan',
		'nico',
		'players'
	],
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #accessing }
LockerTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
LockerTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #accessing }
LockerTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
LockerTest >> setUp [

	
	die := Die of: 10 rolling: #(7 4 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
LockerTest >> testAAAAAAAAAAAAAAAAAAAAAAA [

	| locker game lockers|
	
	locker:= Locker atPosition: 7 withEffect: WormHole new.
	lockers:= OrderedCollection new.
	lockers 
			add:locker.
	board := Board withLockers: 60 andLaps: 2 withEffects: lockers.
	
	game:= UCABoardGame rolling: die on: board with: players.
	game nextTurn.
	self assert: juan lockerPosition equals: 3.
	
]
