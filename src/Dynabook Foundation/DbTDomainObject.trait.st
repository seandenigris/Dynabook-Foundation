Trait {
	#name : 'DbTDomainObject',
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#category : 'Dynabook Foundation-Core',
	#package : 'Dynabook Foundation',
	#tag : 'Core'
}

{ #category : 'acccessing' }
DbTDomainObject >> clipOlAnnotation [

	 ^ Clipboard clipboardText: '{{olObject:uid=', self ensureUUID asString36, '}}'
]

{ #category : 'acccessing' }
DbTDomainObject >> clipUUID [

	 ^ Clipboard clipboardText: self ensureUUID asString36
]

{ #category : 'acccessing' }
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
		anAction dropdown
			priority: 70;
			icon: (BaselineOfObjectiveLepiter loadGtIconFromRepositoryPath:'icons/noun-identification-4239883.png');
			withDropdownIndicator;
			items:[ :a :b :aMenuItems |
				aMenuItems 
					addItemLabel: 'Clip string36' 
						action: [ anObject clipUUID ];
					addItemLabel: 'Clip OlAnnotation' 
						action: [ anObject clipOlAnnotation ] ] ].
		
	^ result
]

{ #category : 'uuid' }
DbTDomainObject >> ensureUUID [
	"See #uuid comment"

	^ self propertyAt: #uuid ifAbsentPut: [ UUID new ]
]

{ #category : 'as yet unclassified' }
DbTDomainObject >> postCopyDbDomainObject [
	"Send after super postCopy"
	
	self postCopyProperties.
	self uuid: nil; ensureUUID.
	self lepiterPageID: nil.
	self supportMaterials: nil.
]

{ #category : 'uuid' }
DbTDomainObject >> uuid [
	
	 ^ self propertyAt: #uuid ifAbsent: [ nil ]
]

{ #category : 'uuid' }
DbTDomainObject >> uuid: aUUID [

	self 
		propertyAt: #uuid
		putRemovingNil: aUUID
]
