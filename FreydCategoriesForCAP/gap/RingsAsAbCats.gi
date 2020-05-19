#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#############################################################################

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
    local unique_object;
    
    unique_object := rec( );
    
    ObjectifyObjectForCAPWithAttributes( unique_object,
                                         category
    );
    
    return unique_object;
    
end );

##
InstallMethod( RingAsCategoryMorphismOp,
               [ IsRingAsCategory, IsObject ],
               
  function( category, element )
    local morphism, unique_object;
    
    morphism := rec( );
    
    unique_object := RingAsCategoryUniqueObject( category );
    
    ## this is a "compiled" version of ObjectifyMorphismForCAPWithAttributes
    ObjectifyWithAttributes( morphism, category!.morphism_type,
                             Source, unique_object,
                             Range, unique_object,
                             UnderlyingRingElement, element,
                             CapCategory, category
    );
    
    return morphism;
    
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
    local ring, equality_func;
    
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
