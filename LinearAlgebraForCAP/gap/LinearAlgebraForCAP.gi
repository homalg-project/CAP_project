# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

InstallMethod( MatrixCategory,
               [ IsFieldForHomalg ],
               
  function( homalg_field )
    local category;
    
    category := CreateCapCategoryWithDataTypes(
        Concatenation( "Category of matrices over ", RingName( homalg_field ) ), IsMatrixCategory,
        IsVectorSpaceObject, IsVectorSpaceMorphism, IsCapCategoryTwoCell,
        IsInt, rec( filter := IsHomalgMatrix, ring := homalg_field ), fail
    );
    
    category!.supports_empty_limits := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
        source_and_range_attributes_from_morphism_attribute := rec(
            object_attribute_name := "AsInteger",
            morphism_attribute_name := "AsHomalgMatrix",
            source_attribute_getter_name := "NumberRows",
            range_attribute_getter_name := "NumberColumns",
        ),
    );
    
    # this cache replaces the KeyDependentOperation caching when using ObjectConstructor directly instead of MatrixCategoryObject
    SetCachingToWeak( category, "ObjectConstructor" );
    
    category!.field_for_matrix_category := homalg_field;
    
    SetUnderlyingRing( category, homalg_field );
    
    SetIsSkeletalCategory( category, true );
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    SetIsAbelianCategoryWithEnoughInjectives( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    SetIsAdditiveMonoidalCategory( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsRigidSymmetricCoclosedMonoidalCategory( category, true );
    
    SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category, true );
    
    SetCommutativeRingOfLinearCategory( category, homalg_field );
    
    SetRangeCategoryOfHomomorphismStructure( category, category );
    SetIsEquippedWithHomomorphismStructure( category, true );
    
    if ValueOption( "no_precompiled_code" ) = true then
        
        if IsPackageMarkedForLoading( "AdditiveClosuresForCAP", ">= 2025.06-01" ) then
            
            category := MatrixCategory_as_CategoryOfRows( homalg_field );
            
        else
            
            Error( "To get a version of `MatrixCategory` without precompiled code, the package `AdditiveClosuresForCAP` is required." );
            
        fi;
        
    else
        
        ADD_FUNCTIONS_FOR_MatrixCategory_precompiled( category );
        
    fi;
    
    #= comment for Julia
    if category!.overhead then
        
        ## TODO: Logic for MatrixCategory
        AddPredicateImplicationFileToCategory( category,
          Filename(
            DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
            "PredicateImplicationsForMatrixCategory.tex" )
        );
        
    fi;
    # =#
    
    Finalize( category );
    
    return category;
    
end );
