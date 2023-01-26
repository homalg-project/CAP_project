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
InstallMethod( RelCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local category, is_finite;
    
    ## TODO: is underlying_category regular?
    
    category := CreateCapCategory( Concatenation( "Rel( ", Name( underlying_category )," )" ) );
    
    category!.category_as_first_argument := false;
    
    SetFilterObj( category, IsRelCategory );
    
    SetUnderlyingCategory( category, underlying_category );
    
    AddObjectRepresentation( category, IsRelCategoryObject );
    
    AddMorphismRepresentation( category, IsRelCategoryMorphism );
    
    INSTALL_FUNCTIONS_FOR_RELATIONS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( RelCategoryObject,
               [ IsCapCategoryObject, IsRelCategory ],
               
  function( original_object, rel )
    
    return ObjectifyObjectForCAPWithAttributes( rec( ), rel,
                                                UnderlyingOriginalObject, original_object
    );
    
end );

##
InstallMethod( RelCategoryMorphism,
               [ IsRelCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsRelCategoryObject ],
               
  function( source, reversed_arrow, arrow, range ) 
    local rel;
    
    rel := CapCategory( source );
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
                             rec( ), rel,
                             source,
                             range,
                             Arrow, arrow,
                             ReversedArrow, reversed_arrow
    );
    
end );

##
InstallMethod( PseudoInverse,
               [ IsRelCategoryMorphism ],
               
  function( mor )
    
    return RelCategoryMorphism( 
        Range( mor ),
        Arrow( mor ),
        ReversedArrow( mor ),
        Source( mor )
    );
    
end );

##
InstallMethod( AssociatedSubobject,
               [ IsRelCategoryMorphism ],
               
  function( mor )
    
    return ImageEmbedding( 
            UniversalMorphismIntoDirectProduct( [ ReversedArrow( mor ), Arrow( mor ) ] )
    );
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_RELATIONS_CATEGORY,
  
  function( category )
    
    ##
    AddIsEqualForObjects( category,
      function( a, b ) 
        
        return IsEqualForObjects( UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( alpha, beta ) 
        local arrow_alpha, arrow_beta;
        
        arrow_alpha := Arrow( alpha );
        
        arrow_beta := Arrow( beta );
        
        return
          IsEqualForObjects( Source( arrow_alpha ), Source( arrow_beta ) )
          and
          IsEqualForMorphisms( arrow_alpha, arrow_beta )
          and
          IsEqualForMorphisms( ReversedArrow( alpha ), ReversedArrow( beta ) );
          
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( alpha, beta ) 
        
        return IsEqualAsSubobjects( 
          AssociatedSubobject( alpha ),
          AssociatedSubobject( beta )
        );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        
        return IsWellDefinedForObjects( UnderlyingOriginalObject( object ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category, 
      function( alpha ) 
        local arrow, reversed;
        
        arrow := Arrow( alpha );
        
        reversed := ReversedArrow( alpha );
        
        if not IsWellDefinedForMorphisms( arrow ) then
          
          return false;
          
        fi;
        
        if not IsWellDefinedForMorphisms( reversed ) then
          
          return false;
          
        fi;
        
        if not IsEqualForObjects( Source( arrow ), Source( reversed ) ) then
          
          return false;
          
        fi;
        
        if not IsEqualForObjects( UnderlyingOriginalObject( Range( alpha ) ), Range( arrow ) ) then
          
          return false;
          
        fi;
        
        if not IsEqualForObjects( UnderlyingOriginalObject( Source( alpha ) ), Range( reversed ) ) then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        local diagram, pi_left, pi_right;
        
        diagram := [ Arrow( alpha ), ReversedArrow( beta ) ];
        
        pi_left := ProjectionInFactorOfFiberProduct( diagram, 1 );
        
        pi_right := ProjectionInFactorOfFiberProduct( diagram, 2 );
        
        return RelCategoryMorphism( Source( alpha ),
                                    PreCompose( pi_left, ReversedArrow( alpha ) ),
                                    PreCompose( pi_right, Arrow( beta ) ),
                                    Range( beta ) 
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( object )
        local id;
        
        id := IdentityMorphism( UnderlyingOriginalObject( object ) );
        
        return RelCategoryMorphism( object, id, id, object );
        
    end );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsRelCategoryMorphism ],
    
    function( alpha )
        
        Display(  "Reversed arrow: \n" );
        
        Display( ReversedArrow( alpha ) );
        
        Display( "Arrow: \n" );
        
        Display( Arrow( alpha ) );
        
end );

##
InstallMethod(  Display,
               [ IsRelCategoryObject ],

  function( obj )
    
    Display( UnderlyingOriginalObject( obj ) );
    
end );

####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
               [ IsCapCategoryObject, IsRelCategory ],
               RelCategoryObject );

##
InstallOtherMethod( \/,
               [ IsCapCategoryMorphism, IsRelCategory ],
               
  function( mor, rel )
    local source, range, id;
    
    source := Source( mor );
    
    id := IdentityMorphism( source );
    
    return RelCategoryMorphism( 
            source/rel,
            id,
            mor,
            Range( mor )/rel
    );
    
end );

##
InstallMethod( \/,
               [ IsRelCategory, IsCapCategoryMorphism ],
               
  function( rel, mor )
    
    return PseudoInverse( mor/rel );
    
end );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsRelCategoryObject ],
               UnderlyingOriginalObject );

##
InstallMethod( DownOnlyMorphismData,
               [ IsRelCategoryMorphism ],
  function( mor )
    
    return [ ReversedArrow( mor ), Arrow( mor ) ];
    
end );
