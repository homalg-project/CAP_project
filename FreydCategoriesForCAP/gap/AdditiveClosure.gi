# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( AdditiveClosure,
               [ IsCapCategory ],
               
  function( underlying_category )
    local category, matrix_element_as_morphism, list_list_as_matrix, homalg_ring, to_be_finalized;
    
    if not ( HasIsAbCategory( underlying_category ) and IsAbCategory( underlying_category ) ) then
        
        Error( "The underlying category has to be an Ab-category" );
        
    fi;
    
    category := CreateCapCategory( Concatenation( "Additive closure( ", Name( underlying_category )," )"  ) );
    
    category!.category_as_first_argument := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
    );
    
    matrix_element_as_morphism := ValueOption( "matrix_element_as_morphism" );
    list_list_as_matrix := ValueOption( "list_list_as_matrix" );
    
    if ( matrix_element_as_morphism = fail and list_list_as_matrix <> fail ) or
       ( matrix_element_as_morphism <> fail and list_list_as_matrix = fail ) then
        
        Display( Concatenation( "WARNING: You have given matrix_element_as_morphism or list_list_as_matrix but not both. ",
            "This is probably an error. If not, you can set the missing one to its default value manually to suppress this message." ) );
       
    fi;
    
    if IsRingAsCategory( underlying_category ) and IsHomalgRing( UnderlyingRing( underlying_category ) ) then
        
        homalg_ring := UnderlyingRing( underlying_category );
        
        if matrix_element_as_morphism = fail then
            
            matrix_element_as_morphism := function( r )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return RingAsCategoryMorphismOp( RingAsCategory( homalg_ring ), r );
                
            end;
            
        fi;
        
        if list_list_as_matrix = fail then
            
            list_list_as_matrix := function( listlist, m, n )
              local ring_elements;
                
                ring_elements :=
                    List( listlist,
                        row -> List( row,
                            entry -> UnderlyingRingElement( entry )
                        )
                    );
                
                return HomalgMatrix( ring_elements, m, n, homalg_ring );
                
            end;
            
        fi;
        
    else
        
        if matrix_element_as_morphism = fail then
            
            matrix_element_as_morphism := IdFunc;
            
        fi;
        
        if list_list_as_matrix = fail then
            
            list_list_as_matrix := ReturnFirst;
            
        fi;
        
    fi;
    
    category!.matrix_element_as_morphism := matrix_element_as_morphism;
    category!.list_list_as_matrix := list_list_as_matrix;
    
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
    
    return ObjectifyObjectForCAPWithAttributes(
                             rec( ), category,
                             ObjectList, list_of_objects
    );
    
end );

##
InstallMethod( AsAdditiveClosureMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return AdditiveClosureMorphismListList( 
             AsAdditiveClosureObject( Source( morphism ) ),
             [ [ morphism ] ],
             AsAdditiveClosureObject( Range( morphism ) )
           );
    
end );

##
InstallMethod( AdditiveClosureMorphism,
               [ IsAdditiveClosureObject, IsObject, IsAdditiveClosureObject ],
               
  function( source, matrix, range )
    local category;
    
    category := CapCategory( source );

    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
                             rec( ), category,
                             source,
                             range,
                             MorphismMatrix, matrix
    );
    
end );

