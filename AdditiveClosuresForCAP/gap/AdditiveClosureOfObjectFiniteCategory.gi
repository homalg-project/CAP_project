# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallOtherMethodForCompilerForCAP( AdditiveClosureObject,
                                     [ IsAdditiveClosureOfObjectFiniteCategory, IsList ],
                                     
  function( category, nr_summands_and_multiplicities )
    
    return ObjectConstructor( category, nr_summands_and_multiplicities );
    
end );

##
InstallMethod( AdditiveClosureMorphism,
               [ IsObjectInAdditiveClosureOfObjectFiniteCategory, IsList, IsObjectInAdditiveClosureOfObjectFiniteCategory ],
               
  function( source, morphism_matrix, target )
    
    return MorphismConstructor( CapCategory( source ), source, morphism_matrix, target );
    
end );

##
InstallOtherMethodForCompilerForCAP( AdditiveClosureMorphism,
                                     [ IsAdditiveClosureOfObjectFiniteCategory,
                                       IsObjectInAdditiveClosureOfObjectFiniteCategory,
                                       IsList,
                                       IsObjectInAdditiveClosureOfObjectFiniteCategory ],
                                     
  function( category, source, morphism_matrix, target )
    
    return MorphismConstructor( category, source, morphism_matrix, target );
    
end );

##
InstallMethod( AdditiveClosureOfObjectFiniteCategory,
               [ IsCapCategory ],
               ADDITIVE_CLOSURE_OF_OBJECT_FINITE_CATEGORY
);

##
InstallMethod( ADDITIVE_CLOSURE_OF_OBJECT_FINITE_CATEGORY,
               [ IsCapCategory ],
               
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, underlying_category )
    local AC_objfin, name, object_datum_type, morphism_datum_type, nr_objects_underlying_category, compare_morphisms, object_function, morphism_function, object_function_inverse, morphism_function_inverse;
    
    Assert( 0, HasIsAbCategory( underlying_category ) and IsAbCategory( underlying_category ) );
    
    Assert( 0, HasIsObjectFiniteCategory( underlying_category ) and IsObjectFiniteCategory( underlying_category ) );
    
    name := Concatenation( "AdditiveClosureOfObjectFiniteCategory( ", Name( underlying_category )," )" );
    
    object_datum_type :=
        CapJitDataTypeOfNTupleOf( 2,
            IsBigInt,
            CapJitDataTypeOfListOf( IsBigInt ) );
            
    morphism_datum_type :=
        CapJitDataTypeOfListOf(
            CapJitDataTypeOfListOf(
                CapJitDataTypeOfMorphismOfCategory( underlying_category ) ) );
    
    AC_objfin := CreateCapCategoryWithDataTypes( name,
                                    IsAdditiveClosureOfObjectFiniteCategory,
                                    IsObjectInAdditiveClosureOfObjectFiniteCategory,
                                    IsMorphismInAdditiveClosureOfObjectFiniteCategory,
                                    IsCapCategoryTwoCell,
                                    object_datum_type,
                                    morphism_datum_type,
                                    fail );
    
    AC_objfin!.supports_empty_limits := true;
    
    AC_objfin!.compiler_hints :=
      rec( category_attribute_names :=
          [ "UnderlyingCategory",
            "ListOfObjectsOfUnderlyingCategory",
            "NumberOfObjectsOfUnderlyingCategory",] );
    
    SetIsAdditiveCategory( AC_objfin, true );
    
    if HasIsSkeletalCategory( underlying_category ) and IsSkeletalCategory( underlying_category ) then
        
        SetIsSkeletalCategory( AC_objfin, true );
        
    fi;
    
    if HasIsLinearCategoryOverCommutativeRing( underlying_category ) and
       IsLinearCategoryOverCommutativeRing( underlying_category ) and
       HasCommutativeSemiringOfLinearCategory( underlying_category )
    then
        
        SetIsLinearCategoryOverCommutativeRing( AC_objfin, true );
        
        SetCommutativeSemiringOfLinearCategory( AC_objfin, CommutativeSemiringOfLinearCategory( underlying_category ) );
        
        if HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( underlying_category ) and
           IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( underlying_category ) then

            SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( AC_objfin, true );
            
            # BasisOfExternalHom and CoefficientsOfMorphism can possibly be derived from the hom structure
            # see https://github.com/homalg-project/CAP_project/pull/652 for a primitive implementation
            
        fi;
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( underlying_category ) then
        
        SetIsEquippedWithHomomorphismStructure( AC_objfin, true );
        
    fi;
    
    if HasIsStrictMonoidalCategory( underlying_category ) and IsStrictMonoidalCategory( underlying_category ) then
        
        SetIsStrictMonoidalCategory( AC_objfin, true );
        
    elif HasIsMonoidalCategory( underlying_category ) and IsMonoidalCategory( underlying_category ) then
        
        SetIsMonoidalCategory( AC_objfin, true );
        
    fi;
    
    SetUnderlyingCategory( AC_objfin, underlying_category );
    
    SetNumberOfObjectsOfUnderlyingCategory( AC_objfin, Length( SetOfObjectsOfCategory( underlying_category ) ) );
    
    INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE_OF_OBJECT_FINITE_CATEGORY( AC_objfin, underlying_category );
    
    # HandlePrecompiledTowers( AC_objfin, underlying_category, "AdditiveClosureOfObjectFiniteCategory" );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( AC_objfin );
        
    fi;
    
    return AC_objfin;
    
