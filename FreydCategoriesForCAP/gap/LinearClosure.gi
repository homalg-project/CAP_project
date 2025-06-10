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
InstallGlobalFunction( LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows,
  function( rows, underlying_category, arg... ) ## rows = CategoryOfRows( ... )
    local ring, name, category, is_finite, sorting_function, with_nf, cocycle;
    
    ring := UnderlyingRing( rows );
    
    if not ( HasIsCommutative( ring ) and IsCommutative( ring ) ) then
        
        Error( "only commutative rings are supported" );
        
    fi;
    
    sorting_function := fail;
    
    cocycle := fail;
    
    if Length( arg ) = 0 then
        
        with_nf := false;
        
    elif Length( arg ) = 1 then
        
        sorting_function := arg[1];
        
        with_nf := true;
        
    else
        
        cocycle := arg[1];
        
        with_nf := arg[2];
        
        if Length( arg ) >= 3 then
            
            sorting_function := arg[3];
            
        fi;
        
    fi;
    
    if cocycle <> fail then
        
        name := Concatenation( "TwistedLinearClosure( ", Name( underlying_category )," )" );
        
    else
        
        name := Concatenation( "LinearClosure( ", Name( underlying_category )," )" );
        
    fi;
    
    category := CreateCapCategory( name, IsLinearClosure, IsLinearClosureObject, IsLinearClosureMorphism, IsCapCategoryTwoCell : overhead := false );
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
    );
    
    category!.with_nf := with_nf;
    
    if sorting_function <> fail then
        
        category!.sorting_function := sorting_function;
        
    fi;
    
    if cocycle <> fail then
        
        category!.cocycle := cocycle;
        
    fi;
    
    SetIsLinearCategoryOverCommutativeRing( category, true );
    
    SetIsAbCategory( category, true );
    
    SetCommutativeRingOfLinearCategory( category, ring );
    
    SetUnderlyingRing( category, ring );
    
    SetUnderlyingCategory( category, underlying_category );
    
    if HasIsObjectFiniteCategory( underlying_category ) and IsObjectFiniteCategory( underlying_category ) then
        
        SetIsObjectFiniteCategory( category, true );
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE( rows, category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( LinearClosure,
               [ IsCategoryOfRows, IsCapCategory, IsFunction ],
               LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows );

##
InstallMethod( LinearClosure,
               [ IsCategoryOfRows, IsCapCategory ],
               LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows );

##
InstallMethod( TwistedLinearClosure,
               [ IsCategoryOfRows, IsCapCategory, IsFunction ],
  function( rows, category, cocycle )
    
    return LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows( rows, category, cocycle, false );
    
end );

##
InstallMethod( TwistedLinearClosure,
               [ IsCategoryOfRows, IsCapCategory, IsFunction, IsFunction ],
  function( rows, category, cocycle, sorting_function )
    
    return LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows( rows, category, cocycle, true, sorting_function );
    
end );

## Special cases for groups
##
InstallMethod( LinearClosure,
               [ IsCategoryOfRows, IsGroupAsCategory ],
  function( rows, group_as_category )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LinearClosure( rows, group_as_category, compare_func );
    
end );

##
InstallMethod( TwistedLinearClosure,
               [ IsCategoryOfRows, IsGroupAsCategory, IsFunction ],
  function( rows, category, cocycle )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows( rows, category, cocycle, true, compare_func );
    
end );

##
InstallGlobalFunction( LINEAR_CLOSURE_CONSTRUCTOR,
  function( ring, underlying_category, arg... )
    local rows;
    
    rows := CategoryOfRows( ring : overhead := false, FinalizeCategory := true );
    
    return CallFuncList( LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows,
                   Concatenation( [ rows, underlying_category ], arg ) );
    
end );

## sorting_function:
## compares two morphisms alpha: a -> b, beta: a -> b
## such that, if we take the quotient by IsCongruentForMorphisms, we get a total ordering on morphisms
InstallMethod( LinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction ],
               LINEAR_CLOSURE_CONSTRUCTOR );

##
InstallMethod( LinearClosure,
               [ IsHomalgRing, IsCapCategory ],
               LINEAR_CLOSURE_CONSTRUCTOR );

##
InstallMethod( TwistedLinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction ],
  function( ring, category, cocycle )
    
    return LINEAR_CLOSURE_CONSTRUCTOR( ring, category, cocycle, false );
    
