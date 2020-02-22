#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################

## Specification of data structure of morphisms:
## there are two valid lists that can represent a morphism:
## 1) an m x n matrix of morphisms with m,n >=1
## 2) the empty list [], which represents the zero morphism
## In particular, [ [ ] ] or [ [], [] ] is not allowed

####################################
##
## Constructors
##
####################################

##
InstallMethod( AdditiveClosure,
               [ IsCapCategory ],
               
  function( underlying_category )
    local category, to_be_finalized;
    
    if not ( HasIsAbCategory( underlying_category ) and IsAbCategory( underlying_category ) ) then
        
        Error( "The underlying category has to be an Ab-category" );
        
    fi;
    
    category := CreateCapCategory( Concatenation( "Additive closure( ", Name( underlying_category )," )"  ) );
    
    SetFilterObj( category, IsAdditiveClosureCategory );
    
    SetIsAdditiveCategory( category, true );
    
    SetUnderlyingCategory( category, underlying_category );
    
    AddObjectRepresentation( category, IsAdditiveClosureObject );
    
    AddMorphismRepresentation( category, IsAdditiveClosureMorphism and HasMorphismMatrix );
    
    if HasIsLinearCategoryOverCommutativeRing( underlying_category ) and
        HasCommutativeRingOfLinearCategory( underlying_category ) then
        
        SetIsLinearCategoryOverCommutativeRing( category, true );
        
        SetCommutativeRingOfLinearCategory( category, CommutativeRingOfLinearCategory( underlying_category ) );
    
    fi;
    
    INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE( category );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    if to_be_finalized = false then
      
      return category;
    
    fi;
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( AsAdditiveClosureObject,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return AdditiveClosureObject( [ object ], AdditiveClosure( CapCategory( object ) ) );
    
end );

##
InstallMethodWithCache( AdditiveClosureObject,
                        [ IsList, IsAdditiveClosureCategory ],
               
  function( list_of_objects, category )
    local additive_closure_object;
    
    additive_closure_object := rec( );
    
    ObjectifyObjectForCAPWithAttributes( 
                             additive_closure_object, category,
                             ObjectList, list_of_objects
    );
    
    return additive_closure_object;
    
end );

##
InstallMethod( AsAdditiveClosureMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return AdditiveClosureMorphism( 
             AsAdditiveClosureObject( Source( morphism ) ),
             [ [ morphism ] ],
             AsAdditiveClosureObject( Range( morphism ) )
           );
    
end );

##
InstallMethod( AdditiveClosureMorphism,
               [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ],
               
  function( source, matrix, range )
    local additive_closure_morphism, category;
    
    additive_closure_morphism := rec( );
    
    category := CapCategory( source );

    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( 
                             additive_closure_morphism, category,
                             source,
                             range,
                             MorphismMatrix, matrix
    );
    
    return additive_closure_morphism;
    
end );

##
InstallMethod( \/,
               [ IsList, IsAdditiveClosureCategory ],
               
  function( listlist, category )
    local source, range;
    
    if IsEmpty( listlist ) then
      
      Error( "The first argument should be a list of objects or listlist of morphisms!\n" );
      
    fi;
    
    if IsCapCategoryObject( listlist[ 1 ] ) then
      
      return AdditiveClosureObject( listlist, category );
      
    fi;
    
    if IsEmpty( listlist[1] ) then
      
      Error( "The first argument should not contain empty lists!\n" );
      
    fi;
    
    source := AdditiveClosureObject( List( listlist, row -> Source( row[1] ) ), category );
    
    range := AdditiveClosureObject( List( listlist[1], col -> Range( col ) ), category );
    
    return AdditiveClosureMorphism(
      source,
      listlist,
      range
    );
    
end );

##
InstallMethod( \/,
          [ IsCapCategoryObject, IsAdditiveClosureCategory ],
  function( o, C )
    
    if not IsIdenticalObj( UnderlyingCategory( C ), CapCategory( o ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    return AsAdditiveClosureObject( o );
    
end );

##
InstallMethod( \/,
          [ IsCapCategoryMorphism, IsAdditiveClosureCategory ],
  function( alpha, C )
    
    if not IsIdenticalObj( UnderlyingCategory( C ), CapCategory( alpha ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    return AsAdditiveClosureMorphism( alpha );
    
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

##
InstallMethod( InclusionFunctorInAdditiveClosure,
              [ IsCapCategory ],
  function( C )
    local additive_closure, name, G;
    
    additive_closure := AdditiveClosure( C );
    
    name := Concatenation( "Inclusion functor of ", Name( C ), " in its additive closure" );
    
    G := CapFunctor( name, C, additive_closure );
    
    AddObjectFunction( G, AsAdditiveClosureObject );
    
    AddMorphismFunction( G, { s, alpha, r } -> AsAdditiveClosureMorphism( alpha ) );
    
    return G;
    
end );

##
InstallMethod( ExtendFunctorToAdditiveClosures,
              [ IsCapFunctor ],
  function( F )
    local source_cat, range_cat, additive_closure_source, additive_closure_range, name, G;
    
    source_cat := AsCapCategory( Source( F ) );
    
    range_cat := AsCapCategory( Range( F ) );
    
    additive_closure_source := AdditiveClosure( source_cat );
    
    additive_closure_range := AdditiveClosure( range_cat );
    
    name := Concatenation( "Extension of ", Name( F ), " to additive closures" );
    
    G := CapFunctor( name, additive_closure_source, additive_closure_range );
    
    AddObjectFunction( G,
      function( a )
        local objs;
        
        objs := ObjectList( a );
        
        objs := List( objs, obj -> ApplyFunctor( F, obj ) );
        
        return AdditiveClosureObject( objs, additive_closure_range );
        
    end );
    
    AddMorphismFunction( G,
      function( source, alpha, range )
        local mat;
        
        mat := MorphismMatrix( alpha );
        
        mat := List( mat, row -> List( row, morphism -> ApplyFunctor( F, morphism ) ) );
        
        return AdditiveClosureMorphism( source, mat, range );
        
    end );
    
    return G;
    
end );

##
InstallMethod( ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource,
              [ IsCapFunctor ],
  function( F )
    local source_cat, range_cat, additive_closure_source, name, G;
    
    source_cat := AsCapCategory( Source( F ) );
    
    range_cat := AsCapCategory( Range( F ) );
    
    if not ( HasIsAdditiveCategory( range_cat ) and IsAdditiveCategory( range_cat ) ) then
      
      Error( "The range category must be additive!\n" );
      
    fi;
    
    additive_closure_source := AdditiveClosure( source_cat );
    
    name := Concatenation( "Extension of ", Name( F ), " to a functor from the additive closure of the source" );
    
    G := CapFunctor( name, additive_closure_source, range_cat );
    
    AddObjectFunction( G,
      function( a )
        local objs;
        
        objs := ObjectList( a );
        
        objs := List( objs, obj -> ApplyFunctor( F, obj ) );
        
        if IsEmpty( objs ) then
          
          return ZeroObject( range_cat );
        
        else
          
          return DirectSum( objs );
        
        fi;
        
    end );
    
    AddMorphismFunction( G,
      function( source, alpha, range )
        local mat;
        
        mat := MorphismMatrix( alpha );
        
        mat := List( mat, row -> List( row, morphism -> ApplyFunctor( F, morphism ) ) );
        
        return MorphismBetweenDirectSums( source, mat, range );
        
    end );
    
    return G;
    
end );

##
InstallMethod( ExtendFunctorToAdditiveClosureOfSource,
              [ IsCapFunctor ],
  function( F )
    local range_cat;
    
    range_cat := AsCapCategory( Range( F ) );
    
    if not ( HasIsAdditiveCategory( range_cat ) and IsAdditiveCategory( range_cat ) ) then
      
      return ExtendFunctorToAdditiveClosures( F );
      
    fi;
    
    return ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource( F );
    
end );

##
InstallMethod( ExtendNaturalTransformationToAdditiveClosureOfSource,
          [ IsCapNaturalTransformation ],
  function( eta )
    local F, G, range, lambda, name;
    
    F := Source( eta );
    
    G := Range( eta );
    
    range := AsCapCategory( Range( F ) ); # = Range( G )
    
    if not ( HasIsAdditiveCategory( range ) and IsAdditiveCategory( range ) ) then
        
      Error( "The range category for source and range functors should be additive!\n" );
      
    fi;
    
    F := ExtendFunctorToAdditiveClosureOfSource( F );
    
    G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    name := "Extension of a natural transformation to additive closure";
    
    lambda := NaturalTransformation( name, F, G );
    
    AddNaturalTransformationFunction( lambda,
      function( F_a, a, G_a )
        local objs;
        
        objs := ObjectList( a );
        
        if IsEmpty( objs ) then
          
          return ZeroMorphism( F_a, G_a );
          
        fi;
        
        objs := List( objs, obj -> ApplyNaturalTransformation( eta, obj ) );
        
        return DirectSumFunctorial( objs );
        
    end );
    
    return lambda;
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( \[\],
               [ IsAdditiveClosureMorphism, IsInt ],
               
  function( morphism, i )
    
    if not i in [ 1 .. NrRows( morphism ) ] then
        
        Error( "bad index" );
        
    fi;
    
    if NrColumns( morphism ) = 0 then
        
        return [ ];
        
    fi;
    
    return MorphismMatrix( morphism )[i];
    
end );

##
InstallMethod( \[\],
               [ IsAdditiveClosureMorphism, IsInt, IsInt ],
               
  function( morphism, i, j )
    
    if not ( i in [ 1 .. NrRows( morphism ) ]
        and j in [ 1 .. NrColumns( morphism ) ] ) then
        
        Error( "bad index!\n" );
        
    fi;
    
    return MorphismMatrix( morphism )[ i, j ];
    
end );

##
InstallMethod( \[\],
               [ IsAdditiveClosureObject, IsInt ],
               
  function( object, i )
    local obj_list;
    
    obj_list := ObjectList( object );
    
    if i < 1 or i > Size( obj_list ) then
        Error( "bad index!\n" );
    fi;
    
    return obj_list[ i ];
    
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE,
  
  function( category )
    local compare_morphisms, underlying_category, range_category;
    
    underlying_category := UnderlyingCategory( category );
    
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
        
        if not ForAll( ObjectList( object ), obj -> IsIdenticalObj( underlying_category, CapCategory( obj ) ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local matrix, nr_rows, nr_cols, source_list, range_list;
        
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
            
            return false;
            
        fi;
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsIdenticalObj( underlying_category, CapCategory( matrix[i][j] ) )
                 ) 
               ) then
            
            return false;
            
        fi;
        
        source_list := ObjectList( Source( morphism ) );
        
        range_list := ObjectList( Range( morphism ) );
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsEqualForObjects( Source( matrix[i][j] ), source_list[i] ) and IsEqualForObjects( Range( matrix[i][j] ), range_list[j] )
                 )
               ) then
            
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
    
    compare_morphisms := function( morphism_1, morphism_2, comparison_function )
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
                 ForAll( [ 1 .. nr_cols_1 ], j -> comparison_function( matrix_1[i][j], matrix_2[i][j] ) )
               );
        
    end;
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return compare_morphisms( morphism_1, morphism_2, IsEqualForMorphisms );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return compare_morphisms( morphism_1, morphism_2, IsCongruentForMorphisms );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local object_list, size, matrix, i, j;
        
        object_list := ObjectList( object );
        
        size := Size( object_list );
        
        matrix := List( [ 1 .. size ], i -> [ ] );
        
        for i in [ 1 .. size ] do
            
            matrix[i][i] := IdentityMorphism( object_list[i] );
            
            for j in [ i + 1 .. size ]  do
                
                matrix[i][j] := ZeroMorphism( object_list[i], object_list[j] );
                
                matrix[j][i] := ZeroMorphism( object_list[j], object_list[i] );
                
            od;
            
        od;
        
        return AdditiveClosureMorphism( object, matrix, object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local object_list_source, object_list_range, size_list_source, size_list_range, matrix, i, j;
        
        object_list_source := ObjectList( source );
        
        object_list_range := ObjectList( range );
        
        size_list_source := Size( object_list_source );
        
        size_list_range := Size( object_list_range );
        
        if size_list_source = 0 or size_list_range = 0 then
            
            return AdditiveClosureMorphism( source, [ ], range );
            
        fi;
        
        matrix := List( [ 1 .. size_list_source ], i -> [ ] );
        
        for i in [ 1 .. size_list_source ] do
            
            for j in [ 1 .. size_list_range ] do
                
                matrix[i][j] := ZeroMorphism( object_list_source[i], object_list_range[j] );
                
            od;
            
        od;
        
        return AdditiveClosureMorphism( source, matrix, range );
        
    end );
    
    ##
    AddPreCompose( category,
      function( morphism_1, morphism_2 )
        local nr_rows_1, nr_cols_1, nr_rows_2, nr_cols_2, matrix, matrix_1, matrix_2, i, j;
        
        nr_rows_1 := NrRows( morphism_1 );
        
        nr_cols_1 := NrColumns( morphism_1 );
        
        nr_rows_2 := NrRows( morphism_2 );
        
        nr_cols_2 := NrColumns( morphism_2 );
        
        if ForAny( [ nr_rows_1, nr_cols_2 ], IsZero ) then
            
            return AdditiveClosureMorphism( Source( morphism_1 ), [ ], Range( morphism_2 ) );
            
        fi;
        
        if ForAny( [ nr_cols_1, nr_rows_2 ], IsZero ) then
            
            return ZeroMorphism( Source( morphism_1 ), Range( morphism_2 ) );
            
        fi;
        
        matrix := List( [ 1 .. nr_rows_1 ], i -> [ ] );
        
        matrix_1 := MorphismMatrix( morphism_1 );
        
        matrix_2 := MorphismMatrix( morphism_2 );
        
        for i in [ 1 .. nr_rows_1 ] do
            
            for j in [ 1 .. nr_cols_2 ] do
                
                matrix[i][j] := Sum( List( [ 1 .. nr_cols_1 ], k -> PreCompose( matrix_1[i][k], matrix_2[k][j] ) ) );
                
            od;
            
        od;
        
        return AdditiveClosureMorphism( Source( morphism_1 ), matrix, Range( morphism_2 ) );
        
    end );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        local matrix;
        
        matrix := MorphismMatrix( morphism );
        
        if IsEmpty( matrix ) then
            
            return true;
            
        fi;
        
        return ForAll( Concatenation( matrix ), IsZeroForMorphisms );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return AdditiveClosureMorphism( Source( morphism_1 ),
                                        MorphismMatrix( morphism_1 ) + MorphismMatrix( morphism_2 ),
                                        Range( morphism_2 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return AdditiveClosureMorphism( Source( morphism ),
                                        -MorphismMatrix( morphism ),
                                        Range( morphism ) );
        
    end );
    ##
    AddZeroObject( category,
      function( )
        
        return AdditiveClosureObject( [ ], category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        
        return AdditiveClosureMorphism( sink, [ ], zero_object );
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        
        return AdditiveClosureMorphism( zero_object, [ ], source );
        
    end );
    
    ##
    AddDirectSum( category,
      function( list )
        
        return AdditiveClosureObject( Concatenation( List( list, ObjectList ) ), category );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( list, projection_number, direct_sum_object )
        local pre_object, range, post_object, pre_zero, id, post_zero;
        
        pre_object := DirectSum( category, list{[1 .. projection_number - 1]} );
        
        range := list[projection_number];
        
        post_object := DirectSum( category, list{[projection_number + 1 .. Size( list )]} );
        
        pre_zero := ZeroMorphism( pre_object, range );
        
        id := IdentityMorphism( range );
        
        post_zero := ZeroMorphism( post_object, range );
        
        return AdditiveClosureMorphism( direct_sum_object,
                                        Concatenation( MorphismMatrix( pre_zero ), MorphismMatrix( id ), MorphismMatrix( post_zero ) ),
                                        range );
        
    end );
    
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( list, injection_number, direct_sum_object )
        local pre_object, source, post_object, pre_zero, id, post_zero;
        
        pre_object := DirectSum( category, list{[1 .. injection_number - 1]} );
        
        source := list[injection_number];
        
        post_object := DirectSum( category, list{[injection_number + 1 .. Size( list )]} );
        
        pre_zero := ZeroMorphism( source, pre_object );
        
        id := IdentityMorphism( source );
        
        post_zero := ZeroMorphism( source, post_object );
        
        return AdditiveClosureMorphism( source,
                                        List( [ 1 .. NrRows( id ) ], i -> Concatenation( pre_zero[i], id[i], post_zero[i] ) ),
                                        direct_sum_object );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum )
        local test_object, list;
        
        test_object := Source( source[1] );
        
        list := List( [ 1 .. Size( ObjectList( test_object ) ) ], i -> Concatenation( List( source, tau -> tau[i] ) ) );
        
        if not IsEmpty( list ) and IsEmpty( list[1] ) then
          
          list := [];
          
        fi;
        
        return AdditiveClosureMorphism( test_object,
                                        list,
                                        direct_sum );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local test_object;
        
        test_object := Range( sink[1] );
        
        return AdditiveClosureMorphism( direct_sum,
                                        Concatenation( List( sink, MorphismMatrix ) ),
                                        test_object );
        
    end );
    
    ##
    AddMorphismBetweenDirectSums( category,
      function( source, listlist, range )
        local nr_cols_out, mat, outer_row, nr_inner_rows, i, new_row;
        
        if IsEmpty( listlist ) or IsEmpty( listlist[1] ) then
          
          return ZeroMorphism( source, range );
          
        fi;
        
        nr_cols_out := Size( listlist[1] );
        
        mat := [];
        
        for outer_row in listlist do
          
          nr_inner_rows := NrRows( outer_row[1] );
          
          if nr_inner_rows > 0 then
            
            for i in [ 1 .. nr_inner_rows ] do
                
                new_row := Concatenation(
                  List( [ 1 .. nr_cols_out ], c -> outer_row[c][i] )
              );
              
              Add( mat, new_row );
              
            od;
            
          fi;
            
        od;
        
        return AdditiveClosureMorphism(
          source,
          mat,
          range
        );
        
    end );
    
    if CanCompute( underlying_category, "MultiplyWithElementOfCommutativeRingForMorphisms" ) then
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
        function( r, alpha )
          local mat;
          
          mat := MorphismMatrix( alpha );
          
          mat := List( mat, row -> List( row, m -> MultiplyWithElementOfCommutativeRingForMorphisms( r, m ) ) );
          
          return AdditiveClosureMorphism( Source( alpha ), mat, Range( alpha ) );
          
      end );
    
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( underlying_category ) then
        
        range_category := CapCategory( DistinguishedObjectOfHomomorphismStructure( underlying_category ) );
        
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        
        if ForAll( [ "DirectSum" ], f -> CanCompute( range_category, f ) )
           and  ForAll( [ "HomomorphismStructureOnObjects" ], f -> CanCompute( underlying_category, f ) ) then
            
            ##
            AddHomomorphismStructureOnObjects( category,
              function( object_1, object_2 )
                
                return DirectSum( range_category,
                          Concatenation(
                            List( ObjectList( object_1 ), obj_i ->
                              List( ObjectList( object_2 ), obj_j -> HomomorphismStructureOnObjects( obj_i, obj_j ) )
                            )
                          )
                        );
                
            end );
        
        fi;
        
        if ForAll( [ "MorphismBetweenDirectSums" ], f -> CanCompute( range_category, f ) )
           and  ForAll( [ "HomomorphismStructureOnMorphismsWithGivenObjects" ], f -> CanCompute( underlying_category, f ) ) then
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( source, alpha, beta, range )
                local matrix_alpha, matrix_beta, size_i, size_k, size_j, size_l;
                
                matrix_alpha := MorphismMatrix( alpha );
                
                matrix_beta := MorphismMatrix( beta );
                
                size_i := NrColumns( alpha );
                
                size_k := NrRows( alpha );
                
                size_j := NrRows( beta );
                
                size_l := NrColumns( beta );
                
                if ForAny( [ size_i, size_k, size_j, size_l ], IsZero ) then
                    
                    return ZeroMorphism( source, range );
                    
                fi;
                
                return MorphismBetweenDirectSums(
                        source,
                        List( [ 1 .. size_i ], i ->
                          List( [ 1 .. size_k ], k -> 
                            MorphismBetweenDirectSums(
                              List( [ 1 .. size_j ], j ->
                                List( [ 1 .. size_l ], l ->
                                  HomomorphismStructureOnMorphisms( matrix_alpha[k][i], matrix_beta[j][l] )
                                )
                              )
                            )
                          )
                        ),
                        range );
                
            end );
            
        fi;
        
        if ForAll( [ "DistinguishedObjectOfHomomorphismStructure" ], f -> CanCompute( underlying_category, f ) ) then
            ##
            AddDistinguishedObjectOfHomomorphismStructure( category,
              function( )
                
                return DistinguishedObjectOfHomomorphismStructure( underlying_category );
                
            end );
            
        fi;
        
        if ForAll( [ "UniversalMorphismIntoZeroObject", 
                     "UniversalMorphismIntoDirectSum" ], 
                     f -> CanCompute( range_category, f ) )
           and ForAll( [ "DistinguishedObjectOfHomomorphismStructure", 
                         "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ],
                         f -> CanCompute( underlying_category, f ) ) then
            
            ##
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
              function( alpha )
                local size_i, size_j, matrix_alpha;
                
                size_i := NrRows( alpha );
                
                size_j := NrColumns( alpha );
                
                matrix_alpha := MorphismMatrix( alpha );
                
                if size_i = 0 or size_j = 0 then
                    
                    return UniversalMorphismIntoZeroObject( DistinguishedObjectOfHomomorphismStructure( underlying_category ) );
                    
                fi;
                
                return UniversalMorphismIntoDirectSum(
                        List( [ 1 .. size_i ], i ->
                          UniversalMorphismIntoDirectSum(
                            List( [ 1 .. size_j ], j ->
                              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( matrix_alpha[i][j] )
                            )
                          )
                        )
                      );
                
            end );
            
        fi;
        
        if ForAll( [ "HomomorphismStructureOnObjects",
                     "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ],
                     f -> CanCompute( underlying_category, f ) )
           and ForAll( [ "PreCompose",
                         "ProjectionInFactorOfDirectSum" ],
                         f -> CanCompute( range_category, f ) ) then
            
            ##
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
              function( A, B, morphism )
                local obj_list_A, obj_list_B, size_i, size_j, matrix, summands;
                
                obj_list_A := ObjectList( A );
                
                obj_list_B := ObjectList( B );
                
                size_i := Size( obj_list_A );
                
                size_j := Size( obj_list_B );
                
                if size_i = 0 or size_j = 0 then
                    
                    return ZeroMorphism( A, B );
                    
                fi;
                
                summands := 
                  Concatenation(
                            List( obj_list_A, obj_i ->
                                List( obj_list_B, obj_j -> HomomorphismStructureOnObjects( obj_i, obj_j ) )
                            )
                          );
                
                matrix := List( [ 1 .. size_i ], i ->
                            List( [ 1 .. size_j ], j ->
                              PreCompose(
                                morphism,
                                ProjectionInFactorOfDirectSum( summands, size_j * (i - 1) + j )
                              )
                            )
                          );
                
                return AdditiveClosureMorphism(
                        A,
                        List( [ 1 .. size_i ], i ->
                          List( [ 1 .. size_j ], j ->
                            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                              obj_list_A[i],
                              obj_list_B[j],
                              matrix[i][j]
                            )
                          )
                        ),
                        B
                      );
                
            end );
        fi;
        
        if  ForAll( [ "Lift",
              "ProjectionInFactorOfDirectSum", 
              "PreCompose", 
              "UniversalMorphismIntoDirectSum", 
              "UniversalMorphismFromDirectSum" ], f -> CanCompute( range_category, f ) ) then
              
              ##
              AddLift( category,
                function( alpha, beta )
                  local left_coefficients, right_coefficients, right_side, right_divide;
                  
                  left_coefficients := [ [ IdentityMorphism( Source( alpha ) ) ] ];
                  
                  right_coefficients := [ [ beta ] ];
                  
                  right_side := [ alpha ];
                  
                  right_divide := SolveLinearSystemInAbCategory(
                                    left_coefficients, right_coefficients, right_side );
                  
                  if right_divide = fail then
                    
                    return fail;
                    
                  fi;
                  
                  return right_divide[1];
                  
              end );
              
              ##
              AddColift( category,
                function( alpha, beta )
                  local left_coefficients, right_coefficients, right_side, left_divide;
                  
                  left_coefficients := [ [ alpha ] ];
                  
                  right_coefficients := [ [ IdentityMorphism( Range( beta ) ) ] ];
                  
                  right_side := [ beta ];
                  
                  left_divide := SolveLinearSystemInAbCategory(
                                    left_coefficients, right_coefficients, right_side );
                  
                  if left_divide = fail then
                    
                    return fail;
                    
                  fi;
                  
                  return left_divide[1];
                  
              end );
              
        fi;
    
    fi;
    
    INSTALL_FUNCTIONS_OF_RANDOM_METHODS_FOR_ADDITIVE_CLOSURE( category );
    
end );

##
InstallGlobalFunction( INSTALL_FUNCTIONS_OF_RANDOM_METHODS_FOR_ADDITIVE_CLOSURE,
  function( category )
    local underlying_category;
    
    underlying_category := UnderlyingCategory( category );
     
    if CanCompute( underlying_category, "RandomObjectByInteger" ) then
      
      AddRandomObjectByInteger( category,
        function( category, n )
          
          if n = 0 then
            
            return ZeroObject( category );
            
          else
            
            return List( [ 1 .. AbsInt( n ) ],
                  i -> RandomObjectByInteger( underlying_category, n )
                    ) / category;
                    
          fi;
          
      end );
      
    fi;
    
    if CanCompute( underlying_category, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
      
      AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
        function( source, range, n )
          local source_objects, range_objects, morphisms, current_row, s, r;
          
          source_objects := ObjectList( source );
          
          range_objects := ObjectList( range );
          
          if IsEmpty( source_objects ) or IsEmpty( range_objects ) then
            
            return ZeroMorphism( source, range );
            
          else
            
            morphisms := [ ];
            
            for s in source_objects do
              
              current_row := [ ];
              
              for r in range_objects do
                
                Add( current_row, RandomMorphismWithFixedSourceAndRange( s, r, n ) );
                
              od;
              
              Add( morphisms, current_row );
              
            od;
            
            return morphisms / category;
            
          fi;
           
      end );
      
      if CanCompute( underlying_category, "RandomObjectByInteger" ) then
          
        AddRandomMorphismWithFixedSourceByInteger( category,
          function( source, n )
            local range;
            
            range := RandomObjectByInteger( category, n );
            
            return RandomMorphismWithFixedSourceAndRangeByInteger( source, range, n );
            
        end );
        
        AddRandomMorphismWithFixedRangeByInteger( category,
          function( range, n )
            local source;
            
            source := RandomObjectByInteger( category, n );
            
            return RandomMorphismWithFixedSourceAndRangeByInteger( source, range, n );
            
        end );
        
      fi;
      
    fi;
       
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
          [ IsAdditiveClosureMorphism ],
  function( morphism )
    Print( "<A morphism in ", Name( CapCategory( morphism ) ),
            " defined by a ", NrRows( morphism ), " x ", NrColumns( morphism ), " matrix of underlying morphisms>"
            );
end );

##
InstallMethod( ViewObj,
          [ IsAdditiveClosureObject ],
  function( object )
    Print( "<An object in ", Name( CapCategory( object ) ),
            " defined by ", Size( ObjectList( object ) ), " underlying objects>"
            );
end );

##
InstallMethod( Display,
               [ IsAdditiveClosureMorphism ],
               
  function( morphism )
    local nr_rows, nr_cols, matrix, i, j;
    
    nr_rows := NrRows( morphism );
    
    nr_cols := NrColumns( morphism );
    
    Print( Concatenation( "A ", String( nr_rows ), " x ", String( nr_cols ), " matrix with entries in ", Name( UnderlyingCategory( CapCategory( morphism ) ) ), "\n" ) );
    
    matrix := MorphismMatrix( morphism );
    
    for i in [ 1 .. nr_rows ] do
        
        for j in [ 1 .. nr_cols ] do
            
            Print( Concatenation( "\n[", String(i), ",", String(j), "]: " ) );
            
            ViewObj( matrix[i][j] );
            
        od;
        
    od;
    
end );

##
InstallMethod( Display,
               [ IsAdditiveClosureObject ],
               
  function( object )
    local object_list, obj;
    
    object_list := ObjectList( object );
    
    Print( Concatenation( "A formal direct sum consisting of ", String( Size( object_list ) ), " objects." ) );
    
    for obj in object_list do
        
        Print( "\n" );
        
        ViewObj( obj );
        
    od;
    
end );
