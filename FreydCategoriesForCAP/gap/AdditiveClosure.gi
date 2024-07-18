# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Helper functions
##
####################################

InstallGlobalFunction( NullMatImmutable, function ( arg... )
  local null, m, n, zero, row, i, k, f;
    # taken from NullMat
    
    if Length( arg ) = 2 then
        
        m := arg[1];
        n := arg[2];
        f := Rationals;
        
    elif Length( arg ) = 3 and IsRing( arg[3] ) then
        
        m := arg[1];
        n := arg[2];
        f := arg[3];
        
    elif Length( arg ) = 3 then
        
        m := arg[1];
        n := arg[2];
        f := Ring( One( arg[3] ), arg[3] );
        
    else
        
        Error( "usage: NullMatImmutable( <m>, <n> [, <R>] )" );
        
    fi;
    
    zero := Zero( f );
    
    row := ListWithIdenticalEntries( n, zero );
    
    null := ListWithIdenticalEntries( m, row );
    
    MakeImmutable( null );
    
    return null;
    
end );

InstallGlobalFunction( UnionOfRowsListList, function ( nr_cols, matrices )
    
    return Concatenation( matrices );
    
end );

InstallGlobalFunction( UnionOfColumnsListList, function ( nr_rows, matrices )
    
    return List( [ 1 .. nr_rows ], i -> Concatenation( List( matrices, mat -> mat[i] ) ) );
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( AdditiveClosure,
               [ IsCapCategory ],
               ADDITIVE_CLOSURE
);

##
InstallMethod( ADDITIVE_CLOSURE,
               [ IsCapCategory ],
               
  function( underlying_category )
    local category, precompiled_towers, remaining_constructors_in_tower, precompiled_functions_adder, info;
    
    if not ( HasIsAbCategory( underlying_category ) and IsAbCategory( underlying_category ) ) then
        
        Error( "The underlying category has to be an Ab-category" );
        
    fi;
    
    category := CreateCapCategory( Concatenation( "AdditiveClosure( ", Name( underlying_category )," )" ), IsAdditiveClosureCategory, IsAdditiveClosureObject, IsAdditiveClosureMorphism, IsCapCategoryTwoCell );
    
    category!.supports_empty_limits := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
    );
    
    if ValueOption( "matrix_element_as_morphism" ) <> fail or ValueOption( "list_list_as_matrix" ) <> fail then
        
        Error(
            "The options `matrix_element_as_morphism` and `list_list_as_matrix` are not supported anymore. ",
            "Use a `WrapperCategory` with custom ObjectConstructor and MorphismConstructor instead. ",
            "See `CategoryOfRows_as_AdditiveClosure_RingAsCategory` as an example."
        );
        
    fi;
    
    SetIsAdditiveCategory( category, true );
    
    SetUnderlyingCategory( category, underlying_category );
    
    if HasIsLinearCategoryOverCommutativeRing( underlying_category ) and IsLinearCategoryOverCommutativeRing( underlying_category ) and
        HasCommutativeRingOfLinearCategory( underlying_category ) then
        
        SetIsLinearCategoryOverCommutativeRing( category, true );
        
        SetCommutativeRingOfLinearCategory( category, CommutativeRingOfLinearCategory( underlying_category ) );
        
        if HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( underlying_category ) and
           IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( underlying_category ) then
            
            SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category, true );
            
            # BasisOfExternalHom and CoefficientsOfMorphism can possibly be derived from the hom structure
            # see https://github.com/homalg-project/CAP_project/pull/652 for a primitive implementation
            
        fi;
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE( category );
    
    HandlePrecompiledTowers( category, underlying_category, "AdditiveClosure" );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( AsAdditiveClosureObject,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return AdditiveClosureObject( AdditiveClosure( CapCategory( object ) ), [ object ] );
    
end );

##
InstallMethod( AdditiveClosureObject,
               [ IsList, IsAdditiveClosureCategory ],
               
  function( list_of_objects, category )
    
    return AdditiveClosureObject( category, list_of_objects );
    
end );