end );

##
InstallMethod( TwistedLinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction, IsFunction ],
  function( ring, category, cocycle, sorting_function )
    
    return LINEAR_CLOSURE_CONSTRUCTOR( ring, category, cocycle, true, sorting_function );
    
end );

## Special cases for groups
##
InstallMethod( LinearClosure,
               [ IsHomalgRing, IsGroupAsCategory ],
  function( ring, group_as_category )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LinearClosure( ring, group_as_category, compare_func );
    
end );

##
InstallMethod( TwistedLinearClosure,
               [ IsHomalgRing, IsGroupAsCategory, IsFunction ],
  function( ring, category, cocycle )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LINEAR_CLOSURE_CONSTRUCTOR( ring, category, cocycle, true, compare_func );
    
end );

##
InstallMethodForCompilerForCAP( LinearClosureObject,
                                [ IsLinearClosure, IsCapCategoryObject ],
               
  function( category, object )
    
    return CreateCapCategoryObjectWithAttributes( category,
                                                  UnderlyingOriginalObject, object );
    
end );

##
InstallOtherMethod( LinearClosureObject,
                    [ IsCapCategoryObject, IsLinearClosure ],
               
  function( object, category )
    
    return LinearClosureObject( category, object );
    
end );

## Data structure for morphisms:
##
## 1.case: there is a sorting function
## list of morphisms in underlying category: [ alpha_1, alpha_2, ..., alpha_n ],
## pairwise not congruent, and sorted w.r.t. sorting_function in increasing order.
##
## list of coefficients, same length as list of morphisms: [ c_1, ..., c_n ].
## non of the c_i must be zero.
##
## Interpreation: formal linear combination Sum_{i = 1}^n c_i * alpha_i
##
## Reason for sorting:
## this gives a normal form, which makes the congruence decision possible
##
## 2.case: there is no sorting function
## list of morphisms in underlying category: [ alpha_1, alpha_2, ..., alpha_n ]
## list of coefficients, same length as list of morphisms: [ c_1, ..., c_n ]
## no further restrictions
##
InstallMethod( LinearClosureMorphism,
               [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( source, coefficients, support_morphisms, range )
    local category, sorting_function, coefficients_copy, support_morphisms_copy,
          coefficients_NF, support_morphisms_NF, m, c, i, m_compare;
    
    category := CapCategory( source );
    
    if IsEmpty( coefficients ) or ( not category!.with_nf ) then
        
        return LinearClosureMorphismNC( source, coefficients, support_morphisms, range );
        
    fi;
    
    ## create normal form (NF)
    sorting_function := category!.sorting_function;
    
    coefficients_copy := ShallowCopy( coefficients );
    
    support_morphisms_copy := ShallowCopy( support_morphisms );
    
    SortParallel( support_morphisms_copy, coefficients_copy, sorting_function );
    
    coefficients_NF := [];
    
    support_morphisms_NF := [];
    
    m := support_morphisms_copy[1];
    
    c := coefficients_copy[1];
    
    for i in [ 2 .. Length( support_morphisms_copy ) ] do
        
        m_compare := support_morphisms_copy[i];
        
        if IsCongruentForMorphisms( m, m_compare ) then
            
            c := c + coefficients_copy[i];
            
        else
            
            if not IsZero( c ) then
                
                Add( support_morphisms_NF, m );
                
                Add( coefficients_NF, c );
                
            fi;
            
            m := m_compare;
            
            c := coefficients_copy[i];
            
        fi;
        
    od;
    
    if not IsZero( c ) then
        
        Add( support_morphisms_NF, m );
                
        Add( coefficients_NF, c );
        
    fi;
    
    return LinearClosureMorphismNC( source, coefficients_NF, support_morphisms_NF, range );
    
end );

##
InstallMethod( LinearClosureMorphismNC,
               [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( source, coefficients, support_morphisms, range )
    local category;
    
    category := CapCategory( source );
    
    return LinearClosureMorphismNC( category, source, coefficients, support_morphisms, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( LinearClosureMorphismNC,
                                     [ IsLinearClosure, IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( category, source, coefficients, support_morphisms, range )
    
    return CreateCapCategoryMorphismWithAttributes( category,
        source, range,
        CoefficientsList, coefficients,
        SupportMorphisms, support_morphisms
    );
    
end );

##
InstallGlobalFunction( LINEAR_CLOSURE_MORPHISM_SIMPLIFY,
    function( alpha, arg... )
        local abort, coeffs, supp, diff, s, test_func, pos, c, new_supp, new_coeffs;
        
        if Length( arg ) = 1 then
            
            abort := arg[1];
            
        else
            
            abort := false;
            
        fi;
        
        coeffs := ShallowCopy( CoefficientsList( alpha ) );
        
        supp := ShallowCopy( SupportMorphisms( alpha ) );
        
        new_supp := [];
        
        new_coeffs := [];
        
        while not IsEmpty( supp ) do
            
            s := supp[1];
            
            test_func := x -> IsCongruentForMorphisms( s, x );
            
            diff := [ 2 .. Length( supp ) ];
            
            pos := Concatenation( [1], PositionsProperty( supp{ diff }, test_func ) + 1 );
            
            c := Sum( coeffs{ pos } );
            
            if not IsZero( c ) then
                
                if abort then
                    
                    return false;
                    
                fi;
                
                Add( new_supp, s );
                
                Add( new_coeffs, c );
                
            fi;
            
            diff := Difference( [ 1 .. Length( supp ) ], pos ) ;
            
            supp := supp{ diff };
            
            coeffs := coeffs{ diff };
            
        od;
        
        if abort and IsEmpty( new_supp ) then
            
            return true;
            
        fi;
        
        return LinearClosureMorphismNC(
            Source( alpha ),
            new_coeffs,
            new_supp,
            Range( alpha )
        );
        
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE,
  function( rows, category )
    local ring, underlying_category, sorting_function, mul_coeffs, mul_supp, with_nf,
          equality_func, finsets, t_obj, t_finsets, FunctorMor, FunctorObj, cocycle;
    
    if not IsCategoryOfRows( rows ) then
        Error( "the first argument `rows` must be a category of rows\n" );
    fi;
    
    ring := UnderlyingRing( category );
    
    underlying_category := UnderlyingCategory( category );
    
    with_nf := category!.with_nf;
    
    if with_nf then
        
        sorting_function := category!.sorting_function;
        
    fi;
    
    ##
    AddObjectConstructor( category,
      function( cat, underlying_object )
        
        return LinearClosureObject( cat, underlying_object );
        
    end );
    
    ##
    AddObjectDatum( category,
      function( cat, object )
        
        return UnderlyingOriginalObject( object );
        
    end );
    
    ##
    AddMorphismConstructor( category,
      function( cat, source, pair, range )
        
        return LinearClosureMorphismNC( cat, source, pair[1], pair[2], range );
        
    end );
    
    ##
    AddMorphismDatum( category,
      function( cat, morphism )
        
        return Pair( CoefficientsList( morphism ), SupportMorphisms( morphism ) );
        
    end );
    
    ##
    AddIsEqualForObjects( category, {cat, a, b} -> IsEqualForObjects( UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) ) );
    
    equality_func := function( alpha, beta, equal_or_cong )
        local coeffs_a, coeffs_b, supp_a, supp_b, size;
        
        coeffs_a := CoefficientsList( alpha );
        
        coeffs_b := CoefficientsList( beta );
        
        size := Length( coeffs_a );
        
        if size <> Length( coeffs_b ) then
            return false;
        fi;
        
        return ForAll( [ 1 .. size ], i -> equal_or_cong( SupportMorphisms( alpha )[i], SupportMorphisms( beta )[i] ) ) and
                coeffs_a = coeffs_b;
        
    end;
    
    ##
    AddIsEqualForMorphisms( category, {cat, alpha, beta} -> equality_func( alpha, beta, IsEqualForMorphisms ) );
    
    if with_nf then
        
        ##
        AddIsCongruentForMorphisms( category, {cat, alpha, beta} -> equality_func( alpha, beta, IsCongruentForMorphisms ) );
        
    else
        
        ##
        AddIsCongruentForMorphisms( category,
            function( cat, alpha, beta )
                
                return IsZeroForMorphisms( SubtractionForMorphisms( alpha, beta ) );
                
        end );
        
    fi;
    
    ##
    AddIsWellDefinedForObjects( category, {cat, x} -> IsIdenticalObj( underlying_category, CapCategory( UnderlyingOriginalObject( x ) ) ) );

    ##
    AddIsWellDefinedForMorphisms( category,
    function( cat, alpha )
        local coeffs, supp, size, s, i;
        
        coeffs := CoefficientsList( alpha );
        
        supp := SupportMorphisms( alpha );
        
        if IsEmpty( coeffs ) then
            if IsEmpty( supp ) then
                return true;
            else
                return false;
            fi;
        fi;
        
        size := Length( coeffs );
        
        if size <> Length( supp ) then
            return false;
        fi;
        
        if not ForAll( coeffs, c -> c in ring ) then
            return false;
        fi;
        
        if not with_nf then
            
            return true;
            
        fi;
        
        if ForAny( coeffs, c -> IsZero( c ) ) then
            return false;
        fi;
        
        s := supp[1];
        
        for i in [ 2 .. size ] do
            
            if not sorting_function( s, supp[i] ) then
                return false;
            fi;
            
            s := supp[i];
            
        od;
        
        return true;
        
    end );
    
    ##
    mul_supp := {alpha, beta} -> PreCompose( alpha, beta );
    
    mul_coeffs := {a,b} -> a * b;
    
    if not IsBound( category!.cocycle ) then
        
        ##
        AddPreCompose( category,
        function( cat, alpha, beta )
            local coeffs, supp;
            
            coeffs := ListX( CoefficientsList( alpha ), CoefficientsList( beta ), mul_coeffs );
            
            supp := ListX( SupportMorphisms( alpha ), SupportMorphisms( beta ), mul_supp );
            
            return LinearClosureMorphism( Source( alpha ), coeffs, supp, Range( beta ) );
            
        end );
        
    else
        
        cocycle := category!.cocycle;
        
        ##
        AddPreCompose( category,
        function( cat, alpha, beta )
            local coeffs_alpha, coeffs_beta, supp_alpha, supp_beta, coeffs, supp, a, b, gamma, coeff;
            
            coeffs_alpha := CoefficientsList( alpha );
            
            coeffs_beta := CoefficientsList( beta );
            
            supp_alpha := SupportMorphisms( alpha );
            
            supp_beta := SupportMorphisms( beta );
            
            coeffs := [];
            
            supp := [];
            
            for a in [ 1 .. Length( coeffs_alpha ) ] do
                
                for b in [ 1 .. Length( coeffs_beta ) ] do
                    
                    gamma := mul_supp( supp_alpha[a], supp_beta[b] );
                    
                    coeff := mul_coeffs( coeffs_alpha[a], coeffs_beta[b] ) * cocycle( supp_alpha[a], supp_beta[b], gamma );
                    
                    Add( supp, gamma );
                    
                    Add( coeffs, coeff );
                    
                od;
                
            od;
            
            return LinearClosureMorphism( Source( alpha ), coeffs, supp, Range( beta ) );
            
        end );
        
    fi;
    
    ##
    AddIdentityMorphism( category,
      function( cat, object )
        
        return LinearClosureMorphismNC( cat, object, [ One( ring ) ], [ IdentityMorphism( UnderlyingCategory( cat ), UnderlyingOriginalObject( object ) ) ], object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, a, b )
        
        return LinearClosureMorphismNC( cat,
                       a,
                       CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( RingElementFilter( CommutativeRingOfLinearCategory( cat ) ) ) ),
                       CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( cat ) ) ) ),
                       b );
        
    end );
    
    
    if with_nf then
        
        ##
        AddIsZeroForMorphisms( category,
        function( cat, alpha )
            
            return IsEmpty( CoefficientsList( alpha ) );
            
        end );
        
    else
        
        ##
        AddIsZeroForMorphisms( category,
        function( cat, alpha )
            
            return LINEAR_CLOSURE_MORPHISM_SIMPLIFY( alpha, true );
            
        end );
        
    fi;
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, alpha, beta )
        return LinearClosureMorphism(
            Source( alpha ),
            Concatenation( CoefficientsList( alpha ), CoefficientsList( beta ) ),
            Concatenation( SupportMorphisms( alpha ), SupportMorphisms( beta ) ),
            Range( alpha )
        );
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, alpha )
        return LinearClosureMorphism(
            Source( alpha ),
            List( CoefficientsList( alpha ), c -> MinusOne( ring ) * c ),
            SupportMorphisms( alpha ),
            Range( alpha )
        );
    end );
    
    ##
    AddSubtractionForMorphisms( category,
      function( cat, alpha, beta )
        return LinearClosureMorphism(
            Source( alpha ),
            Concatenation( CoefficientsList( alpha ), List( CoefficientsList( beta ), c -> MinusOne( ring ) * c ) ),
            Concatenation( SupportMorphisms( alpha ), SupportMorphisms( beta ) ),
            Range( alpha )
        );
    end );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
        function( cat, r, alpha )
            return LinearClosureMorphism(
                Source( alpha ),
                List( CoefficientsList( alpha ), c -> r * c ),
                SupportMorphisms( alpha ),
                Range( alpha )
        );
    end );
    
    if not with_nf then
        
        ##
        AddSimplifyMorphism( category,
            function( cat, alpha, i )
                
                return LINEAR_CLOSURE_MORPHISM_SIMPLIFY( alpha );
                
        end );
        
    fi;
    
    if HasIsObjectFiniteCategory( underlying_category ) and IsObjectFiniteCategory( underlying_category ) then
        
        ##
        AddSetOfObjectsOfCategory( category,
            function( cat )
                
                return List( SetOfObjectsOfCategory( underlying_category ),
                             obj -> LinearClosureObject( category, obj ) );
                
        end );
        
    fi;
    
    ## Homomorphism structure
    
    if ForAll(
        [ "DistinguishedObjectOfHomomorphismStructure",
         "HomomorphismStructureOnObjects",
         "HomomorphismStructureOnMorphismsWithGivenObjects",
         "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
         "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ],
         f -> CanCompute( underlying_category, f ) ) and
              IsSkeletalCategoryOfFiniteSets( RangeCategoryOfHomomorphismStructure( underlying_category ) ) and
              with_nf
         then
            
        finsets := RangeCategoryOfHomomorphismStructure( underlying_category );
        
        SetRangeCategoryOfHomomorphismStructure( category, rows );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        if HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( rows ) and
           IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( rows ) then
            SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category, true );
        fi;
        
        t_obj := CategoryOfRowsObject( rows, 1 );
        
        t_finsets := TerminalObject( finsets );
        
        FunctorObj := function( set )
            #% CAP_JIT_RESOLVE_FUNCTION
            return CategoryOfRowsObject( rows, Length( set ) );
        end;
        
        FunctorMor := function( mor )
            local range, id;
            #% CAP_JIT_RESOLVE_FUNCTION
            
            range := Range( mor );
            
            id := HomalgIdentityMatrix( Length( range ), ring );
            
            return CategoryOfRowsMorphism( rows,
                FunctorObj( Source( mor ) ),
                CertainRows( id, 1 + AsList( mor ) ),
                FunctorObj( range )
            );
            
        end;
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
        function( cat )
            
            return t_obj;
            
        end );
        
        ##
        AddHomomorphismStructureOnObjects( category,
          function( cat, a, b )
            
            return FunctorObj( HomomorphismStructureOnObjects( UnderlyingCategory( cat ), UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) ) );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( cat, source, alpha, beta, range )
            local coeffs_a, size_a, coeffs_b, size_b, supp_a, supp_b;
            
            coeffs_a := CoefficientsList( alpha );
            
            size_a := Length( coeffs_a );
            
            coeffs_b := CoefficientsList( beta );
            
            size_b := Length( coeffs_b );
            
            if size_a = 0 or size_b = 0 then
                
                return ZeroMorphism( rows, source, range );
                
            fi;
            
            supp_a := SupportMorphisms( alpha );
            
            supp_b := SupportMorphisms( beta );
            
            return Iterated(
                    List(
                        [ 1 .. size_a ],
                        i -> Iterated(
                            List(
                                [ 1 .. size_b ],
                                j ->  MultiplyWithElementOfCommutativeRingForMorphisms( rows, coeffs_a[i] * coeffs_b[j], FunctorMor( HomomorphismStructureOnMorphisms( UnderlyingCategory( cat ),  supp_a[i], supp_b[j] ) ) )
                            ),
                            { mor1, mor2 } -> AdditionForMorphisms( rows, mor1, mor2 )
                        )
                    ),
                    { mor1, mor2 } -> AdditionForMorphisms( rows, mor1, mor2 )
                );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
            function( cat, alpha )
                local coeffs, supp;
                
                coeffs := CoefficientsList( alpha );
                
                if IsEmpty( coeffs ) then
                    
                    return ZeroMorphism( t_obj, HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) ) );
                    
                fi;
                
                supp := SupportMorphisms( alpha );
                
                return Sum( List( [ 1 .. Length( coeffs ) ],
                    i -> coeffs[i] * FunctorMor( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( supp[i] ) ) ) );
                
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, a, b, mor )
            local size, a_und, b_und, range_finset;
            
            size := RankOfObject( Range( mor ) );
            
            a_und := UnderlyingOriginalObject( a );
            
            b_und := UnderlyingOriginalObject( b );
            
            range_finset := FinSet( finsets, size );
            
            return LinearClosureMorphism(
                    a,
                    EntriesOfHomalgMatrix( UnderlyingMatrix( mor ) ),
                    List( [ 0 .. size - 1 ], i ->
                        InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                            a_und, b_und, MapOfFinSets( t_finsets, [ i ], range_finset )
                        )
                    ),
                    b
                );
            
        end );
        
    fi;
