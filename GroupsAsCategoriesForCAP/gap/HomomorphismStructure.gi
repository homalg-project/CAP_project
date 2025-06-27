# SPDX-License-Identifier: GPL-2.0-or-later
# GroupsAsCategoriesForCAP: Groups as categories on one object
#
# Implementations
#

BindGlobal( "GROUPS_AS_CATEGORIES_SkeletalFinSets", SkeletalCategoryOfFiniteSets( : overhead := false ) );

InstallGlobalFunction( SET_HOMOMORPHISM_STRUCTURE_ATTRIBUTES_FOR_GROUP_AS_CATEGORY,
  
  function( category )
    
    SetRangeCategoryOfHomomorphismStructure( category, GROUPS_AS_CATEGORIES_SkeletalFinSets );
    SetIsEquippedWithHomomorphismStructure( category, true );
    
end );

InstallGlobalFunction( INSTALL_HOMOMORPHISM_STRUCTURE_FOR_GROUP_AS_CATEGORY,
  
  function( category )
    local sets, t_obj, elements, size, RG, HOM_PERMUTATION_ARRAY;
    
    sets := RangeCategoryOfHomomorphismStructure( category );
    
    t_obj := TerminalObject( sets );
    
    elements := ElementsOfUnderlyingGroup( category );
    
    size := Length( elements );
    
    RG := FinSet( GROUPS_AS_CATEGORIES_SkeletalFinSets, size );
    
    ## Homomorphism structure
    ##
    ## Warning: the hom structure is costly for big finite groups.
    ## TODO: Only do a preprocessing for small groups
    AddHomomorphismStructureOnObjects( category,
      function( cat, a, b )
        
        return RG;
        
    end );
    
    ## Precomputatation of the multiplication maps
    ## [g,h] -> List encoding the multiplication map (x -> G[g] * x * G[h])
    
    ## take Size( SymmetricGroup( 5 ) ) as a first guess
    if size <= 120 then
        
        ## heavy precomputation, only do for reasonable sizes
        
        HOM_PERMUTATION_ARRAY :=
            List( [ 1 .. size ], g ->
                List( [ 1 .. size ], h ->
                    List( elements, x -> -1 + Position( elements, elements[g] * x * elements[h] ) )
                )
            );
        
        ## Should this function have a cache?
        ##
        AddHomomorphismStructureOnMorphisms( category,
        function( cat, alpha, beta )
            
            return MapOfFinSets(
                    GROUPS_AS_CATEGORIES_SkeletalFinSets,
                    RG,
                    HOM_PERMUTATION_ARRAY[ PositionWithinElements( alpha ) ][ PositionWithinElements( beta ) ],
                    RG
            );
        
        end );
        
    else
        
        ## Should this function have a cache?
        ##
        AddHomomorphismStructureOnMorphisms( category,
        function( cat, alpha, beta )
            
            return MapOfFinSets(
                    GROUPS_AS_CATEGORIES_SkeletalFinSets,
                    RG,
                    List( elements, x -> -1 + Position( elements, elements[PositionWithinElements( alpha )] * x * elements[PositionWithinElements( beta )] ) ),
                    RG
            );
            
        end );
        
    fi;
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function( cat )
        
        return t_obj;
        
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
      function( cat, alpha )
        return MapOfFinSets(
            GROUPS_AS_CATEGORIES_SkeletalFinSets,
            t_obj,
            [ -1 + PositionWithinElements( alpha ) ],
            RG
        );
    end );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( cat, a, b, mor )
        return GroupAsCategoryMorphism(
            category,
            elements[ 1 + AsList( mor )[1] ]
        );
    end );
    
end );
