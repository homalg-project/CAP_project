# SPDX-License-Identifier: GPL-2.0-or-later
# GroupsAsCategoriesForCAP: Groups as categories on one object
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( GroupAsCategory,
               [ IsGroup ],
               
  function( group )
    local group_name, category, is_finite;
    
    if HasName( group ) then
        group_name := Name( group );
    elif HasStructureDescription( group ) then
        group_name := StructureDescription( group );
    else
        group_name := String( group );
    fi;
    
    category :=
      CreateCapCategoryWithDataTypes(
              Concatenation( "GroupAsCategory( ", group_name," )" ),
              IsGroupAsCategory,
              IsGroupAsCategoryObject,
              IsGroupAsCategoryMorphism,
              IsCapCategoryTwoCell,
              fail,
              CapJitDataTypeOfElementOfGroup( group ),
              fail
              : overhead := false );
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingGroup",
        ],
    );
    
    SetUnderlyingGroup( category, group );
    
    SetIsObjectFiniteCategory( category, true );
    
    is_finite := HasIsFinite( group ) and IsFinite( group );
    
    if is_finite then
        
        SetIsFiniteCategory( category, true );
        
        if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" ) then
            
            SET_HOMOMORPHISM_STRUCTURE_ATTRIBUTES_FOR_GROUP_AS_CATEGORY( category );
            
        fi;
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY( category, is_finite );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( GroupAsCategoryUniqueObject,
               [ IsGroupAsCategory ],
               
  function( category )
    
    return CreateCapCategoryObjectWithAttributes( category );
    
end );

##
InstallMethod( GroupAsCategoryMorphismOp,
               [ IsGroupAsCategory, IsObject ],
               
  function( category, element )
    local unique_object;
    
    unique_object := GroupAsCategoryUniqueObject( category );
    
    return CreateCapCategoryMorphismWithAttributes( category,
                                                    unique_object,
                                                    unique_object,
                                                    UnderlyingGroupElement, element );
    
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
    AddIsEqualForObjects( category, {cat, a, b} -> true );
    
    equality_func := {cat, alpha, beta} -> UnderlyingGroupElement( alpha ) = UnderlyingGroupElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, {cat, x} -> IsIdenticalObj( category, CapCategory( x ) ) );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, alpha )
        
        return UnderlyingGroupElement( alpha ) in UnderlyingGroup( category );
        
    end );
    
    ##
    AddPreCompose( category,
      function( cat, alpha, beta )
        
        return GroupAsCategoryMorphism(
            category,
            UnderlyingGroupElement( alpha ) * UnderlyingGroupElement( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( cat, unique_object )
        
        return GroupAsCategoryMorphism(
            category,
            One( group )
        );
        
    end );
    
    ##
    AddInverseForMorphisms( category,
      function( cat, alpha )
        
        return  GroupAsCategoryMorphism(
            category,
            Inverse( UnderlyingGroupElement( alpha ) )
        );
        
    end );
    
    ##
    AddIsIsomorphism( category, {cat, mor} -> true );
    
    ##
    AddIsEpimorphism( category, {cat, mor} -> true );
    
    ##
    AddIsMonomorphism( category, {cat, mor} -> true );
    
    ##
    AddIsLiftable( category, {cat, mor1, mor2} -> true );
    
    ##
    AddIsColiftable( category, {cat, mor1, mor2} -> true );
    
    ##
    AddLift( category,
        function( cat, alpha, beta )
            return  GroupAsCategoryMorphism(
            category,
            UnderlyingGroupElement( alpha ) * Inverse( UnderlyingGroupElement( beta ) )
        );
    end );
    
    ##
    AddColift( category,
        function( cat, alpha, beta )
            return  GroupAsCategoryMorphism(
            category,
            Inverse( UnderlyingGroupElement( alpha ) ) * UnderlyingGroupElement( beta )
        );
    end );
    
    ##
    AddSetOfObjectsOfCategory( category,
      function( cat )
        
        return [ GroupAsCategoryUniqueObject( cat ) ];
        
    end );
        
    if is_finite then
        
        elements := ElementsOfUnderlyingGroup( category );
        
        ##
        AddSetOfMorphismsOfFiniteCategory( category,
          function( cat )
            
            return List( elements, el -> GroupAsCategoryMorphism( category, el ) );
            
        end );
        
        if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" ) then
            
            INSTALL_HOMOMORPHISM_STRUCTURE_FOR_GROUP_AS_CATEGORY( category );
            
        fi;
        
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

InstallOtherMethod( \/,
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
