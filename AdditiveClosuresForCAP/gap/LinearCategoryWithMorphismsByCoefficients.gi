# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
InstallMethod( LinearCategoryWithMorphismsByCoefficients,
        [  IsCapCategory, IsRecord ],
        
 FunctionWithNamedArguments(
  [ [ "overhead", true ],
    [ "FinalizeCategory", true ],
    [ "no_precompiled_code", false ],
  ],
  function ( CAP_NAMED_ARGUMENTS, L, options )
    local known_options_with_filters, option_name, filter,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          reinterpretation_options, Coeff;
    
    Assert( 0, HasIsLinearCategoryOverCommutativeSemiringWithFinitelyGeneratedFreeExternalHoms( L ) and
            IsLinearCategoryOverCommutativeSemiringWithFinitelyGeneratedFreeExternalHoms( L ) );
    
    Assert( 0, HasRangeCategoryOfHomomorphismStructure( L ) and
            IsCategoryOfRows( RangeCategoryOfHomomorphismStructure( L ) ) );
    
    ## check given options
    known_options_with_filters :=
      rec( name := IsString,
           category_filter := IsFilter,
           category_object_filter := IsFilter,
           category_morphism_filter := IsFilter,
           );
    
    for option_name in RecNames( options ) do
        
        if IsBound( known_options_with_filters.(option_name) ) then
            
            filter := known_options_with_filters.(option_name);
            
            if not filter( options.(option_name) ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "The value of the option `", option_name, "` must lie in the filter ", filter );
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The following option is not known to `LinearCategoryWithMorphismsByCoefficients`: ", option_name );
            
        fi;
        
    od;
    
    ##
    object_datum_type := ObjectDatumType( L );
    
    ##
    object_constructor :=
      function ( Coeff, datum )
        
        return CreateCapCategoryObjectWithAttributes( Coeff,
                       UnderlyingDatum, datum );
        
    end;
    
    ##
    object_datum :=
      function ( Coeff, obj )
        
        return UnderlyingDatum( obj );
        
    end;
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfNTupleOf( 2,
              IsBigInt,
              CapJitDataTypeOfListOf( SemiringElementFilter( CommutativeSemiringOfLinearCategory( L ) ) ) );
    
    ##
    morphism_constructor :=
      function ( Coeff, source, pair_of_int_and_list_of_coefficients, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, pair_of_int_and_list_of_coefficients[1] = Length( pair_of_int_and_list_of_coefficients[2] ) );
        
        return CreateCapCategoryMorphismWithAttributes( Coeff,
                       source,
                       target,
                       PairOfIntAndListOfCoefficients, pair_of_int_and_list_of_coefficients );
        
    end;
    
    ##
    morphism_datum :=
      function ( Coeff, phi )
        
        return PairOfIntAndListOfCoefficients( phi );
        
    end;
    
    ## building the categorical tower:
    # L := L;
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function ( Coeff, datum )
        local L;
        
        L := ModelingCategory( Coeff );
        
        return ObjectConstructor( L, datum );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function ( Coeff, objL )
        local L;
        
        L := ModelingCategory( Coeff );
        
        return ObjectDatum( L, objL );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function ( Coeff, source, pair_of_int_and_list_of_coefficients, target )
        local L, basis;
        
        L := ModelingCategory( Coeff );
        
        basis := BasisOfExternalHom( L, source, target );
        
        return LinearCombinationOfMorphisms( L,
                       source,
                       pair_of_int_and_list_of_coefficients[2], basis,
                       target );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function ( Coeff, morL )
        local L, multiplicities;
        
        L := ModelingCategory( Coeff );

        multiplicities := CoefficientsOfMorphism( L, morL );
        
        return Pair( Length( multiplicities ), multiplicities );
        
    end;
    
    reinterpretation_options :=
      rec( name := Concatenation( "LinearCategoryWithMorphismsByCoefficients( ", Name( L ), " )" ),
           category_filter := IsLinearCategoryWithMorphismsByCoefficients,
           category_object_filter := IsObjectInLinearCategoryWithMorphismsByCoefficients,
           category_morphism_filter := IsMorphismInLinearCategoryWithMorphismsByCoefficients,
           object_datum_type := object_datum_type,
           morphism_datum_type := morphism_datum_type,
           object_constructor := object_constructor,
           object_datum := object_datum,
           morphism_constructor := morphism_constructor,
           morphism_datum := morphism_datum,
           modeling_tower_object_constructor := modeling_tower_object_constructor,
           modeling_tower_object_datum := modeling_tower_object_datum,
           modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
           modeling_tower_morphism_datum := modeling_tower_morphism_datum,
           only_primitive_operations := true );
    
    if IsBound( options.name ) then
        reinterpretation_options.name := options.name;
    fi;
    
    if IsBound( options.category_filter ) then
        reinterpretation_options.category_filter := options.category_filter;
    fi;
    
    if IsBound( options.category_object_filter ) then
        reinterpretation_options.category_object_filter := options.category_object_filter;
    fi;
    
    if IsBound( options.category_morphism_filter ) then
        reinterpretation_options.category_morphism_filter := options.category_morphism_filter;
    fi;
    
    ##
    Coeff :=
      ReinterpretationOfCategory( L,
              reinterpretation_options :
              FinalizeCategory := false,
              overhead := CAP_NAMED_ARGUMENTS.overhead );
    
    ##
    AddBasisOfExternalHom( Coeff,
      function ( Coeff, source, target )
        local L, hom, u, H, Hom, l;
        
        L := ModelingCategory( Coeff );
        
        hom := HomomorphismStructureOnObjects( L, ModelingObject( Coeff, source ), ModelingObject( Coeff, target ) );
        
        u := DistinguishedObjectOfHomomorphismStructure( L );
        
        H := RangeCategoryOfHomomorphismStructure( L );
        
        Hom := BasisOfExternalHom( H, u, hom );
        
        l := Length( Hom );
        
        return List( Hom, bas ->
                     MorphismConstructor( Coeff,
                             source,
                             Pair( l, EntriesOfHomalgRowVector( MorphismDatum( H, bas ) ) ),
                             target ) );
        
    end );
    
    ##
    AddCoefficientsOfMorphism( Coeff,
      function ( Coeff, mor )
        
        return PairOfIntAndListOfCoefficients( mor )[2];
        
    end );
    
    ##
    AddZeroMorphism( Coeff,
      function ( Coeff, source, target )
        local k, l;
        
        k := CommutativeSemiringOfLinearCategory( Coeff );
        
        l := Length( BasisOfExternalHom( Coeff, source, target ) );
        
        return MorphismConstructor( Coeff,
                       source,
                       Pair( l, ListWithIdenticalEntries( l, Zero( k ) ) ),
                       target );
        
    end );
    
    ##
    AddAdditionForMorphisms( Coeff,
      function ( Coeff, mor1, mor2 )
        local pair1, l, coeffs1, coeffs2;
        
        pair1 := PairOfIntAndListOfCoefficients( mor1 );
        
        l := pair1[1];
        coeffs1 := pair1[2];
        
        coeffs2 := PairOfIntAndListOfCoefficients( mor2 )[2];
        
        return MorphismConstructor( Coeff,
                       Source( mor1 ),
                       Pair( l, List( [ 1 .. l ], i -> coeffs1[i] + coeffs2[i] ) ),
                       Target( mor1 ) );
        
    end );
    
    ##
    AddMultiplyWithElementOfCommutativeSemiringForMorphisms( Coeff,
      function ( Coeff, r, mor )
        local pair, l, coeffs;
        
        pair := PairOfIntAndListOfCoefficients( mor );
        
        l := pair[1];
        coeffs := pair[2];
        
        return MorphismConstructor( Coeff,
                       Source( mor ),
                       Pair( l, List( [ 1 .. l ], i -> r * coeffs[i] ) ),
                       Target( mor ) );
        
    end );
    
    if CanCompute( L, "AdditiveInverseForMorphisms" ) then
        
        ##
        AddAdditiveInverseForMorphisms( Coeff,
          function ( Coeff, mor )
            local pair, l, coeffs;
            
            pair := PairOfIntAndListOfCoefficients( mor );
            
            l := pair[1];
            coeffs := pair[2];
            
            return MorphismConstructor( Coeff,
                           Source( mor ),
                           Pair( l, List( [ 1 .. l ], i -> -coeffs[i] ) ),
                           Target( mor ) );
            
        end );
        
    fi;
    
    if CanCompute( L, "SubtractionForMorphisms" ) then
        
        ##
        AddSubtractionForMorphisms( Coeff,
          function ( Coeff, mor1, mor2 )
            local pair1, l, coeffs1, coeffs2;
            
            pair1 := PairOfIntAndListOfCoefficients( mor1 );
            
            l := pair1[1];
            coeffs1 := pair1[2];
            
            coeffs2 := PairOfIntAndListOfCoefficients( mor2 )[2];
            
            return MorphismConstructor( Coeff,
                           Source( mor1 ),
                           Pair( l, List( [ 1 .. l ], i -> coeffs1[i] - coeffs2[i] ) ),
                           Target( mor1 ) );
            
        end );
        
    fi;
    
    ##
    AddPreCompose( Coeff,
      function ( Coeff, mor_pre, mor_pst )
        local source, target, L, coeffs_pre, coeffs_pst, pos_pre, pos_pst, bas_pre, bas_pst, l, cmp;
        
        source := Source( mor_pre );
        target := Target( mor_pst );
        
        L := ModelingCategory( Coeff );
        
        coeffs_pre := PairOfIntAndListOfCoefficients( mor_pre )[2];
        coeffs_pst := PairOfIntAndListOfCoefficients( mor_pst )[2];
        
        pos_pre := PositionsProperty( coeffs_pre, coeff -> not IsZero( coeff ) );
        pos_pst := PositionsProperty( coeffs_pst, coeff -> not IsZero( coeff ) );
        
        bas_pre := BasisOfExternalHom( L, ModelingObject( Coeff, source ), ModelingObject( Coeff, Target( mor_pre ) ) );
        bas_pst := BasisOfExternalHom( L, ModelingObject( Coeff, Source( mor_pst ) ), ModelingObject( Coeff, target ) );
        
        l := Length( BasisOfExternalHom( Coeff, source, target ) );
        
        cmp := List( pos_pre, pre ->
                     List( pos_pst, pst ->
                           List( CoefficientsOfMorphism( L, PreCompose( L, bas_pre[pre], bas_pst[pst] ) ), coeff -> coeffs_pre[pre] * coeffs_pst[pst] * coeff ) ) );
        
        cmp := Concatenation( cmp );
        
        return MorphismConstructor( Coeff,
                       source,
                       Pair( l, List( [ 1 .. l ], i -> Sum( cmp, c -> c[i] ) ) ),
                       target );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( Coeff,
      function ( Coeff, mor )
        local l, pair;
        
        l := Length( BasisOfExternalHom( Coeff, Source( mor ), Target( mor ) ) );
        
        pair := PairOfIntAndListOfCoefficients( mor );
        
        return l = pair[1] and
               l = Length( pair[2] );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( Coeff,
      function ( Coeff, mor1, mor2 )
        
        return PairOfIntAndListOfCoefficients( mor1 ) = PairOfIntAndListOfCoefficients( mor2 );
        
    end );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        Finalize( Coeff );
    fi;
    
    return Coeff;
    
end ) );