end ) );

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE_OF_OBJECT_FINITE_CATEGORY,
  
  function( AC_objfin, underlying_category )
    local nr_objects_underlying_category, compare_morphisms, object_function, morphism_function, object_function_inverse, morphism_function_inverse, underlying_range_category, range_category;
    
    nr_objects_underlying_category := NumberOfObjectsOfUnderlyingCategory( AC_objfin );
    
    ##
    AddObjectConstructor( AC_objfin,
      function( AC_objfin, nr_summands_and_multiplicities )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, nr_summands_and_multiplicities[1] = Sum( nr_summands_and_multiplicities[2] ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Length( nr_summands_and_multiplicities[2] ) = nr_objects_underlying_category );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, ForAll( nr_summands_and_multiplicities[2], multiplicity -> multiplicity >= 0 ) );
        
        return CreateCapCategoryObjectWithAttributes( AC_objfin,
                       NrSummandsAndMultiplicities, nr_summands_and_multiplicities );
        
    end );
    
    ##
    AddObjectDatum( AC_objfin,
      function( AC_objfin, object )
        
        return NrSummandsAndMultiplicities( object );
        
    end );
    
    ##
    AddMorphismConstructor( AC_objfin,
      function( AC_objfin, source, morphism_matrix, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Length( morphism_matrix ) = NrOfSummands( source ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, ForAll( morphism_matrix, row -> Length( row ) = NrOfSummands( target ) ) );
        
        return CreateCapCategoryMorphismWithAttributes( AC_objfin,
                       source,
                       target,
                       MorphismMatrix, morphism_matrix );
        
    end );
    
    ##
    AddMorphismDatum( AC_objfin,
      function( AC_objfin, morphism )
        
        return MorphismMatrix( morphism );
        
    end );
    
    if CanCompute( underlying_category, "IsWellDefinedForObjects" ) then
        
        ##
        AddIsWellDefinedForObjects( AC_objfin,
          function( AC_objfin, object )
            local nr_summands_and_multiplicities;
            
            nr_summands_and_multiplicities := NrSummandsAndMultiplicities( object );
            
            if not nr_summands_and_multiplicities[1] = Sum( nr_summands_and_multiplicities[2] ) then
                
                return false;
                
            elif not Length( nr_summands_and_multiplicities[2] ) = NumberOfObjectsOfUnderlyingCategory( AC_objfin ) then
                
                return false;
                
            elif ForAny( nr_summands_and_multiplicities[2], multiplicity -> multiplicity < 0 ) then
                
                return false;
                
            else
                
                return true;
                
            fi;
            
        end );
        
    fi;
    
    if CanCompute( underlying_category, "IsWellDefinedForMorphismsWithGivenSourceAndRange" ) then
        
        ##
        AddIsWellDefinedForMorphisms( AC_objfin,
          function( AC_objfin, morphism )
            local source_list, target_list, nr_rows, nr_cols;
            
            source_list := UnderlyingObjectList( AC_objfin, Source( morphism ) );
            target_list := UnderlyingObjectList( AC_objfin, Target( morphism ) );
            
            nr_rows := NumberRows( morphism );
            nr_cols := NumberColumns( morphism );
            
            if Length( MorphismMatrix( morphism ) ) <> nr_rows then
                
                return false;
                
            elif ForAny( MorphismMatrix( morphism ), row -> Length( row ) <> nr_cols ) then
                
                return false;
                
            elif not ForAll( [ 1 .. nr_rows ], i ->
                        ForAll( [ 1 .. nr_cols ], j ->
                            # IsWellDefinedForMorphismsWithGivenSourceAndRange
                            IsWellDefinedForMorphisms( UnderlyingCategory( AC_objfin ), morphism[i,j] #, source_list[i], target_list[j]
                            ) and
                            IsEqualForObjects( UnderlyingCategory( AC_objfin ), Source( morphism[i,j] ), source_list[i] ) and
                            IsEqualForObjects( UnderlyingCategory( AC_objfin ), Target( morphism[i,j] ), target_list[j] ) ) )
            then
                
                return false;
                
            else
                
                return true;
                
            fi;
            
        end );
        
    fi;
    
    ##
    AddIsEqualForObjects( AC_objfin,
      function( AC_objfin, object_1, object_2 )
        
        return NrSummandsAndMultiplicities( object_1 ) = NrSummandsAndMultiplicities( object_2 );
        
    end );
    
    compare_morphisms := function( cat, morphism_1, morphism_2, comparison_function )
      local nr_rows_1, nr_rows_2, nr_cols_1, nr_cols_2;
        #% CAP_JIT_RESOLVE_FUNCTION
        
        nr_rows_1 := NumberRows( morphism_1 );
        nr_rows_2 := NumberRows( morphism_2 );
        
        nr_cols_1 := NumberColumns( morphism_1 );
        nr_cols_2 := NumberColumns( morphism_2 );
        
        if nr_rows_1 <> nr_rows_2 then
            
            return false;
            
        elif nr_cols_1 <> nr_cols_2 then
            
            return false;
            
        fi;
        
        return ForAll( [ 1 .. nr_rows_1 ], i ->
                   ForAll( [ 1 .. nr_cols_1 ], j ->
                       comparison_function( UnderlyingCategory( cat ), morphism_1[i, j], morphism_2[i, j] ) ) );
        
    end;
    
    ##
    AddIsEqualForMorphisms( AC_objfin,
      function( AC_objfin, morphism_1, morphism_2 )
        
        return compare_morphisms( AC_objfin, morphism_1, morphism_2, IsEqualForMorphisms );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( AC_objfin,
      function( AC_objfin, morphism_1, morphism_2 )
        
        return compare_morphisms( AC_objfin, morphism_1, morphism_2, IsCongruentForMorphisms );
        
    end );
    
    ##
    AddIdentityMorphism( AC_objfin,
      function( AC_objfin, object )
        local size, object_list, morphism_matrix;
        
        size := NrOfSummands( object );

        object_list := UnderlyingObjectList( AC_objfin, object );
        
        morphism_matrix :=
            List( [ 1 .. size ], i ->
                List( [ 1 .. size ], function( j )
                   if i = j then
                       return IdentityMorphism( UnderlyingCategory( AC_objfin ), object_list[i] );
                   else
                       return ZeroMorphism( UnderlyingCategory( AC_objfin ), object_list[i], object_list[j] );
                    fi;
                end ) );
        
        return AdditiveClosureMorphism( AC_objfin, object, morphism_matrix, object );
        
    end );
    
    ##
    AddPreCompose( AC_objfin,
      function( AC_objfin, morphism_1, morphism_2 )
        local nr_rows_1, nr_cols_1, nr_rows_2, nr_cols_2, morphism_matrix, i, j;
        
        nr_rows_1 := NumberRows( morphism_1 );
        nr_rows_2 := NumberRows( morphism_2 );
        
        nr_cols_1 := NumberColumns( morphism_1 );
        nr_cols_2 := NumberColumns( morphism_2 );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, nr_cols_1 = nr_rows_2 );
        
        morphism_matrix :=
            List( [ 1 .. nr_rows_1 ], i ->
                List( [ 1 .. nr_cols_2 ], j ->
                    SumOfMorphisms( UnderlyingCategory( AC_objfin ),
                                    UnderlyingObjectList( AC_objfin, Source( morphism_1 ) )[i],
                                    List( [ 1 .. nr_cols_1 ], k ->
                                        PreCompose( UnderlyingCategory( AC_objfin ), morphism_1[i, k], morphism_2[k, j] ) ),
                                    UnderlyingObjectList( AC_objfin, Target( morphism_2 ) )[j] ) ) );
        
        return AdditiveClosureMorphism( AC_objfin, Source( morphism_1 ), morphism_matrix, Target( morphism_2 ) );
        
    end );
    
    ##
    AddZeroMorphism( AC_objfin,
      function( AC_objfin, source, target )
        local size_list_source, size_list_target, object_list_source, object_list_target, morphism_matrix, i, j;
        
        size_list_source := NrOfSummands( source );
        
        size_list_target := NrOfSummands( target );
        
        object_list_source := UnderlyingObjectList( AC_objfin, source );
        
        object_list_target := UnderlyingObjectList( AC_objfin, target );
        
        morphism_matrix :=
            List( [ 1 .. size_list_source ], i ->
                List( [ 1 .. size_list_target ], j ->
                    ZeroMorphism( UnderlyingCategory( AC_objfin ), object_list_source[i], object_list_target[j] )));
        
        return AdditiveClosureMorphism( AC_objfin, source, morphism_matrix, target );
        
    end );
    
    ##
    AddIsZeroForMorphisms( AC_objfin,
      function( AC_objfin, morphism )
        
        return ForAll( [ 1 .. NumberRows( morphism ) ], i ->
                   ForAll( [ 1 .. NumberColumns( morphism ) ], j ->
                       IsZeroForMorphisms( UnderlyingCategory( AC_objfin ), morphism[i, j] ) ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( AC_objfin,
      function( AC_objfin, morphism_1, morphism_2 )
        local morphism_matrix;
        
        morphism_matrix :=
            List( [ 1 .. NumberRows( morphism_1 ) ], i ->
                List( [ 1 .. NumberColumns( morphism_1 ) ], j ->
                    AdditionForMorphisms( UnderlyingCategory( AC_objfin ), morphism_1[i, j], morphism_2[i, j] ) ) );
        
        return AdditiveClosureMorphism( AC_objfin, Source( morphism_1 ), morphism_matrix, Target( morphism_1 ) );
        
    end );
    
    ##
    AddSumOfMorphisms( AC_objfin,
      function( AC_objfin, source, morphisms, target )
        local length_source_list, length_target_list, source_object_list, target_object_list, morphism_matrix;
        
        length_source_list := NrOfSummands( source );
        length_target_list := NrOfSummands( target );
        
        source_object_list := UnderlyingObjectList( AC_objfin, source );
        target_object_list := UnderlyingObjectList( AC_objfin, target );
        
        morphism_matrix :=
            List( [ 1 .. length_source_list ], i ->
                List( [ 1 .. length_target_list ], j ->
                    SumOfMorphisms( underlying_category,
                                    source_object_list[i],
                                    List( morphisms, m -> m[i, j] ),
                                    target_object_list[j] ) ) );
        
        return AdditiveClosureMorphism( AC_objfin,
                                        source,
                                        morphism_matrix,
                                        target );
        
    end );
    
    AddAdditiveInverseForMorphisms( AC_objfin,
      function( AC_objfin, morphism )
        local morphism_matrix;
        
        morphism_matrix :=
            List( [ 1 .. NumberRows( morphism ) ], i ->
                List( [ 1 .. NumberColumns( morphism ) ], j ->
                    AdditiveInverseForMorphisms( UnderlyingCategory( AC_objfin ), morphism[i, j] ) ) );
        
        return AdditiveClosureMorphism( AC_objfin, Source( morphism ), morphism_matrix, Target( morphism ) );
        
    end );
    
    AddZeroObject( AC_objfin,
      function( AC_objfin )
        local zero_list;
        
        zero_list := ListWithIdenticalEntries( NumberOfObjectsOfUnderlyingCategory( AC_objfin ), 0 );
        
        return AdditiveClosureObject( AC_objfin, Pair( 0, zero_list ) );
        
    end );
    
    ##
    AddDirectSum( AC_objfin,
      function( AC_objfin, diagram )
        local sum;
        
        sum := Sum( List( diagram, obj -> NrSummandsAndMultiplicities( obj ) ) );
        
        return AdditiveClosureObject( AC_objfin, sum );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( AC_objfin,
      function( AC_objfin, diagram, test_object, morphisms, direct_sum )
        local morphism_matrix;
        
        morphism_matrix := UnionOfColumnsListList( NrOfSummands( test_object ),
                                                   List( morphisms, tau -> MorphismMatrix( tau ) ) );
        
        return AdditiveClosureMorphism( AC_objfin, test_object, morphism_matrix, direct_sum );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( AC_objfin,
      function( AC_objfin, diagram, test_object, morphisms, direct_sum )
        local morphism_matrix;
        
        morphism_matrix := UnionOfRowsListList( NrOfSummands( test_object ),
                                                List( morphisms, tau -> MorphismMatrix( tau ) ) );
        
        return AdditiveClosureMorphism( AC_objfin, direct_sum, morphism_matrix, test_object );
        
    end );
    
    ##
    AddComponentOfMorphismIntoDirectSum( AC_objfin,
      function( AC_objfin, morphism, summands, nr )
        local lengths, offset, start, stop;
        
        lengths := List( summands, s -> NrOfSummands( s ) );
        
        offset := Sum( lengths{[ 1 .. nr-1 ]} );
        
        start := offset + 1;
        stop := offset + lengths[nr];
        
        return AdditiveClosureMorphism( AC_objfin,
                                        Source( morphism ),
                                        List( MorphismMatrix( morphism ), row -> row{[ start .. stop ]} ), # CertainColumns
                                        summands[nr] );
        
    end );
    
    ##
    AddComponentOfMorphismFromDirectSum( AC_objfin,
      function( AC_objfin, morphism, summands, nr )
        local lengths, offset, start, stop;
        
        lengths := List( summands, s -> NrOfSummands( s ) );
        
        offset := Sum( lengths{[ 1 .. nr-1 ]} );
        
        start := offset + 1;
        stop := offset + lengths[nr];
        
        return AdditiveClosureMorphism( AC_objfin, summands[nr],
                                        MorphismMatrix( morphism ){[ start .. stop ]}, # CertainRows
                                        Target( morphism ) );
        
    end );
    
    if CanCompute( underlying_category, "MultiplyWithElementOfCommutativeSemiringForMorphisms" ) then
      
      AddMultiplyWithElementOfCommutativeSemiringForMorphisms( AC_objfin,
        function( AC_objfin, r, alpha )
          local morphism_matrix;
          
          morphism_matrix :=
              List( [ 1 .. NumberRows( alpha ) ], i ->
                  List( [ 1 .. NumberColumns( alpha ) ], j ->
                      MultiplyWithElementOfCommutativeSemiringForMorphisms( underlying_category, r, alpha[i, j] ) ) );
          
          return AdditiveClosureMorphism( AC_objfin, Source( alpha ), morphism_matrix, Target( alpha ) );
          
      end );
      
    fi;
    
    # The homomorphism structure is taken from AdditiveClosuresForCAP/gap/AdditiveClosure.gi
    if HasRangeCategoryOfHomomorphismStructure( underlying_category ) then
        
        underlying_range_category := RangeCategoryOfHomomorphismStructure( underlying_category );
        
        # If the range category of the underlying category is not additive but pre-additive, we first apply AdditiveClosure to it.
        # See https://arxiv.org/abs/1908.04132 (Sebastian Posur: Methods of constructive category theory), Remark 1.28
        if not (HasIsAdditiveCategory( underlying_range_category ) and IsAdditiveCategory( underlying_range_category )) and
           HasIsAbCategory( underlying_range_category ) and IsAbCategory( underlying_range_category )
        then
            
            if IsIdenticalObj( underlying_category, underlying_range_category ) then
                
                # prevent infinite recursion
                range_category := AC_objfin;
                
            else
                
                range_category := AdditiveClosure( underlying_range_category );
                
            fi;
            
            # prepare for ExtendRangeOfHomomorphismStructureByFullEmbedding
            object_function := function ( category, range_category, object )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return AdditiveClosureObject( range_category, [ object ] );
                
            end;
            
            morphism_function := function ( category, range_category, source, morphism, range )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return AdditiveClosureMorphism( range_category, source, [ [ morphism ] ], range );
                
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
                Assert( 0, NumberRows( morphism ) = 1 and NumberColumns( morphism ) = 1 );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, IsEqualForObjects( source, Source( morphism[1,1] ) ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, IsEqualForObjects( range, Target( morphism[1,1] ) ) );
                
                return morphism[1,1];
                
            end;
            
            ExtendRangeOfHomomorphismStructureByFullEmbedding( underlying_category,
                                                               range_category,
                                                               object_function,
                                                               morphism_function,
                                                               object_function_inverse,
                                                               morphism_function_inverse );
            
        else
            
            range_category := underlying_range_category;
            
            ExtendRangeOfHomomorphismStructureByIdentityAsFullEmbedding( underlying_category );
            
        fi;
        
        SetRangeCategoryOfHomomorphismStructure( AC_objfin, range_category );
        
        if (ForAll( [ "DirectSum" ], f -> CanCompute( range_category, f ) ) or IsIdenticalObj( range_category, AC_objfin ) ) and
           ForAll( [ "HomomorphismStructureOnObjects" ], f -> CanCompute( underlying_category, f ) )
        then
            
            ##
            AddHomomorphismStructureOnObjects( AC_objfin,
              function( cat, object_1, object_2 )
                
                return DirectSum( range_category,
                          List( [ 1 .. Length( UnderlyingObjectList( AC_objfin, object_1 ) ) ], j ->
                            DirectSum( range_category,
                              List( [ 1 .. Length( UnderlyingObjectList( AC_objfin, object_2 ) ) ], s ->
                                HomomorphismStructureOnObjectsExtendedByFullEmbedding(
                                    UnderlyingCategory( cat ),
                                    range_category,
                                    UnderlyingObjectList( AC_objfin, object_1 )[j],
                                    UnderlyingObjectList( AC_objfin, object_2 )[s] ) ) ) ) );
                
            end );
        
        fi;
        
        # legacy
        if (ForAll( [ "MorphismBetweenDirectSumsWithGivenDirectSums" ], f -> CanCompute( range_category, f ) ) or IsIdenticalObj( range_category, AC_objfin )) and
           ForAll( [ "HomomorphismStructureOnMorphismsWithGivenObjects" ], f -> CanCompute( underlying_category, f ) ) and
           not (IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true) then
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( AC_objfin,
              function( cat, source, alpha, beta, range )
                local size_i, size_j, size_s, size_t;
                
                size_i := NumberRows( alpha );
                
                size_j := NumberColumns( alpha );
                
                size_s := NumberRows( beta );
                
                size_t := NumberColumns( beta );
                
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
        
        if (ForAll( [ "MorphismBetweenDirectSumsWithGivenDirectSums" ], f -> CanCompute( range_category, f ) ) or IsIdenticalObj( range_category, AC_objfin ))
           and ForAll( [ "HomomorphismStructureOnMorphismsWithGivenObjects" ], f -> CanCompute( underlying_category, f ) )
           and IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true then
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( AC_objfin,
              function( cat, source, alpha, beta, range )
                local size_i, size_j, size_s, size_t, A, B, C, D, H_B_C, H_A_D, source_direct_sums, range_direct_sums;
                
                size_i := NumberRows( alpha );
                
                size_j := NumberColumns( alpha );
                
                size_s := NumberRows( beta );
                
                size_t := NumberColumns( beta );
                
                A := Source( alpha );
                B := Target( alpha );
                C := Source( beta );
                D := Target( beta );
                
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
            AddDistinguishedObjectOfHomomorphismStructure( AC_objfin,
              function( cat )
                
                return DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding( UnderlyingCategory( cat ), range_category );
                
            end );
            
        fi;
        
        if (ForAll( [ "UniversalMorphismIntoZeroObject",
                     "UniversalMorphismIntoDirectSum" ],
                     f -> CanCompute( range_category, f ) ) or IsIdenticalObj( range_category, AC_objfin )) and
           ForAll( [ "DistinguishedObjectOfHomomorphismStructure",
                         "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ],
                         f -> CanCompute( underlying_category, f ) ) and
           not (IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true) then
            
            ##
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( AC_objfin,
              function( cat, alpha )
                local size_i, size_j;
                
                size_i := NumberRows( alpha );
                
                size_j := NumberColumns( alpha );
                
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
        
        if (ForAll( [ "UniversalMorphismIntoDirectSum" ],
                     f -> CanCompute( range_category, f ) ) or IsIdenticalObj( range_category, AC_objfin )) and
           ForAll( [ "DistinguishedObjectOfHomomorphismStructure",
                         "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ],
                         f -> CanCompute( underlying_category, f ) ) and
           IsBound( range_category!.supports_empty_limits ) and range_category!.supports_empty_limits = true then
            
            ##
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( AC_objfin,
              function( cat, distinguished_object, alpha, range )
                local size_j, size_s, B, C, H_B_C, direct_sums;
                
                size_j := NumberRows( alpha );
                
                size_s := NumberColumns( alpha );
                
                B := Source( alpha );
                C := Target( alpha );
                
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
                     f -> CanCompute( underlying_category, f ) ) and
           (ForAll( [ "PreCompose",
                         "ProjectionInFactorOfDirectSum" ],
                         f -> CanCompute( range_category, f ) ) or IsIdenticalObj( range_category, AC_objfin )) then
            
            ##
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( AC_objfin,
              function( cat, B, C, morphism )
                local size_j, size_s, H_B_C, direct_sums, blocks, listlist;
                
                size_j := Length( UnderlyingObjectList( AC_objfin, B ) );
                
                size_s := Length( UnderlyingObjectList( AC_objfin, C ) );
                
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

    if HasIsMonoidalCategory( underlying_category ) and IsMonoidalCategory( underlying_category ) then
        
        ##
        AddTensorUnit( AC_objfin,
          function( AC_objfin )
            local multiplicities;
            
            multiplicities := ObjectToMultiplicityList( underlying_category, TensorUnit( underlying_category ) );
            
            return AdditiveClosureObject( AC_objfin, [ 1, multiplicities ] );
            
        end );
        
        ##
        AddTensorProductOnObjects( AC_objfin,
          function( AC_objfin, obj_1, obj_2 )
            local len_1, len_2, summands, multiplicities;
            
            len_1 := NrOfSummands( obj_1 );
            len_2 := NrOfSummands( obj_2 );
            
            summands :=
                List( [ 0 .. len_1 * len_2 - 1 ], i ->
                    TensorProductOnObjects( underlying_category,
                        obj_1[ 1 + QuoInt( i, len_2 ) ],
                        obj_2[ 1 + RemInt( i, len_2 ) ] ) );
            
            multiplicities := ObjectsToMultiplicityList( underlying_category, summands );
            
            return AdditiveClosureObject( AC_objfin, [ Length( summands ), multiplicities ] );
            
        end );
        
        ##
        AddTensorProductOnMorphismsWithGivenTensorProducts( AC_objfin,
          function( AC_objfin, source, morph_1, morph_2, target )
            local source_1, source_2, target_1, target_2,
                  len_s1, len_s2, len_t1, len_t2;
            
            source_1 := Source( morph_1 );
            source_2 := Source( morph_2 );
            target_1 := Target( morph_1 );
            target_2 := Target( morph_2 );
            len_s1 := NrOfSummands( source_1 );
            len_s2 := NrOfSummands( source_2 );
            len_t1 := NrOfSummands( target_1 );
            len_t2 := NrOfSummands( target_2 );
            
            return AdditiveClosureMorphism( AC_objfin,
                      source,
                          List( [ 0 .. len_s1 * len_s2 - 1 ], i ->
                              List( [ 0 .. len_t1 * len_t2 - 1 ], j ->
                                  TensorProductOnMorphismsWithGivenTensorProducts( underlying_category,
                                      source[ 1 + len_s2 * QuoInt( i, len_s2 ) + RemInt( i, len_s2 ) ],
                                      morph_1[ 1 + QuoInt( i, len_s2 ), 1 + QuoInt( j, len_t2 ) ],
                                      morph_2[ 1 + RemInt( i, len_s2 ), 1 + RemInt( j, len_t2 ) ],
                                      target[ 1 + len_t2 * QuoInt( j, len_t2 ) + RemInt( j, len_t2 ) ] ) ) ),
                      target );
            
        end );
        
        if not ( HasIsStrictMonoidalCategory( underlying_category ) and IsStrictMonoidalCategory( underlying_category ) ) then
            
            ##
            AddLeftUnitorWithGivenTensorProduct( AC_objfin,
              function( AC_objfin, obj, unit_tensor_obj )
                local length, source_diagram, target_diagram;
                
                length := NrOfSummands( obj );
                source_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ unit_tensor_obj[ o ] ] ) );
                target_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ obj[ o ] ] ) );
                
                return DirectSumFunctorialWithGivenDirectSums( AC_objfin,
                          unit_tensor_obj,
                          source_diagram,
                          List( [ 1 .. length ], o ->
                              AdditiveClosureMorphism( AC_objfin,
                                  source_diagram[ o ],
                                  [ [ LeftUnitorWithGivenTensorProduct( underlying_category,
                                      obj[ o ],
                                      unit_tensor_obj[ o ] ) ] ],
                                  target_diagram[ o ] ) ),
                          target_diagram,
                          obj );
                
            end );
            
            ##
            AddLeftUnitorInverseWithGivenTensorProduct( AC_objfin,
              function( AC_objfin, obj, unit_tensor_obj )
                local length, source_diagram, target_diagram;
                
                length := NrOfSummands( obj );
                source_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ obj[ o ] ] ) );
                target_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ unit_tensor_obj[ o ] ] ) );
                
                return DirectSumFunctorialWithGivenDirectSums( AC_objfin,
                          obj,
                          source_diagram,
                          List( [ 1 .. length ], o ->
                              AdditiveClosureMorphism( AC_objfin,
                                  source_diagram[ o ],
                                  [ [ LeftUnitorInverseWithGivenTensorProduct( underlying_category,
                                      obj[ o ],
                                      unit_tensor_obj[ o ] ) ] ],
                                  target_diagram[ o ] ) ),
                          target_diagram,
                          unit_tensor_obj );
                
            end );
            
            ##
            AddRightUnitorWithGivenTensorProduct( AC_objfin,
              function( AC_objfin, obj, obj_tensor_unit )
                local length, source_diagram, target_diagram;
                
                length := Length( UnderlyingObjectList( AC_objfin, obj ) );
                source_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ obj_tensor_unit[ o ] ] ) );
                target_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ obj[ o ] ] ) );
                
                return DirectSumFunctorialWithGivenDirectSums( AC_objfin,
                          obj_tensor_unit,
                          source_diagram,
                          List( [ 1 .. length ], o ->
                              AdditiveClosureMorphism( AC_objfin,
                                  source_diagram[ o ],
                                  [ [ RightUnitorWithGivenTensorProduct( underlying_category,
                                      obj[ o ],
                                      obj_tensor_unit[ o ] ) ] ],
                                  target_diagram[ o ] ) ),
                          target_diagram,
                          obj );
                
            end );
            
            ##
            AddRightUnitorInverseWithGivenTensorProduct( AC_objfin,
              function( AC_objfin, obj, obj_tensor_unit )
                local length, source_diagram, target_diagram;
                
                length := Length( UnderlyingObjectList( AC_objfin, obj ) );
                source_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ obj[ o ] ] ) );
                target_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ obj_tensor_unit[ o ] ] ) );
                
                return DirectSumFunctorialWithGivenDirectSums( AC_objfin,
                          obj,
                          source_diagram,
                          List( [ 1 .. length ], o ->
                              AdditiveClosureMorphism( AC_objfin,
                                  source_diagram[ o ],
                                  [ [ RightUnitorInverseWithGivenTensorProduct( underlying_category,
                                      obj[ o ],
                                      obj_tensor_unit[ o ] ) ] ],
                                  target_diagram[ o ] ) ),
                          target_diagram,
                          obj_tensor_unit );
                
            end );
            
            ##
            AddAssociatorLeftToRightWithGivenTensorProducts( AC_objfin,
              function( AC_objfin, source, obj_1, obj_2, obj_3, target )
                local len_1, len_2, len_3, length, source_diagram, target_diagram;
                
                len_1 := Length( UnderlyingObjectList( AC_objfin, obj_1 ) );
                len_2 := Length( UnderlyingObjectList( AC_objfin, obj_2 ) );
                len_3 := Length( UnderlyingObjectList( AC_objfin, obj_3 ) );
                length := len_1 * len_2 * len_3;
                source_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ source[ o ] ] ) );
                target_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ target[ o ] ] ) );
                
                return DirectSumFunctorialWithGivenDirectSums( AC_objfin,
                          source,
                          source_diagram,
                          List( [ 0 .. length - 1 ], o ->
                              AdditiveClosureMorphism( AC_objfin,
                                  source_diagram[1 + o],
                                  [ [ AssociatorLeftToRightWithGivenTensorProducts( underlying_category,
                                      source[1 + o],
                                      obj_1[1 + QuoInt( o, len_2 * len_3 )],
                                      obj_2[1 + RemInt( QuoInt( o, len_3 ), len_2 )],
                                      obj_3[1 + RemInt( o, len_3 )],
                                      target[1 + o] ) ] ],
                                  target_diagram[1 + o] ) ),
                          target_diagram,
                          target );
                
            end );
            
            ##
            AddAssociatorRightToLeftWithGivenTensorProducts( AC_objfin,
              function( AC_objfin, source, obj_1, obj_2, obj_3, target )
                local len_1, len_2, len_3, length, source_diagram, target_diagram;
                
                len_1 := Length( UnderlyingObjectList( AC_objfin, obj_1 ) );
                len_2 := Length( UnderlyingObjectList( AC_objfin, obj_2 ) );
                len_3 := Length( UnderlyingObjectList( AC_objfin, obj_3 ) );
                length := len_1 * len_2 * len_3;
                source_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ source[ o ] ] ) );
                target_diagram := List( [ 1 .. length ], o -> AdditiveClosureObject( AC_objfin, [ target[ o ] ] ) );
                
                return DirectSumFunctorialWithGivenDirectSums( AC_objfin,
                          source,
                          source_diagram,
                          List( [ 0 .. length - 1 ], o ->
                              AdditiveClosureMorphism( AC_objfin,
                                  source_diagram[1 + o],
                                  [ [ AssociatorRightToLeftWithGivenTensorProducts( underlying_category,
                                      source[1 + o],
                                      obj_1[1 + QuoInt( o, len_2 * len_3 )],
                                      obj_2[1 + RemInt( QuoInt( o, len_3 ), len_2 )],
                                      obj_3[1 + RemInt( o, len_3 )],
                                      target[1 + o] ) ] ],
                                  target_diagram[1 + o] ) ),
                          target_diagram,
                          target );
                
            end );
            
        fi;
    fi;
    
