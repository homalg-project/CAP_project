# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallGlobalFunction( InfoStringOfInstalledOperationsOfCategory,
  
  function( category )
    local list_of_properties, property, string;
    
    if not IsCapCategory( category ) then
        Error( "first argument must be a category" );
        return;
    fi;
    
    list_of_properties := Intersection( ListKnownCategoricalProperties( category ), RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ) );
    
    list_of_properties := Filtered( list_of_properties, p -> CheckConstructivenessOfCategory( category, p ) = [ ] );
    
    list_of_properties := MaximalObjects( list_of_properties,
                                  { p1, p2 } ->
                                  IsSubset( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p2 ), CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p1 ) ) or
                                  p1 in ListImpliedFilters( ValueGlobal( p2 ) )
                          );
    
    StableSortBy( list_of_properties, p -> Length( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( p ) ) );
    
    string := ShallowCopy( String( Length( ListPrimitivelyInstalledOperationsOfCategory( category ) ) ) );
    Append( string, " primitive operations were used to derive " );
    Append( string, String( Length( ListInstalledOperationsOfCategory( category ) ) ) );
    Append( string, " operations for this category" );
    if not IsEmpty( list_of_properties ) then
        Append( string, " which constructively" );
    fi;
    for property in list_of_properties do
        Append( string, "\n* " );
        Append( string, property );
    od;
    
    return string;
    
end );

InstallGlobalFunction( InfoOfInstalledOperationsOfCategory,
  
  function( category )

    Display( InfoStringOfInstalledOperationsOfCategory( category ) );
    
end );
