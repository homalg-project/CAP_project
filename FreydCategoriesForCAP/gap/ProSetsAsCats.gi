#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2020, Tal Gottesman, Paris Diderot, Sebastian Posur, University of Siegen
##
#############################################################################

####################################
##
## Constructors
##
####################################

## TODO: create a meaningful sanity check
InstallGlobalFunction( PRO_SET_AS_CATEGORY_SANITY_CHECK,
  function( incidence_matrix ) 
    
    return true;
    
end );

##
InstallMethod( ProSetAsCategory,
               [ IsList ],
               
  function( incidence_matrix )
    local category;
    
    if not PRO_SET_AS_CATEGORY_SANITY_CHECK( incidence_matrix ) then
        
        Error( "the input is not a valid incidence matrix" );
        
    fi;
    
    category := CreateCapCategory( "ProSet" : overhead := false );
    
    SetFilterObj( category, IsProSetAsCategory );
    
    SetIncidenceMatrix( category, incidence_matrix );
    
    AddObjectRepresentation( category, IsProSetAsCategoryObject );
    
    AddMorphismRepresentation( category, IsProSetAsCategoryMorphism );
    
    SetRangeCategoryOfHomomorphismStructure( category, FREYD_CATEGORIES_SkeletalFinSets );
    
    INSTALL_FUNCTIONS_FOR_PROSET_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( Size,
               [ IsProSetAsCategory ],
               
  function( category )
    
    return Size( IncidenceMatrix( category ) );
    
end );

##
InstallMethod( ProSetAsCategoryObject,
               [ IsInt, IsProSetAsCategory ],
               
  function( number_object, category ) 
    local object;
    ## TODO: sanity check: is number_object in the range [ 1 .. n ]?
    
    if not number_object in [ 1 .. Size( category ) ] then
        
        Error( Concatenation( String( number_object ), " must lie between 1 and ", String( Size( category ) ) ) );
        
    fi;
    
    object := rec( );
    
    ObjectifyObjectForCAPWithAttributes( object, category,
                                         UnderlyingInteger, number_object
    );
    
    return object;
    
end );

InstallMethod( ProSetAsCategoryMorphism,
               [ IsProSetAsCategoryObject, IsProSetAsCategoryObject ],
               
  function( source, range ) 
    local category, morphism;
    
    category := CapCategory( source );
    
    ## Santiy check
    
    if not IsIdenticalObj( CapCategory( range ), category ) then
        
        Error( "the two given objects have to lie in the same category" );
        
    fi;
    
    if not IncidenceMatrix( category )[ UnderlyingInteger( source ) ][ UnderlyingInteger( range ) ] = 1 then
        
        Error( "there is no morphism between the two given objects" );
        
    fi;
    
    morphism := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( 
                             morphism, category,
                             source,
                             range
    );
    
    return morphism;
    
end );

##
InstallMethod( ProSetAsCategoryMorphism,
               [ IsInt, IsInt, IsProSetAsCategory ],
               
  function( int_source, int_range, category ) 
    
    return ProSetAsCategoryMorphism( 
        ProSetAsCategoryObject( int_source, category ),
        ProSetAsCategoryObject( int_range, category )
    );
    
end );

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_PROSET_AS_CATEGORY,
  function( category )
    
    ##
    AddIsEqualForObjects( category,
        function( a, b ) 
            
            return UnderlyingInteger( a ) = UnderlyingInteger( b );
            
    end );
    
    ##
    AddIsEqualForMorphisms( category, ReturnTrue );
    
    ##
    AddIsCongruentForMorphisms( category, ReturnTrue );
    
    ##
    AddIsWellDefinedForObjects( category,
      function( obj ) 
        
        ## tests if the object satisfies our specification
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category, 
      function( alpha ) 
        
        ## tests if the morphism satisfies our specification
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        
        ## a -- alpha --> b -- beta --> c
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( obj )
        
        ## Id( obj )
        
    end );
    
    ##
    AddInverse( category,
      function( alpha )
        
        ## check if inverse exists,
        ##  if not -> return fail
        ##  if yes -> return inverse
        
    end );
    
    ##
    AddIsIsomorphism( category, 
      function( alpha ) 
        
        
        
    end );
    
    ##
    AddIsEpimorphism( category, 
      function( alpha ) 
        
        
        
    end );
    
    ##
    AddIsMonomorphism( category, 
      function( alpha ) 
        
        
        
    end );
    
    ##
    AddIsLiftable( category, 
      function( alpha, beta )
      
      ## decision: if the lift exists
      
    end );
    
    ##
    AddIsColiftable( category, function( alpha, beta )
      
      ## decision: if the colift exists
      
    end );
    
    ##
    AddLift( category, 
        function( alpha, beta )
      
      ## decision: if the lift exists
      ## if it does not exist -> fail
      ##  if it exists -> output the lift
      
    end );
    
    ##
    AddColift( category, 
        function( alpha, beta )
      
      ## decision: if the colift exists
      ## if it does not exist -> fail
      ##  if it exists -> output the colift
      
    end );
        
    ## Homomorphism structure
    AddHomomorphismStructureOnObjects( category,
      function( a, b )
        
    end );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
      function( source, alpha, beta, range )
        
    end );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function()
        
    end );
        
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
      function( alpha )
        
    end );
        
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( a, b, mor )
        
    end );
    
end );



####################################
##
## View
##
####################################

# ##
# InstallMethod( ViewString,
#                [ IsProSetAsCategoryMorphism ],
    
#     function( alpha )
        
#         return Concatenation( "<", ViewString( UnderlyingProSetElement( alpha ) ), ">" );
        
# end );

##
InstallMethod( ViewString,
               [ IsProSetAsCategoryObject ],

  function( obj )
    
    return String( UnderlyingInteger( obj ) );
    
end );

##
# InstallMethod( ViewObj,
#                [ IsProSetAsCategoryMorphism ],
               
#     function( alpha )
        
#         Print( ViewString( alpha ) );
        
# end );

##
InstallMethod( ViewObj,
               [ IsProSetAsCategoryObject ],
               
    function( obj )
        
        Print( ViewString( obj ) );
        
end );