end );

####################################
##
## Attributes
##
####################################

InstallMethod( ListOfObjectsOfUnderlyingCategory,
               [ IsAdditiveClosureOfObjectFiniteCategory ],
               
  function( cat )
    
    return SetOfObjectsOfCategory( UnderlyingCategory( cat ) );
    
end );

InstallMethodForCompilerForCAP( NrOfSummands,
                                [ IsObjectInAdditiveClosureOfObjectFiniteCategory ],

  function( obj )

    return NrSummandsAndMultiplicities( obj )[1];

end );

InstallMethodForCompilerForCAP( Multiplicities,
                                [ IsObjectInAdditiveClosureOfObjectFiniteCategory ],
                                
  function( obj )
    
    return NrSummandsAndMultiplicities( obj )[2];
    
end );

InstallMethodForCompilerForCAP( UnderlyingObjectList,
                                [ IsAdditiveClosureOfObjectFiniteCategory, IsObjectInAdditiveClosureOfObjectFiniteCategory ],
                                
  function( cat, obj )
    local underlying_objects, l, multiplicities;
    
    underlying_objects := ListOfObjectsOfUnderlyingCategory( cat );
    
    l := NumberOfObjectsOfUnderlyingCategory( cat );
    
    multiplicities := Multiplicities( obj );
    
    return Concatenation( List( [ 1 .. l ], i -> ListWithIdenticalEntries( multiplicities[i], underlying_objects[i] ) ) );
    
end );

