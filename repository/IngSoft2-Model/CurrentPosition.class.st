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

{ #category : #accessing }
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
CurrentPosition >> decreaseLap [
	laps:= laps-1.
]

{ #category : #'move forward' }
CurrentPosition >> forwardTo: nextPosition changingLapIfCrossing: finishline [
	
	self moveForwardTo: nextPosition ifDoesNotCross: finishline.
	self moveForwardTo: nextPosition ifCrosses: finishline.

	

	
]

{ #category : #comparing }
CurrentPosition >> hash [
	
	^self species hash bitXor: (self  lapNumber hash bitXor: self lockerPosition hash).

]

{ #category : #lap }
CurrentPosition >> increaseLap [
	laps:= laps+1.
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

{ #category : #playerPosition }
CurrentPosition >> moveBackwards: moveTo [
	
	locker:= moveTo.
	
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsAmountOf: aNumberOflockers knowing: finishline [
	
	
	| nextPosition |

	nextPosition := locker - aNumberOflockers.
	self moveBackwardsTo: nextPosition ifDoesNotCross: finishline.
	self moveBackwardsTo: nextPosition ifCrosses: finishline.

	
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsTo: nextPosition changingLapIfCrossing: finishline [ 
		
	self moveBackwardsTo: nextPosition ifDoesNotCross: finishline.
	self moveBackwardsTo: nextPosition ifCrosses: finishline.

]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsTo: nextPosition ifCrosses: finishLine [

	| followingPosition|

	(nextPosition < 0 and: laps > 0 )
		ifTrue: [ 
			followingPosition := finishLine + nextPosition.
			self moveBackwards: followingPosition.
			self decreaseLap].
	(nextPosition < 0 and: (laps == 0 ))
		ifTrue: [ 
			self moveBackwards: 0.
			 ].
]

{ #category : #'move backwards' }
CurrentPosition >> moveBackwardsTo: nextPosition ifDoesNotCross: finishLine [

	(nextPosition >=0)
		ifTrue: [ self moveBackwards: nextPosition ]
]

{ #category : #playerPosition }
CurrentPosition >> moveForward: moveTo [
	
	locker:= moveTo.
	
]

{ #category : #'move forward' }
CurrentPosition >> moveForwardTo: nextPosition ifCrosses: finishLine [

	(nextPosition >= finishLine)
	
		ifTrue: [ self moveForward: (nextPosition - finishLine).
			self increaseLap ].
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
			forwardTo: nextPosition
			changingLapIfCrossing: finishline]
]