##
InstallMethod( AdditiveClosureMorphismListList,
               [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ],
               
  function( source, listlist, range )
    local category, matrix;
    
    category := CapCategory( source );
    
    matrix := category!.list_list_as_matrix( listlist, Size( ObjectList( source ) ), Size( ObjectList( range ) ) );
    
    return AdditiveClosureMorphism( source, matrix, range );
    
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
    
    return AdditiveClosureMorphismListList(
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
    #% CAP_JIT_RESOLVE_FUNCTION
    
    if IsMatrixObj( MorphismMatrix( morphism ) ) then
        
        return NrRows( MorphismMatrix( morphism ) );
        
    else
        
        return Size( ObjectList( Source( morphism ) ) );
        
    fi;
    
end );

##
InstallMethod( NrCols,
               [ IsAdditiveClosureMorphism ],
               
  function( morphism )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    if IsMatrixObj( MorphismMatrix( morphism ) ) then
        
        return NrCols( MorphismMatrix( morphism ) );
        
    else
        
        return Size( ObjectList( Range( morphism ) ) );
        
    fi;
    
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
        local listlist;
        
        listlist := List( [ 1 .. NrRows( alpha ) ], i -> List( [ 1 .. NrCols( alpha ) ], j -> ApplyFunctor( F, alpha[i,j] ) ) );
        
        return AdditiveClosureMorphismListList( source, listlist, range );
        
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
        local source_diagram, range_diagram, listlist;
        
        source_diagram := List( ObjectList( Source( alpha ) ), obj -> ApplyFunctor( F, obj ) );
        range_diagram := List( ObjectList( Range( alpha ) ), obj -> ApplyFunctor( F, obj ) );
        
        listlist := List( [ 1 .. NrRows( alpha ) ], i -> List( [ 1 .. NrCols( alpha ) ], j -> ApplyFunctor( F, alpha[i,j] ) ) );
        
        return MorphismBetweenDirectSumsWithGivenDirectSums( source, source_diagram, listlist, range_diagram, range );
        
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
InstallMethod( \[\,\],
               [ IsAdditiveClosureMorphism, IsInt, IsInt ],
               
  function( morphism, i, j )
    local matrix_element_as_morphism;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    if not ( i in [ 1 .. NrRows( morphism ) ]
        and j in [ 1 .. NrCols( morphism ) ] ) then
        
        Error( "bad index!\n" );
        
    fi;
    
    matrix_element_as_morphism := CapCategory( morphism )!.matrix_element_as_morphism;
    
    return matrix_element_as_morphism( MorphismMatrix( morphism )[i, j] );
    
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
      { cat, obj1, obj2 } -> IsIdenticalObj( obj1, obj2 ) );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      { cat, mor1, mor2 } -> IsIdenticalObj( mor1, mor2 ) );

    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( cat, object )
        
        if not ForAll( ObjectList( object ), obj -> IsIdenticalObj( underlying_category, CapCategory( obj ) ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, morphism )
        local nr_rows, nr_cols, source_list, range_list;
        
        nr_rows := Size( ObjectList( Source( morphism ) ) );
        
        nr_cols := Size( ObjectList( Range( morphism ) ) );
        
        if IsMatrixObj( MorphismMatrix( morphism ) ) then
            
            if not ( nr_rows = NrRows( MorphismMatrix( morphism ) ) and nr_cols = NrCols( MorphismMatrix( morphism ) ) ) then
                
                return false;
                
            fi;
            
        fi;
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsCapCategoryMorphism( morphism[i, j] ) )
                 ) then
            
            return false;
            
        fi;
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsIdenticalObj( underlying_category, CapCategory( morphism[i, j] ) )
                 ) 
               ) then
            
            return false;
            
        fi;
        
        source_list := ObjectList( Source( morphism ) );
        
        range_list := ObjectList( Range( morphism ) );
        
        if not ForAll( [ 1 .. nr_rows ], i ->
                 ForAll( [ 1 .. nr_cols ], j ->
                   IsEqualForObjects( Source( morphism[i, j] ), source_list[i] ) and IsEqualForObjects( Range( morphism[i, j] ), range_list[j] )
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
      function( cat, object_1, object_2 )
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
      local nr_rows_1, nr_rows_2, nr_cols_1, nr_cols_2;
        
        nr_rows_1 := NrRows( morphism_1 );
        
        nr_rows_2 := NrRows( morphism_2 );
        
        if nr_rows_1 <> nr_rows_2 then
            
            return false;
            
        fi;
        
        nr_cols_1 := NrCols( morphism_1 );
        
        nr_cols_2 := NrCols( morphism_2 );
        
        if nr_cols_1 <> nr_cols_2 then
            
            return false;
            
        fi;
        
        if nr_rows_1 = 0 or nr_cols_1 = 0 then
            
            return true;
            
        fi;
        
        return ForAll( [ 1 .. nr_rows_1 ], i ->
                 ForAll( [ 1 .. nr_cols_1 ], j -> comparison_function( morphism_1[i, j], morphism_2[i, j] ) )
               );
        
    end;
    
    ##
    AddIsEqualForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return compare_morphisms( morphism_1, morphism_2, IsEqualForMorphisms );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return compare_morphisms( morphism_1, morphism_2, IsCongruentForMorphisms );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      function( cat, object )
        local object_list, size, listlist, i, j;
        
        object_list := ObjectList( object );
        
        size := Size( object_list );
        
        listlist := List( [ 1 .. size ], i ->
                        List( [ 1 .. size ], function( j )
                            
                            if i = j then
                                
                                return IdentityMorphism( object_list[i] );
                                
                            else
                                
                                return ZeroMorphism( object_list[i], object_list[j] );
                                
                            fi;
                            
                        end )
                    );
        
        return AdditiveClosureMorphismListList( object, listlist, object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, source, range )
        local object_list_source, object_list_range, size_list_source, size_list_range, listlist, i, j;
        
        object_list_source := ObjectList( source );
        
        object_list_range := ObjectList( range );
        
        size_list_source := Size( object_list_source );
        
        size_list_range := Size( object_list_range );
        
        listlist := List( [ 1 .. size_list_source ], i ->
                        List( [ 1 .. size_list_range ], j ->
                            ZeroMorphism( object_list_source[i], object_list_range[j] )
                        )
                    );
        
        return AdditiveClosureMorphismListList( source, listlist, range );
        
    end );
    
    ##
    AddPreCompose( category,
      function( cat, morphism_1, morphism_2 )
        local nr_rows_1, nr_cols_1, nr_rows_2, nr_cols_2, listlist, i, j;
        
        nr_rows_1 := NrRows( morphism_1 );
        
        nr_cols_1 := NrCols( morphism_1 );
        
        nr_rows_2 := NrRows( morphism_2 );
        
        nr_cols_2 := NrCols( morphism_2 );
        
        if ForAny( [ nr_cols_1, nr_rows_2 ], IsZero ) then
            
            return ZeroMorphism( Source( morphism_1 ), Range( morphism_2 ) );
            
        fi;
        
        listlist := List( [ 1 .. nr_rows_1 ], i ->
                        List( [ 1 .. nr_cols_2 ], j ->
                            Sum( List( [ 1 .. nr_cols_1 ], k -> PreCompose( morphism_1[i, k], morphism_2[k, j] ) ) )
                        )
                    );
        
        return AdditiveClosureMorphismListList( Source( morphism_1 ), listlist, Range( morphism_2 ) );
        
    end );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( cat, morphism )
        
        return ForAll( [ 1 .. NrRows( morphism ) ], i -> ForAll( [ 1 .. NrCols( morphism ) ], j -> IsZeroForMorphisms( morphism[i, j] ) ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        local listlist;
        
        listlist := List( [ 1 .. NrRows( morphism_1 ) ],
                        i -> List( [ 1 .. NrCols( morphism_1 ) ],
                            j -> morphism_1[i, j] + morphism_2[i, j] ) );
        
        return AdditiveClosureMorphismListList( Source( morphism_1 ),
                                                listlist,
                                                Range( morphism_1 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, morphism )
        local listlist;
        
        listlist := List( [ 1 .. NrRows( morphism ) ],
                        i -> List( [ 1 .. NrCols( morphism ) ],
                            j -> - ( morphism[i, j] ) ) );
        
        return AdditiveClosureMorphismListList( Source( morphism ),
                                                listlist,
                                                Range( morphism ) );
        
    end );
    ##
    AddZeroObject( category,
      function( cat )
        
        return AdditiveClosureObject( [ ], category );
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, list )
        
        return AdditiveClosureObject( Concatenation( List( list, ObjectList ) ), category );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, morphisms, direct_sum )
        local listlist;
        
        # UnionOfColumns
        listlist := List( [ 1 .. NrRows( morphisms[1] ) ], i ->
                        Concatenation(
                            List( morphisms, tau ->
                                List( [ 1 .. NrCols( tau ) ],
                                   j -> tau[i, j]
                                )
                            )
                        )
                    );
        
        return AdditiveClosureMorphismListList( test_object,
                                                listlist,
                                                direct_sum );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, morphisms, direct_sum )
        local listlist;
        
        # UnionOfRows
        listlist := Concatenation(
                        List( morphisms, tau ->
                            List( [ 1 .. NrRows( tau ) ], i ->
                               List( [ 1 .. NrCols( tau ) ],
                                   j -> tau[i, j]
                                )
                            )
                        )
                    );
        
        return AdditiveClosureMorphismListList( direct_sum,
                                                listlist,
                                                test_object );
        
    end );
    
    if CanCompute( underlying_category, "MultiplyWithElementOfCommutativeRingForMorphisms" ) then
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
        function( cat, r, alpha )
          local listlist;
            
            listlist := List( [ 1 .. NrRows( alpha ) ],
                            i -> List( [ 1 .. NrCols( alpha ) ],
                                j -> MultiplyWithElementOfCommutativeRingForMorphisms( r, alpha[i, j] ) ) );
            
            return AdditiveClosureMorphismListList( Source( alpha ), listlist, Range( alpha ) );
            
      end );
    
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( underlying_category ) then
        
        range_category := CapCategory( DistinguishedObjectOfHomomorphismStructure( underlying_category ) );
        
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        
        if ForAll( [ "DirectSum" ], f -> CanCompute( range_category, f ) )
           and  ForAll( [ "HomomorphismStructureOnObjects" ], f -> CanCompute( underlying_category, f ) ) then
            
            ##
            AddHomomorphismStructureOnObjects( category,
              function( cat, object_1, object_2 )
                
                return DirectSum( range_category,
                          Concatenation(
                            List( ObjectList( object_1 ), obj_i ->
                              List( ObjectList( object_2 ), obj_j -> HomomorphismStructureOnObjects( obj_i, obj_j ) )
                            )
                          )
                        );
                
            end );
        
        fi;
        
        if ForAll( [ "MorphismBetweenDirectSumsWithGivenDirectSums" ], f -> CanCompute( range_category, f ) )
           and  ForAll( [ "HomomorphismStructureOnMorphismsWithGivenObjects" ], f -> CanCompute( underlying_category, f ) ) then
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( cat, source, alpha, beta, range )
                local size_i, size_j, size_s, size_t;
                
                size_i := NrRows( alpha );
                
                size_j := NrCols( alpha );
                
                size_s := NrRows( beta );
                
                size_t := NrCols( beta );
                
                if size_i <= 0 or size_j <= 0 or size_s <= 0 or size_t <= 0 then
                    
                    return ZeroMorphism( source, range );
                    
                fi;
                
                return MorphismBetweenDirectSums(
                        List( [ 1 .. size_j ], j ->
                          List( [ 1 .. size_i ], i ->
                            MorphismBetweenDirectSums(
                              List( [ 1 .. size_s ], s ->
                                List( [ 1 .. size_t ], t ->
                                  HomomorphismStructureOnMorphisms( alpha[i, j], beta[s, t] )
                                )
                              )
                            )
                          )
                        ) );
                
            end );
            
        fi;
        
        if ForAll( [ "DistinguishedObjectOfHomomorphismStructure" ], f -> CanCompute( underlying_category, f ) ) then
            ##
            AddDistinguishedObjectOfHomomorphismStructure( category,
              function( cat )
                
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
              function( cat, alpha )
                local size_i, size_j;
                
                size_i := NrRows( alpha );
                
                size_j := NrCols( alpha );
                
                if size_i = 0 or size_j = 0 then
                    
                    return UniversalMorphismIntoZeroObject( DistinguishedObjectOfHomomorphismStructure( underlying_category ) );
                    
                fi;
                
                return UniversalMorphismIntoDirectSum(
                        List( [ 1 .. size_i ], i ->
                          UniversalMorphismIntoDirectSum(
                            List( [ 1 .. size_j ], j ->
                              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha[i, j] )
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
              function( cat, A, B, morphism )
                local obj_list_A, obj_list_B, size_i, size_j, listlist, summands;
                
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
                
                listlist := List( [ 1 .. size_i ], i ->
                            List( [ 1 .. size_j ], j ->
                              PreCompose(
                                morphism,
                                ProjectionInFactorOfDirectSum( summands, size_j * (i - 1) + j )
                              )
                            )
                          );
                
                return AdditiveClosureMorphismListList(
                        A,
                        List( [ 1 .. size_i ], i ->
                          List( [ 1 .. size_j ], j ->
                            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                              obj_list_A[i],
                              obj_list_B[j],
                              listlist[i][j]
                            )
                          )
                        ),
                        B
                      );
                
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
            " defined by a ", NrRows( morphism ), " x ", NrCols( morphism ), " matrix of underlying morphisms>"
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
    local nr_rows, nr_cols, i, j;
    
    nr_rows := NrRows( morphism );
    
    nr_cols := NrCols( morphism );
    
    Print( Concatenation( "A ", String( nr_rows ), " x ", String( nr_cols ), " matrix with entries in ", Name( UnderlyingCategory( CapCategory( morphism ) ) ), "\n" ) );
    
    for i in [ 1 .. nr_rows ] do
        
        for j in [ 1 .. nr_cols ] do
            
            Print( Concatenation( "\n[", String(i), ",", String(j), "]: " ) );
            
            ViewObj( morphism[i, j] );
            
        od;
        
    od;
    
end );

##
InstallMethod( Display,
               [ IsAdditiveClosureObject ],
               
  function( object )
    local object_list, obj;
    
    object_list := ObjectList( object );
    
    Print( Concatenation( "A formal direct sum consisting of ", String( Size( object_list ) ), " objects.\n" ) );
    
    for obj in object_list do
        
        ViewObj( obj );
        
        Print( "\n" );
        
    od;
    
end );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsAdditiveClosureObject ],
               ObjectList );

##
InstallMethod( DownOnlyMorphismData,
               [ IsAdditiveClosureMorphism ],
               MorphismMatrix );