##
InstallMethodForCompilerForCAP( NumberRows,
                                [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ],
                                
  function( morphism )
    
    return NrOfSummands( Source( morphism ) );
    
end );

##
InstallMethodForCompilerForCAP( NumberColumns,
                                [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ],
                                
  function( morphism )
    
    return NrOfSummands( Target( morphism ) );
    
end );

####################################
##
## Operators
##
####################################

##
InstallMethod( \[\],
               [ IsObjectInAdditiveClosureOfObjectFiniteCategory, IsInt ],
                                
  function( object, i )
    local obj_list;
    
    obj_list := UnderlyingObjectList( CapCategory( object ), object );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0, 1 <= i and i <= Length( obj_list ), "out of bounds.\n" );
    
    return obj_list[ i ];
    
end );

##
InstallMethodForCompilerForCAP( \[\,\],
               [ IsMorphismInAdditiveClosureOfObjectFiniteCategory, IsInt, IsInt ],
                                
  function( morphism, i, j )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0, 1 <= i and i <= NumberRows( morphism ) and
               1 <= j and j <= NumberColumns( morphism ), "out of bounds.\n" );
    
    return MorphismMatrix( morphism )[i][j];
    
end );

##
InstallMethodForCompilerForCAP( ObjectToMultiplicityList,
                                [ IsCapCategory and IsObjectFiniteCategory, IsCapCategoryObject ],
  function( category, obj )
    local set_of_objects, pos, positions;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0, category = CapCategory( obj ) );
    
    set_of_objects := SetOfObjectsOfCategory( category );
    
    pos := Position( set_of_objects, obj );
    
    positions := ListWithIdenticalEntries( Length( set_of_objects ), 0 );
    
    positions[pos] := 1;
    
    return positions;
    
