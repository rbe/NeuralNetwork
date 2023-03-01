Class {
	#name : #SigmoidAF,
	#superclass : #ActivationFunction,
	#category : #NeuralNetwork
}

{ #category : #evaluation }
SigmoidAF >> derivative: output [

	^ output * (1 - output)
]

{ #category : #evaluation }
SigmoidAF >> eval: z [

	^ 1 / (1 + z negated exp)
]
