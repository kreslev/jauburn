"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'myTranscript',
		'myInput'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^#abs -> [ :num | num abs ]
]

{ #category : #primitives }
JbInterpreter >> asNumBinding [
	^#asNum -> [ :value | value asNumber ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^#concat -> [ :value :value2 | value, value2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	myTranscript := MockTranscript new.
	myInput := MockInput new.
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding bindingMethod |
				binding := self perform: s.
				bindingMethod := JbPrimitive new block: binding value.
				environment at: binding key put: bindingMethod ].
]

{ #category : #primitives }
JbInterpreter >> inputBinding [

	^#input -> [ :value | myInput inputMethod: value.
		myInput transcript. ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^#length -> [ :str | str size ]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^#mod -> [ :value1 :value2 | value1 \\ value2 ]
]

{ #category : #accessing }
JbInterpreter >> myInput [
	^myInput 
]

{ #category : #accessing }
JbInterpreter >> myTranscript [
	^myTranscript 
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^#not -> [ :value | value
		ifTrue: [ false ]
		ifFalse: [ true ] ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [

	^#print -> [ :value | myTranscript transcript: value asString ]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [

	^ #println
		-> [ :value | 
			myTranscript
				transcript: (value asString, Character cr asString) ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]
