LoadPackage( "LinearAlgebraForCAP" );

DeclareRepresentation( "IsWrappedObjectRep",
                       IsCapCategoryObjectRep,
                       [ ] );

BindGlobal( "TheTypeOfWrappedObjects",
        NewType( TheFamilyOfCapCategoryObjects,
                IsWrappedObjectRep ) );

DeclareRepresentation( "IsWrappedMorphismRep",
                       IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfWrappedMorphisms",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsWrappedMorphismRep ) );

DeclareOperation( "WrappedObject",
                  [ IsCapCategoryObject ] );

DeclareAttribute( "UnderlyingCell",
                  IsWrappedObjectRep );

DeclareOperation( "WrappedMorphism",
                  [ IsWrappedObjectRep, IsCapCategoryMorphism, IsWrappedObjectRep ] );

DeclareAttribute( "UnderlyingCell",
                  IsWrappedMorphismRep );


#################################
##
## Creation of category
##
#################################

Q := HomalgFieldOfRationals();

vec := MatrixCategory( Q );

wrapped_cat := CreateCapCategory( "Wrapped Category" );

#################################
##
## Constructors for objects and morphisms
##
#################################

InstallMethod( WrappedObject,
               [ IsCapCategoryObject ],
               
  function( obj )
    local wrapped_obj;
    
    wrapped_obj := ObjectifyWithAttributes( rec( ), TheTypeOfWrappedObjects,
                                            UnderlyingCell, obj
    );
    
    Add( wrapped_cat, wrapped_obj );
    
    return wrapped_obj;
    
end );

InstallMethod( WrappedMorphism,
                  [ IsWrappedObjectRep, IsCapCategoryMorphism, IsWrappedObjectRep ],
                  
  function( source, morphism, range )
    local wrapped_morphism;

    wrapped_morphism := ObjectifyWithAttributes( rec( ), TheTypeOfWrappedMorphisms,
                                                 Source, source,
                                                 Range, range,
                                                 UnderlyingCell, morphism
    );

    Add( wrapped_cat, wrapped_morphism );
    
    return wrapped_morphism;
    
end );

AddKernelEmbedding( wrapped_cat,
  function( diagram )
    local underlying_kernel_embedding;
    
    underlying_kernel_embedding := KernelEmbedding( UnderlyingCell( diagram ) );
    
    return WrappedMorphism( WrappedObject( Source( underlying_kernel_embedding ) ),
                            underlying_kernel_embedding,
                            Source( diagram ) );
    
end );

Finalize( wrapped_cat );

V := VectorSpaceObject( 3, Q );
alpha := VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ], 3, 3, Q ), V );

V_wrapped := WrappedObject( V );
alpha_wrapped := WrappedMorphism( V_wrapped, alpha, V_wrapped );
