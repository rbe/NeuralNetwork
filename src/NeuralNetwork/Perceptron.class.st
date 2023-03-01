Class {
	#name : #Perceptron,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'learningRate'
	],
	#category : #NeuralNetwork
}

{ #category : #'logical operations' }
Perceptron class >> digitalComparator: inputs [

	"Return an array of three elements"

	| not and nor a b aGreaterB aEqualsB aLessB notA notB |
	a := inputs first.
	b := inputs second.
	and := self makeAND.
	not := self makeNOT.
	nor := self makeNOR.
	notA := not feed: { a }.
	notB := not feed: { b }.
	aLessB := and feed: { 
			       notA.
			       b }.
	aGreaterB := and feed: { 
			       a.
			       notB }.
	aEqualsB := nor feed: { 
			       aGreaterB.
			       aLessB }.
	^ { 
		  aGreaterB.
		  aEqualsB.
		  aLessB }
]

{ #category : #factory }
Perceptron class >> makeAND [

	^ self withWeights: #( 1 1 ) andBias: -1.5.
]

{ #category : #'as yet unclassified' }
Perceptron class >> makeNAND [

	^ self withWeights: #( -1 -1 ) andBias: 1.5
]

{ #category : #factory }
Perceptron class >> makeNOR [

	^ self withWeights: #( -1 -1 ) andBias: 0.5
]

{ #category : #factory }
Perceptron class >> makeNOT [

	^ self withWeights: #( -1 ) andBias: 0.5
]

{ #category : #factory }
Perceptron class >> makeOR [

	^ self withWeights: #( 1 1 ) andBias: -0.5.
]

{ #category : #factory }
Perceptron class >> withWeights: aCollection andBias: aBias [

	^self new
		weights: aCollection;
		bias: aBias
]

{ #category : #accessing }
Perceptron >> bias [
^bias
]

{ #category : #accessing }
Perceptron >> bias: aNumber [
bias:=aNumber 
]

{ #category : #accessing }
Perceptron >> feed: inputs [

	| z |
	z := (inputs with: weights collect: [ :x :w | x * w ]) sum + bias.
	^ z > 0 ifTrue: [ 1 ] ifFalse: [ 0 ]
]

{ #category : #initialization }
Perceptron >> initialize [
	super initialize.
	learningRate := 0.1
]

{ #category : #accessing }
Perceptron >> learningRate [
	"Return the learning rate of a Neuron"
	^learningRate
]

{ #category : #accessing }
Perceptron >> learningRate: aFloat [

	"Set the learning rate of a neuron."

	learningRate := aFloat
]

{ #category : #training }
Perceptron >> train: inputs desiredOutput: desiredOutput [

	| theError output newWeight |
	output := self feed: inputs.
	theError := desiredOutput - output.
	inputs withIndexDo: [ :anInput :index |
		newWeight := (weights at: index)+(learningRate * theError * anInput ).
		weights at: index put: newWeight].
	bias:=bias+(learningRate *theError )
]

{ #category : #accessing }
Perceptron >> weights [
^weights 
]

{ #category : #accessing }
Perceptron >> weights: aCollection [

	weights := aCollection copy
]
