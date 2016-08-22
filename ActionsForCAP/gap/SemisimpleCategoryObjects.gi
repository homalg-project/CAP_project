############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
##
#############################################################################

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
    local semisimple_category_object, normalized_semisimple_object_list;
    
    semisimple_category_object := rec( );
    
    normalized_semisimple_object_list := NormalizeSemisimpleCategoryObjectList( semisimple_object_list, category );
    
    ObjectifyWithAttributes( semisimple_category_object, TheTypeOfSemisimpleCategoryObjects,
                             SemisimpleCategoryObjectList, normalized_semisimple_object_list
    );

    Add( category, semisimple_category_object );
    
    return semisimple_category_object;
    
end );

##
InstallMethod( NormalizeSemisimpleCategoryObjectList,
               [ IsList, IsCapCategory ],
               
  function( semisimple_object_list, category )
    local sort_function, equality_function, result_list, multiplicity, j, irreducible_object, size, i;
    
    semisimple_object_list := Filtered( semisimple_object_list, entry -> entry[1] > 0 );
    
    sort_function := function( a, b ) return LowerEqualFunctionForSemisimpleCategory( category )( a[2], b[2] ); end;
    
    equality_function := EqualityFunctionForSemisimpleCategory( category );
    
    Sort( semisimple_object_list, sort_function );
    
    size := Size( semisimple_object_list );
    
    result_list := [ ];
    
    i := 1;
    
    while ( i <= size ) do
        
        irreducible_object := semisimple_object_list[i][2];
        
        multiplicity := semisimple_object_list[i][1];
        
        j := i + 1;
        
        while ( j <= size ) and ( equality_function( semisimple_object_list[j][2], irreducible_object ) ) do
            
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
## View
##
####################################
