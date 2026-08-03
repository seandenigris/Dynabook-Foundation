"
I provide a domain object with a canonical representation in the project system.

Use me when an instance can meaningfully answer the question, “What project represents this object?” without requiring additional situational context. The resulting project may represent either the enduring value of the object or the work naturally associated with it.

I support two forms of representation:

* When `isPpValuedObject` answers true, I provide a `PpValuedObject` representing the domain object.
* When `isPpValuedObject` answers false, I provide an ordinary `PpProject` linked to the domain object and configured through overridable hooks such as `ppProjectTitle` and `ppProjectConfigureLinked:`.

The second form is appropriate for domain objects that naturally define actionable or trackable work but are not themselves durable objects of value. Subclasses or trait users should override the configuration hooks when the default project title or setup does not adequately express the domain semantics.

Do not use me merely because an object can be related to, discovered from, or used within a project. Many subordinate objects—such as identifiers, comments, prices, or other implementation details—derive their project relevance from a containing or related domain object and should not manufacture an independent project. A useful test is whether the receiver alone contains enough meaning to configure a stable, unsurprising project that users would reasonably navigate to and manage.

`DbTDomainObject` identifies an object as part of the durable domain model. Using this trait makes the stronger claim that the object also has a canonical project representation.

`ppProject` is a passive accessor. It answers the existing canonical project representation or nil and never creates or registers one. Send `ppProjectEnsured` when the domain object should intentionally acquire a registered project representation. This distinction prevents inspection, querying, and presentation code from promoting domain objects as an incidental consequence of reading them.

"
Trait {
	#name : 'DbTProjectProperty',
	#category : 'Dynabook Foundation',
	#package : 'Dynabook Foundation'
}

{ #category : 'accessing' }
DbTProjectProperty >> newLinkedPpProject [
	
	| result |
	result := self ppLinkedProjectClass new
		title: self ppProjectTitle;
		yourself.
		
	self ppProjectConfigureLinked: result.
	
	^ result
]

{ #category : 'accessing' }
DbTProjectProperty >> newPpProject [

	^ self ppIsValuedObject
		ifTrue: [ self ppValuedObjectClass on: self ]
		ifFalse: [ self newLinkedPpProject ]
]

{ #category : 'as yet unclassified' }
DbTProjectProperty >> postCopyProjectProperty [
	"Send after super postCopy"
	
	self ppProjectBasic: nil
]

{ #category : 'testing' }
DbTProjectProperty >> ppIsValuedObject [
	"If yes, self will *become* a project via a wrapper. If not, we will *link* to a related project. See trait commend for more explanation"
	self explicitRequirement
]

{ #category : 'accessing' }
DbTProjectProperty >> ppProject [
	"Answer the existing canonical project representation, or nil. Do not create or register one."

	^ self
		propertyAt: #ppProject
		ifAbsent: [ nil ]

]

{ #category : 'accessing' }
DbTProjectProperty >> ppProject: aPpValue [
		
	aPpValue 
		ifNotNil: [ self ppProjectConfigureLinked: aPpValue ]
		ifNil: [ self ppProjectOnRemove ].
		
	self ppProjectBasic: aPpValue.
]

{ #category : 'accessing' }
DbTProjectProperty >> ppProjectBasic: aPpValue [

	self
		propertyAt: #ppProject
		putRemovingNil: aPpValue
]

{ #category : 'accessing' }
DbTProjectProperty >> ppProjectConfigureLinked: aPpValue [
	"Override for custom project configuration e.g. setting a backlink from the project to self."
]

{ #category : 'accessing' }
DbTProjectProperty >> ppProjectEnsured [
	"Answer the canonical project representation, creating and registering it when necessary."

	| result |

	result := self ppProject.
	result ifNil: [
		result := self newPpProject.
		self ppProjectBasic: result ].

	result masterList ifNotNil: [ ^ result ].

	^ self projectList ensureChild: result

]

{ #category : 'testing' }
DbTProjectProperty >> ppProjectExists [
	^ self ppProject isNotNil

]

{ #category : 'accessing' }
DbTProjectProperty >> ppProjectOnRemove [
	"Override for custom projects e.g. removing a backlink from the project to self."
]

{ #category : 'accessing' }
DbTProjectProperty >> ppProjectTitle [
	"#title is set as the default for convenience. Override as needed"

	^ self title
]
