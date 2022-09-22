# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallGlobalFunction( InfoStringOfInstalledOperationsOfCategory,
  
  function( category )
    local list_of_mathematical_properties, list_of_potential_algorithmic_properties,
          list_of_algorithmic_properties, list_of_maximal_algorithmic_properties, property, string;
    
    if not IsCapCategory( category ) then
        Error( "first argument must be a category" );
        return;
    fi;
    
    list_of_mathematical_properties := ListKnownCategoricalProperties( category );

    list_of_potential_algorithmic_properties := RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD );
    
    list_of_algorithmic_properties := Intersection( list_of_mathematical_properties, list_of_potential_algorithmic_properties );
    
    list_of_algorithmic_properties := Filtered( list_of_algorithmic_properties, p -> IsEmpty( CheckConstructivenessOfCategory( category, p ) ) );
    
    list_of_maximal_algorithmic_properties := MaximalObjects( list_of_algorithmic_properties, { p1, p2 } ->
                                               IsSubset( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p2 ), CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p1 ) ) or
                                               p1 in ListImpliedFilters( ValueGlobal( p2 ) ) );
    
    StableSortBy( list_of_maximal_algorithmic_properties, p -> Length( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p ) ) );
    
    string := ShallowCopy( String( Length( ListPrimitivelyInstalledOperationsOfCategory( category ) ) ) );
    Append( string, " primitive operations were used to derive " );
    Append( string, String( Length( ListInstalledOperationsOfCategory( category ) ) ) );
    Append( string, " operations for this category" );
    if not IsEmpty( list_of_maximal_algorithmic_properties ) then
        Append( string, " which algorithmically" );
    fi;
    for property in list_of_maximal_algorithmic_properties do
        Append( string, "\n* " );
        Append( string, property );
    od;
    
    list_of_mathematical_properties := Difference( list_of_mathematical_properties, list_of_algorithmic_properties );
    
    list_of_mathematical_properties := MaximalObjects( list_of_mathematical_properties, { p1, p2 } -> p1 in ListImpliedFilters( ValueGlobal( p2 ) ) );
    
    if not IsEmpty( list_of_mathematical_properties ) then
        if not IsEmpty( list_of_algorithmic_properties ) then
            Append( string, "\nand furthermore" );
        else
            Append( string, " which" );
        fi;
        Append( string, " mathematically" );
    fi;
    for property in list_of_mathematical_properties do
        Append( string, "\n* " );
        Append( string, property );
        if property in Difference( list_of_potential_algorithmic_properties, list_of_algorithmic_properties ) then
            Append( string, " (but not yet algorithmically)" );
        fi;
    od;
    
    return string;
    
end );

InstallGlobalFunction( InfoOfInstalledOperationsOfCategory,
  
  function( category )

    Display( InfoStringOfInstalledOperationsOfCategory( category ) );
    
end );
