Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'transcript'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
MockTranscript >> transcript [
	^ transcript
]

{ #category : #accessing }
MockTranscript >> transcript: anObject [
	transcript := anObject
]
