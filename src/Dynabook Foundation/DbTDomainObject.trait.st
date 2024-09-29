Trait {
	#name : #DbTDomainObject,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#category : #'Dynabook Foundation-Core'
}

{ #category : #acccessing }
DbTDomainObject >> clipUUID [

	 ^ Clipboard clipboardText: self ensureUUID asString36
]

{ #category : #acccessing }
DbTDomainObject >> clipUUIDDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
		action: #clipUUID;
		gtIcon: [ 
			BaselineOfObjectiveLepiter loadGtIconFromRepositoryPath:'icons/noun-identification-4239883.png' ];
		isLabelVisible: false;
		comment: 'Copy UUID string36 to clipboard';
		yourself
]

{ #category : #uuid }
DbTDomainObject >> ensureUUID [
	"See #uuid comment"
	 ^ self 
	 	propertyAt: #uuid
	 	ifAbsentPut: [ UUIDGenerator next ]
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
