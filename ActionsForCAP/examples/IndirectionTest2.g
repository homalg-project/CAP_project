#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true

DeclareRepresentation( "IsWrappedObjectRep",
                       IsCapCategoryObjectRep,
                       [ ] );;

DeclareRepresentation( "IsWrappedMorphismRep",
                       IsCapCategoryMorphismRep,
                       [ ] );;

DeclareOperation( "WrappedObject",
                  [ IsCapCategoryObject ] );;

DeclareAttribute( "UnderlyingCell",
                  IsWrappedObjectRep );;

DeclareOperation( "WrappedMorphism",
                  [ IsWrappedObjectRep, IsCapCategoryMorphism, IsWrappedObjectRep ] );;

DeclareAttribute( "UnderlyingCell",
                  IsWrappedMorphismRep );;


#################################
##
## Creation of category
##
#################################

Q := HomalgFieldOfRationals();;

vec := MatrixCategory( Q );;

wrapped_cat := CreateCapCategory( "Wrapped Category" );
#! Wrapped Category

AddObjectRepresentation( wrapped_cat, IsWrappedObjectRep );
AddMorphismRepresentation( wrapped_cat, IsWrappedMorphismRep );

#################################
##
## Constructors for objects and morphisms
##
#################################

InstallMethod( WrappedObject,
               [ IsCapCategoryObject ],
               
  function( obj )
    
    return ObjectifyObjectForCAPWithAttributes(
        rec( ), wrapped_cat,
        UnderlyingCell, obj
    ); end );

InstallMethod( WrappedMorphism,
               [ IsWrappedObjectRep, IsCapCategoryMorphism, IsWrappedObjectRep ],
                  
  function( source, morphism, range )
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
        rec( ), wrapped_cat,
        Source, source,
        Range, range,
        UnderlyingCell, morphism
    ); end );

AddKernelEmbedding( wrapped_cat,
  function( diagram )
    
    # avoid semicolons so AutoDoc does not start a new statement
    return ({ underlying_kernel_embedding } ->
        WrappedMorphism( WrappedObject( Source( underlying_kernel_embedding ) ),
                         underlying_kernel_embedding,
                         Source( diagram ) )
    )(KernelEmbedding( UnderlyingCell( diagram ) )); end );

Finalize( wrapped_cat );;

V := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
alpha := VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ], 3, 3, Q ), V );
#! <A morphism in Category of matrices over Q>

V_wrapped := WrappedObject( V );
#! <An object in Wrapped Category>
alpha_wrapped := WrappedMorphism( V_wrapped, alpha, V_wrapped );
#! <A morphism in Wrapped Category>

#! @EndExample