end );

##
InstallMethodForCompilerForCAP( ObjectsToMultiplicityList,
                                [ IsCapCategory and IsObjectFiniteCategory, IsList ],
  function( category, objects )
    local set_of_objects;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0, ForAll( objects, obj -> category = CapCategory( obj ) ) );
    
    set_of_objects := SetOfObjectsOfCategory( category );
    
    return List( [ 1 .. Length( set_of_objects ) ], i ->
              Length( PositionsProperty( objects, obj ->
                   IsEqualForObjects( category, obj, set_of_objects[i] ) ) ) );
    
end );

##
InstallOtherMethod( \/,
                   [ IsList, IsAdditiveClosureOfObjectFiniteCategory ],
                  
  function( listlist, AC_objfin )
    local underlying_category, multiplicities, nr_summands_and_multiplicities,
          sources_list, targets_list, source, target, mor;
    
    underlying_category := UnderlyingCategory( AC_objfin );
    
    if ForAll( listlist, obj -> IsCapCategoryObject( obj ) and
                                IsIdenticalObj( CapCategory( obj ), underlying_category ) )
    then
        
        # It's a list of objects in the underlying category.
        
        multiplicities := ObjectsToMultiplicityList( underlying_category, listlist );
         
        nr_summands_and_multiplicities := [ Length( listlist ), multiplicities ];
         
        return AdditiveClosureObject( AC_objfin, nr_summands_and_multiplicities );
        
    else
        
        # Assume it's a matrix of morphisms in the underlying category.
        
        sources_list := List( listlist, row -> Source( row[1] ) );
        targets_list := List( listlist[1], col -> Target( col ) );
        
        source := AdditiveClosureObject( AC_objfin,
                    [ Length( sources_list ), ObjectsToMultiplicityList( underlying_category, sources_list ) ] );
        
        target := AdditiveClosureObject( AC_objfin,
                    [ Length( targets_list ), ObjectsToMultiplicityList( underlying_category, targets_list ) ] );
        
        return AdditiveClosureMorphism( AC_objfin, source, listlist, target );
        
    fi;
    
end );

