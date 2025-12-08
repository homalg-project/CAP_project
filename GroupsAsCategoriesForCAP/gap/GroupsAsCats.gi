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
    local group_name, group_as_category, is_finite;
    
    if HasName( group ) then
        group_name := Name( group );
    elif HasStructureDescription( group ) then
        group_name := StructureDescription( group );
    else
        group_name := String( group );
    fi;
    
    group_as_category :=
      CreateCapCategoryWithDataTypes(
              Concatenation( "GroupAsCategory( ", group_name," )" ),
              IsGroupAsCategory,
              IsGroupAsCategoryObject,
              IsGroupAsCategoryMorphism,
              IsCapCategoryTwoCell,
              IsBool,
              CapJitDataTypeOfElementOfGroup( group ),
              fail
              : overhead := false );
    
    group_as_category!.compiler_hints :=
      rec( category_attribute_names := [
              "UnderlyingGroup",
              ],
           );
    
    SetUnderlyingGroup( group_as_category, group );
    
    SetIsObjectFiniteCategory( group_as_category, true );
    
    is_finite := HasIsFinite( group ) and IsFinite( group );
    
    if is_finite then
        
        SetIsFiniteCategory( group_as_category, true );
        
        if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" ) then
            
            SET_HOMOMORPHISM_STRUCTURE_ATTRIBUTES_FOR_GROUP_AS_CATEGORY( group_as_category );
            
        fi;
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY( group_as_category, is_finite );
    
    Finalize( group_as_category );
    
    return group_as_category;
    
end );

##
InstallMethodForCompilerForCAP( GroupAsCategoryUniqueObject,
        [ IsGroupAsCategory ],
        
  function( group_as_category )
    
    return ObjectConstructor( group_as_category, true );
    
end );

##
InstallMethodForCompilerForCAP( GroupAsCategoryMorphism,
        [ IsGroupAsCategory, IsMultiplicativeElementWithInverse ],
        
  function( group_as_category, group_element )
    local unique_object;
    
    unique_object := GroupAsCategoryUniqueObject( group_as_category );
    
    return MorphismConstructor( group_as_category,
                   unique_object,
                   group_element,
                   unique_object );
    
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
        
  function( group_as_category )
    
    return Elements( UnderlyingGroup( group_as_category ) );
    
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
  
  function( group_as_category, is_finite )
    local group;
    
    group := UnderlyingGroup( group_as_category );
    
    ##
    AddObjectConstructor( group_as_category,
      function( group_as_category, input )
        
        return CreateCapCategoryObjectWithAttributes( group_as_category );
        
    end );
    
    ##
    AddObjectDatum( group_as_category,
      function( group_as_category, object )
        
        return true;
        
    end );
    
    ##
    AddMorphismConstructor( group_as_category,
      function( group_as_category, source, group_element, target )

        return CreateCapCategoryMorphismWithAttributes( group_as_category,
                       source,
                       target,
                       UnderlyingGroupElement, group_element );
        
    end );
    
    ##
    AddMorphismDatum( group_as_category,
      function( group_as_category, morphism )
        
        return UnderlyingGroupElement( morphism );
        
    end );
    
    ##
    AddIsEqualForObjects( group_as_category,
      function( group_as_category, a, b )
        
        return true;
        
    end );
    
    ##
    AddIsEqualForMorphisms( group_as_category,
      function( group_as_category, alpha, beta )
        
        return UnderlyingGroupElement( alpha ) = UnderlyingGroupElement( beta );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( group_as_category,
      function( group_as_category, alpha, beta )
        
        return IsEqualForMorphisms( group_as_category, alpha, beta );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( group_as_category,
      function( group_as_category, x )
        
        return IsIdenticalObj( group_as_category, CapCategory( x ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( group_as_category,
      function( group_as_category, alpha )
        
        return UnderlyingGroupElement( alpha ) in UnderlyingGroup( group_as_category );
        
    end );
    
    ##
    AddPreCompose( group_as_category,
      function( group_as_category, alpha, beta )
        
        return GroupAsCategoryMorphism( group_as_category,
                       UnderlyingGroupElement( alpha ) * UnderlyingGroupElement( beta ) );
        
    end );
    
    ##
    AddIdentityMorphism( group_as_category,
      function( group_as_category, unique_object )
        
        return GroupAsCategoryMorphism( group_as_category,
                       One( group ) );
        
    end );
    
    ##
    AddInverseForMorphisms( group_as_category,
      function( group_as_category, alpha )
        
        return GroupAsCategoryMorphism( group_as_category,
                       Inverse( UnderlyingGroupElement( alpha ) ) );
        
    end );
    
    ##
    AddIsIsomorphism( group_as_category,
      function( group_as_category, mor )
        
        return true;
        
    end );
    
    ##
    AddIsEpimorphism( group_as_category,
      function( group_as_category, mor )
        
        return true;
        
    end );
    
    ##
    AddIsMonomorphism( group_as_category,
      function( group_as_category, mor )
        
        return true;
        
    end );
    
    ##
    AddIsLiftable( group_as_category,
      function( group_as_category, mor1, mor2 )
        
        return true;
        
    end );
    
    ##
    AddIsColiftable( group_as_category,
      function( group_as_category, mor1, mor2 )
        
        return true;
        
    end );
    
    ##
    AddLift( group_as_category,
      function( group_as_category, alpha, beta )
        
        return GroupAsCategoryMorphism( group_as_category,
                       UnderlyingGroupElement( alpha ) * Inverse( UnderlyingGroupElement( beta ) ) );
        
    end );
    
    ##
    AddColift( group_as_category,
      function( group_as_category, alpha, beta )
        
        return GroupAsCategoryMorphism( group_as_category,
                       Inverse( UnderlyingGroupElement( alpha ) ) * UnderlyingGroupElement( beta ) );
        
    end );
    
        ##
    AddSetOfObjectsOfCategory( group_as_category,
      function( group_as_category )
        
        return [ GroupAsCategoryUniqueObject( group_as_category ) ];
        
    end );
    
    if is_finite then
        
        ##
        AddSetOfMorphismsOfFiniteCategory( group_as_category,
          function( group_as_category )
            
            return List( ElementsOfUnderlyingGroup( group_as_category ), el -> GroupAsCategoryMorphism( group_as_category, el ) );
            
        end );
        
        if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" ) then
            
            INSTALL_HOMOMORPHISM_STRUCTURE_FOR_GROUP_AS_CATEGORY( group_as_category );
            
        fi;
        
    fi;
    
    if HasGeneratorsOfMagmaWithInverses( group ) then
        
        SetIsFinitelyPresentedCategory( group_as_category, true );
        
        ##
        AddSetOfGeneratingMorphismsOfCategory( group_as_category,
          function( group_as_category )
            
            return List( GeneratorsOfMagmaWithInverses( UnderlyingGroup( group_as_category ) ), el -> GroupAsCategoryMorphism( group_as_category, el ) );
            
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

InstallOtherMethod( \/,
        [ IsMultiplicativeElementWithInverse, IsGroupAsCategory ],
        
  function( group_element, group_as_category )
    
    return GroupAsCategoryMorphism( group_as_category, group_element );
    
end );

##
InstallMethod( SetOfObjects,
        [ IsGroupAsCategory ],
        
  function( cat )
    
    return SetOfObjectsOfCategory( cat );
    
end );

##
InstallMethod( SetOfGeneratingMorphisms,
        [ IsGroupAsCategory ],
        
  function( cat )
    
    return SetOfGeneratingMorphismsOfCategory( cat );
    
end );

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
