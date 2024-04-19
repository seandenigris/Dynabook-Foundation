Extension { #name : #String }

{ #category : #'*Dynabook Foundation' }
String >> dbAsDate [

	^ self asDate translateToUTC
]
