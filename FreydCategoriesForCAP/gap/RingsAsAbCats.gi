# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( RingAsCategory,
               [ IsRing ],
               RING_AS_CATEGORY
);

##
InstallMethod( RING_AS_CATEGORY,
               [ IsRing ],
               
  function( ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "RingAsCategory( ", String( ring )," )" ), IsRingAsCategory, IsRingAsCategoryObject, IsRingAsCategoryMorphism, IsCapCategoryTwoCell );
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
            "RingAsCategoryUniqueObject",
        ],
    );
    
    SetUnderlyingRing( category, ring );
    
    SetIsAbCategory( category, true );
    
    INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( RingAsCategoryUniqueObject,
               [ IsRingAsCategory ],
               
  function( category )
    
    return CreateCapCategoryObjectWithAttributes( category );
    
end );

##
InstallMethodForCompilerForCAP( RingAsCategoryMorphism,
                                [ IsRingAsCategory, IsRingElement ],
                                
  function( category, element )
    local unique_object;
    
    unique_object := RingAsCategoryUniqueObject( category );
    
    return CreateCapCategoryMorphismWithAttributes( category,
                                                    unique_object,
                                                    unique_object,
                                                    UnderlyingRingElement, element );
    
end );

##
InstallOtherMethod( RingAsCategoryMorphism,
               [ IsRingElement, IsRingAsCategory ],
               
  function( element, category )
    
    return RingAsCategoryMorphism( category, element );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
               [ IsRingAsCategoryMorphism ],
    
    function( alpha )
        
        return Concatenation( "<", ViewString( UnderlyingRingElement( alpha ) ), ">" );
        
end );

##
InstallMethod( ViewString,
               [ IsRingAsCategoryObject ],

  function( obj )
    
    return "*";
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY,
  
  function( category )
    local ring, equality_func, field, basis_over_base_field, indets, l, basis_over_base_field_as_column_vector, k, comb;
    
    ring := UnderlyingRing( category );
    
    ##
    AddIsEqualForObjects( category, {cat, A, B} -> true );
    
    equality_func := {cat, alpha, beta} -> UnderlyingRingElement( alpha ) = UnderlyingRingElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, {cat, x} -> true );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, alpha )
        
        return UnderlyingRingElement( alpha ) in UnderlyingRing( category );
        
    end );
    
    ##
    AddPreCompose( category,
      function( cat, alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) * UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( cat, unique_object )
        
        return RingAsCategoryMorphism(
            category,
            One( UnderlyingRing( cat ) )
        );
        
    end );
    
    ##
    AddIsOne( category,
      function( cat, alpha )
        
        return IsOne( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, a, b )
        
        return RingAsCategoryMorphism(
            category,
            Zero( UnderlyingRing( cat ) )
        );
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( cat, alpha )
        
        return IsZero( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) + UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, alpha )
        
        return RingAsCategoryMorphism(
            category,
            - UnderlyingRingElement( alpha )
        );
        
    end );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category, true );
        
        SetCommutativeRingOfLinearCategory( category, ring );
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return RingAsCategoryMorphism( category, r * UnderlyingRingElement( alpha ) );
            
        end );
        
        ##
        AddBasisOfExternalHom( category, { cat, a, b } -> [ RingAsCategoryMorphism( category, One( UnderlyingRing( cat ) ) ) ] );
        
        ##
        AddCoefficientsOfMorphism( category, { cat, mor } -> [ UnderlyingRingElement( mor ) ] );
        
        ##
        AddLift( category,
          function( cat, alpha, beta )
            
            return RingAsCategoryMorphism(
                category,
                UnderlyingRingElement( alpha ) / UnderlyingRingElement( beta )
            );
            
        end );
        
        ##
        AddColift( category,
          function( cat, alpha, beta )
            
            return RingAsCategoryMorphism(
                category,
                UnderlyingRingElement( beta ) / UnderlyingRingElement( alpha )
            );
            
        end );
        
        ## Homomorphism structure for commutative rings, see https://arxiv.org/abs/1908.04132 (Sebastian Posur: Methods of constructive category theory), Example 1.24
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, category );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, { cat } -> RingAsCategoryUniqueObject( cat ) );
        
        ##
        AddHomomorphismStructureOnObjects( category, { cat, a, b } -> RingAsCategoryUniqueObject( cat ) );
        
        ##
        AddHomomorphismStructureOnMorphisms( category,
          function( cat, alpha, beta )
            local a, b, rows;
            
            a := UnderlyingRingElement( alpha );
            b := UnderlyingRingElement( beta );
            
            return RingAsCategoryMorphism( cat, a * b );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( cat, alpha )
            
            return alpha;
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, a, b, mor )
            
            return mor;
            
        end );
        
    fi;
    
    if IsHomalgRing( ring ) and HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( BaseRing( ring ) ) then
        
        field := BaseRing( ring );
        
        SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category, true );
        
        SetCommutativeRingOfLinearCategory( category, field );
        
        SetRangeCategoryOfHomomorphismStructure( category, CategoryOfRows( field ) );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return RingAsCategoryMorphism( category, (r / ring) * UnderlyingRingElement( alpha ) );
            
        end );
        
        indets := IndeterminatesOfExteriorRing( ring );
        
        l := Length( indets );
        
        basis_over_base_field := [ One( ring ) ];
        for k in [ 1 .. l ] do
            for comb in Combinations( indets, k ) do
                Add( basis_over_base_field, Product( comb ) );
            od;
        od;
        
        basis_over_base_field_as_column_vector := HomalgColumnVector( basis_over_base_field, Length( basis_over_base_field ), ring );
        
        SetBasisOverBaseFieldAsColumnVector( category, basis_over_base_field_as_column_vector );
        
        Add( category!.compiler_hints.category_attribute_names, "BasisOverBaseFieldAsColumnVector" );
        
        ##
        AddBasisOfExternalHom( category, { cat, a, b } -> List( EntriesOfHomalgColumnVector( BasisOverBaseFieldAsColumnVector( cat ) ), x -> RingAsCategoryMorphism( cat, x ) ) );
        
        ##
        AddCoefficientsOfMorphism( category, { cat, r } -> EntriesOfHomalgRowVector( CoercedMatrix( UnderlyingRing( cat ), field, CoefficientsWithGivenMonomials( HomalgMatrixListList( [ [ UnderlyingRingElement( r ) ] ], 1, 1, UnderlyingRing( cat ) ), BasisOverBaseFieldAsColumnVector( cat ) ) ) ) );
        
    fi;
    
    ## Random Methods
    
    AddRandomObjectByInteger( category,
      { cat, n } -> RingAsCategoryUniqueObject( cat ) );
    
    AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
      { cat, S, R, n } ->  RingAsCategoryMorphism( cat, Sum( [ 1 .. n ], i -> Random( UnderlyingRing( cat ) ), Zero( UnderlyingRing( cat ) ) ) ) );
    
end );

####################################
##
## Convenience
##
####################################

InstallMethod( \*,
               [ IsRingAsCategoryMorphism, IsRingAsCategoryMorphism ],
               PreCompose );

InstallMethod( \=,
               [ IsRingAsCategoryMorphism, IsRingAsCategoryMorphism ],
               IsCongruentForMorphisms );

InstallOtherMethod( \/,
               [ IsRingElement, IsRingAsCategory ],
               RingAsCategoryMorphism );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsRingAsCategoryObject ],
               UnderlyingRing );

##
InstallMethod( DownOnlyMorphismData,
               [ IsRingAsCategoryMorphism ],
               UnderlyingRingElement );
