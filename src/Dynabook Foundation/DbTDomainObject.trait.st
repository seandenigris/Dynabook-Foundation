Trait {
	#name : #DbTDomainObject,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#category : #'Dynabook Foundation-Core'
}

{ #category : #acccessing }
DbTDomainObject >> clipOlAnnotation [

	 ^ Clipboard clipboardText: '{{olObject:uid=', self ensureUUID asString36, '}}'
]

{ #category : #acccessing }
DbTDomainObject >> clipUUID [

	 ^ Clipboard clipboardText: self ensureUUID asString36
]

{ #category : #acccessing }
DbTDomainObject >> clipUUIDDescription [
	<magritteActionDescription>
	
	| result |
	result := MAActionDescription new
		action: #clipUUID;
		gtIcon: [ 
			BaselineOfObjectiveLepiter loadGtIconFromRepositoryPath:'icons/noun-identification-4239883.png' ];
		isLabelVisible: false;
		comment: 'Copy UUID string36 to clipboard';
		yourself.
		
	result gtAction: [ :anAction :anObject |
		anAction explicit
		priority: 70;
		stencil: [ | button |
			button := BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					"label: 'Browse class for current object';"
					icon: (BaselineOfObjectiveLepiter loadGtIconFromRepositoryPath:'icons/noun-identification-4239883.png');
					action: [ :aButton :aModel :anEvent | 
						anObject clipUUID ].
			button viewModel
				when: BlClickEvent
				do: [ :anEvent | anEvent modifiers isPrimaryModifier ifTrue: [ anObject clipOlAnnotation ] ].
			"button viewModel
				when: BlMouseEnterEvent
				do: [ :anEvent | 
					anEvent consumed: true.
					anEvent modifiers isPrimaryModifier
						ifTrue: [ anEvent target mouseCursor: BlCopyCursor new ]
						ifFalse: [ anEvent target mouseCursor: nil ].
					anEvent target requestFocus ]."
			button ] ].
		
	^ result
]

{ #category : #uuid }
DbTDomainObject >> ensureUUID [
	"See #uuid comment"
	 ^ self 
	 	propertyAt: #uuid
	 	ifAbsentPut: [ UUIDGenerator next ]
]

{ #category : #'as yet unclassified' }
DbTDomainObject >> postCopyDbDomainObject [
	"Send after super postCopy"
	
	self postCopyProperties.
	self uuid: nil; ensureUUID.
	self lepiterPageID: nil.
	self supportMaterials: nil.
]

{ #category : #uuid }
DbTDomainObject >> uuid [
	
	 ^ self propertyAt: #uuid ifAbsent: [ nil ]
]

{ #category : #uuid }
DbTDomainObject >> uuid: aUUID [

	self 
		propertyAt: #uuid
		putRemovingNil: aUUID
]
