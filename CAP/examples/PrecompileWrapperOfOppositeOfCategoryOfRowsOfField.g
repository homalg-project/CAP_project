#! @Chunk WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled

#! @Example

LoadPackage( "WrapperCategories", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
category_constructor := EvalString( ReplacedString( """function( field )
  local matrix_category, op, object_constructor, object_datum, morphism_constructor, morphism_datum, wrapper@
    
    matrix_category := CategoryOfRows( field : FinalizeCategory := true )@
    
    op := Opposite( matrix_category : FinalizeCategory := true, only_primitive_operations := true )@
    
    ##
    object_constructor := function( cat, underlying_object )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    RankOfObject, RankOfObject( Opposite( underlying_object ) ) )@
        
    end@
    
    ##
    object_datum := function( cat, obj )
      local op, matrix_category@
        
        op := UnderlyingCategory( cat )@
        
        matrix_category := Opposite( op )@
        
        return ObjectConstructor( op, CategoryOfRowsObject( matrix_category, RankOfObject( obj ) ) )@
        
    end@
    
    ##
    morphism_constructor := function( cat, source, underlying_morphism, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                source,
                range,
                UnderlyingMatrix, UnderlyingMatrix( Opposite( underlying_morphism ) ) )@
        
    end@
    
    ##
    morphism_datum := function( cat, mor )
      local op, matrix_category, matrix_morphism@
        
        op := UnderlyingCategory( cat )@
        
        matrix_category := Opposite( op )@
        
        matrix_morphism := CategoryOfRowsMorphism(
            matrix_category,
            CategoryOfRowsObject( matrix_category, RankOfObject( Range( mor ) ) ),
            UnderlyingMatrix( mor ),
            CategoryOfRowsObject( matrix_category, RankOfObject( Source( mor ) ) )
        )@
        
        return MorphismConstructor(
            op,
            ObjectConstructor( op, Range( matrix_morphism ) ),
            matrix_morphism, 
            ObjectConstructor( op, Source( matrix_morphism ) )
        )@
        
    end@
    
    wrapper := WrapperCategory( op, rec(
        name := "Columns( Q )",
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        only_primitive_operations := true,
    ) )@
    
    SetUnderlyingRing( wrapper, field )@
    
    Add( wrapper!.compiler_hints.category_attribute_names, "UnderlyingRing" )@
    
    wrapper!.compiler_hints.source_and_range_attributes_from_morphism_attribute := rec(
        object_attribute_name := "RankOfObject",
        morphism_attribute_name := "UnderlyingMatrix",
        source_attribute_getter_name := "NrColumns",
        range_attribute_getter_name := "NrRows",
    )@
    
    return wrapper@
    
end""", "@", ";" ) );;

given_arguments := [ QQ ];;
compiled_category_name := "WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled";;
package_name := "WrapperCategories";;
operations := "primitive";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);
#! WARNING: Could not resolve all CAP operations while precompiling HomomorphismS\
#! tructureOnMorphismsWithGivenObjects.
#! WARNING: Could not resolve all CAP operations while precompiling InterpretMorp\
#! hismFromDistinguishedObjectToHomomorphismStructureAsMorphism.

ReadPackage(
    "WrapperCategories",
    "gap/precompiled_categories/WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled.gi"
);;
WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled( QQ );
#! Columns( Q )

#! @EndExample
