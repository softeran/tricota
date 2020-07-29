"
I'm Current Position, i represent the position in the board and the amount of laps of a certain player.
"
Class {
	#name : #CurrentPosition,
	#superclass : #Object,
	#instVars : [
		'locker',
		'laps'
	],
	#category : #'IngSoft2-Model-Player'
}

{ #category : #'instance creation' }
CurrentPosition class >> atLocker: aLocker atLap: aLap [

	^self new initializeAtLocker: 0 atLap: 0.
]

{ #category : #'instance creation' }
CurrentPosition class >> startingAtZero [

	^self new initializeAtLocker: 0 atLap: 0.
]

{ #category : #comparing }
CurrentPosition >> = anObject [ 
	laps = anObject lapNumber ifFalse: [ ^false ].
	locker = anObject lockerPosition ifFalse: [ ^false ].
 ^true

]

{ #category : #comparing }
CurrentPosition >> >= aCurrentPosition [ 
	laps > aCurrentPosition lapNumber ifTrue: [ ^true].
	laps < aCurrentPosition lapNumber ifTrue: [ ^false].
	locker >= aCurrentPosition  lockerPosition  ifTrue: [ ^true ].
	
 ^false.

]

{ #category : #lap }
CurrentPosition >> assertNoNegativeLap [
	(laps < 0) ifTrue: [ laps:= 0 ]
]

{ #category : #lap }
CurrentPosition >> decreaseLap: number [
	laps:= laps+number.
	self assertNoNegativeLap.
]

{ #category : #comparing }
CurrentPosition >> hash [
	
	^self species hash bitXor: (self  lapNumber hash bitXor: self lockerPosition hash).

]

{ #category : #lap }
CurrentPosition >> increaseLap: numberToIncrease [
	laps:= laps+numberToIncrease.
]

{ #category : #' initialization' }
CurrentPosition >> initializeAtLocker: number atLap: numberOfLaps [
	locker:= number.
	laps:= numberOfLaps.
]

{ #category : #lap }
CurrentPosition >> lapNumber [
	^laps.
]

{ #category : #playerPosition }
CurrentPosition >> lockerPosition [
	^locker
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwards: moveTo [
	
	locker:= moveTo.
	
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsAmountOf: aNumberOflockers knowing: finishline [
	
	
	| nextPosition |

	nextPosition := locker - aNumberOflockers.
	self moveBackwardsTo: nextPosition changingLapIfCrossing: finishline 

	
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsTo: nextPosition changingLapIfCrossing: finishline [ 
	
	(nextPosition < 0)
		ifTrue: [self moveBackwardsTo: nextPosition ifCrosses: finishline]
		ifFalse: [ self moveBackwardsTo: nextPosition ifDoesNotCross: finishline]

]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsTo: nextPosition ifCrosses: finishline [

	| followingPosition|

	(laps > 0 )
		ifTrue: [ 
			followingPosition := (nextPosition\\finishline).
			self moveBackwards: followingPosition.
			self decreaseLap: nextPosition //finishline ]
		ifFalse: [ 
			self moveBackwards: 0.
			 ].
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsTo: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >=0)
		ifTrue: [ self moveBackwards: nextPosition ]
]

{ #category : #'move forward' }
CurrentPosition >> moveForward: moveTo [
	
	locker:= moveTo.
	
]

{ #category : #'move forward' }
CurrentPosition >> moveForwardAmountOf: aNumberOflockers knowing: finishline [
	| nextPosition |

	nextPosition := locker + aNumberOflockers.
	self moveForwardTo: nextPosition changingLapIfCrossing: finishline 

	
]

{ #category : #'move forward' }
CurrentPosition >> moveForwardTo: nextPosition changingLapIfCrossing: finishline [
	
	self moveForwardTo: nextPosition ifDoesNotCross: finishline.
	self moveForwardTo: nextPosition ifCrosses: finishline.

	

	
]

{ #category : #'move forward' }
CurrentPosition >> moveForwardTo: nextPosition ifCrosses: finishLine [

	|lapsToIncrease|
	(nextPosition >= finishLine)
	
		ifTrue: [ 
			lapsToIncrease:= nextPosition //finishLine .
			self moveForward: (nextPosition \\ finishLine).
			self increaseLap: lapsToIncrease  ].
]

{ #category : #'move forward' }
CurrentPosition >> moveForwardTo: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >= finishLine)
		ifFalse: [ self moveForward: nextPosition ]
]

{ #category : #playing }
CurrentPosition >> moveTo: nextPosition knowing: finishline [
	self whenIsGoingForwardMoveTo: nextPosition knowing: finishline.
	self whenIsGoingBackwardsMoveTo: nextPosition knowing: finishline
]

{ #category : #'move backwards' }
CurrentPosition >> whenIsGoingBackwardsMoveTo: nextPosition knowing: finishline [  

	(locker > nextPosition)
	ifTrue: [
		self
			moveBackwardsTo: nextPosition
			changingLapIfCrossing: finishline]
]

{ #category : #'move forward' }
CurrentPosition >> whenIsGoingForwardMoveTo: nextPosition knowing: finishline [ 
	
	(locker < nextPosition)
	ifTrue: [
		self
			moveForwardTo: nextPosition
			changingLapIfCrossing: finishline]
]
