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
    
    return MATRIX_CATEGORY( homalg_field );
    
end );

InstallGlobalFunction( MATRIX_CATEGORY,
  function( homalg_field )
    local category;
    
    category := CreateCapCategoryWithDataTypes(
        Concatenation( "Category of matrices over ", RingName( homalg_field ) ), IsMatrixCategory,
        IsVectorSpaceObject and HasDimension and HasIsProjective and IsProjective, IsVectorSpaceMorphism and HasUnderlyingMatrix, IsCapCategoryTwoCell,
        IsInt, IsHomalgMatrix, fail
    );
    
    category!.category_as_first_argument := true;
    
    category!.supports_empty_limits := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
        source_and_range_attributes_from_morphism_attribute := rec(
            object_attribute_name := "Dimension",
            morphism_attribute_name := "UnderlyingMatrix",
            source_attribute_getter_name := "NumberRows",
            range_attribute_getter_name := "NumberColumns",
        ),
        category_filter := IsMatrixCategory,
        object_filter := IsVectorSpaceObject,
        morphism_filter := IsVectorSpaceMorphism,
    );
    
    # this cache replaces the KeyDependentOperation caching when using ObjectConstructor directly instead of MatrixCategoryObject
    SetCachingToWeak( category, "ObjectConstructor" );
    
    category!.field_for_matrix_category := homalg_field;
    
    SetUnderlyingRing( category, homalg_field );
    
    SetIsSkeletalCategory( category, true );
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    SetIsAbelianCategoryWithEnoughInjectives( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsRigidSymmetricCoclosedMonoidalCategory( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    SetIsLinearCategoryOverCommutativeRing( category, true );
    
    SetCommutativeRingOfLinearCategory( category, homalg_field );
    
    SetRangeCategoryOfHomomorphismStructure( category, category );
    
    if category!.overhead then
        
        ## TODO: Logic for MatrixCategory
        AddPredicateImplicationFileToCategory( category,
          Filename(
            DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
            "PredicateImplicationsForMatrixCategory.tex" )
        );
        
    fi;
    
    if ValueOption( "no_precompiled_code" ) = true then
        
        if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2022.10-14" ) then
            
            return MatrixCategoryAsCategoryOfRows( homalg_field );
            
        else
            
            Error( "To get a version of `MatrixCategory` without precompiled code, the package `FreydCategoriesForCAP` is required." );
            
        fi;
        
    else
        
        ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled( category );
        
    fi;
    
    Finalize( category );
    
    return category;
    
end );
