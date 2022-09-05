# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

BindGlobal( "CATEGORY_FILTER_CHECKER",
  function( cat )
    local k;
    
    # if the category is matrix category of some homalg field then do nothing
    if IsBound( cat!.field_for_matrix_category ) then
        
        return false;
        
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( cat ) and IsLinearCategoryOverCommutativeRing( cat ) ) then
        
        return false;
        
    fi;
    
    k := CommutativeRingOfLinearCategory( cat );
    
    if not ( HasIsFieldForHomalg( k ) and IsFieldForHomalg( k ) ) then
        
        return false;
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( cat ) then
        
        if not HasMatrixCategory( k ) then
            
            return false;
            
        fi;
        
        if not IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), MatrixCategory( k ) ) then
            
            return false;
            
        fi;
        
    fi;
    
    return true;
    
end );

##
AddFinalDerivation( DistinguishedObjectOfHomomorphismStructure,
                    [
                      [ BasisOfExternalHom, 3 ], # part of CoefficientsOfMorphism
                      [ CoefficientsOfMorphismWithGivenBasisOfExternalHom, 2 ],
                      [ MultiplyWithElementOfCommutativeRingForMorphisms, 2 ],
                      [ ZeroMorphism, 1 ],
                      [ PreCompose, 2 ],
                    ],
                    [
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      DistinguishedObjectOfHomomorphismStructure,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
  
  function( cat )
    local k;
    
    k := CommutativeRingOfLinearCategory( cat );
    
    return VectorSpaceObject( 1, k );
    
  end,
[
  HomomorphismStructureOnObjects,
  function( cat, a, b )
    local k, dimension;
    
    k := CommutativeRingOfLinearCategory( cat );
    
    dimension := Length( BasisOfExternalHom( a, b ) );
    
    return VectorSpaceObject( dimension, k );
    
  end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
    
    #          alpha
    #      a --------> a'     s = H(a',b) ---??--> r = H(a,b')
    #      |           |
    # alpha.h.beta     h
    #      |           |
    #      v           v
    #      b' <------- b
    #          beta
    
  function( cat, hom_source, alpha, beta, hom_range )
    local k, dim_hom_source, dim_hom_range, B, mat;
    
    k := CommutativeRingOfLinearCategory( cat );
    
    dim_hom_source := Dimension( hom_source );
    
    dim_hom_range := Dimension( hom_range );
    
    if dim_hom_source * dim_hom_range = 0 then
      
      return ValueGlobal( "ZeroMorphism" )( hom_source, hom_range ); # sanity checks for final derivations
                                                                     # thinks this ZeroMorphism is being used in cat;
    fi;                                                              # hence, insists that it should be in the list of required
                                                                     # primitive methods.
    B := BasisOfExternalHom( Range( alpha ), Source( beta ) );
    
    B := List( B, b -> PreCompose( [ alpha, b, beta ] ) );
    
    B := List( B, CoefficientsOfMorphism );
    
    mat := HomalgMatrix( B, dim_hom_source, dim_hom_range, k );
    
    return VectorSpaceMorphism( hom_source, mat, hom_range );
    
  end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  function( cat, alpha )
    local k, coeff, D;
    
    k := CommutativeRingOfLinearCategory( cat );
    
    coeff := CoefficientsOfMorphism( alpha );
    
    coeff := HomalgMatrix( coeff, 1, Size( coeff ), k );
    
    D := VectorSpaceObject( 1, k );
    
    return VectorSpaceMorphism( D, coeff, VectorSpaceObject( NrCols( coeff ), k ) );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  function( cat, a, b, iota )
    local mat, coeff, B, L;
    
    mat := UnderlyingMatrix( iota );
    
    coeff := EntriesOfHomalgMatrix( mat );
    
    B := BasisOfExternalHom( a, b );
    
    L := List( [ 1 .. Length( coeff ) ],
      i -> MultiplyWithElementOfCommutativeRingForMorphisms( coeff[ i ], B[ i ] ) );
      
    if L = [  ] then
      
      return ZeroMorphism( a, b );
      
    else
      
      return Sum( L );
      
    fi;
    
  end
] :
  FunctionCalledBeforeInstallation :=
    function( cat )
      local matrix_cat;
      matrix_cat := MatrixCategory( CommutativeRingOfLinearCategory( cat ) );
      SetRangeCategoryOfHomomorphismStructure( cat, matrix_cat );
      return;
    end,
  CategoryFilter := CATEGORY_FILTER_CHECKER,
  Description := "Adding homomorphism structure using external hom methods"
);

