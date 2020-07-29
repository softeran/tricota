Class {
	#name : #LockerTarget,
	#superclass : #Object,
	#instVars : [
		'numberOfLocker'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
LockerTarget class >> atLocker: aLocker [
 ^self new intializeAtLocker: aLocker .

]

{ #category : #'as yet unclassified' }
LockerTarget >> intializeAtLocker: aLocker [ 
 numberOfLocker:= aLocker.
]

{ #category : #testing }
LockerTarget >> is: aLocker [
	^false. 
]

{ #category : #'as yet unclassified' }
LockerTarget >> number [ 
^numberOfLocker.
]
