Class {
	#name : #PerceptronTest,
	#superclass : #TestCase,
	#category : #NeuralNetwork
}

{ #category : #'instance creation' }
PerceptronTest >> newNeuron [

	^ Perceptron new
]

{ #category : #tests }
PerceptronTest >> testAND [

	| p |
	p := Perceptron makeNAND.
	self assert: (p feed: #( 0 0 )) equals: 1.
	self assert: (p feed: #( 0 1 )) equals: 1.
	self assert: (p feed: #( 1 0 )) equals: 1.
	self assert: (p feed: #( 1 1 )) equals: 0
]

{ #category : #tests }
PerceptronTest >> testDigitalComparator [

	self assert: (Perceptron digitalComparator: #( 0 0 )) equals: #( 0 1 0 ).
	self assert: (Perceptron digitalComparator: #( 0 1 )) equals: #( 0 0 1 ).
	self assert: (Perceptron digitalComparator: #( 1 0 )) equals: #( 1 0 0 ).
	self assert: (Perceptron digitalComparator: #( 1 1 )) equals: #( 0 1 0 )
]

{ #category : #tests }
PerceptronTest >> testNAND [

	| p |
	p := Perceptron makeNAND.
	self assert: (p feed: #( 0 0 )) equals: 1.
	self assert: (p feed: #( 0 1 )) equals: 1.
	self assert: (p feed: #( 1 0 )) equals: 1.
	self assert: (p feed: #( 1 1 )) equals: 0
]

{ #category : #tests }
PerceptronTest >> testNOR [

	| p |
	p := Perceptron makeNOR.
	self assert: (p feed: #( 0 0 )) equals: 1.
	self assert: (p feed: #( 0 1 )) equals: 0.
	self assert: (p feed: #( 1 0 )) equals: 0.
	self assert: (p feed: #( 1 1 )) equals: 0
]

{ #category : #tests }
PerceptronTest >> testNOT [

	| p |
	p := Perceptron makeNOT.
	self assert: (p feed: #( 1 )) equals: 0.
	self assert: (p feed: #( 0 )) equals: 1
]

{ #category : #tests }
PerceptronTest >> testOR [

	| p |
	p := Perceptron makeOR.
	self assert: (p feed: #( 0 0 )) equals: 0.
	self assert: (p feed: #( 0 1 )) equals: 1.
	self assert: (p feed: #( 1 0 )) equals: 1.
	self assert: (p feed: #( 1 1 )) equals: 1
]

{ #category : #'instance creation' }
PerceptronTest >> testSmallExample [
|p result|
p:=self newNeuron.
p weights: #(1 2).
p bias: -2.
result := p feed: #(5 2).
self assert: result equals: 1.
]

{ #category : #'instance creation' }
PerceptronTest >> testSmallExample2 [

	| p result |
	p := Perceptron withWeights: #( 1 2 ) andBias: -2.
	result := p feed: #( 5 2 ).
	self assert: result equals: 1
]

{ #category : #tests }
PerceptronTest >> testTrainingNOT [

	| p |
	p := Perceptron withWeights: #( -1 ) andBias: 2.
	40 timesRepeat: [ 
		p train: #( 0 ) desiredOutput: 1.
		p train: #( 1 ) desiredOutput: 0 ].
	self assert: (p feed: #( 0 )) equals: 1.
	self assert: (p feed: #( 1 )) equals: 0
]

{ #category : #tests }
PerceptronTest >> testTrainingOR [

	| p |
	p := Perceptron withWeights: #( -1 -1 ) andBias: 2.
	40 timesRepeat: [ 
		p train: #( 0 0 ) desiredOutput: 0.
		p train: #( 0 1 ) desiredOutput: 1.
		p train: #( 1 0 ) desiredOutput: 1.
		p train: #( 1 1 ) desiredOutput: 1 ].
	self assert: (p feed: #( 0 0 )) equals: 0.
	self assert: (p feed: #( 0 1 )) equals: 1.
	self assert: (p feed: #( 1 0 )) equals: 1.
	self assert: (p feed: #( 1 1 )) equals: 1
]

{ #category : #tests }
PerceptronTest >> testWrongFeeding [

	| p |
	p := Perceptron withWeights: #( -1 ) andBias: 0.5.
	self should: [ p feed: #( 1 1 ) ] raise: Error
]
