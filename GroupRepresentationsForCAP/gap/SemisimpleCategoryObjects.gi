# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Implementations
#

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsSemisimpleCategoryObjectRep",
                       IsSemisimpleCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemisimpleCategoryObjects",
        NewFamily( "TheFamilyOfSemisimpleCategoryObjects" ) );

BindGlobal( "TheTypeOfSemisimpleCategoryObjects",
        NewType( TheFamilyOfSemisimpleCategoryObjects,
                IsSemisimpleCategoryObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategoryObject,
               [ IsList, IsCapCategory ],
               
  function( semisimple_object_list, category )
    local semisimple_object_flat_list, size;
    
    size := Size( semisimple_object_list );
    
    semisimple_object_flat_list := List( [ 2 .. 2 * size + 1 ],
      i -> semisimple_object_list[ QuoInt( i, 2 ) ][ RemInt( i, 2 ) + 1 ] );
    
    return SemisimpleCategoryObjectConstructorWithFlatList( semisimple_object_flat_list, category );
    
end );

##
InstallMethodWithCache( SemisimpleCategoryObjectConstructorWithFlatList,
                        [ IsList, IsCapCategory ],
               
  function( semisimple_object_flat_list, category )
    local size, semisimple_object_list, semisimple_category_object, normalized_semisimple_object_list, field;
    
    size := Size( semisimple_object_flat_list );
    
    semisimple_object_list := List( [ 1 .. size/2 ], i ->
      [ semisimple_object_flat_list[ 2*i - 1 ], semisimple_object_flat_list[ 2*i ] ] );
    
    normalized_semisimple_object_list := NormalizeSemisimpleCategoryObjectList( semisimple_object_list );
    
    field := UnderlyingCategoryForSemisimpleCategory( category )!.field_for_matrix_category;
    
    semisimple_category_object := ObjectifyWithAttributes( rec( ), TheTypeOfSemisimpleCategoryObjects,
                                                           SemisimpleCategoryObjectList, normalized_semisimple_object_list,
                                                           UnderlyingFieldForHomalg, field
    );
    
    SetFilterObj( semisimple_category_object, GivenObjectFilterForSemisimpleCategory( category ) );
    
    Add( category, semisimple_category_object );
    
    return semisimple_category_object;
    
end );

##
InstallMethod( NormalizeSemisimpleCategoryObjectList,
               [ IsList ],
               
  function( semisimple_object_list )
    local sort_function, result_list, multiplicity, j, irreducible_object, size, i;
    
    semisimple_object_list := Filtered( semisimple_object_list, entry -> entry[1] > 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( semisimple_object_list, sort_function );
    
    size := Size( semisimple_object_list );
    
    result_list := [ ];
    
    i := 1;
    
    while ( i <= size ) do
        
        irreducible_object := semisimple_object_list[i][2];
        
        multiplicity := semisimple_object_list[i][1];
        
        j := i + 1;
        
        while ( j <= size ) and ( semisimple_object_list[j][2] = irreducible_object ) do
            
            multiplicity := multiplicity + semisimple_object_list[j][1];
            
            j := j + 1;
            
        od;
        
        Add( result_list, [ multiplicity, irreducible_object ] );
        
        i := j;
        
    od;
    
    return result_list;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( Support,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return List( SemisimpleCategoryObjectList( object ), elem -> elem[2] );
    
end );

##
InstallMethod( Dimension,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return Sum( List( SemisimpleCategoryObjectList( object ), elem -> elem[1] * Dimension( elem[2] ) ) );
    
end );

##
InstallMethod( SemisimpleCategoryObjectListWithActualObjects,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return List( SemisimpleCategoryObjectList( object ), 
             elem -> [ elem[1], SemisimpleCategoryObject( [ [ 1, elem[2] ] ], category ) ] );
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( Multiplicity,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( semisimple_category_object, irr )
    local coeff;
    
    coeff := First( SemisimpleCategoryObjectList( semisimple_category_object ), elem -> elem[2] = irr );
    
    if coeff = fail then
        
        return 0;
        
    else
        
        return coeff[1];
        
    fi;
    
end );

##
InstallMethod( Component,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( semisimple_category_object, irr )
    local multiplicity;
    
    multiplicity := Multiplicity( semisimple_category_object, irr );
    
    return MatrixCategoryObject( UnderlyingCategoryForSemisimpleCategory( CapCategory( semisimple_category_object ) ), multiplicity );
    
end );

####################################
##
## View
##
####################################

InstallMethod( String,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local object_list, string, i, size;
    
    object_list := SemisimpleCategoryObjectList( object );
    
    size := Size( object_list );
    
    if size = 0 then
        
        return "0";
        
    fi;
    
    string := Concatenation( String( object_list[1][1] ), "*(", String( object_list[1][2] ), ")" );
    
    for i in [ 2 .. size ] do
        
        Append( string, Concatenation( " + ", String( object_list[i][1] ), "*(", String( object_list[i][2] ), ")" ) );
        
    od;
    
    return string;
    
end );

##
InstallMethod( ViewString,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return String( object );
    
end );

##
InstallMethod( DisplayString,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return Concatenation( String( object ), "\n" );
    
end );

##
InstallMethod( LaTeXOutput,
        "for an object in a semisimple category",
        [ IsSemisimpleCategoryObject ],
        
  function ( object )
    
    return LaTeXStringOfSemisimpleCategoryObjectList( SemisimpleCategoryObjectList( object ) );
    
end );

MakeShowable( [ "text/latex", "application/x-latex" ], IsSemisimpleCategoryObject );