end );

####################################
##
## Functors
##
####################################

##
InstallMethodWithCache( ExtendFunctorToLinearClosureOfSource,
              [ IsCapFunctor, IsLinearClosure, IsFunction ],
  function( F, linear_closure_source, ring_map )
    local source_cat, range_cat, name, G;
    
    source_cat := AsCapCategory( Source( F ) );
    
    range_cat := AsCapCategory( Range( F ) );
    
    if not IsIdenticalObj( source_cat, UnderlyingCategory( linear_closure_source ) ) then
      
      Error( "The arguments are not compatible!\n" );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( range_cat ) and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
      
      Error( "The range category named ", Name( range_cat ), " should be linear over some commutative ring!\n" );
      
    fi;
     
    name := Concatenation( "Extension of ", Name( F ), " to a functor from ", Name( linear_closure_source ) );
    
    G := CapFunctor( name, linear_closure_source, range_cat );
    
    AddObjectFunction( G,
      function( a )
        local o;
        
        o := UnderlyingOriginalObject( a );
        
        return ApplyFunctor( F, o );
        
    end );
    
    AddMorphismFunction( G,
      function( s, alpha, r )
        local coeffs, non_zeros, supp;
        
        coeffs := CoefficientsList( alpha );
        
        non_zeros := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( non_zeros ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        coeffs := List( coeffs{ non_zeros }, ring_map );
        
        supp := SupportMorphisms( alpha ){ non_zeros };
        
        supp := List( supp, m -> ApplyFunctor( F, m ) );
        
        return LinearCombinationOfMorphisms( s, coeffs, supp, r );
        
    end );
    
    return G;
    
end );

##
InstallMethodWithCache( ExtendFunctorToLinearClosureOfSource,
              [ IsCapFunctor, IsLinearClosure ],
    { F, linear_closure_source } -> ExtendFunctorToLinearClosureOfSource( F, linear_closure_source, IdFunc )
);

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
               [ IsLinearClosureMorphism ],
    
    function( alpha )
        local coeffs, support, list;
        
        coeffs := CoefficientsList( alpha );
        
        if IsEmpty( coeffs ) then
            
            return "0";
            
        fi;
        
        support := SupportMorphisms( alpha );
        
        list := List( [ 1 .. Length( coeffs ) ], i -> Concatenation( "(", ViewString( coeffs[i] ), "*", ViewString( support[i] ), ")" ) );
        
        return JoinStringsWithSeparator( list, " + " );
        
end );

##
InstallMethod( ViewString,
               [ IsLinearClosureObject ],

  function( obj )
    
    return Concatenation( "LinearClosureObject(", ViewString( UnderlyingOriginalObject( obj ) ), ")" );
    
end );

####################################
##
## Convenience
##
####################################

InstallMethod( \*,
               [ IsLinearClosureMorphism, IsLinearClosureMorphism ],
               PreCompose );

InstallMethod( \=,
               [ IsLinearClosureMorphism, IsLinearClosureMorphism ],
               IsCongruentForMorphisms );

InstallOtherMethod( \/,
               [ IsCapCategoryMorphism, IsLinearClosure ],
               
    function( mor, cat )
        
        return LinearClosureMorphismNC(
            LinearClosureObject( Source( mor ), cat ),
            [ One( UnderlyingRing( cat ) ) ],
            [ mor ],
            LinearClosureObject( Range( mor ), cat )
        );
        
end );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsLinearClosureObject ],
  function( obj )
    
    return UnderlyingOriginalObject( obj );
    
end );

##
InstallMethod( DownOnlyMorphismData,
               [ IsLinearClosureMorphism ],
  function( mor )
    
    return [ CoefficientsList( mor ), SupportMorphisms( mor ) ];
    
end );