##
InstallOtherMethod( \/,
               [ IsCapCategoryObject, IsAdditiveClosureOfObjectFiniteCategory ],
               
  function( obj, AC_objfin )
    local pos, multiplicity_list;
    
    Assert( 0, IsIdenticalObj( UnderlyingCategory( AC_objfin ), CapCategory( obj ) ) );
    
    multiplicity_list := ObjectToMultiplicityList( UnderlyingCategory( AC_objfin ), obj );
    
    return ObjectConstructor( AC_objfin, [ 1, multiplicity_list ] );
    
end );

##
InstallOtherMethod( \/,
               [ IsCapCategoryMorphism, IsAdditiveClosureOfObjectFiniteCategory ],
               
  function( alpha, AC_objfin )
    local underlying_category, source, target;
    
    underlying_category := UnderlyingCategory( AC_objfin );
    
    Assert( 0, IsIdenticalObj( underlying_category, CapCategory( alpha ) ) );
    
    source := ObjectConstructor( AC_objfin, [ 1, ObjectToMultiplicityList( underlying_category, Source( alpha ) ) ] );
    target := ObjectConstructor( AC_objfin, [ 1, ObjectToMultiplicityList( underlying_category, Target( alpha ) ) ] );
    
    return MorphismConstructor( AC_objfin, source, [ [ alpha ] ], target );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
               [ IsObjectInAdditiveClosureOfObjectFiniteCategory ],
               
  function( object )
    return Concatenation(
                "<An object in ", Name( CapCategory( object ) ),
                " defined by ", String( NrOfSummands( object ) ) , " underlying objects>" );
end );

