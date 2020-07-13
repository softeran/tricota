Class {
	#name : #Cancellation,
	#superclass : #Card,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Cancellation >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	game lastCardPlayed: self.
	^ self removeCardFrom: activeCards.
	
]

{ #category : #playing }
Cancellation >> removeCardFrom: activeCards [
	activeCards
		doWithIndex: [ :currentCard :i | 
			(currentCard = card and: currentCard target = target)
				ifTrue: [ activeCards removeAt: i.
					^ true ] ]
]
