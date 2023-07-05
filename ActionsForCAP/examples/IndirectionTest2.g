#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true

DeclareFilter( "IsWrappedObject", IsCapCategoryObject );;

DeclareFilter( "IsWrappedMorphism", IsCapCategoryMorphism );;

DeclareOperation( "WrappedObject",
                  [ IsCapCategoryObject ] );;

DeclareAttribute( "UnderlyingCell",
                  IsWrappedObject );;

DeclareOperation( "WrappedMorphism",
                  [ IsWrappedObject, IsCapCategoryMorphism, IsWrappedObject ] );;

DeclareAttribute( "UnderlyingCell",
                  IsWrappedMorphism );;


#################################
##
## Creation of category
##
#################################

Q := HomalgFieldOfRationals();;

vec := MatrixCategory( Q );;

wrapped_cat := CreateCapCategory( "Wrapped Category", IsCapCategory, IsWrappedObject, IsWrappedMorphism, IsCapCategoryTwoCell );
#! Wrapped Category

wrapped_cat!.category_as_first_argument := false;;

#################################
##
## Constructors for objects and morphisms
##
#################################

InstallMethod( WrappedObject,
               [ IsCapCategoryObject ],
               
  function( obj )
    
    return CreateCapCategoryObjectWithAttributes( wrapped_cat,
        UnderlyingCell, obj
    ); end );

InstallMethod( WrappedMorphism,
               [ IsWrappedObject, IsCapCategoryMorphism, IsWrappedObject ],
                  
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
