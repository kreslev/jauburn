Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAssignment1 [ 
	self interpret: 'var x = 1; x = 2;'.
	self assert: (interpreter environment at: 'x') equals: 2.
]

{ #category : #tests }
JbInterpreterTest >> testComparators [

	self interpret: 'var x = 9 == 9;'.
	self interpret: 'var y = 9 == 8;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self assert: (interpreter environment at: 'y') equals: false.
	self interpret: 'var x = 9 < 10;'.
	self interpret: 'var y = 9 < 8;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self assert: (interpreter environment at: 'y') equals: false.
	self interpret: 'var x = 9 > 10;'.
	self interpret: 'var y = 9 > 8;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self assert: (interpreter environment at: 'y') equals: true.
	self interpret: 'var x = 9 != 9;'.
	self interpret: 'var y = 9 != 8;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self assert: (interpreter environment at: 'y') equals: true.
	self interpret: 'var x = 9 <= 10;'.
	self interpret: 'var y = 9 <= 8;'.
	self interpret: 'var z = 9 <= 9;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self assert: (interpreter environment at: 'y') equals: false.
	self assert: (interpreter environment at: 'z') equals: true.
	self interpret: 'var x = 9 >= 10;'.
	self interpret: 'var y = 9 >= 8;'.
	self interpret: 'var z = 9 >= 9;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self assert: (interpreter environment at: 'y') equals: true.
	self assert: (interpreter environment at: 'z') equals: true.

]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 6 - 15 / 3;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 5; var y = 30/x;'.
	self assert: (interpreter environment at: 'y') equals: 6.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testFunction [
	self interpret: 'var y = function(){};'.
	self assert: (interpreter environment at: 'y') parameters size equals: 0.
	self interpret: 'var y = function(a, b){};'.
	self assert: (interpreter environment at: 'y') parameters size equals: 2.
	self assert: (interpreter environment at: 'y') parameters first equals: 'a'.
	self assert: (interpreter environment at: 'y') parameters second equals: 'b'.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCall [
	self interpret: 'var x = 1; var y = function(){x = x + 1;}; var z = y();'.
	self assert: (interpreter environment at: 'x') equals: 2.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCall2 [
	self interpret: 'var x = 1; var y = function(x){var a = x + x;}; var z = y();'.
	self assert: (interpreter environment at: 'a') equals: 2.
	self interpret: 'var x = 1; var b = 3; var y = function(x, b){var a = x + x; var c = a + b;}; var z = y();'.
	self assert: (interpreter environment at: 'c') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testGCD [
	| a b |
	a := JbSamplePrograms new.
	b := a greatestCommon.
	self interpret: 'var a = 12; var b = 8; var gcd =', b, 'var z = gcd();'.
	self assert: (interpreter environment at: 't') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testIfStatement [

	self interpret: 'var x = 0;'.
	self interpret: 'var y = 0;'.
	self interpret: 'if (x == y) {y = 45};'.
	self assert: (interpreter environment at: 'y') equals: 45.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitives [
	self interpret: 'var x = not(true);'.
	self assert: (interpreter environment at: 'x') equals: false.
	self interpret: 'var x = not(false);'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = abs(9);'.
	self assert: (interpreter environment at: 'x') equals: 9.
	self interpret: 'var x = abs(-9);'.
	self assert: (interpreter environment at: 'x') equals: 9.
	self interpret: 'var x = length("dog");'.
	self assert: (interpreter environment at: 'x') equals: 3.
	self interpret: 'var x = concat("cat", "dog");'.
	self assert: (interpreter environment at: 'x') equals: 'catdog'.
	self interpret: 'var x = mod(8, 5);'.
	self assert: (interpreter environment at: 'x') equals: 3.
	self interpret: 'var x = mod(7, 2);'.
	self assert: (interpreter environment at: 'x') equals: 1.

]

{ #category : #tests }
JbInterpreterTest >> testPrimitives2 [
	self interpret: 'var x = print("hello");'.
	self assert: interpreter myTranscript transcript equals: 'hello'.
	self interpret: 'var x = println("hello");'.
	self assert: interpreter myTranscript transcript equals: 'hello', (Character cr asString).
	self interpret: 'var x = print(7);'.
	self assert: interpreter myTranscript transcript equals: '7'.
	self interpret: 'var y = input("Input the Number 8"); print(y);'.
	self assert: interpreter myInput transcript equals: '8'.
	self interpret: 'var y = asNum("9");'.
	self assert: (interpreter environment at: 'y') equals: 9.
]

{ #category : #tests }
JbInterpreterTest >> testTwoInputs [
	"Enter 5 for both"
	| x y |
	x := JbSamplePrograms new.
	y := x twoInputs.
	self interpret: y.
	self assert: (interpreter environment at: 'a') equals: 5.
	self assert: (interpreter environment at: 'b') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testUnaryOperator [
	
	self interpret: 'var x = -2;'.
	self assert: (interpreter environment at: 'x') equals: -2.
	
	self interpret: 'var x = -(-2);'.
	self assert: (interpreter environment at: 'x') equals: 2.
]

{ #category : #tests }
JbInterpreterTest >> testWhileStatement [

	self interpret: 'var x = 1;'.
	self interpret: 'var y = 0;'.
	self interpret: 'while (x < 10) { y = y + x; x = x + 1};'.
	self assert: (interpreter environment at: 'y') equals: 45.
]
