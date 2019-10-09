Class {
	#name : #JbWhileNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileNode >> condition: anObject [
	condition := anObject
]

{ #category : #api }
JbWhileNode >> evaluateIn: anEnvironment [ 
	| newWhile |
	newWhile := JbWhile new.
	newWhile condition: self condition.
	newWhile environment: anEnvironment.
	newWhile trueStatements: (trueStatements collect: [ :each | each identifier ]).
	^newWhile
]

{ #category : #accessing }
JbWhileNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbWhileNode >> trueStatements: anObject [
	trueStatements := anObject
]
