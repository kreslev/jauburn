"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #'as yet unclassified' }
JbSamplePrograms >> greatestCommon [
	| programString |
	programString := 'function(a, b){if(b==0){return a} var t=b; b=mod(a, b); a=t; gcd(a, b);};'.
	^programString
]

{ #category : #'as yet unclassified' }
JbSamplePrograms >> squareRootNewton [
	| programString |
	programString := 'var userIn = input("Number for Square Root"); var x = asNum(userIn);'.
	^programString
	
]

{ #category : #'as yet unclassified' }
JbSamplePrograms >> twoInputs [
	| programString |
	programString := 'var num1 = input("Enter a number"); var a = asNum(num1); var num2 = input("Enter a number"); var b = asNum(num2);'.
	^programString
]
