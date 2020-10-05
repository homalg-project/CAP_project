#
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
               
  function( ring )
    local finalize_option, category;
    
    finalize_option := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "FinalizeCategory", true );
    
    category := CreateCapCategory( Concatenation( "Ring as category( ", String( ring )," )" ) );
    
    SetFilterObj( category, IsRingAsCategory );
    
    SetUnderlyingRing( category, ring );
    
    SetIsAbCategory( category, true );
    
    AddObjectRepresentation( category, IsRingAsCategoryObject );
    
    AddMorphismRepresentation( category, IsRingAsCategoryMorphism and HasUnderlyingRingElement );
    
    INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY( category );
    
    if finalize_option then
        
        Finalize( category );
        
    fi;
    
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
InstallMethod( RingAsCategoryMorphismOp,
               [ IsRingAsCategory, IsObject ],
               
  function( category, element )
    local unique_object;
    
    unique_object := RingAsCategoryUniqueObject( category );
    
    ## this is a "compiled" version of ObjectifyMorphismForCAPWithAttributes
    return ObjectifyWithAttributes( rec(), category!.morphism_type,
                                    Source, unique_object,
                                    Range, unique_object,
                                    UnderlyingRingElement, element,
                                    CapCategory, category
    );
    
end );

##
InstallOtherMethod( RingAsCategoryMorphism,
               [ IsObject, IsRingAsCategory ],
               
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
    
    equality_func := {alpha, beta} -> UnderlyingRingElement( alpha ) = UnderlyingRingElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, x -> IsIdenticalObj( category, CapCategory( x ) ) );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( alpha )
        
        return UnderlyingRingElement( alpha ) in UnderlyingRing( category );
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) * UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( unique_object )
        
        return RingAsCategoryMorphism(
            category,
            One( ring )
        );
        
    end );
    
    ##
    AddIsOne( category,
      function( alpha )
        
        return IsOne( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( a, b )
        
        return RingAsCategoryMorphism(
            category,
            Zero( ring )
        );
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( alpha )
        
        return IsZero( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) + UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( alpha )
        
        return RingAsCategoryMorphism(
            category,
            - UnderlyingRingElement( alpha )
        );
        
    end );

    ## Homomorphism structure
    
    range_category := fail;
    
    ## Homomorphism structure for homalg exterior rings over fields
    if IsHomalgRing( ring ) and HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( CoefficientsRing( ring ) ) then
        
        field := CoefficientsRing( ring );
        
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
        
        ring_as_module := CategoryOfRowsObjectOp( range_category, Length( generating_system ) );
        
        # field^{1 x 1}
        distinguished_object := CategoryOfRowsObjectOp( range_category, 1 );
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CoefficientsWithGivenMonomials( HomalgMatrix( [ r ], 1, 1, ring ), generating_system_as_column ) * field;
            
        end;
        
        morphism_constructor := CategoryOfRowsMorphism;
        
        ring_inclusion := RingMap( [], field, ring );
        
    fi;
    
    ## Homomorphism structure for commutative homalg rings
    if IsHomalgRing( ring ) and HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        range_category := CategoryOfRows( ring );
        
        generating_system := [ One( ring ) ];
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        ring_as_module := CategoryOfRowsObjectOp( range_category, Length( generating_system ) );
        
        # ring^{1 x 1}
        distinguished_object := CategoryOfRowsObjectOp( range_category, 1 );
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return HomalgMatrix( [ r ], 1, 1, ring );
            
        end;
        
        morphism_constructor := CategoryOfRowsMorphism;
        
        # identity
        ring_inclusion := RingMap( ring );
        
    fi;
    
    if range_category <> fail then
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, {} -> distinguished_object );
        
        ##
        AddHomomorphismStructureOnObjects( category, {a,b} -> ring_as_module );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( source, alpha, beta, range )
            local a, b, rows;
            
            a := UnderlyingRingElement( alpha );
            b := UnderlyingRingElement( beta );
            
            rows := List( generating_system, function( generator )
              local res, element;
                
                element := a * (generator * b);
                
                res := interpret_element_as_row_vector( element );
                
                return res;
                
            end );
            
            return morphism_constructor( ring_as_module, UnionOfRows( rows ), ring_as_module );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( alpha )
            local decomposition;
            
            decomposition := interpret_element_as_row_vector( UnderlyingRingElement( alpha ) );
            
            return morphism_constructor( distinguished_object, decomposition, ring_as_module );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( a, b, mor )
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

InstallMethod( \/,
               [ IsObject, IsRingAsCategory ],
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
