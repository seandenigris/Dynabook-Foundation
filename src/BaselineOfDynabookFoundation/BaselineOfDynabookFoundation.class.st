Class {
	#name : #BaselineOfDynabookFoundation,
	#superclass : #BaselineOf,
	#category : #BaselineOfDynabookFoundation
}

{ #category : #baseline }
BaselineOfDynabookFoundation >> baseline: spec [
	<baseline>
	
	^ spec for: #common do: [
		spec
			baseline: #'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ].
		spec package: #'Dynabook Foundation' with: [
			spec requires: #(Magritte) ] ]
]