##
InstallMethod( ViewString,
               [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ],
               
  function( morphism )
    return Concatenation(
                "<A morphism in ", Name( CapCategory( morphism ) ),
                " defined by a ",
                String( NrOfSummands( Source( morphism ) ) ),
                " x ",
                String( NrOfSummands( Target( morphism ) ) ),
                " matrix of underlying morphisms>" );
end );

##
InstallMethod( DisplayString,
               [ IsObjectInAdditiveClosureOfObjectFiniteCategory ],
               
  function( object )
    local AC_objfin, A, objects_of_underlying_category, nr_objects_of_underlying_category,
          nr_objects, multiplicities, string, obj;
    
    AC_objfin := CapCategory( object );
    A := UnderlyingCategory( AC_objfin );
    
    objects_of_underlying_category := SetOfObjectsOfCategory( A );
    nr_objects_of_underlying_category := NumberOfObjectsOfUnderlyingCategory( AC_objfin );
    nr_objects := NrOfSummands( object );
    multiplicities := Multiplicities( object );
    
    if nr_objects = 1 then
      
      string := Concatenation( "A formal direct sum consisting of ", String( nr_objects ), " object:\n\n" );
      
    else
      
      string := Concatenation( "A formal direct sum consisting of ", String( nr_objects ), " objects:\n\n" );
      
    fi;
    
    for obj in [ 1 .. nr_objects_of_underlying_category  ] do
        
        string := Concatenation( string, String( multiplicities[ obj ] ), " times: " );
        
        string := Concatenation( string, ViewString( objects_of_underlying_category[ obj ] ), "\n" );
        
    od;
    
    return string;
    
end );

##
InstallMethod( DisplayString,
               [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ],
               
  function( morphism )
    local nr_rows, nr_cols, string, i, j;
    
    nr_rows := NumberRows( morphism );
    nr_cols := NumberColumns( morphism );
    
    string := Concatenation( "A ", String( nr_rows ), " x ", String( nr_cols ),
                             " matrix with entries in ",
                             Name( UnderlyingCategory( CapCategory( morphism ) ) ), "\n" );
    
    for i in [ 1 .. nr_rows ] do
        
        for j in [ 1 .. nr_cols ] do
            
            string := Concatenation( string, Concatenation( "\n[", String(i), ",", String(j), "]: " ) );
            
            string := Concatenation( string, ViewString( morphism[i,j] ) );
            
        od;
        
    od;
    
    string := Concatenation( string, "\n" );
    
    return string;
    
end );

