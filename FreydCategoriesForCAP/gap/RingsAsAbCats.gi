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
    
    category := CreateCapCategory( Concatenation( "Ring as category( ", String( ring )," )" ) );
    
    category!.category_as_first_argument := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
            "GeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure",
            "ColumnVectorOfGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure",
            "RingInclusionForHomomorphismStructure",
        ],
        category_filter := IsRingAsCategory,
        object_filter := IsRingAsCategoryObject,
        morphism_filter := IsRingAsCategoryMorphism,
    );
    
    SetFilterObj( category, IsRingAsCategory );
    
    SetUnderlyingRing( category, ring );
    
    SetIsAbCategory( category, true );
    
    AddObjectRepresentation( category, IsRingAsCategoryObject );
    
    AddMorphismRepresentation( category, IsRingAsCategoryMorphism and HasUnderlyingRingElement );
    
    INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( RingAsCategoryUniqueObject,
               [ IsRingAsCategory ],
               
  function( category )
    
    return ObjectifyObjectForCAPWithAttributes( rec( ),
                                                category
    );
    
end );

##
InstallMethodForCompilerForCAP( RingAsCategoryMorphismOp,
                                [ IsRingAsCategory, IsRingElement ],
                                
  function( category, element )
    local unique_object;
    
    unique_object := RingAsCategoryUniqueObject( category );
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
        rec(),
        category,
        unique_object,
        unique_object,
        UnderlyingRingElement, element
    );
    
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

##
InstallMethod( ViewObj,
               [ IsRingAsCategoryMorphism ],
               
    function( alpha )
        
        Print( ViewString( alpha ) );
        
end );

##
InstallMethod( ViewObj,
               [ IsRingAsCategoryObject ],
               
    function( obj )
        
        Print( ViewString( obj ) );
        
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY,
  
  function( category )
    local ring, equality_func, range_category, field, generating_system, indets, l, generating_system_as_column, ring_as_module, distinguished_object, interpret_element_as_row_vector, morphism_constructor, ring_inclusion, k, comb;
    
    ring := UnderlyingRing( category );
    
    ##
    AddIsEqualForObjects( category, ReturnTrue );
    
    equality_func := {cat, alpha, beta} -> UnderlyingRingElement( alpha ) = UnderlyingRingElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, {cat, x} -> IsIdenticalObj( category, CapCategory( x ) ) );
    
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
            One( ring )
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
            Zero( ring )
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
        
        SetCommutativeRingOfLinearCategory( category, ring );
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return RingAsCategoryMorphism( category, r * UnderlyingRingElement( alpha ) );
            
        end );
        
    fi;
    
    ## Homomorphism structure
    
    range_category := fail;
    
    ## Homomorphism structure for homalg exterior rings over fields
    if IsHomalgRing( ring ) and HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( BaseRing( ring ) ) then
        
        field := BaseRing( ring );
        
        range_category := CategoryOfRows( field );
        
        generating_system := [ One( ring ) ];
        
        indets := IndeterminatesOfExteriorRing( ring );
        
        l := Length( indets );
        
        for k in [ 1 .. l ] do
            for comb in Combinations( indets, k ) do
                Add( generating_system, Product( comb ) );
            od;
        od;
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        ring_as_module := function ( )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CategoryOfRowsObject( range_category, Length( generating_system ) );
            
        end;
        
        # field^{1 x 1}
        distinguished_object := function( )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CategoryOfRowsObject( range_category, 1 );
            
        end;
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CoercedMatrix( ring, field, CoefficientsWithGivenMonomials( HomalgMatrix( [ r ], 1, 1, ring ), generating_system_as_column ) );
            
        end;
        
        morphism_constructor := CategoryOfRowsMorphism;
        
        ring_inclusion := RingMap( [], field, ring );
        
    fi;
    
    ## Homomorphism structure for commutative homalg rings
    if IsHomalgRing( ring ) and HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        range_category := CategoryOfRows( ring );
        
        generating_system := [ One( ring ) ];
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        ring_as_module := function ( )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CategoryOfRowsObject( range_category, Length( generating_system ) );
            
        end;
        
        # ring^{1 x 1}
        distinguished_object := function( )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CategoryOfRowsObject( range_category, 1 );
            
        end;
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return HomalgMatrix( [ r ], 1, 1, ring );
            
        end;
        
        morphism_constructor := CategoryOfRowsMorphism;
        
        # identity
        ring_inclusion := RingMap( ring );
        
    fi;
    
    if range_category <> fail then
        
        # set attributes
        MakeImmutable( generating_system );
        SetGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure( category, generating_system );
        
        SetColumnVectorOfGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure( category, generating_system_as_column );
        
        SetRingInclusionForHomomorphismStructure( category, ring_inclusion );
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, { cat } -> distinguished_object( ) );
        
        ##
        AddHomomorphismStructureOnObjects( category, { cat, a, b } -> ring_as_module( ) );
        
        ##
        AddHomomorphismStructureOnMorphisms( category,
          function( cat, alpha, beta )
            local a, b, rows;
            
            a := UnderlyingRingElement( alpha );
            b := UnderlyingRingElement( beta );
            
            rows := List( generating_system, function( generator )
              local res, element;
                
                element := a * (generator * b);
                
                res := interpret_element_as_row_vector( element );
                
                return res;
                
            end );
            
            return morphism_constructor( range_category, ring_as_module( ), UnionOfRows( UnderlyingRing( range_category ), Length( generating_system ), rows ), ring_as_module( ) );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( cat, alpha )
            local decomposition;
            
            decomposition := interpret_element_as_row_vector( UnderlyingRingElement( alpha ) );
            
            return morphism_constructor( range_category, distinguished_object( ), decomposition, ring_as_module( ) );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, a, b, mor )
            local element;
            
            element := EntriesOfHomalgMatrix( Pullback( ring_inclusion, UnderlyingMatrix( mor ) ) * generating_system_as_column )[1];
            
            return RingAsCategoryMorphism( category, element );
            
        end );
        
    fi;
    
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
