# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallGlobalFunction( InfoStringOfInstalledOperationsOfCategory,
  
  function( category )
    local result, MaximalPropertiesWithRegardToImplication, list_of_potential_categorical_properties, list_of_mathematical_properties,
          list_of_potential_algorithmic_properties, list_of_algorithmic_and_not_yet_algorithmic_properties,
          list_of_algorithmic_properties, list_of_maximal_algorithmic_properties,
          list_of_not_yet_algorithmic_properties, list_of_maximal_not_yet_algorithmic_properties,
          property,
          list_of_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties, list_of_maximal_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties;
    
    if not IsCapCategory( category ) then
        Error( "first argument must be a category" );
        return;
    fi;
    
    result := String( Length( ListPrimitivelyInstalledOperationsOfCategory( category ) ) );
    result := Concatenation( result, " primitive operations were used to derive " );
    result := Concatenation( result, String( Length( ListInstalledOperationsOfCategory( category ) ) ) );
    result := Concatenation( result, " operations for this category" );
    
    MaximalPropertiesWithRegardToImplication := function ( list_of_properties )
        
        return MaximalObjects( list_of_properties, { p1, p2 } -> IsSpecializationOfFilter( ValueGlobal( p1 ), ValueGlobal( p2 ) ) );
        
    end;
    
    list_of_potential_categorical_properties := Set( Filtered( Concatenation( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST ), x -> x <> fail ) );
    
    list_of_mathematical_properties := ListKnownCategoricalProperties( category );
    
    list_of_potential_algorithmic_properties := SortedList( RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ) );
    
    # check that all potential algorithmic properties except "IsCapCategory" are potential categorical properties
    Assert( 0, Difference( list_of_potential_algorithmic_properties, list_of_potential_categorical_properties ) = [ "IsCapCategory" ] );
    
    list_of_algorithmic_and_not_yet_algorithmic_properties := Intersection( list_of_mathematical_properties, list_of_potential_algorithmic_properties );
    
    list_of_algorithmic_properties := Filtered( list_of_algorithmic_and_not_yet_algorithmic_properties, p -> IsEmpty( MissingOperationsForConstructivenessOfCategory( category, p ) ) );
    
    list_of_maximal_algorithmic_properties := MaximalPropertiesWithRegardToImplication( list_of_algorithmic_properties );
    
    StableSortBy( list_of_maximal_algorithmic_properties, p -> Length( ListOfDefiningOperations( p ) ) );
    
    if not IsEmpty( list_of_maximal_algorithmic_properties ) then
        
        result := Concatenation( result, " which algorithmically" );
        
        for property in list_of_maximal_algorithmic_properties do
            
            result := Concatenation( result, "\n* " );
            result := Concatenation( result, property );
            
        od;
    fi;
    
    list_of_not_yet_algorithmic_properties := Difference( list_of_algorithmic_and_not_yet_algorithmic_properties, list_of_algorithmic_properties );
    
    list_of_maximal_not_yet_algorithmic_properties := MaximalPropertiesWithRegardToImplication( list_of_not_yet_algorithmic_properties );
    
    StableSortBy( list_of_maximal_not_yet_algorithmic_properties, p -> Length( ListOfDefiningOperations( p ) ) );
    
    if not IsEmpty( list_of_maximal_not_yet_algorithmic_properties ) then
        
        if IsEmpty( list_of_maximal_algorithmic_properties ) then
            result := Concatenation( result, " which" );
        else
            result := Concatenation( result, "\nand" );
        fi;
        
        result := Concatenation( result, " not yet algorithmically" );
        
        for property in list_of_maximal_not_yet_algorithmic_properties do
            result := Concatenation( result, "\n* " );
            result := Concatenation( result, property );
        od;
        
    fi;
    
    ## Finally, capture the remaining mathematical properties influencing the derivation mechanism:
    list_of_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties :=
      Filtered( list_of_mathematical_properties, pm -> not ForAny( list_of_algorithmic_and_not_yet_algorithmic_properties, pa -> IsSpecializationOfFilter( ValueGlobal( pm ), ValueGlobal( pa ) ) ) );
    
    list_of_maximal_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties :=
      MaximalPropertiesWithRegardToImplication( list_of_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties );
    
    if not IsEmpty( list_of_maximal_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties ) then
        
        if IsEmpty( list_of_maximal_algorithmic_properties ) and IsEmpty( list_of_maximal_not_yet_algorithmic_properties ) then
            result := Concatenation( result, " which" );
        else
            result := Concatenation( result, "\nand furthermore" );
        fi;
        result := Concatenation( result, " mathematically" );
        
        for property in list_of_maximal_mathematical_properties_not_implied_by_algorithmic_or_not_yet_algorithmic_properties do
            result := Concatenation( result, "\n* " );
            result := Concatenation( result, property );
        od;
        
    fi;
    
    return result;
    
end );

InstallGlobalFunction( InfoOfInstalledOperationsOfCategory,
  
  function( category )

    Display( InfoStringOfInstalledOperationsOfCategory( category ) );
    
end );
