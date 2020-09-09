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

BindGlobal( "FREYD_CATEGORIES_SkeletalFinSets", CategoryOfSkeletalFinSets( : overhead := false ) );

##
InstallMethod( GroupAsCategory,
               [ IsGroup ],
               
  function( group )
    local category, is_finite;
    
    category := CreateCapCategory( Concatenation( "Group as category( ", String( group )," )" ) : overhead := false );
    
    SetFilterObj( category, IsGroupAsCategory );
    
    SetUnderlyingGroup( category, group );
    
    AddObjectRepresentation( category, IsGroupAsCategoryObject );
    
    AddMorphismRepresentation( category, IsGroupAsCategoryMorphism and HasUnderlyingGroupElement );
    
    is_finite := HasIsFinite( group ) and IsFinite( group );
    
    if is_finite then
        
        SetRangeCategoryOfHomomorphismStructure( category, FREYD_CATEGORIES_SkeletalFinSets );
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY( category, is_finite );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( GroupAsCategoryUniqueObject,
               [ IsGroupAsCategory ],
               
  function( category )
    
    return ObjectifyObjectForCAPWithAttributes( rec( ),
                                                category
    );
    
end );

##
InstallMethod( GroupAsCategoryMorphismOp,
               [ IsGroupAsCategory, IsObject ],
               
  function( category, element )
    local unique_object;
    
    unique_object := GroupAsCategoryUniqueObject( category );
    
    ## this is a "compiled" version of ObjectifyMorphismForCAPWithAttributes
    return ObjectifyWithAttributes( rec( ), category!.morphism_type,
                                    Source, unique_object,
                                    Range, unique_object,
                                    UnderlyingGroupElement, element,
                                    CapCategory, category
    );
    
end );

##
InstallOtherMethod( GroupAsCategoryMorphism,
               [ IsObject, IsGroupAsCategory ],
               
  function( element, category )
    
    return GroupAsCategoryMorphism( category, element );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
               [ IsGroupAsCategoryMorphism ],
    
    function( alpha )
        
        return Concatenation( "<", ViewString( UnderlyingGroupElement( alpha ) ), ">" );
        
end );

##
InstallMethod( ViewString,
               [ IsGroupAsCategoryObject ],

  function( obj )
    
    return "*";
    
end );

##
InstallMethod( ViewObj,
               [ IsGroupAsCategoryMorphism ],
               
    function( alpha )
        
        Print( ViewString( alpha ) );
        
end );

##
InstallMethod( ViewObj,
               [ IsGroupAsCategoryObject ],
               
    function( obj )
        
        Print( ViewString( obj ) );
        
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( ElementsOfUnderlyingGroup,
               [ IsGroupAsCategory ],
               
  function( CG )
    
    return Elements( UnderlyingGroup( CG ) );
    
end );

##
InstallMethod( PositionWithinElements,
               [ IsGroupAsCategoryMorphism ],
               
  function( alpha )
    
    return Position( ElementsOfUnderlyingGroup( CapCategory( alpha ) ), UnderlyingGroupElement( alpha ) );
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY,
  
  function( category, is_finite )
    local group, equality_func,
          sets, t_obj, elements, size, RG, HOM_PERMUTATION_ARRAY;
    
    group := UnderlyingGroup( category );
    
    ##
    AddIsEqualForObjects( category, ReturnTrue );
    
    equality_func := {alpha, beta} -> UnderlyingGroupElement( alpha ) = UnderlyingGroupElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, x -> IsIdenticalObj( category, CapCategory( x ) ) );
    
    ##
    AddIsWellDefinedForMorphisms( category, 
      function( alpha ) 
        
        return UnderlyingGroupElement( alpha ) in UnderlyingGroup( category );
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        
        return GroupAsCategoryMorphism( 
            category,
            UnderlyingGroupElement( alpha ) * UnderlyingGroupElement( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( unique_object )
        
        return GroupAsCategoryMorphism(
            category,
            One( group )
        );
        
    end );
    
    ##
    AddInverse( category,
      function( alpha )
        
        return  GroupAsCategoryMorphism(
            category,
            Inverse( UnderlyingGroupElement( alpha ) )
        );
        
    end );
    
    ##
    AddIsIsomorphism( category, ReturnTrue );
    
    ##
    AddIsEpimorphism( category, ReturnTrue );
    
    ##
    AddIsMonomorphism( category, ReturnTrue );
    
    ##
    AddIsLiftable( category, ReturnTrue );
    
    ##
    AddIsColiftable( category, ReturnTrue );
    
    ##
    AddLift( category, 
        function( alpha, beta )
            return  GroupAsCategoryMorphism(
            category,
            UnderlyingGroupElement( alpha ) * Inverse( UnderlyingGroupElement( beta ) )
        );
    end );
    
    ##
    AddColift( category, 
        function( alpha, beta )
            return  GroupAsCategoryMorphism(
            category,
            Inverse( UnderlyingGroupElement( alpha ) ) * UnderlyingGroupElement( beta )
        );
    end );
    
    ## Warning: the hom structure is costly for big finite groups.
    ## TODO: Only do a preprocessing for small groups
    if is_finite then
        
        sets := RangeCategoryOfHomomorphismStructure( category );
        
        t_obj := TerminalObject( sets );
        
        elements := ElementsOfUnderlyingGroup( category );
        
        size := Size( elements );
        
        RG := FinSet( FREYD_CATEGORIES_SkeletalFinSets, size );
        
        ## Homomorphism structure
        AddHomomorphismStructureOnObjects( category,
          function( a, b )
            
            return RG;
            
        end );
        
        ## Precomputatation of the multiplication maps
        ## [g,h] -> List encoding the multiplication map (x -> G[g] * x * G[h])
        
        if size <= 120 then ## take Size( SymmetricGroup( 5 ) ) as a first guess
            
            ## heavy precomputation, only do for reasonable sizes
            
            HOM_PERMUTATION_ARRAY :=
                List( [ 1 .. size ], g ->
                    List( [ 1 .. size ], h ->
                        List( elements, x -> Position( elements, elements[g] * x * elements[h] ) )
                    )
                );
            
            ## Should this function have a cache?
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
            function( source, alpha, beta, range )
                
                return MapOfFinSets(
                        RG,
                        HOM_PERMUTATION_ARRAY[ PositionWithinElements( alpha ) ][ PositionWithinElements( beta ) ],
                        RG
                );
            
            end );
            
        else
            
            ## Should this function have a cache?
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
            function( source, alpha, beta, range )
                
                return MapOfFinSets(
                        RG,
                        List( elements, x -> Position( elements, elements[PositionWithinElements( alpha )] * x * elements[PositionWithinElements( beta )] ) ),
                        RG
                );
                
            end );
            
        fi;
        
        
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
          function()
            
            return t_obj;
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( alpha )
            return MapOfFinSets(
                t_obj,
                [ PositionWithinElements( alpha ) ],
                RG
            );
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( a, b, mor )
            return GroupAsCategoryMorphism(
                category,
                elements[ AsList( mor )[1] ]
            );
        end );
        
    fi;
    
end );

####################################
##
## Convenience
##
####################################

InstallMethod( \*,
               [ IsGroupAsCategoryMorphism, IsGroupAsCategoryMorphism ],
               PreCompose );

InstallMethod( \=,
               [ IsGroupAsCategoryMorphism, IsGroupAsCategoryMorphism ],
               IsCongruentForMorphisms );

InstallMethod( \/,
               [ IsObject, IsGroupAsCategory ],
               GroupAsCategoryMorphism );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsGroupAsCategoryObject ],
  function( obj )
    
    return "*";
    
end );

##
InstallMethod( DownOnlyMorphismData,
               [ IsGroupAsCategoryMorphism ],
  function( mor )
    
    return UnderlyingGroupElement( mor );
    
end );
