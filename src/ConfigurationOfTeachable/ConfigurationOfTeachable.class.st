Class {
	#name : #ConfigurationOfTeachable,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfTeachable
}

{ #category : #private }
ConfigurationOfTeachable class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfTeachable class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.15"
			self bootstrapPackage: 'Gofer-lr.83' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello tool support' }
ConfigurationOfTeachable class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfTeachable class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfTeachable class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfTeachable class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfTeachable class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfTeachable >> baseline10: spec [
    <version: '1.0-baseline'>
    
    spec for: #common do: [
        spec 
			blessing: #baseline;
			description: '1.0 baseline for Teachable';
			repository: 'http://www.squeaksource.com/Teachable'.     
			 
        spec package: 'Teachable-Core'.
		 spec package: 'Teachable-Tests' with: [ spec requires: #('Teachable-Core' ) ].		
				
		 spec
			group: 'all' with: #('Tests');		
			group: 'default' with: #('Teachable-Core' );
			group: 'Tests' with: #('Teachable-Tests' ).
								   
    ]
      
        

]

{ #category : #accessing }
ConfigurationOfTeachable >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear.
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfTeachable >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0'.
]

{ #category : #versions }
ConfigurationOfTeachable >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline')>
	
	spec for: #common do: [
		spec blessing: #'release'.	 
		spec description: 'first release'. 
		spec author: 'Torsten Bergmann'.
		spec timestamp: '3/1/2010 16:49'.
		spec package: 'Teachable-Core' with: 'Teachable-Core-tbn.1'.
		spec package: 'Teachable-Tests' with: 'Teachable-Tests-tbn.1'.		
	]
]