##
InstallOtherMethodForCompilerForCAP( AdditiveClosureObject,
                                     [ IsAdditiveClosureCategory, IsList ],
                                     
  function( category, list_of_objects )
    
    return CreateCapCategoryObjectWithAttributes( category,
                                                  ObjectList, list_of_objects );
    
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
               
  function( source, listlist, range )
    
    return AdditiveClosureMorphism( CapCategory( source ), source, listlist, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( AdditiveClosureMorphism,
                                     [ IsAdditiveClosureCategory, IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ],
                                     
  function( category, source, listlist, range )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    if Length( ObjectList( source ) ) > 0 and Length( ObjectList( range ) ) > 0 then
        
        Assert( 0, Length( listlist ) = Length( ObjectList( source ) ) );
        Assert( 0, ForAll( listlist, row -> Length( row ) = Length( ObjectList( range ) ) ) );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( category,
                                                    source,
                                                    range,
                                                    MorphismMatrix, listlist );
    
end );

##
InstallOtherMethod( \/,
               [ IsList, IsAdditiveClosureCategory ],
               
  function( listlist, category )
    local source, range;
    
    if IsEmpty( listlist ) then
      
      Error( "The first argument should be a list of objects or listlist of morphisms!\n" );
      
    fi;
    
    if IsCapCategoryObject( listlist[ 1 ] ) then
      
      return AdditiveClosureObject( category, listlist );
      
    fi;
    
    if IsEmpty( listlist[1] ) then
      
      Error( "The first argument should not contain empty lists!\n" );
      
    fi;
    
    source := AdditiveClosureObject( category, List( listlist, row -> Source( row[1] ) ) );
    
    range := AdditiveClosureObject( category, List( listlist[1], col -> Range( col ) ) );
    
    return AdditiveClosureMorphism( category,
      source,
      listlist,
      range
    );
    
end );

##
InstallOtherMethod( \/,
          [ IsCapCategoryObject, IsAdditiveClosureCategory ],
  function( o, C )
    
    if not IsIdenticalObj( UnderlyingCategory( C ), CapCategory( o ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    return AsAdditiveClosureObject( o );
    
end );

##
InstallOtherMethod( \/,
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
InstallMethodForCompilerForCAP( NrRows,
                                [ IsAdditiveClosureMorphism ],
               
  function( morphism )
    
    return Length( ObjectList( Source( morphism ) ) );
    
end );

##
InstallMethodForCompilerForCAP( NrCols,
                                [ IsAdditiveClosureMorphism ],
               
  function( morphism )
    
    return Length( ObjectList( Range( morphism ) ) );
    
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
        
        return AdditiveClosureObject( additive_closure_range, objs );
        
    end );
    
    AddMorphismFunction( G,
      function( source, alpha, range )
        local listlist;
        
        listlist := List( [ 1 .. NrRows( alpha ) ], i -> List( [ 1 .. NrCols( alpha ) ], j -> ApplyFunctor( F, alpha[i,j] ) ) );
        
        return AdditiveClosureMorphism( additive_closure_range, source, listlist, range );
        
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
InstallMethodForCompilerForCAP( \[\,\],
                                [ IsAdditiveClosureMorphism, IsInt, IsInt ],
               
  function( morphism, i, j )
    
    if not ( i in [ 1 .. NrRows( morphism ) ]
        and j in [ 1 .. NrCols( morphism ) ] ) then
        
        Error( "bad index!\n" );
        
    fi;
    
    return MorphismMatrix( morphism )[i][j];
    
end );

##
InstallMethodForCompilerForCAP( \[\],
                                [ IsAdditiveClosureObject, IsInt ],
               
  function( object, i )
    local obj_list;
    
    obj_list := ObjectList( object );
    
    if i < 1 or i > Length( obj_list ) then
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
    local compare_morphisms, underlying_category, range_category, object_function, morphism_function, object_function_inverse, morphism_function_inverse;
    
    underlying_category := UnderlyingCategory( category );
    
    ##
    AddObjectConstructor( category,
      function( cat, list_of_objects )
        
        return AdditiveClosureObject( cat, list_of_objects );
        
    end );
    
    ##
    AddObjectDatum( category,
      function( cat, object )
        
        return ObjectList( object );
        
    end );
    
    ##
    AddMorphismConstructor( category,
      function( cat, source, listlist, range )
        
        return AdditiveClosureMorphism( cat, source, listlist, range );
        
    end );
    
    ##
    AddMorphismDatum( category,
      function( cat, morphism )
        
        return MorphismMatrix( morphism );
        
    end );
    
    if CanCompute( underlying_category, "IsWellDefinedForObjects" ) then
        
        ##
        AddIsWellDefinedForObjects( category,
          function( cat, object )
            
            if not IsList( ObjectList( object ) ) then
                
                return false;
                
            elif not ForAll( ObjectList( object ), obj -> IsWellDefinedForObjects( UnderlyingCategory( cat ), obj ) ) then
                
                return false;
                
            fi;
            
            # all tests passed, so it is well-defined
            return true;
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "IsWellDefinedForMorphismsWithGivenSourceAndRange" ) then
        
        ##
        AddIsWellDefinedForMorphisms( category,
          function( cat, morphism )
            local source_list, range_list, nr_rows, nr_cols;
            
            source_list := ObjectList( Source( morphism ) );
            range_list := ObjectList( Range( morphism ) );
            
            nr_rows := Length( source_list );
            nr_cols := Length( range_list );
            
            if not (IsList( MorphismMatrix( morphism ) ) and Length( MorphismMatrix( morphism ) ) = nr_rows) then
                
                return false;
                
            elif not ForAll( [ 1 .. nr_rows ], i -> IsList( MorphismMatrix( morphism )[i] ) and Length( MorphismMatrix( morphism )[i] ) = nr_cols ) then
                
                return false;
                
            elif not ForAll( [ 1 .. nr_rows ], i ->
                     ForAll( [ 1 .. nr_cols ], j ->
                       # is a well-defined CAP category morphism from `source_list[i]` to `range_list[j]` in the underlying category
                       IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat ), source_list[i], morphism[i, j], range_list[j] )
                     )
                   ) then
                
                return false;
                
            fi;
            
            # all tests passed, so it is well-defined
            return true;
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "IsEqualForObjects" ) then
        
        ##
        AddIsEqualForObjects( category,
          function( cat, object_1, object_2 )
            local list_1, list_2, size_1, size_2;
            
            list_1 := ObjectList( object_1 );
            
            list_2 := ObjectList( object_2 );
            
            size_1 := Length( list_1 );
            
            size_2 := Length( list_2 );
            
            if size_1 <> size_2 then
                
                return false;
                
            fi;
            
            return ForAll( [ 1 .. size_1 ], i -> IsEqualForObjects( UnderlyingCategory( cat ), list_1[i], list_2[i] ) );
            
        end );
        
    fi;
    
    compare_morphisms := function( cat, morphism_1, morphism_2, comparison_function )
      local nr_rows_1, nr_rows_2, nr_cols_1, nr_cols_2;
        #% CAP_JIT_RESOLVE_FUNCTION
        
        nr_rows_1 := NrRows( morphism_1 );
        
        nr_rows_2 := NrRows( morphism_2 );
        
        nr_cols_1 := NrCols( morphism_1 );
        
        nr_cols_2 := NrCols( morphism_2 );
        
        if nr_rows_1 <> nr_rows_2 then
            
            return false;
            
        elif nr_cols_1 <> nr_cols_2 then
            
            return false;
            
        fi;
        
        return ForAll( [ 1 .. nr_rows_1 ], i ->
                 ForAll( [ 1 .. nr_cols_1 ], j -> comparison_function( UnderlyingCategory( cat ), morphism_1[i, j], morphism_2[i, j] ) )
               );
        
    end;
    
    if CanCompute( underlying_category, "IsEqualForMorphisms" ) then
        
        ##
        AddIsEqualForMorphisms( category,
          function( cat, morphism_1, morphism_2 )
            
            return compare_morphisms( cat, morphism_1, morphism_2, IsEqualForMorphisms );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "IsCongruentForMorphisms" ) then
        
        ##
        AddIsCongruentForMorphisms( category,
          function( cat, morphism_1, morphism_2 )
            
            return compare_morphisms( cat, morphism_1, morphism_2, IsCongruentForMorphisms );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "IdentityMorphism" ) and CanCompute( underlying_category, "ZeroMorphism" ) then
        
        ##
        AddIdentityMorphism( category,
          function( cat, object )
            local object_list, size, listlist, i, j;
            
            object_list := ObjectList( object );
            
            size := Length( object_list );
            
            listlist := List( [ 1 .. size ], i ->
                            List( [ 1 .. size ], function( j )
                                
                                if i = j then
                                    
                                    return IdentityMorphism( UnderlyingCategory( cat ), object_list[i] );
                                    
                                else
                                    
                                    return ZeroMorphism( UnderlyingCategory( cat ), object_list[i], object_list[j] );
                                    
                                fi;
                                
                            end )
                        );
            
            return AdditiveClosureMorphism( cat, object, listlist, object );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "ZeroMorphism" ) then
        
        ##
        AddZeroMorphism( category,
          function( cat, source, range )
            local object_list_source, object_list_range, size_list_source, size_list_range, listlist, i, j;
            
            object_list_source := ObjectList( source );
            
            object_list_range := ObjectList( range );
            
            size_list_source := Length( object_list_source );
            
            size_list_range := Length( object_list_range );
            
            listlist := List( [ 1 .. size_list_source ], i ->
                            List( [ 1 .. size_list_range ], j ->
                                ZeroMorphism( UnderlyingCategory( cat ), object_list_source[i], object_list_range[j] )
                            )
                        );
            
            return AdditiveClosureMorphism( cat, source, listlist, range );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "PreCompose" ) and CanCompute( underlying_category, "SumOfMorphisms" ) then
        
        ##
        AddPreCompose( category,
          function( cat, morphism_1, morphism_2 )
            local nr_rows_1, nr_cols_1, nr_rows_2, nr_cols_2, listlist, i, j;
            
            nr_rows_1 := NrRows( morphism_1 );
            
            nr_cols_1 := NrCols( morphism_1 );
            
            nr_rows_2 := NrRows( morphism_2 );
            
            nr_cols_2 := NrCols( morphism_2 );
            
            #% CAP_JIT_DROP_NEXT_STATEMENT
            Assert( 0, nr_cols_1 = nr_rows_2 ); # already checked by the pre function
            
            listlist := List( [ 1 .. nr_rows_1 ], i ->
                            List( [ 1 .. nr_cols_2 ], j ->
                                SumOfMorphisms( UnderlyingCategory( cat ),
                                    Source( morphism_1 )[i],
                                    List( [ 1 .. nr_cols_1 ], k -> PreCompose( UnderlyingCategory( cat ), morphism_1[i, k], morphism_2[k, j] ) ),
                                    Range( morphism_2 )[j]
                                )
                            )
                        );
            
            return AdditiveClosureMorphism( cat, Source( morphism_1 ), listlist, Range( morphism_2 ) );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "IsZeroForMorphisms" ) then
        
        ##
        AddIsZeroForMorphisms( category,
          function( cat, morphism )
            
            return ForAll( [ 1 .. NrRows( morphism ) ], i -> ForAll( [ 1 .. NrCols( morphism ) ], j -> IsZeroForMorphisms( UnderlyingCategory( cat ), morphism[i, j] ) ) );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "AdditionForMorphisms" ) then
        
        ##
        AddAdditionForMorphisms( category,
          function( cat, morphism_1, morphism_2 )
            local listlist;
            
            listlist := List( [ 1 .. NrRows( morphism_1 ) ],
                            i -> List( [ 1 .. NrCols( morphism_1 ) ],
                                j -> AdditionForMorphisms( UnderlyingCategory( cat ), morphism_1[i, j], morphism_2[i, j] ) ) );
            
            return AdditiveClosureMorphism( cat, Source( morphism_1 ),
                                            listlist,
                                            Range( morphism_1 ) );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "SumOfMorphisms" ) then
        
        ##
        AddSumOfMorphisms( category,
          function( cat, source, morphisms, range )
            local listlist;
            
            listlist := List( [ 1 .. Length( ObjectList( source ) ) ],
                            i -> List( [ 1 .. Length( ObjectList( range ) ) ],
                                j -> SumOfMorphisms( UnderlyingCategory( cat ), source[i], List( morphisms, m -> m[i, j] ), range[j] ) ) );
            
            return AdditiveClosureMorphism( cat, source,
                                            listlist,
                                            range );
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "AdditiveInverseForMorphisms" ) then
        
        ##
        AddAdditiveInverseForMorphisms( category,
          function( cat, morphism )
            local listlist;
            
            listlist := List( [ 1 .. NrRows( morphism ) ],
                            i -> List( [ 1 .. NrCols( morphism ) ],
                                j -> AdditiveInverseForMorphisms( UnderlyingCategory( cat ), morphism[i, j] ) ) );
            
            return AdditiveClosureMorphism( cat, Source( morphism ),
                                            listlist,
                                            Range( morphism ) );
            
        end );
        
    fi;
    
    ##
    AddZeroObject( category,
      function( cat )
        
        return AdditiveClosureObject( cat, CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( cat ) ) ) ) );
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, diagram )
        
        return AdditiveClosureObject( cat, Concatenation( List( [ 1 .. Length( diagram ) ], i -> ObjectList( diagram[i] ) ) ) );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, morphisms, direct_sum )
        local listlist;
        
        listlist := UnionOfColumnsListList( BigInt( Length( ObjectList( test_object ) ) ), List( morphisms, tau -> MorphismMatrix( tau ) ) );
        
        return AdditiveClosureMorphism( cat, test_object,
                                        listlist,
                                        direct_sum );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, morphisms, direct_sum )
        local listlist;
        
        listlist := UnionOfRowsListList( BigInt( Length( ObjectList( test_object ) ) ), List( morphisms, tau -> MorphismMatrix( tau ) ) );
        
        return AdditiveClosureMorphism( cat, direct_sum,
                                        listlist,
                                        test_object );
        
    end );
    
    ##
    AddComponentOfMorphismIntoDirectSum( category,
      function( cat, morphism, summands, nr )
        local lengths, offset, start, stop;
        
        lengths := List( summands, s -> Length( ObjectList( s ) ) );
        
        offset := Sum( lengths{[ 1 .. nr-1 ]} );
        
        start := offset + 1;
        stop := offset + lengths[nr];
        
        return AdditiveClosureMorphism( cat, Source( morphism ),
                                        List( MorphismMatrix( morphism ), row -> row{[ start .. stop ]} ), # CertainColumns
                                        summands[nr] );
        
    end );
    
    ##
    AddComponentOfMorphismFromDirectSum( category,
      function( cat, morphism, summands, nr )
        local lengths, offset, start, stop;
        
        lengths := List( summands, s -> Length( ObjectList( s ) ) );
        
        offset := Sum( lengths{[ 1 .. nr-1 ]} );
        
        start := offset + 1;
        stop := offset + lengths[nr];
        
        return AdditiveClosureMorphism( cat, summands[nr],
                                        MorphismMatrix( morphism ){[ start .. stop ]}, # CertainRows
                                        Range( morphism ) );
        
    end );
    
    if CanCompute( underlying_category, "MultiplyWithElementOfCommutativeRingForMorphisms" ) then
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
        function( cat, r, alpha )
          local listlist;
            
            listlist := List( [ 1 .. NrRows( alpha ) ],
                            i -> List( [ 1 .. NrCols( alpha ) ],
                                j -> MultiplyWithElementOfCommutativeRingForMorphisms( UnderlyingCategory( cat ), r, alpha[i, j] ) ) );
            
            return AdditiveClosureMorphism( cat, Source( alpha ), listlist, Range( alpha ) );
            
      end );
    
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( underlying_category ) then
        
        # If the range category of the underlying category is not additive but pre-additive, we first apply AdditiveClosure to it.
        # See https://arxiv.org/abs/1908.04132 (Sebastian Posur: Methods of constructive category theory), Remark 1.28
        if not (HasIsAdditiveCategory and IsAdditiveCategory)( RangeCategoryOfHomomorphismStructure( underlying_category ) ) and (HasIsAbCategory and IsAbCategory)( RangeCategoryOfHomomorphismStructure( underlying_category ) ) then
            
            if IsIdenticalObj( underlying_category, RangeCategoryOfHomomorphismStructure( underlying_category ) ) then
                
                # prevent infinite recursion
                range_category := category;
                
            else
                
                range_category := AdditiveClosure( RangeCategoryOfHomomorphismStructure( underlying_category ) );
                
            fi;
            
            # prepare for ExtendRangeOfHomomorphismStructureByFullEmbedding
            object_function := function ( category, range_category, object )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return AdditiveClosureObject( range_category, [ object ] );
                
            end;
            
            morphism_function := function ( category, range_category, source, morphism, range )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return AdditiveClosureMorphism( range_category,
                    source,
                    [ [ morphism ] ],
                    range
                );
                
            end;
            
            object_function_inverse := function ( category, range_category, object )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, Length( ObjectList( object ) ) = 1 );
                
                return ObjectList( object )[1];
                
            end;
            
            morphism_function_inverse := function ( category, range_category, source, morphism, range )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, NrRows( morphism ) = 1 and NrCols( morphism ) = 1 );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, IsEqualForObjects( source, Source( morphism[1,1] ) ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, IsEqualForObjects( range, Range( morphism[1,1] ) ) );
                
                return morphism[1,1];
                
            end;
            
            ExtendRangeOfHomomorphismStructureByFullEmbedding( underlying_category, range_category, object_function, morphism_function, object_function_inverse, morphism_function_inverse );
            
        else
            
            range_category := RangeCategoryOfHomomorphismStructure( underlying_category );
            
            ExtendRangeOfHomomorphismStructureByIdentityAsFullEmbedding( underlying_category );
            
        fi;
        
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        if ForAll( [ "DirectSum" ], f -> CanCompute( range_category, f ) )
           and  ForAll( [ "HomomorphismStructureOnObjects" ], f -> CanCompute( underlying_category, f ) ) then
            
            ##
            AddHomomorphismStructureOnObjects( category,
              function( cat, object_1, object_2 )
                
                return DirectSum( range_category,
                          List( [ 1 .. Length( ObjectList( object_1 ) ) ], j ->
                            DirectSum( range_category,
                              List( [ 1 .. Length( ObjectList( object_2 ) ) ], s -> HomomorphismStructureOnObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, ObjectList( object_1 )[j], ObjectList( object_2 )[s] ) )
                            )
                          )
                        );
                
            end );
        
        fi;
        
        # legacy
        if ForAll( [ "MorphismBetweenDirectSumsWithGivenDirectSums" ], f -> CanCompute( range_category, f ) )
           and  ForAll( [ "HomomorphismStructureOnMorphismsWithGivenObjects" ], f -> CanCompute( underlying_category, f ) )
           and not (IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true) then
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( cat, source, alpha, beta, range )
                local size_i, size_j, size_s, size_t;
                
                size_i := NrRows( alpha );
                
                size_j := NrCols( alpha );
                
                size_s := NrRows( beta );
                
                size_t := NrCols( beta );
                
                if size_i <= 0 or size_j <= 0 or size_s <= 0 or size_t <= 0 then
                    
                    return ZeroMorphism( range_category, source, range );
                    
                fi;
                
                return MorphismBetweenDirectSums(
                        List( [ 1 .. size_j ], j ->
                          List( [ 1 .. size_i ], i ->
                            MorphismBetweenDirectSums(
                              List( [ 1 .. size_s ], s ->
                                List( [ 1 .. size_t ], t ->
                                  HomomorphismStructureOnMorphismsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, alpha[i, j], beta[s, t] )
                                )
                              )
                            )
                          )
                        ) );
                
            end );
            
        fi;
        
        if ForAll( [ "MorphismBetweenDirectSumsWithGivenDirectSums" ], f -> CanCompute( range_category, f ) )
           and ForAll( [ "HomomorphismStructureOnMorphismsWithGivenObjects" ], f -> CanCompute( underlying_category, f ) )
           and IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true then
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( cat, source, alpha, beta, range )
                local size_i, size_j, size_s, size_t, A, B, C, D, H_B_C, H_A_D, source_direct_sums, range_direct_sums;
                
                size_i := NrRows( alpha );
                
                size_j := NrCols( alpha );
                
                size_s := NrRows( beta );
                
                size_t := NrCols( beta );
                
                A := Source( alpha );
                B := Range( alpha );
                C := Source( beta );
                D := Range( beta );
                
                H_B_C :=
                    List( [ 1 .. size_j ], j ->
                        List( [ 1 .. size_s ], s ->
                            HomomorphismStructureOnObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, B[j], C[s] )
                        )
                    );
                
                H_A_D :=
                    List( [ 1 .. size_i ], i ->
                        List( [ 1 .. size_t ], t ->
                            HomomorphismStructureOnObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, A[i], D[t] )
                        )
                    );
                
                source_direct_sums := List( [ 1 .. size_j ], j -> DirectSum( range_category, List( [ 1 .. size_s ], s -> H_B_C[j][s] ) ) );
                range_direct_sums := List( [ 1 .. size_i ], i -> DirectSum( range_category, List( [ 1 .. size_t ], t -> H_A_D[i][t] ) ) );
                
                return MorphismBetweenDirectSumsWithGivenDirectSums(
                    range_category,
                    source,
                    source_direct_sums,
                    List( [ 1 .. size_j ], j ->
                        List( [ 1 .. size_i ], i ->
                            MorphismBetweenDirectSumsWithGivenDirectSums(
                                range_category,
                                source_direct_sums[j],
                                List( [ 1 .. size_s ], s -> H_B_C[j][s] ),
                                List( [ 1 .. size_s ], s ->
                                    List( [ 1 .. size_t ], t ->
                                        HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, H_B_C[j][s], alpha[i, j], beta[s, t], H_A_D[i][t] )
                                    )
                                ),
                                List( [ 1 .. size_t ], t -> H_A_D[i][t] ),
                                range_direct_sums[i]
                            )
                        )
                    ),
                    range_direct_sums,
                    range
                );
                
            end );
            
        fi;
        
        if ForAll( [ "DistinguishedObjectOfHomomorphismStructure" ], f -> CanCompute( underlying_category, f ) ) then
            ##
            AddDistinguishedObjectOfHomomorphismStructure( category,
              function( cat )
                
                return DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category );
                
            end );
            
        fi;
        
        if ForAll( [ "UniversalMorphismIntoZeroObject", 
                     "UniversalMorphismIntoDirectSum" ], 
                     f -> CanCompute( range_category, f ) )
           and ForAll( [ "DistinguishedObjectOfHomomorphismStructure", 
                         "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ],
                         f -> CanCompute( underlying_category, f ) )
           and not (IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true) then
            
            ##
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
              function( cat, alpha )
                local size_i, size_j;
                
                size_i := NrRows( alpha );
                
                size_j := NrCols( alpha );
                
                if size_i = 0 or size_j = 0 then
                    
                    return UniversalMorphismIntoZeroObject( range_category, DistinguishedObjectOfHomomorphismStructure( UnderlyingCategory( cat ) ) );
                    
                fi;
                
                return UniversalMorphismIntoDirectSum( range_category,
                        List( [ 1 .. size_i ], i ->
                          UniversalMorphismIntoDirectSum( range_category,
                            List( [ 1 .. size_j ], j ->
                              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, alpha[i, j] )
                            )
                          )
                        )
                      );
                
            end );
            
        fi;
        
        if ForAll( [ "UniversalMorphismIntoDirectSum" ],
                     f -> CanCompute( range_category, f ) )
           and ForAll( [ "DistinguishedObjectOfHomomorphismStructure",
                         "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ],
                         f -> CanCompute( underlying_category, f ) )
           and IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true then
            
            ##
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( category,
              function( cat, distinguished_object, alpha, range )
                local size_j, size_s, B, C, H_B_C, direct_sums;
                
                size_j := NrRows( alpha );
                
                size_s := NrCols( alpha );
                
                B := Source( alpha );
                C := Range( alpha );
                
                H_B_C :=
                    List( [ 1 .. size_j ], j ->
                        List( [ 1 .. size_s ], s ->
                            HomomorphismStructureOnObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, B[j], C[s] )
                        )
                    );
                
                direct_sums := List( [ 1 .. size_j ], j -> DirectSum( range_category, List( [ 1 .. size_s ], s -> H_B_C[j][s] ) ) );
                
                return UniversalMorphismIntoDirectSumWithGivenDirectSum(
                    range_category,
                    direct_sums,
                    distinguished_object,
                    List( [ 1 .. size_j ], j ->
                        UniversalMorphismIntoDirectSumWithGivenDirectSum( range_category,
                            List( [ 1 .. size_s ], s -> H_B_C[j][s] ),
                            distinguished_object,
                            List( [ 1 .. size_s ], s ->
                                InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, distinguished_object, alpha[j, s], H_B_C[j][s] )
                            ),
                            direct_sums[j]
                        )
                    ),
                    range
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
              function( cat, B, C, morphism )
                local size_j, size_s, H_B_C, direct_sums, blocks, listlist;
                
                size_j := Length( ObjectList( B ) );
                
                size_s := Length( ObjectList( C ) );
                
                H_B_C :=
                    List( [ 1 .. size_j ], j ->
                        List( [ 1 .. size_s ], s ->
                            HomomorphismStructureOnObjectsExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category, B[j], C[s] )
                        )
                    );
                
                direct_sums := List( [ 1 .. size_j ], j -> DirectSum( range_category, List( [ 1 .. size_s ], s -> H_B_C[j][s] ) ) );
                
                blocks := List( [ 1 .. size_j ], j ->
                            ComponentOfMorphismIntoDirectSum( range_category,
                              morphism,
                              direct_sums,
                              j
                            )
                          );
                
                listlist := List( [ 1 .. size_j ], j ->
                            List( [ 1 .. size_s ], s ->
                              ComponentOfMorphismIntoDirectSum( range_category,
                                blocks[j],
                                H_B_C[j],
                                s
                              )
                            )
                          );
                
                return AdditiveClosureMorphism( cat,
                        B,
                        List( [ 1 .. size_j ], j ->
                          List( [ 1 .. size_s ], s ->
                            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category,
                              B[j],
                              C[s],
                              listlist[j][s]
                            )
                          )
                        ),
                        C
                      );
                
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
    
    ## Random Methods by Integers
    ##
    if CanCompute( underlying_category, "RandomObjectByInteger" ) then
      
      AddRandomObjectByInteger( category,
        function( cat, n )
          
          if IsNegInt( n ) then
              Error( "the integer passed to 'RandomObjectByInteger' in ", Name( category ), " must be a non-negative integer!\n" );
          fi;
          
          return AdditiveClosureObject( List( [ 1 .. Random( 0, n ) ], i -> RandomObjectByInteger( underlying_category, n ) ), cat );
          
      end );
      
    fi;
    
    if CanCompute( underlying_category, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
      
      AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
        function( cat, S, R, n )
          
          return AdditiveClosureMorphism(
                    S,
                    List( ObjectList( S ), s -> List( ObjectList( R ), r -> RandomMorphismWithFixedSourceAndRangeByInteger( underlying_category, s, r, n ) ) ),
                    R );
      
      end );
      
    fi;
    
    ## Random Methods by Lists
    ##
    if CanCompute( underlying_category, "RandomObjectByList" ) then
      
      AddRandomObjectByList( category,
        function( cat, L )
          
          if Length( L ) <> 2 or (not ForAll( L, IsList )) or IsEmpty( L[1] ) or ForAny( L[1], IsNegInt ) then
              Error( "the list passed to 'RandomObjectByList' in ", Name( category ), " must be a list of length two consisting of a non-empty list of non-negative integers and a list!\n" );
          fi;
          
          return AdditiveClosureObject( List( [ 1 .. Random( L[1] ) ], i -> RandomObjectByList( underlying_category, L[2] ) ), cat );
      
      end );
      
    fi;
    
    if CanCompute( underlying_category, "RandomMorphismWithFixedSourceAndRangeByList" ) then
      
      AddRandomMorphismWithFixedSourceAndRangeByList( category,
        function( cat, S, R, L )
          
          return AdditiveClosureMorphism(
                    S,
                    List( ObjectList( S ), s -> List( ObjectList( R ), r -> RandomMorphismWithFixedSourceAndRangeByList( underlying_category, s, r, L ) ) ),
                    R );
      
      end );
      
    fi;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
          [ IsAdditiveClosureMorphism ],
  function( morphism )
    return Concatenation( "<A morphism in ", Name( CapCategory( morphism ) ),
            " defined by a ", String( NrRows( morphism ) ), " x ", String( NrCols( morphism ) ), " matrix of underlying morphisms>"
            );
