"
The metacello configuration for the teachable project
"
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

{ #category : #catalog }
ConfigurationOfTeachable class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ ''
]

{ #category : #catalog }
ConfigurationOfTeachable class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'You can contact the author on the pharo mailinglist'
]

{ #category : #catalog }
ConfigurationOfTeachable class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Provide a better file browser for Pharo.'
]

{ #category : #catalog }
ConfigurationOfTeachable class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ ' '
]

{ #category : #catalog }
ConfigurationOfTeachable class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(meta teaching oop) 
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
			repository: 'http://smalltalkhub.com/mc/TorstenBergmann/Teachable/main'.     
			 
       spec package: 'Teachable-Core'.
		 spec package: 'Teachable-Tests' with: [ spec requires: #('Teachable-Core' ) ].		
				
		 spec
			group: 'all' with: #('Tests');		
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: #('Teachable-Core' );
			group: 'Tests' with: #('Teachable-Tests' ).
								   
    ]
      
        

]

{ #category : #baselines }
ConfigurationOfTeachable >> baseline20: spec [
    <version: '2.0-baseline'>

	spec for: #'common' do: [ 
		spec
			baseline: 'Teachable' with: [ 
				spec 
					className: 'BaselineOfTeachable';
					repository: 'github://astares/Pharo-Teachable:master/src' ]]
]

{ #category : #baselines }
ConfigurationOfTeachable >> baseline30: spec [
    <version: '3.0-baseline'>

	spec for: #'common' do: [ 
		spec
			baseline: 'Teachable' with: [ 
				spec 
					className: 'BaselineOfTeachable';
					repository: 'github://astares/Pharo-Teachable:master/src' ]]
]

{ #category : #'symbolic versions' }
ConfigurationOfTeachable >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '3.0-baseline'
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

	spec for: #'common' version: '2.0'.
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

{ #category : #versions }
ConfigurationOfTeachable >> version20: spec [
	<version: '2.0'>

	spec for: #'common' do: [ 
		spec
			baseline: 'Teachable' with: [ 
				spec 
					className: 'BaselineOfTeachable';
					repository: 'github://astares/Pharo-Teachable:2.0/src' ]]
]
