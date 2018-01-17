#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################

##
InstallMethod( CreateHomomorphismStructureData,
               [ IsQuiverAlgebra ],
               
  function( quiver_algebra )
    local quiver, vertices, basis, list, path;
    
    quiver := QuiverOfAlgebra( quiver_algebra );
    
    vertices := Vertices( quiver );
    
    basis := BasisPaths( CanonicalBasis( quiver_algebra ) );
    
    list := List( vertices, i -> List( vertices, i -> [ ] ) );
    
    for path in basis do
        
        Add( list[ VertexNumber( Source( path ) ) ][ VertexNumber( Target( path ) ) ], path );
        
    od;
    
    return list;
    
end );

##
InstallGlobalFunction( INSTALL_HOMOMORPHISM_STRUCTURE_FOR_BIALGEBROID,
                       
  function( bialgebroid )
    local object_constructor, morphism_constructor, distinguished_object, quiver_algebra, data, ring;
    
    quiver_algebra := UnderlyingQuiverAlgebra( bialgebroid );
    
    data := CreateHomomorphismStructureData( quiver_algebra );
    
    ring := LeftActingDomain( quiver_algebra );
    
    object_constructor := function( size )
      return VectorSpaceObject( size, ring );
    end;
    
    morphism_constructor := function( mat )
      return VectorSpaceMorphism(
               VectorSpaceObject( NrRows( mat ), ring ),
               mat,
               VectorSpaceObject( NrColumns( mat ), ring )
            );
    end;
    
    distinguished_object := function()
      return TensorUnit( MatrixCategory( ring ) );
    end;
    
    ##
    InstallMethodWithCacheFromObject( HomomorphismStructureOnObjects,
                                      [ IsCapCategoryObject and ObjectFilter( bialgebroid ), IsCapCategoryObject and ObjectFilter( bialgebroid ) ],
      function( object_1, object_2 )
        local nr_source, nr_range, basis_elements;
        
        nr_source := VertexNumber( UnderlyingVertex( object_1 ) );
        
        nr_range := VertexNumber( UnderlyingVertex( object_2 ) );
        
        basis_elements := data[nr_source][nr_range];
        
        return object_constructor( Size( basis_elements ) );
        
    end );
    
    ##
    InstallMethodWithCacheFromObject( HomomorphismStructureOnMorphismsWithGivenObjects,
                                      [ IsCapCategoryObject,
                                        IsCapCategoryMorphism and MorphismFilter( bialgebroid ),
                                        IsCapCategoryMorphism and MorphismFilter( bialgebroid ),
                                        IsCapCategoryObject ],
      function( source, alpha, beta, range )
        local elem_alpha, elem_beta, a, b, ap, bp, basis_elements_source, basis_elements_range, size_source, size_range, images, path;
        
        elem_alpha := UnderlyingQuiverAlgebraElement( alpha );
        
        elem_beta := UnderlyingQuiverAlgebraElement( beta );
        
        a := VertexNumber( UnderlyingVertex( Range( alpha ) ) );
        
        b := VertexNumber( UnderlyingVertex( Source( beta ) ) );
        
        ap := VertexNumber( UnderlyingVertex( Source( alpha ) ) );
        
        bp := VertexNumber( UnderlyingVertex( Range( beta ) ) );
        
        basis_elements_source := data[a][b];
        
        basis_elements_range := data[ap][bp];
        
        size_source := Size( basis_elements_source );
        
        size_range := Size( basis_elements_range );
        
        if size_source = 0 or size_range = 0 then
            
            return morphism_constructor( HomalgZeroMatrix( size_source, size_range, ring ) );
            
        fi;
        
        images := [ ];
        
        for path in basis_elements_source do
            
            Add( images,
              CoefficientsOfPaths( basis_elements_range, Representative( elem_alpha * quiver_algebra.(String(path)) * elem_beta ) )
            );
            
        od;
        
        return morphism_constructor( HomalgMatrix( images, size_source, size_range, ring ) );
        
    end );
    
    ##
    InstallMethod( DistinguishedObjectOfHomomorphismStructure,
                   [ IsCapCategory and CategoryFilter( bialgebroid ) ],
                   
      function( cat )
        
        return distinguished_object();
        
    end );
    
    ##
    InstallMethod( InterpretHomomorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure,
                   [ IsCapCategoryMorphism and MorphismFilter( bialgebroid ) ],
                   
      function( alpha )
        local a, b, basis_elements, size_basis;
        
        a := VertexNumber( UnderlyingVertex( Source( alpha ) ) );
        
        b := VertexNumber( UnderlyingVertex( Range( alpha ) ) );
        
        basis_elements := data[a][b];
        
        size_basis := Size( basis_elements );
        
        if size_basis = 0 then
            
            return HomalgZeroMatrix( 1, 0, ring );
            
        fi;
        
        return morphism_constructor(
                 HomalgMatrix( CoefficientsOfPaths( basis_elements, Representative( UnderlyingQuiverAlgebraElement( alpha ) ) ), 1, size_basis, ring )
               );
        
    end );
    
    ##
    InstallMethodWithCacheFromObject( InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsHomomorphism,
                                      [ IsCapCategoryObject and ObjectFilter( bialgebroid ),
                                        IsCapCategoryObject and ObjectFilter( bialgebroid ),
                                        IsCapCategoryMorphism ],
                                       
      function( a, b, morphism )
        local coefficients, basis, element;
        
        coefficients := EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) );
        
        basis := data[VertexNumber( UnderlyingVertex( a ) )][VertexNumber( UnderlyingVertex( b ) )];
        
        element := QuiverAlgebraElement( quiver_algebra, coefficients, basis );
        
        return MorphismInAlgebroid( a, element, b );
        
    end );
    
    SetFilterObj( bialgebroid, IsCategoryWithHomomorphismStructure);
    
end );