end );

##
InstallMethod( ViewString,
          [ IsAdditiveClosureObject ],
  function( object )
    return Concatenation( "<An object in ", Name( CapCategory( object ) ),
            " defined by ", String( Length( ObjectList( object ) ) ), " underlying objects>"
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
    
    Print( "\n" );
    
end );

##
InstallMethod( Display,
               [ IsAdditiveClosureObject ],
               
  function( object )
    local object_list, obj;
    
    object_list := ObjectList( object );
    
    Print( Concatenation( "A formal direct sum consisting of ", String( Length( object_list ) ), " objects.\n" ) );
    
    for obj in object_list do
        
        ViewObj( obj );
        
        Print( "\n" );
        
    od;
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsAdditiveClosureObject ],
          
  function( obj )
    local objs;
    
    objs := CollectEntries( ObjectList( obj ) );
    
    if IsEmpty( objs ) then
      return "0";
    else
      return
        JoinStringsWithSeparator(
          List( objs,
              function( pair )
                local s;
                s := Concatenation( "{", LaTeXOutput( pair[ 1 ] ), "}" );
                if pair[ 2 ] <> 1 then
                    s := Concatenation( s, "^{\\oplus ", String( pair[ 2 ] ), "}" );
                fi;
                return s;
              end ),
          "\\oplus" );
    fi;
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsAdditiveClosureMorphism ],
          
  function( morphism )
    local matrix, str;
    
    matrix := MorphismMatrix( morphism );
    
    if ForAny( List( [ Source( morphism ), Range( morphism ) ], ObjectList ), IsEmpty ) then
        str := "\\\\";
    else
        str := JoinStringsWithSeparator(
              List( matrix, row -> JoinStringsWithSeparator(
                                      List( row, m -> LaTeXOutput( m : OnlyDatum := true ) ),
                                      "\&" ) ),
              "\\\\ \n"
            );
    fi;
    
    str :=  Concatenation( "\\begin{pmatrix}", str, "\\end{pmatrix}" );
    
    if ValueOption( "OnlyDatum" ) = true then
        return str;
    fi;
    
    return Concatenation(
              LaTeXOutput( Source( morphism ) ),
              "\\xrightarrow{", str, "}",
              LaTeXOutput( Range( morphism ) )
            );
    
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
