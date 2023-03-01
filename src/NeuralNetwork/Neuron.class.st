Class {
	#name : #Neuron,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'learningRate',
		'activationFunction'
	],
	#category : #NeuralNetwork
}

{ #category : #'logical operations' }
Neuron class >> digitalComparator: inputs [

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
Neuron class >> makeAND [

	^ self withWeights: #( 1 1 ) andBias: -1.5.
]

{ #category : #'as yet unclassified' }
Neuron class >> makeNAND [

	^ self withWeights: #( -1 -1 ) andBias: 1.5
]

{ #category : #factory }
Neuron class >> makeNOR [

	^ self withWeights: #( -1 -1 ) andBias: 0.5
]

{ #category : #factory }
Neuron class >> makeNOT [

	^ Neuron withWeights: #( -1 ) andBias: 0.5
]

{ #category : #factory }
Neuron class >> makeOR [

	^ self withWeights: #( 1 1 ) andBias: -0.5.
]

{ #category : #factory }
Neuron class >> withWeights: aCollection andBias: aBias [

	^self new
		weights: aCollection;
		bias: aBias
]

{ #category : #accessing }
Neuron >> bias [
^bias
]

{ #category : #accessing }
Neuron >> bias: aNumber [
bias:=aNumber 
]

{ #category : #accessing }
Neuron >> feed: inputs [

	| z |
	z := (inputs with: weights collect: [ :x :w | x * w ]) sum + bias.
	^ activationFunction eval: z
]

{ #category : #initialization }
Neuron >> initialize [
	super initialize.
	learningRate := 0.1
]

{ #category : #accessing }
Neuron >> learningRate [
	"Return the learning rate of a Neuron"
	^learningRate
]

{ #category : #accessing }
Neuron >> learningRate: aFloat [

	"Set the learning rate of a neuron.
	The argument should be a small floating value such as 0.01."

	learningRate := aFloat
]

{ #category : #training }
Neuron >> train: inputs desiredOutput: desiredOutput [

	| theError output newWeight |
	output := self feed: inputs.
	theError := desiredOutput - output.
	inputs withIndexDo: [ :anInput :index |
		newWeight := (weights at: index)+(learningRate * theError * anInput ).
		weights at: index put: newWeight].
	bias:=bias+(learningRate *theError )
]

{ #category : #accessing }
Neuron >> weights [
^weights 
]

{ #category : #accessing }
Neuron >> weights: aCollection [

	weights := aCollection copy
]
