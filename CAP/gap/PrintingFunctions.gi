# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallGlobalFunction( InfoStringOfInstalledOperationsOfCategory,
  
  function( category )
    local list_of_mathematical_properties, list_of_potential_algorithmic_properties,
          list_of_algorithmic_properties, list_of_maximal_algorithmic_properties, property, result,
          list_of_non_algorithmic_mathematical_properties, list_of_maximal_non_algorithmic_mathematical_properties;
    
    if not IsCapCategory( category ) then
        Error( "first argument must be a category" );
        return;
    fi;
    
    list_of_mathematical_properties := ListKnownCategoricalProperties( category );
    
    list_of_potential_algorithmic_properties := RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD );
    
    list_of_algorithmic_properties := Filtered( list_of_mathematical_properties, p -> p in list_of_potential_algorithmic_properties and IsEmpty( CheckConstructivenessOfCategory( category, p ) ) );
    
    list_of_maximal_algorithmic_properties := MaximalObjects( list_of_algorithmic_properties, { p1, p2 } ->
                                               IsSubset( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p2 ), CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p1 ) ) or
                                               p1 in ListImpliedFilters( ValueGlobal( p2 ) ) );
    
    StableSortBy( list_of_maximal_algorithmic_properties, p -> Length( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p ) ) );
    
    result := String( Length( ListPrimitivelyInstalledOperationsOfCategory( category ) ) );
    result := Concatenation( result, " primitive operations were used to derive " );
    result := Concatenation( result, String( Length( ListInstalledOperationsOfCategory( category ) ) ) );
    result := Concatenation( result, " operations for this category" );
    if not IsEmpty( list_of_maximal_algorithmic_properties ) then
        result := Concatenation( result, " which algorithmically" );
        for property in list_of_maximal_algorithmic_properties do
            result := Concatenation( result, "\n* " );
            result := Concatenation( result, property );
        od;
    fi;
    
    list_of_non_algorithmic_mathematical_properties := Difference( list_of_mathematical_properties, list_of_algorithmic_properties );
    
    list_of_maximal_non_algorithmic_mathematical_properties := MaximalObjects( list_of_non_algorithmic_mathematical_properties, { p1, p2 } -> p1 in ListImpliedFilters( ValueGlobal( p2 ) ) );
    
    if not IsEmpty( list_of_maximal_non_algorithmic_mathematical_properties ) then
        if not IsEmpty( list_of_maximal_algorithmic_properties ) then
            result := Concatenation( result, "\nand furthermore" );
        else
            result := Concatenation( result, " which" );
        fi;
        result := Concatenation( result, " mathematically" );
        for property in list_of_maximal_non_algorithmic_mathematical_properties do
            result := Concatenation( result, "\n* " );
            result := Concatenation( result, property );
            if property in list_of_potential_algorithmic_properties then
                result := Concatenation( result, " (but not yet algorithmically)" );
            fi;
        od;
    fi;
    
    return result;
    
end );

InstallGlobalFunction( InfoOfInstalledOperationsOfCategory,
  
  function( category )

    Display( InfoStringOfInstalledOperationsOfCategory( category ) );
    
end );
