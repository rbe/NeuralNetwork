Class {
	#name : #StepAF,
	#superclass : #ActivationFunction,
	#category : #NeuralNetwork
}

{ #category : #evaluation }
StepAF >> derivative: output [

	^ 1
]

{ #category : #evaluation }
StepAF >> eval: z [

	^ (z > 0) ifTrue: [ 1 ] ifFalse: [ 0 ]
]
