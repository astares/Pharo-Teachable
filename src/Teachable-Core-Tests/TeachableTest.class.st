"
TestCases for the class Teachable
"
Class {
	#name : #TeachableTest,
	#superclass : #TestCase,
	#instVars : [
		'teachable'
	],
	#category : #'Teachable-Core-Tests'
}

{ #category : #defaults }
TeachableTest >> defaultTestClass [
	"Returns the receivers default test class"
	
	^Teachable
]

{ #category : #running }
TeachableTest >> setUp [
	"Set up the receiver for running a new test"
	
	super setUp.
	self teachable: self defaultTestClass new
]

{ #category : #accessing }
TeachableTest >> teachable [
	^teachable
]

{ #category : #accessing }
TeachableTest >> teachable: anObject [
	teachable := anObject
]

{ #category : #running }
TeachableTest >> tearDown [
	"Tear down the receiver after running a test"
	
	super tearDown.
	self teachable: nil.
]

{ #category : #testing }
TeachableTest >> testAcceptSendWithBinaryMessage [
	"Test if the teachable object is able to accept a message send it is teached"
	
	self should: [self teachable + 3] raise: Exception.
	self teachable acceptSend: #+.
	self shouldnt: [self teachable + 3] raise: Exception.
]

{ #category : #testing }
TeachableTest >> testAcceptSendWithKeyWordMessage [
	"Test if the teachable object is able to accept a message send it is teached"
	
	self should: [self teachable foo: 3] raise: Exception.
	self teachable acceptSend: #foo:.
	self shouldnt: [self teachable foo: 3] raise: Exception.
]

{ #category : #testing }
TeachableTest >> testAcceptSendWithUnaryMessage [
	"Test if the teachable object is able to accept a message send it is teached"

	self should: [self teachable foo] raise: Exception.
	self teachable acceptSend: #foo.
	self shouldnt: [self teachable foo] raise: Exception
]

{ #category : #testing }
TeachableTest >> testInstanceCreation [
	"Test the instance creation of the teachable"
	
	| instance |
	instance := self defaultTestClass new.
	self assert: instance notNil.
	self assert: instance class = self defaultTestClass
]

{ #category : #testing }
TeachableTest >> testWhenSendEvaluate [
	"Tests teaching the teachable to evaluate a block"
	
	|called|
	called := false.
	self should: [self teachable foo] raise: Exception.
	self teachable whenSend: #foo evaluate: [called := true. 1].
	self shouldnt: [self teachable foo] raise: Exception.
	self assert: self teachable foo = 1.
	self assert: called.

]

{ #category : #testing }
TeachableTest >> testWhenSendEvaluateWithOneArgumentBlock [
	"Tests teaching the teachable to evaluate a block with an argument"
	
	|called|
	called := false.
	self should: [self teachable foo: #uninteresting] raise: Exception.
	self teachable whenSend: #foo: evaluate: [:arg | called := arg. 1].
	self shouldnt: [self teachable foo: #uninteresting] raise: Exception.
	self assert: (self teachable foo: true) = 1.
	self assert: called.
	self assert: (self teachable foo: false) = 1.
	self assert: called not.

]

{ #category : #testing }
TeachableTest >> testWhenSendWithReturnValue [
	"Tests teaching the teachable to respond to a teached message with a return value"
	
	|object|
	object := OrderedCollection new.
	self should: [self teachable foo] raise: Exception.
	self teachable whenSend: #foo return: object.
	self shouldnt: [self teachable foo] raise: Exception.
	self teachable foo == object
]
