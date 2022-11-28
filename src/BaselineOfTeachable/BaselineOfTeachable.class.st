"
Baseline for https://github.com/astares/Pharo-Teachable
"
Class {
	#name : #BaselineOfTeachable,
	#superclass : #BaselineOf,
	#category : #BaselineOfTeachable
}

{ #category : #baselines }
BaselineOfTeachable >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		"Packages" 
		spec 
			package: 'Teachable-Core'; 
			package: 'Teachable-Core-Tests' with: [ spec requires: #('Teachable-Core') ].
			
		"Groups"	
			spec	
				group: 'Core' with: #('Teachable-Core');
				group: 'Tests' with: #('Teachable-Core-Tests');
				group: 'all' with: #('Core' 'Tests');
				group: 'default' with: #('all')	
	]
]
