Class {
	#name : #ActivationFunction,
	#superclass : #Object,
	#category : #NeuralNetwork
}

{ #category : #evaluation }
ActivationFunction >> derivative: output [

	^ self subclassResponsibility
]

{ #category : #evaluation }
ActivationFunction >> eval: z [
	^ self subclassResponsibility
]
