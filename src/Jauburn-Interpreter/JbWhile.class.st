Class {
	#name : #JbWhile,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements',
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #api }
JbWhile >> call: arguments in: callEnvironment [

	condition whileTrue: [ trueStatements do: [ :each | each executeIn: environment ] ]
]

{ #category : #accessing }
JbWhile >> condition [
	^ condition
]

{ #category : #accessing }
JbWhile >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
JbWhile >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbWhile >> trueStatements: anObject [
	trueStatements := anObject
]
