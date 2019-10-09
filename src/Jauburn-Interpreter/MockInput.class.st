Class {
	#name : #MockInput,
	#superclass : #Object,
	#instVars : [
		'transcript'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #'as yet unclassified' }
MockInput >> inputMethod: aValue [
	| input |
	input := UIManager default request: aValue.
	self transcript: input.
	^input
]

{ #category : #accessing }
MockInput >> transcript [
	^ transcript
]

{ #category : #accessing }
MockInput >> transcript: anObject [
	transcript := anObject
]
