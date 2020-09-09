#! @Chapter Examples and Tests

#! @Section Homomorphism structure

#! @Example
ReadPackage( "CAP", "examples/StringsAsCategory.g" );;
C := StringsAsCategory();;
obj1 := StringsAsCategoryObject( "qaeiou", C );;
obj2 := StringsAsCategoryObject( "qxayeziouT", C );;
mor := StringsAsCategoryMorphism( obj1, "xyzaTe", obj2 );;
IsWellDefined( mor );
#! true

## Test SimplifyObject
IsEqualForObjects( SimplifyObject( obj1, 0 ), obj1 );
#! true
IsEqualForObjects( SimplifyObject( obj1, 1 ), obj1 );
#! false
ForAny( [0,1,2,3,4], i -> IsEqualForObjects( SimplifyObject( obj1, i ), SimplifyObject( obj1, i + 1 ) ) );
#! false
ForAll( [5,6,7,8], i -> IsEqualForObjects( SimplifyObject( obj1, i ), SimplifyObject( obj1, i + 1 ) ) );
#! true


## Test SimplifyMorphism
IsEqualForMorphisms( SimplifyMorphism( mor, 0 ), mor );
#! true
IsEqualForMorphisms( SimplifyMorphism( mor, 1 ), mor );
#! false
ForAny( [0,1], i -> IsEqualForMorphisms( SimplifyMorphism( mor, i ), SimplifyMorphism( mor, i + 1 ) ) );
#! false
ForAll( [2,3,4,5], i -> IsEqualForMorphisms( SimplifyMorphism( mor, i ), SimplifyMorphism( mor, i + 1 ) ) );
#! true

## Test SimplifySource
IsEqualForMorphismsOnMor( SimplifySource( mor, 0 ), mor );
#! true
IsEqualForMorphismsOnMor( SimplifySource( mor, 1 ), mor );
#! false
ForAny( [0,1,2,3,4], i -> IsEqualForMorphismsOnMor( SimplifySource( mor, i ), SimplifySource( mor, i + 1 ) ) );
#! false
ForAll( [5,6,7,8,9], i -> IsEqualForMorphismsOnMor( SimplifySource( mor, i ), SimplifySource( mor, i + 1 ) ) );
#! true
IsCongruentForMorphisms(
    PreCompose( SimplifySource_IsoFromInputObject( mor, infinity ), SimplifySource( mor, infinity ) ), mor
);
#! true
IsCongruentForMorphisms(
    PreCompose( SimplifySource_IsoToInputObject( mor, infinity ), mor ) , SimplifySource( mor, infinity )
);
#! true

## Test SimplifyRange
IsEqualForMorphismsOnMor( SimplifyRange( mor, 0 ), mor );
#! true
IsEqualForMorphismsOnMor( SimplifyRange( mor, 1 ), mor );
#! false
ForAny( [0,1,2,3,4], i -> IsEqualForMorphismsOnMor( SimplifyRange( mor, i ), SimplifyRange( mor, i + 1 ) ) );
#! false
ForAll( [5,6,7,8,9], i -> IsEqualForMorphismsOnMor( SimplifyRange( mor, i ), SimplifyRange( mor, i + 1 ) ) );
#! true
IsCongruentForMorphisms(
    PreCompose( SimplifyRange( mor, infinity ), SimplifyRange_IsoToInputObject( mor, infinity ) ), mor
);
#! true
IsCongruentForMorphisms(
    PreCompose( mor, SimplifyRange_IsoFromInputObject( mor, infinity ) ), SimplifyRange( mor, infinity )
);
#! true

## Test SimplifySourceAndRange
IsEqualForMorphismsOnMor( SimplifySourceAndRange( mor, 0 ), mor );
#! true
IsEqualForMorphismsOnMor( SimplifySourceAndRange( mor, 1 ), mor );
#! false
ForAny( [0,1,2,3,4], i -> IsEqualForMorphismsOnMor( SimplifySourceAndRange( mor, i ), SimplifySourceAndRange( mor, i + 1 ) ) );
#! false
ForAll( [5,6,7,8,9], i -> IsEqualForMorphismsOnMor( SimplifySourceAndRange( mor, i ), SimplifySourceAndRange( mor, i + 1 ) ) );
#! true
IsCongruentForMorphisms(
    mor,
    PreCompose( [ SimplifySourceAndRange_IsoFromInputSource( mor, infinity ),
                  SimplifySourceAndRange( mor, infinity ),
                  SimplifySourceAndRange_IsoToInputRange( mor, infinity ) ] )
);
#! true
IsCongruentForMorphisms(
    SimplifySourceAndRange( mor, infinity ),
    PreCompose( [ SimplifySourceAndRange_IsoToInputSource( mor, infinity ),
                  mor,
                  SimplifySourceAndRange_IsoFromInputRange( mor, infinity ) ] )
);
#! true

## Test SimplifyEndo
endo := StringsAsCategoryMorphism( obj1, "uoiea", obj1 );;
IsWellDefined( endo );
#! true
IsEqualForMorphismsOnMor( SimplifyEndo( endo, 0 ), endo );
#! true
IsEqualForMorphismsOnMor( SimplifyEndo( endo, 1 ), endo );
#! false
ForAny( [0,1,2,3,4], i -> IsEqualForMorphismsOnMor( SimplifySourceAndRange( endo, i ), SimplifySourceAndRange( endo, i + 1 ) ) );
#! false
ForAll( [5,6,7,8,9], i -> IsEqualForMorphismsOnMor( SimplifySourceAndRange( endo, i ), SimplifySourceAndRange( endo, i + 1 ) ) );
#! true
iota := SimplifyEndo_IsoToInputObject( endo, infinity );;
iota_inv := SimplifyEndo_IsoFromInputObject( endo, infinity );;
IsCongruentForMorphisms( PreCompose( [ iota_inv, SimplifyEndo( endo, infinity ), iota ] ), endo );
#! true
#! @EndExample

