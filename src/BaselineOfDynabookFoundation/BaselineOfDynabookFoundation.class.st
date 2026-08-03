Class {
	#name : 'BaselineOfDynabookFoundation',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDynabookFoundation',
	#package : 'BaselineOfDynabookFoundation'
}

{ #category : 'baseline' }
BaselineOfDynabookFoundation >> baseline: spec [
	<baseline>
	
	^ spec for: #common do: [
		spec
			baseline: 'StateSpecs' with: [ 
				spec repository: 'github://seandenigris/StateSpecs:v5.0.4';
				loads: #('Core') ];
			baseline: #'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ].
		spec package: #'Dynabook Foundation' with: [
			spec requires: #(Magritte) ] ]
]
