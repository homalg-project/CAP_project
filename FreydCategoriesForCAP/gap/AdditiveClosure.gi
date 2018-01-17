#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################

DeclareRepresentation( "IsAdditiveClosureObjectRep",
                       IsAdditiveClosureObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAdditiveClosureObjects",
        NewFamily( "TheFamilyOfAdditiveClosureObjects" ) );

BindGlobal( "TheTypeOfAdditiveClosureObjects",
        NewType( TheFamilyOfAdditiveClosureObjects,
                IsAdditiveClosureObjectRep ) );

DeclareRepresentation( "IsAdditiveClosureMorphismRep",
                       IsAdditiveClosureMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAdditiveClosureMorphisms",
        NewFamily( "TheFamilyOfAdditiveClosureMorphisms" ) );

BindGlobal( "TheTypeOfAdditiveClosureMorphisms",
        NewType( TheFamilyOfAdditiveClosureMorphisms,
                IsAdditiveClosureMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( AdditiveClosure,
               [ IsCapCategory ],
               
  function( underlying_category )
    local category;
    
    if not ( HasIsAbCategory( underlying_category ) and IsAbCategory( underlying_category ) ) then
        
        Error( "The underlying category has to be an Ab-category" );
        
    fi;
    
    category := CreateCapCategory( Concatenation( "Additive closure( ", Name( underlying_category )," )"  ) );
    
    SetFilterObj( category, IsAdditiveClosureCategory );
    
    SetIsAdditiveCategory( category, true );
    
    SetUnderlyingCategory( category, underlying_category );
    
    INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE( category );
    
    Finalize( category );
    
    INSTALL_HOMOMORPHISM_STRUCTURE_FOR_OPPOSITE_CATEGORY( category );
    
    return category;
    
end );

##
InstallMethodWithCache( AdditiveClosureObject,
                        [ IsList, IsAdditiveClosureCategory ],
               
  function( list_of_objects, category )
    local additive_closure_object;
    
    additive_closure_object := rec( );
    
    ObjectifyWithAttributes( additive_closure_object, TheTypeOfAdditiveClosureObjects,
                             ObjectList, list_of_objects
    );

    Add( category, additive_closure_object );
    
    return additive_closure_object;
    
end );


##
InstallMethod( AdditiveClosureMorphism,
               [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ],
               
  function( source, matrix, range )
    local additive_closure_morphism;
    
    additive_closure_morphism := rec( );
    
    ObjectifyWithAttributes( additive_closure_morphism, TheTypeOfAdditiveClosureMorphisms,
                             Source, source,
                             Range, range,
                             MorphismMatrix, matrix
    );

    Add( CapCategory( source ), additive_closure_morphism );
    
    return additive_closure_morphism;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( NrRows,
               [ IsAdditiveClosureMorphism ],
               
  function( morphism )
    
    return Size( ObjectList( Source( morphism ) ) );
    
end );

##
InstallMethod( NrColumns,
               [ IsAdditiveClosureMorphism ],
               
  function( morphism )
    
    return Size( ObjectList( Range( morphism ) ) );
    
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE,
  
  function( category )
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );

    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        local underlying_category;
        
        underlying_category := UnderlyingCategory( category );
        
        if not ForAll( ObjectList( object ), obj -> IsIdenticalObj( underlying_category, CapCategory( obj ) ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local matrix, nr_rows, nr_cols, source_list, range_list, underlying_category;
        
        matrix := MorphismMatrix( morphism );
        
        nr_rows := NrRows( morphism );
        
        nr_cols := NrColumns( morphism );
        
        if nr_rows = 0 or nr_cols = 0  then
            
            return IsEmpty( matrix );
            
        fi;
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsCapCategoryMorphism( matrix[i][j] ) )
                 ) then
            Error( "1" );
            return false;
            
        fi;
        
        underlying_category := UnderlyingCategory( category );
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsIdenticalObj( underlying_category, CapCategory( matrix[i][j] ) )
                 ) 
               ) then
            Error( "2" );
            return false;
            
        fi;
        
        source_list := ObjectList( Source( morphism ) );
        
        range_list := ObjectList( Range( morphism ) );
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsEqualForObjects( Source( matrix[i][j] ), source_list[i] ) and IsEqualForObjects( Range( matrix[i][j] ), range_list[j] )
                 )
               ) then
            Error( "3" );
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
        local list_1, list_2, size_1, size_2;
        
        list_1 := ObjectList( object_1 );
        
        list_2 := ObjectList( object_2 );
        
        size_1 := Size( list_1 );
        
        size_2 := Size( list_2 );
        
        if size_1 <> size_2 then
            
            return false;
            
        fi;
        
        return ForAll( [ 1 .. size_1 ], i -> IsEqualForObjects( list_1[i], list_2[i] ) );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        local nr_rows_1, nr_rows_2, nr_cols_1, nr_cols_2, matrix_1, matrix_2;
        
        nr_rows_1 := NrRows( morphism_1 );
        
        nr_rows_2 := NrRows( morphism_2 );
        
        if nr_rows_1 <> nr_rows_2 then
            
            return false;
            
        fi;
        
        nr_cols_1 := NrColumns( morphism_1 );
        
        nr_cols_2 := NrColumns( morphism_2 );
        
        if nr_cols_1 <> nr_cols_2 then
            
            return false;
            
        fi;
        
        if nr_rows_1 = 0 or nr_cols_1 = 0 then
            
            return true;
            
        fi;
        
        matrix_1 := MorphismMatrix( morphism_1 );
        
        matrix_2 := MorphismMatrix( morphism_2 );
        
        return ForAll( [ 1 .. nr_rows_1 ], i ->
                 ForAll( [ 1 .. nr_cols_1 ], j -> IsEqualForMorphisms( matrix_1[i][j], matrix_2[i][j] ) )
               );
        
    end );
    
end );
