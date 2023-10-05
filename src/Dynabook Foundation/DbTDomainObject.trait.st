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
	"It is a stretch to place this in MATPropertyOwner, but it's only two methods, so in the interest of simplicity we'll put it here until someone complains. We had extracted this to ObjectiveLepiter, the only user. However, due to limitations in Pharo packaging, namely lack of extension traits, users become unusable unless in GT, where OL works. For now, it seems prudent to live with the two methods in question to make life easier"
]

{ #category : #uuid }
DbTDomainObject >> uuid: aUUID [

	self 
		propertyAt: #uuid
		put: aUUID
]
