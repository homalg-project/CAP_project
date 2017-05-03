#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
## Internals
##
####################################

InstallValue( CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY, rec( ) );

##
InstallMethod( CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromRight,
               [ IsList, IsInt ],
               
  function( permutation, b )
    
    return Flat( List( permutation, p -> List( [ 1 .. b ], i -> (p - 1) * b + i ) ) );
    
end );

##
InstallMethod( CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromLeft,
               [ IsList, IsInt ],
               
  function( permutation, b )
    local a;
    
    a := Size( permutation );
    
    return Flat( List( [ 0 .. b - 1 ], i -> List( permutation, p -> p + i * a ) ) );
    
end );

##
InstallMethod( CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromRight,
               [ IsList, IsSemisimpleCategoryObject, IsList ],
               
  function( permutation_list, b, support_tensor_product )
    local b_object_list, new_permutation_list, k, height, k_permutation, i, j, c_kij, list, rows;
    
    b_object_list := SemisimpleCategoryObjectList( b );
    
    new_permutation_list := [ ];
    
    for k in support_tensor_product do
        
        height := 0;
        
        k_permutation := [ ];
        
        for i in permutation_list do
            
            for j in b_object_list do
                
                c_kij := Multiplicity( k, i[2], j[2] );
                
                if c_kij > 0 then
                    
                    list := CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromRight( i[1], j[1] * c_kij );
                    
                    rows := c_kij * j[1] * Size( i[1] );
                    
                    Append( k_permutation, List( list, l -> l + height ) );
                    
                    height := height + rows;
                    
                fi;
                
            od;
            
        od;
        
        Add( new_permutation_list, [ k_permutation, k ] );
        
    od;
    
    return new_permutation_list;
    
end );

##
InstallMethod( CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromLeft,
               [ IsList, IsSemisimpleCategoryObject, IsList ],
               
  function( permutation_list, b, support_tensor_product )
    local b_object_list, new_permutation_list, k, height, k_permutation, i, j, c_kij, list, rows;
    
    b_object_list := SemisimpleCategoryObjectList( b );
    
    new_permutation_list := [ ];
    
    for k in support_tensor_product do
        
        height := 0;
        
        k_permutation := [ ];
        
        for i in b_object_list do
            
            for j in permutation_list do
                
                c_kij := Multiplicity( k, i[2], j[2] );
                
                if c_kij > 0 then
                    
                    list := CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromRight( j[1], c_kij );
                    
                    list := CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromLeft( list, i[1] );
                    
                    rows := c_kij * i[1] * Size( j[1] );
                    
                    Append( k_permutation, List( list, l -> l + height ) );
                    
                    height := height + rows;
                    
                fi;
                
            od;
            
        od;
        
        Add( new_permutation_list, [ k_permutation, k ] );
        
    od;
    
    return new_permutation_list;
    
end );

##
InstallMethod( CAP_INTERNAL_DirectSumForPermutationLists,
               [ IsList, IsList ],
               
  function( permutation_lists, support )
    local result_list, chi, chi_permutation, elem, height, permutation;
    
    result_list := [ ];
    
    for chi in support do
        
        chi_permutation := [ ];
        
        height := 0;
        
        for elem in permutation_lists do
            
            permutation := First( elem, i -> i[2] = chi );
            
            if not permutation = fail then
                
                Append( chi_permutation, List( permutation[1], i -> i + height ) );
                
                height := height + Size( permutation[1] );
                
            fi;
            
        od;
        
        if not IsEmpty( chi_permutation ) then
            
            Add( result_list, [ chi_permutation, chi ] );
          
        fi;
    od;
    
    return result_list;
    
end );

InstallMethodWithCache( CAP_INTERNAL_ExpandSemisimpleCategoryObjectList,
                        [ IsList ],
                        
  function( semisimple_category_object_list_with_actual_objects )
    local list, expanded_list, elem;
    
    expanded_list := [ ];
    
    for elem in semisimple_category_object_list_with_actual_objects do
        
        Append( expanded_list, List( [ 1 .. elem[1] ], i -> elem[2] ) );
        
    od;
    
    return expanded_list;
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY,
  function( category, tensor_unit, associator_data, is_complete_data )
    local field, membership_function, associator_on_irreducibles, braiding_on_irreducibles,
          distributivity_expanding_for_triple, distributivity_factoring_for_triple,
          right_distributivity_expanding_permutation, left_distributivity_expanding_permutation,
          distributivity_function;
    
    field := UnderlyingCategoryForSemisimpleCategory( category )!.field_for_matrix_category;
    
    membership_function := MembershipFunctionForSemisimpleCategory( category );
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
        local object_1_list, object_2_list, size;
        
        object_1_list := SemisimpleCategoryObjectList( object_1 );
        
        object_2_list := SemisimpleCategoryObjectList( object_2 );
        
        size := Size( object_1_list );
        
        if not size = Size( object_2_list ) then
            
            return false;
            
        fi;
        
        return ForAll( [ 1 .. size ], i ->
                 ( object_1_list[i][1] = object_2_list[i][1] ) and ( object_1_list[i][2] = object_2_list[i][2] )
               );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        local morphism_1_list, morphism_2_list, size;
        
        morphism_1_list := SemisimpleCategoryMorphismList( morphism_1 );
        
        morphism_2_list := SemisimpleCategoryMorphismList( morphism_2 );
        
        size := Size( morphism_1_list );
        
        return ForAll( [ 1 .. size ], i -> IsCongruentForMorphisms( morphism_1_list[i][1], morphism_2_list[i][1] ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        local object_list, last_irr, elem;
        
        object_list := SemisimpleCategoryObjectList( object );
        
        ## representing the zero object
        if IsEmpty( object_list ) then
            
            return true;
            
        fi;
        
        if not ForAll( object_list, elem ->
          IsList( elem ) and Size( elem ) = 2 and IsInt( elem[1] ) and elem[1] > 0 and membership_function( elem[2] ) ) then
            
            Error( "the semisimple category object list does not have the correct form" );
            
            return false;
            
        fi;
        
        last_irr := object_list[1][2];
        
        ## is it sorted without duplications?
        for elem in [ 2 .. Size( object_list ) ] do
            
            if not object_list[elem][2] > last_irr then
                
                Error( "the semisimple category object is not sorted without duplications" );
                
                return false;
                
            fi;
            
            last_irr := object_list[elem][2];
            
        od;
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local source, range, source_list, range_list, union, irr, morphism_list,
              irr_nr, dim_source, dim_range;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        source_list := SemisimpleCategoryObjectList( source );
        
        range_list := SemisimpleCategoryObjectList( range );
        
        union := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        if not ForAll( morphism_list, elem ->
          IsList( elem ) and Size( elem ) = 2 and IsVectorSpaceMorphism( elem[1] ) #and IsWellDefined( elem[1] ) 
          and membership_function( elem[2] ) ) or Size( morphism_list ) <> Size( union )  then
            
            Error( "the semisimple category morphism list does not have the correct form" );
            
            return false;
            
        fi;
        
        for irr_nr in [ 1 .. Size( union ) ] do
            
            if not morphism_list[irr_nr][2] = union[irr_nr] then
                
                Error( "the support of the objects does not match the support of the morphism" );
                
                return false;
                
            fi;
            
            dim_source := First( source_list, elem -> elem[2] = union[irr_nr] );
            
            if not dim_source = fail then
                
                dim_source := dim_source[1];
                
            else
                
                dim_source := 0;
                
            fi;
            
            dim_range := First( range_list, elem -> elem[2] = union[irr_nr] );
            
            if not dim_range = fail then
                
                dim_range := dim_range[1];
                
            else
                
                dim_range := 0;
                
            fi;
            
            if not Dimension( Source( morphism_list[irr_nr][1] ) ) = dim_source then
                
                Error( "the source multiplicity does not match the matrices" );
                
                return false;
                
            fi;
            
            if not Dimension( Range( morphism_list[irr_nr][1] ) ) = dim_range then
                
                Error( "the range multiplicity does not match the matrices" );
                
                return false;
                
            fi;
            
        od;
        
        return true;
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local object_list, morphism_list;
        
        object_list := SemisimpleCategoryObjectList( object );
        
        morphism_list := 
          List( object_list, elem -> [ IdentityMorphism( VectorSpaceObject( elem[1], field ) ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( object, morphism_list, object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      [ 
        [ function( morphism_1, morphism_2 )
            local mor_1_list, mor_2_list, source, range, union, composition_list, irr, mor_1, mor_2;
            
            mor_1_list := SemisimpleCategoryMorphismList( morphism_1 );
            
            mor_2_list := SemisimpleCategoryMorphismList( morphism_2 );
            
            source := Source( morphism_1 );
            
            range := Range( morphism_2 );
            
            union := Set( Concatenation( Support( source ), Support( range ) ) );
            
            composition_list := [ ];
            
            for irr in union do
                
                mor_1 := First( mor_1_list, elem -> elem[2] = irr );
                
                mor_2 := First( mor_2_list, elem -> elem[2] = irr );
                
                if mor_1 = fail then
                    
                    Add( composition_list,
                         [ UniversalMorphismFromZeroObject( Range( mor_2[1] ) ), irr ] );
                    
                elif mor_2 = fail then
                    
                    Add( composition_list,
                         [ UniversalMorphismIntoZeroObject( Source( mor_1[1] ) ), irr ] );
                    
                else
                    
                    Add( composition_list,
                         [ PreCompose( mor_1[1], mor_2[1] ), irr ] );
                    
                fi;
                
            od;
            
            return SemisimpleCategoryMorphism( source, composition_list, range );
            
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
      ]
    
    );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        local morphism_list;
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        return ForAll( morphism_list, elem -> IsZeroForMorphisms( elem[1] ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local source, range, morphism_1_list, morphism_2_list, result_morphism_list, size;
        
        source := Source( morphism_1 );
        
        range := Range( morphism_1 );
        
        morphism_1_list := SemisimpleCategoryMorphismList( morphism_1 );
        
        morphism_2_list := SemisimpleCategoryMorphismList( morphism_2 );
        
        size := Size( morphism_1_list );
        
        result_morphism_list := List( [ 1 .. size ], i -> [ morphism_1_list[i][1] + morphism_2_list[i][1], morphism_1_list[i][2] ] );
        
        return SemisimpleCategoryMorphism( source, result_morphism_list, range );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        local source, range, morphism_list, result_morphism_list;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        result_morphism_list := List( morphism_list, elem -> [ AdditiveInverseForMorphisms( elem[1] ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( source, result_morphism_list, range );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local union, morphism_list, source_list, range_list, irr, dim_source, dim_range;
        
        union := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := [ ];
        
        source_list := SemisimpleCategoryObjectList( source );
        
        range_list := SemisimpleCategoryObjectList( range );
        
        for irr in union do
            
            dim_source := First( source_list, elem -> elem[2] = irr );
            
            if not dim_source = fail then
                
                dim_source := dim_source[1];
                
            else
                
                dim_source := 0;
                
            fi;
            
            dim_range := First( range_list, elem -> elem[2] = irr );
            
            if not dim_range = fail then
                
                dim_range := dim_range[1];
                
            else
                
                dim_range := 0;
                
            fi;
            
            Add( morphism_list, [ ZeroMorphism( VectorSpaceObject( dim_source, field ), VectorSpaceObject( dim_range, field ) ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( source, morphism_list, range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return SemisimpleCategoryObject( [ ], category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local sink_object_list, result_morphism_list;
        
        sink_object_list := SemisimpleCategoryObjectList( sink );
        
        result_morphism_list := List( sink_object_list, elem ->
          [ UniversalMorphismIntoZeroObject( VectorSpaceObject( elem[1], field ) ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( sink, result_morphism_list, zero_object )  ;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local source_object_list, result_morphism_list;
        
        source_object_list := SemisimpleCategoryObjectList( source );
        
        result_morphism_list := List( source_object_list, elem ->
          [ UniversalMorphismFromZeroObject( VectorSpaceObject( elem[1], field ) ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( zero_object, result_morphism_list, source )  ;
        
    end );
    
    ##
    AddDirectSum( category,
      function( semisimple_objects_list )
      local object_list;
      
      object_list := List( semisimple_objects_list, SemisimpleCategoryObjectList );
      
      if Size( object_list ) > 1 then
          
          object_list := CallFuncList( Concatenation, object_list );
          
      else
          
          object_list := object_list[1];
          
      fi;
      
      return SemisimpleCategoryObject( object_list, category );
      
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( semisimple_objects_list, projection_number, direct_sum_object )
        local support, morphism_list, irr, objects_list, elem;
        
        support := Support( direct_sum_object );
        
        morphism_list := [ ];
        
        for irr in support do
            
            objects_list := List( semisimple_objects_list, obj -> Component( obj, irr ) );
            
            Add( morphism_list, [ ProjectionInFactorOfDirectSum( objects_list, projection_number ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( direct_sum_object, morphism_list, semisimple_objects_list[ projection_number ] );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum_object )
        local test_object, support, morphism_list, irr, irr_diagram, irr_source;
        
        test_object := Source( source[1] );
        
        support := Set( Concatenation( Support( direct_sum_object ), Support( test_object ) ) );
        
        morphism_list := [ ];
        
        for irr in support do
            
            irr_diagram := List( diagram, obj -> Component( obj, irr ) );
            
            irr_source := List( source, morphism -> Component( morphism, irr ) );
            
            Add( morphism_list, [ UniversalMorphismIntoDirectSum( irr_diagram, irr_source ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( test_object, morphism_list, direct_sum_object );
      
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( semisimple_objects_list, injection_number, direct_sum_object )
        local support, morphism_list, irr, objects_list, elem;
        
        support := Support( direct_sum_object );
        
        morphism_list := [ ];
        
        for irr in support do
            
            objects_list := [ ];
            
            for elem in semisimple_objects_list do
                
                Add( objects_list, Component( elem, irr ) );
                
            od;
            
            Add( morphism_list, [ InjectionOfCofactorOfDirectSum( objects_list, injection_number ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( semisimple_objects_list[ injection_number ], morphism_list, direct_sum_object );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum_object )
        local test_object, support, morphism_list, irr, irr_diagram, irr_sink;
        
        test_object := Range( sink[1] );
        
        support := Set( Concatenation( Support( direct_sum_object ), Support( test_object ) ) );
        
        morphism_list := [ ];
        
        for irr in support do
            
            irr_diagram := List( diagram, obj -> Component( obj, irr ) );
            
            irr_sink := List( sink, morphism -> Component( morphism, irr ) );
            
            Add( morphism_list, [ UniversalMorphismFromDirectSum( irr_diagram, irr_sink ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( direct_sum_object, morphism_list, test_object );
      
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( source, diagram, range )
        local support, irr, irr_diagram, morphism_list;
        
        support := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := [ ];
        
        for irr in support do
            
            irr_diagram := List( diagram, mor -> Component( mor, irr ) );
            
            Add( morphism_list, [ DirectSumFunctorial( irr_diagram ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( source, morphism_list, range );
        
    end );
    
    ## Basic Operations for an Abelian category
    ##
    AddKernelObject( category,
      function( morphism )
        local support, object_list;
        
        support := Support( Source( morphism ) );
        
        object_list := List( support, irr -> [ Dimension( KernelObject( Component( morphism, irr ) ) ), irr ] );
        
        return SemisimpleCategoryObject( object_list, category );
        
    end );
    
    ##
    AddKernelEmbedding( category,
      function( morphism )
        local support, result_morphism_list, kernel_object_list, kernel_object;
        
        support := Support( Source( morphism ) );
        
        result_morphism_list := List( support, irr -> [ KernelEmbedding( Component( morphism, irr ) ), irr ] );
        
        kernel_object_list := List( result_morphism_list, elem -> [ Dimension( Source( elem[1] ) ), elem[2] ] );
        
        kernel_object := SemisimpleCategoryObject( kernel_object_list, category );
        
        return SemisimpleCategoryMorphism( kernel_object, result_morphism_list, Source( morphism ) );
        
    end );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( category,
      function( morphism, kernel_object )
        local support, result_morphism_list;
        
        support := Support( Source( morphism ) );
        
        result_morphism_list := List( support, irr -> [ KernelEmbedding( Component( morphism, irr ) ), irr ] );
        
        return SemisimpleCategoryMorphism( kernel_object, result_morphism_list, Source( morphism ) );
        
    end );
    
    ##
    AddLift( category,
      function( alpha, beta )
        local source, range, support, morphism_list;
        
        source := Source( alpha );
        
        range := Source( beta );
        
        support := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := List( support, irr ->
                           [ Lift( Component( alpha, irr ), Component( beta, irr ) ), irr ] );
        
        return SemisimpleCategoryMorphism( source, morphism_list, range );
        
    end );
    
    ##
    AddCokernelObject( category,
      function( morphism )
        local support, object_list;
        
        support := Support( Range( morphism ) );
        
        object_list := List( support, irr -> [ Dimension( CokernelObject( Component( morphism, irr ) ) ), irr ] );
        
        return SemisimpleCategoryObject( object_list, category );
        
    end );
    
    ##
    AddCokernelProjection( category,
      function( morphism )
        local support, result_morphism_list, cokernel_object_list, cokernel_object;
        
        support := Support( Range( morphism ) );
        
        result_morphism_list := List( support, irr -> [ CokernelProjection( Component( morphism, irr ) ), irr ] );
        
        cokernel_object_list := List( result_morphism_list, elem -> [ Dimension( Range( elem[1] ) ), elem[2] ] );
        
        cokernel_object := SemisimpleCategoryObject( cokernel_object_list, category );
        
        return SemisimpleCategoryMorphism( Range( morphism ), result_morphism_list, cokernel_object );
        
    end );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( category,
      function( morphism, cokernel_object )
        local support, result_morphism_list;
        
        support := Support( Range( morphism ) );
        
        result_morphism_list := List( support, irr -> [ CokernelProjection( Component( morphism, irr ) ), irr ] );
        
        return SemisimpleCategoryMorphism( Range( morphism ), result_morphism_list, cokernel_object );
        
    end );
    
    ##
    AddColift( category,
      function( alpha, beta )
        local source, range, support, morphism_list;
        
        source := Range( alpha );
        
        range := Range( beta );
        
        support := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := List( support, irr ->
                           [ Colift( Component( alpha, irr ), Component( beta, irr ) ), irr ] );
        
        return SemisimpleCategoryMorphism( source, morphism_list, range );
        
    end );
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return IsEmpty( SemisimpleCategoryObjectList( object ) );
      
      end );

    ## Basic Operations for Monoidal Categories
    ##
    AddTensorProductOnObjects( category,
      [
        [ function( object_1, object_2 )
            local object_1_list, object_2_list, object_list, elem_1, elem_2, prod, multiplicity;
            
            object_1_list := SemisimpleCategoryObjectList( object_1 );
            
            object_2_list := SemisimpleCategoryObjectList( object_2 );
            
            object_list := [ ];
            
            for elem_1 in object_1_list do
                
                for elem_2 in object_2_list do
                    
                    prod := elem_1[2] * elem_2[2];
                    
                    multiplicity := elem_1[1] * elem_2[1];
                    
                    Append( object_list, List( prod, pair -> [ pair[1] * multiplicity, pair[2] ] ) );
                    
                od;
                
            od;
            
            return SemisimpleCategoryObject( object_list, category );
            
          end,
          
          [ ] ],
        
        [ function( object_1, object_2 )
            
            return object_1;
            
          end,
          
          [ IsZero, ] ],
         
        [ function( object_1, object_2 )
            
            return object_2;
            
          end,
          
          [ , IsZero ] ]
      ]
    
    );
    
    AddTensorUnit( category,
      
      function( )
        
        return SemisimpleCategoryObject( [ [ 1, tensor_unit ] ], category );
        
    end );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local morphism_1_list, morphism_2_list, size_1, size_2, tensor_products, i, j,
              support, size_support, morphism_list, chi, i_list, j_list, multiplicity,
              object;
        
        morphism_1_list := SemisimpleCategoryMorphismList( morphism_1 );
        
        morphism_2_list := SemisimpleCategoryMorphismList( morphism_2 );
        
        size_1 := Size( morphism_1_list );
        
        size_2 := Size( morphism_2_list );
        
        tensor_products := [ ];
        
        # precompute matrices for tensor products
        for i in [ 1 .. size_1 ] do
            
            Add( tensor_products, [ ] );
            
            for j in [ 1 .. size_2 ] do
                
                tensor_products[i][j] := TensorProductOnMorphisms( morphism_1_list[i][1], morphism_2_list[j][1] );
                
            od;
            
        od;
        
        support := Set( Concatenation( Support( new_source ), Support( new_range ) ) );
        
        size_support := Size( support );

        morphism_list := [ ];
        
        for chi in support do
            
            i_list := [ ];
            
            for i in [ 1 .. size_1 ] do
                
                j_list := [ ];
                
                for j in [ 1 .. size_2 ] do
                    
                    multiplicity := Multiplicity( chi, morphism_1_list[i][2], morphism_2_list[j][2] );
                    
                    if multiplicity > 0 then
                        
                        object := VectorSpaceObject( multiplicity, field );
                        
                        Add( j_list, TensorProductOnMorphisms( tensor_products[i][j], IdentityMorphism( object ) ) );
                        
                    fi;
                    
                od;
                
                if not IsEmpty( j_list ) then
                    
                    Add( i_list, DirectSumFunctorial( j_list ) );
                    
                fi;
                
            od;
            
            if not IsEmpty( i_list ) then
                
                Add( morphism_list, [ DirectSumFunctorial( i_list ), chi ] );
                
            fi;
            
        od;
        
        return SemisimpleCategoryMorphism( new_source, morphism_list, new_range );
        
    end );
    
    ## -- Helper functions for distributivity --
    
    ##
    right_distributivity_expanding_permutation := FunctionWithCache(
        function( object_b, list_of_objects, direct_sum, support_tensor_product, is_expanded )
          local permutation_list, k_permutation, size_support, size_list_of_objects, height, l, i, k, direct_sum_support,
                multiplicity_li, sum_up_to_l_minus_1, j, b_j_times_c_kij, cols, rows, height_of_zeros, object_b_list;
          
          if not is_expanded then
              
              list_of_objects := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( list_of_objects );
              
          fi;
          
          permutation_list := [ ];
          
          size_list_of_objects := Size( list_of_objects );
          
          object_b_list := SemisimpleCategoryObjectList( object_b );
          
          direct_sum_support := Support( direct_sum );
          
          for k in support_tensor_product do
              
              k_permutation := [ ];
              
              for l in [ 1 .. size_list_of_objects ] do
                  
                  height := 0;
                  
                  for i in direct_sum_support do
                      
                      multiplicity_li := Multiplicity( list_of_objects[l], i );
                      
                      sum_up_to_l_minus_1 :=
                        Sum( List( [ 1 .. l - 1 ], m -> Multiplicity( list_of_objects[m], i ) ) );
                      
                      for j in object_b_list do
                          
                          b_j_times_c_kij := j[1] * Multiplicity( k, i, j[2] );
                          
                          cols := multiplicity_li * b_j_times_c_kij;
                          
                          rows := Multiplicity( direct_sum, i ) * b_j_times_c_kij;
                          
                          height_of_zeros := sum_up_to_l_minus_1 * b_j_times_c_kij;
                          
                          Append( k_permutation,
                            List( [ 1 .. cols ], m -> height + height_of_zeros + m ) );
                          
                          height := height + rows;
                          
                      od;
                      
                  od;
                  
              od;
              
              Add( permutation_list, [ k_permutation, k ] );
              
          od;
          
          return permutation_list;
          
        end
    );
    ##
    left_distributivity_expanding_permutation := FunctionWithCache(
        function( object_b, list_of_objects, direct_sum, support_tensor_product, is_expanded )
          local permutation_list, k_permutation, size_list_of_objects, height, l, i, k, direct_sum_support,
                j, l_times_j, c_kij, list_of_objects_j, rows, zeros_above, ones, step, object_b_list;
          
          if not is_expanded then
              
              list_of_objects := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( list_of_objects );
              
          fi;
          
          permutation_list := [ ];
          
          size_list_of_objects := Size( list_of_objects );
          
          object_b_list := SemisimpleCategoryObjectList( object_b );
          
          direct_sum_support := Support( direct_sum );
          
          for k in support_tensor_product do
              
              k_permutation := [ ];
              
              for l in [ 1 .. size_list_of_objects ] do
                  
                  height := 0;
                  
                  for i in object_b_list do
                      
                      for j in direct_sum_support do
                          
                          l_times_j := Multiplicity( list_of_objects[l], j );
                          
                          c_kij := Multiplicity( k, i[2], j );
                          
                          list_of_objects_j := Multiplicity( direct_sum, j );
                          
                          rows := i[1] * list_of_objects_j * c_kij;
                          
                          zeros_above := Sum( List( [ 1 .. l - 1 ], m -> Multiplicity( list_of_objects[m], j ) ) ) * c_kij;
                          
                          ones := l_times_j * c_kij;
                          
                          step := list_of_objects_j * c_kij;
                          
                          Append( k_permutation, Flat(
                            List( [ 1 .. i[1] ], m -> List( [ 1 .. ones ], n -> height + (m-1)*step + zeros_above + n ) )
                          ) );
                          
                          height := height + rows;
                          
                      od;
                      
                  od;
                  
              od;
              
              Add( permutation_list, [ k_permutation, k ] );
              
          od;
          
          return permutation_list;
          
        end
    );
    ##
    distributivity_function := function( new_source, object_b, list_of_objects, new_range, permutation_function, invert )
      local support, support_tensor_product, size_support, direct_sum, morphism_list, k, permutation,
            object, dim, homalg_matrix, permutation_list, entry;
        
        support_tensor_product := Support( new_source );
        
        direct_sum := DirectSum( list_of_objects );
        
        permutation_list := permutation_function( object_b, list_of_objects, direct_sum, support_tensor_product, true );
        
        if invert then
            
            permutation_list := 
              List( permutation_list, entry ->
                [ ListPerm( PermList( entry[1] )^(-1), Size( entry[1] ) ), entry[2] ] );
            
        fi;
        
        morphism_list := [ ];
        
        for entry in permutation_list do
            
            object := Component( new_source, entry[2] );
            
            dim := Dimension( object );
            
            homalg_matrix := CertainRows(
              HomalgIdentityMatrix( dim, field ),
              entry[1] );
            
            Add( morphism_list, [ VectorSpaceMorphism( object, homalg_matrix, object ), entry[2] ] );
            
        od;
        
        return SemisimpleCategoryMorphism( new_source, morphism_list, new_range );
      
    end;
    
    ##
    AddRightDistributivityExpandingWithGivenObjects( category,
      
      function( new_source, list_of_objects, object_b, new_range )
          
          return distributivity_function(
                   new_source, object_b, list_of_objects, new_range, right_distributivity_expanding_permutation, true );
          
    end );
    
    
    ##
    AddRightDistributivityFactoringWithGivenObjects( category,
      
      function( new_source, list_of_objects, object_b, new_range )
          
          return distributivity_function(
                   new_source, object_b, list_of_objects, new_range, right_distributivity_expanding_permutation, false );
          
    end );
    
    ##
    AddLeftDistributivityExpandingWithGivenObjects( category,
      
      function( new_source, object_b, list_of_objects, new_range )
          
          return distributivity_function(
                   new_source, object_b, list_of_objects, new_range, left_distributivity_expanding_permutation, true );
          
    end );
    
    ##
    AddLeftDistributivityFactoringWithGivenObjects( category,
      
      function( new_source, object_b, list_of_objects, new_range )
          
          return distributivity_function(
                   new_source, object_b, list_of_objects, new_range, left_distributivity_expanding_permutation, false );
          
    end );
    
    ## -- Helper functions for the associator --
    
    ## computes the associator (left to right) of (c,a,b) via the coherence axiom involving the braiding
    InstallMethodWithCacheFromObject( CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft,
      [ ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject,
        MorphismFilter( category ) and IsSemisimpleCategoryMorphism,
        MorphismFilter( category ) and IsSemisimpleCategoryMorphism ],
        
        function( object_a, object_b, object_c, associator_left_to_right_acb, associator_right_to_left_abc )
          
          return PreCompose( [
            TensorProductOnMorphisms( Braiding( object_c, object_a ), IdentityMorphism( object_b ) ),
            associator_left_to_right_acb,
            TensorProductOnMorphisms( IdentityMorphism( object_a ), Braiding( object_c, object_b ) ),
            associator_right_to_left_abc,
            Braiding( TensorProductOnObjects( object_a, object_b ), object_c ) ] );
          
    end );
    
    ## computes the associator (left to right )of (b,c,a) via the coherence axiom involving the braiding
    InstallMethodWithCacheFromObject( CAP_INTERNAL_AssociatorFromCoherenceAxiomRight,
      [ ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject,
        MorphismFilter( category ) and IsSemisimpleCategoryMorphism,
        MorphismFilter( category ) and IsSemisimpleCategoryMorphism ],
        
        function( object_a, object_b, object_c, associator_right_to_left_abc, associator_left_to_right_bac )
          
          return PreCompose( [
            Braiding( TensorProductOnObjects( object_b, object_c ), object_a ),
            associator_right_to_left_abc,
            TensorProductOnMorphisms( Braiding( object_a, object_b ), IdentityMorphism( object_c ) ),
            associator_left_to_right_bac,
            TensorProductOnMorphisms( IdentityMorphism( object_b ), Braiding( object_a, object_c ) ) ] );
          
    end );
    
    
    ## the input are objects whose underlying list is of the form [ 1, irr ].
    associator_on_irreducibles := function( object_1, object_2, object_3 )
      local irr_1, irr_2, irr_3, data, morphism_list, object, pos_1, 
            pos_2, pos_3, size, homalg_matrix, source, range, i, string,
            irr_1_nr, irr_2_nr, irr_3_nr, result_morphism,
            associator_left_to_right, associator_right_to_left, intermediate_associator;
      
      irr_1 := SemisimpleCategoryObjectList( object_1 )[1][2];
      
      irr_2 := SemisimpleCategoryObjectList( object_2 )[1][2];
      
      irr_3 := SemisimpleCategoryObjectList( object_3 )[1][2];
      
      object := TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 );
      
      ## handle the cases where one of the inputs is the unit
      if IsYieldingIdentities( irr_1 ) or IsYieldingIdentities( irr_2 ) or IsYieldingIdentities( irr_3 ) then
          
          return IdentityMorphism( object );
          
      fi;
      
      if is_complete_data then
          
          morphism_list := AssociatorFromData( irr_1, irr_2, irr_3, associator_data, field, SemisimpleCategoryObjectList( object ) );
          
          result_morphism := SemisimpleCategoryMorphism( object, morphism_list, object );
          
      else
          
          # A <= B <= C
          
          irr_1_nr := irr_1!.UnderlyingCharacterNumber;
          
          irr_2_nr := irr_2!.UnderlyingCharacterNumber;
          
          irr_3_nr := irr_3!.UnderlyingCharacterNumber;
          
          if Size( Set( [ irr_1_nr, irr_2_nr, irr_3_nr ] ) ) = 2 then
              
              if ( irr_1_nr <= irr_2_nr and irr_2_nr <= irr_3_nr ) then
                  #(AAB), (ABB): can be loaded directly
                  
                  morphism_list := AssociatorFromData( irr_1, irr_2, irr_3, associator_data, field, SemisimpleCategoryObjectList( object ) );
                  
                  result_morphism := SemisimpleCategoryMorphism( object, morphism_list, object );
                  
              elif ( irr_1_nr < irr_2_nr ) then
                  #(ABA)
                  
                  associator_left_to_right := AssociatorLeftToRight( object_3, object_1, object_2 );
                  
                  associator_right_to_left := AssociatorRightToLeft( object_1, object_3, object_2 );
                  
                  result_morphism := CAP_INTERNAL_AssociatorFromCoherenceAxiomRight(
                    object_1, object_3, object_2, associator_right_to_left, associator_left_to_right );
                  
              elif ( irr_1_nr = irr_3_nr) then
                  #(BAB)
                  
                  associator_right_to_left := AssociatorRightToLeft( object_2, object_1, object_3 );
                  
                  associator_left_to_right := AssociatorLeftToRight( object_2, object_3, object_1 );
                  
                  result_morphism := CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft(
                    object_2, object_1, object_3, associator_left_to_right, associator_right_to_left );
                  
              elif (irr_2_nr = irr_3_nr ) then
                  #(BAA)
                  
                  associator_right_to_left := AssociatorRightToLeft( object_2, object_3, object_1 );
                  
                  associator_left_to_right := AssociatorLeftToRight( object_3, object_2, object_1 );
                  
                  intermediate_associator := CAP_INTERNAL_AssociatorFromCoherenceAxiomRight(
                    object_2, object_3, object_1, associator_right_to_left, associator_left_to_right );
                  
                  associator_right_to_left := AssociatorRightToLeft( object_2, object_3, object_1 );
                  
                  result_morphism := CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft(
                    object_2, object_3, object_1, intermediate_associator, associator_right_to_left );
                  
              else
                  #(BBA)
                  
                  associator_left_to_right := AssociatorLeftToRight( object_3, object_2, object_1 );
                  
                  associator_right_to_left := AssociatorRightToLeft( object_3, object_1, object_2 );
                  
                  intermediate_associator := CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft(
                    object_3, object_1, object_2, associator_left_to_right, associator_right_to_left );
                  
                  associator_right_to_left := AssociatorRightToLeft( object_3, object_1, object_2 );
                  
                  result_morphism := CAP_INTERNAL_AssociatorFromCoherenceAxiomRight(
                    object_3, object_1, object_2, associator_right_to_left, intermediate_associator );
                  
              fi;
              
          else
              
              if ( irr_1_nr <= irr_2_nr ) and ( irr_1_nr <= irr_3_nr ) then
                  #(ABC), (ACB): can be loaded directly
                  
                  morphism_list := AssociatorFromData( irr_1, irr_2, irr_3, associator_data, field, SemisimpleCategoryObjectList( object ) );
                  
                  result_morphism := SemisimpleCategoryMorphism( object, morphism_list, object );
                  
              elif (irr_1_nr <= irr_3_nr ) then
                  #(CAB), (BAC): usage of 1 helper function
                  
                  associator_left_to_right := AssociatorLeftToRight( object_2, object_1, object_3 );
                  
                  associator_right_to_left := AssociatorRightToLeft( object_2, object_3, object_1 );
                  
                  result_morphism :=
                    CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft(
                      object_2, object_3, object_1, associator_left_to_right, associator_right_to_left );
                  
              else
                  #(BCA), (CBA): usage of 2 helper functions
                  
                  associator_left_to_right :=
                    AssociatorLeftToRight( object_3, object_1, object_2 );
                  
                  associator_right_to_left :=
                    AssociatorRightToLeft( object_3, object_2, object_1 );
                  
                  intermediate_associator :=
                    CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft( 
                      object_3, object_2, object_1, associator_left_to_right, associator_right_to_left );
                  
                  associator_right_to_left :=
                    AssociatorRightToLeft( object_3, object_1, object_2 );
                  
                  result_morphism :=
                    CAP_INTERNAL_AssociatorFromCoherenceAxiomRight( 
                      object_3, object_1, object_2, associator_right_to_left, intermediate_associator );
                  
              fi;
            
          fi;
          
      fi;
      
      return result_morphism;
      
    end;
    
    InstallMethodWithCacheFromObject( CAP_INTERNAL_AssociatorOnIrreducibles,
      [ ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject ],
        
        associator_on_irreducibles );
    
    ##
    distributivity_expanding_for_triple := FunctionWithCache(
        function( object_1, object_2, object_list_with_actual_objects, left_term )
          local summands, direct_sum, object, support_tensor_product_all, direct_sum_2, support_tensor_product_partial,
                tensored_object_list_with_actual_objects, permutation_list_1, permutation_list_2, morphism_list, size, i,
                dim, string, vector_space_object;
          
          summands := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_list_with_actual_objects );
          
          direct_sum := DirectSum( summands );
          
          object := TensorProductOnObjects( TensorProductOnObjects( direct_sum, object_1 ), object_2 );
          
          support_tensor_product_all := Support( object );
          
          direct_sum_2 := TensorProductOnObjects( direct_sum, object_1 );
          
          support_tensor_product_partial := Support( direct_sum_2 );
          
          tensored_object_list_with_actual_objects := 
            List( object_list_with_actual_objects, pair -> [ pair[1], TensorProductOnObjects( pair[2], object_1 ) ] );
          
          if left_term then
              
              permutation_list_1 :=
                right_distributivity_expanding_permutation( 
                  object_1, object_list_with_actual_objects, direct_sum, support_tensor_product_partial, false );
              
              permutation_list_1 :=
                CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromRight( permutation_list_1, object_2, support_tensor_product_all );
              
          else
              
              permutation_list_1 :=
                left_distributivity_expanding_permutation( 
                  object_1, object_list_with_actual_objects, direct_sum, support_tensor_product_partial, false );
              
              permutation_list_1 :=
                CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromRight( permutation_list_1, object_2, support_tensor_product_all );
              
          fi;
          
          permutation_list_2 :=
            right_distributivity_expanding_permutation(
              object_2, tensored_object_list_with_actual_objects, direct_sum_2, support_tensor_product_all, false );
          
          morphism_list := [ ];
          
          ## CLAIM: permutation_lists are sorted w.r.t. ordering in second component
          size := Size( permutation_list_1 );
          
          for i in [ 1 .. size ] do
              
              Add( morphism_list,
                   [ ListPerm( ( PermList( permutation_list_1[i][1] )^(-1) * PermList( permutation_list_2[i][1] )^(-1) )^(-1),
                     Size( permutation_list_1[i][1] ) ),
                     permutation_list_1[i][2] ] 
              );
              
          od;
          
          return morphism_list;
          
        end
    );
    ##
    distributivity_factoring_for_triple := FunctionWithCache(
        function( object_1, object_2, object_list_with_actual_objects, right_term )
          local summands, direct_sum, object, support_tensor_product_all, direct_sum_2, support_tensor_product_partial,
                tensored_object_list_with_actual_objects, permutation_list_1, permutation_list_2, morphism_list, size, i,
                dim, string, vector_space_object;
          
          summands := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_list_with_actual_objects );
          
          direct_sum := DirectSum( summands );
          
          object := TensorProductOnObjects( TensorProductOnObjects( direct_sum, object_1 ), object_2 );
          
          support_tensor_product_all := Support( object );
          
          direct_sum_2 := TensorProductOnObjects( direct_sum, object_2 );
          
          support_tensor_product_partial := Support( direct_sum_2 );
          
          tensored_object_list_with_actual_objects := 
            List( object_list_with_actual_objects, pair -> [ pair[1], TensorProductOnObjects( pair[2], object_2 ) ] );
          
          if right_term then
              
              permutation_list_1 :=
                left_distributivity_expanding_permutation( 
                  object_2, object_list_with_actual_objects, direct_sum, support_tensor_product_partial, false );
              
              permutation_list_1 :=
                CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromLeft( permutation_list_1, object_1, support_tensor_product_all );
              
          else
              
              permutation_list_1 :=
                right_distributivity_expanding_permutation( 
                  object_2, object_list_with_actual_objects, direct_sum, support_tensor_product_partial, false );
              
              permutation_list_1 :=
                CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromLeft( permutation_list_1, object_1, support_tensor_product_all );
              
          fi;
          
          permutation_list_2 :=
            right_distributivity_expanding_permutation(
              object_1, tensored_object_list_with_actual_objects, direct_sum_2, support_tensor_product_all, false );
          
          morphism_list := [ ];
          
          ## CLAIM: permutation_lists are sorted w.r.t. ordering in second component
          size := Size( permutation_list_1 );
          
          for i in [ 1 .. size ] do
              
              Add( morphism_list,
                   [ ListPerm( ( PermList( permutation_list_2[i][1] ) * PermList( permutation_list_1[i][1] ) )^(-1), 
                     Size( permutation_list_2[i][1] ) ),
                     permutation_list_1[i][2] ]
              );
              
          od;
          
          return morphism_list;
          
        end
    );
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( category,
      function( new_source, object_a, object_b, object_c, new_range )
        local object_a_list, object_b_list, object_c_list, result_morphism,
              object_a_expanded_list, object_b_expanded_list, object_c_expanded_list,
              elem, morphism, summand_list, inner_summand_list, outer_summand_list, innermost_summand_list,
              elem_a, elem_b, elem_c,
              morphism_1, morphism_2, morphism_3, morphism_4, morphism_5, morphism_6, morphism_7_inverse,
              tensor_product, first_permutation, first_permutation_morphism_list,
              second_permutation, second_permutation_morphism_list, chi,
              perm1, perm2, perm3, dim, vector_space_object, homalg_matrix;
        
        object_a_list := SemisimpleCategoryObjectListWithActualObjects( object_a );
        
        object_b_list := SemisimpleCategoryObjectListWithActualObjects( object_b );
        
        object_c_list := SemisimpleCategoryObjectListWithActualObjects( object_c );
        
        if IsEmpty( object_a_list ) or IsEmpty( object_b_list ) or IsEmpty( object_c_list ) then
            
            return ZeroMorphism( new_source, new_range );
            
        fi;
        
        object_a_expanded_list :=
          CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_a_list );
        
        object_b_expanded_list :=
          CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_b_list );
        
        object_c_expanded_list :=
          CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_c_list );
        
        result_morphism := IdentityMorphism( new_source );
        
        ## morphism_1
        
        morphism_1 := [ ];
        
        if Size( object_a_expanded_list ) > 1 then
            
            morphism_1 := distributivity_expanding_for_triple( object_b, object_c, object_a_list, true );
            
        fi;
        
        ## morphism_2
        
        morphism_2 := [ ];
        
        if Size( object_b_expanded_list ) > 1 then
            
            summand_list := [ ];
            
            for elem in object_a_list do
                
                morphism := distributivity_expanding_for_triple( elem[2], object_c, object_b_list, false );
                
                Append( summand_list, List( [ 1 .. elem[1] ], i -> morphism ) );
                
            od;
            
            morphism_2 := CAP_INTERNAL_DirectSumForPermutationLists( summand_list, Support( new_source ) );
            
        fi;
        
        ## morphism_3
        
        morphism_3 := [ ];
        
        if Size( object_c_expanded_list ) > 1 then
            
            outer_summand_list := [ ];
            
            for elem_a in object_a_list do
                
                inner_summand_list := [ ];
                
                for elem_b in object_b_list do
                    
                    tensor_product := TensorProductOnObjects( elem_a[2], elem_b[2] );
                    
                    morphism :=
                      left_distributivity_expanding_permutation
                        ( tensor_product, object_c_list,
                          object_c, Support( TensorProductOnObjects( tensor_product, object_c ) ), false );
                    
                    Append( inner_summand_list, List( [ 1 .. elem_b[1] ], i -> morphism ) );
                    
                od;
                
                morphism :=
                  CAP_INTERNAL_DirectSumForPermutationLists(
                    inner_summand_list, Support( TensorProductOnObjects( TensorProductOnObjects( elem_a[2], object_b ), object_c ) )
                  );
                
                Append( outer_summand_list, List( [ 1 .. elem_a[1] ], i -> morphism ) );
                
            od;
            
            morphism_3 := CAP_INTERNAL_DirectSumForPermutationLists( outer_summand_list, Support( new_source ) );
            
        fi;
        
        ## morphism_4
        
        outer_summand_list := [ ];
        
        for elem_a in object_a_list do
            
            inner_summand_list := [ ];
            
            for elem_b in object_b_list do
                
                innermost_summand_list := [ ];
                
                for elem_c in object_c_list do
                    
                    morphism := CAP_INTERNAL_AssociatorOnIrreducibles( elem_a[2], elem_b[2], elem_c[2] );
                    
                    Append( innermost_summand_list, List( [ 1 .. elem_c[1] ], i -> morphism ) );
                    
                od;
                
                morphism := DirectSumFunctorial( innermost_summand_list );
                
                Append( inner_summand_list, List( [ 1 .. elem_b[1] ], i -> morphism ) );
                
            od;
            
            morphism := DirectSumFunctorial( inner_summand_list );
            
            Append( outer_summand_list, List( [ 1 .. elem_a[1] ], i -> morphism ) );
            
        od;
        
        morphism_4 := DirectSumFunctorial( outer_summand_list );
        
        ## morphism_5
        
        morphism_5 := [ ];
        
        if Size( object_c_expanded_list ) > 1 then
            
            outer_summand_list := [ ];
            
            for elem_a in object_a_list do
                
                inner_summand_list := [ ];
                
                for elem_b in object_b_list do
                    
                    morphism :=
                      distributivity_factoring_for_triple( elem_a[2], elem_b[2], object_c_list, true );
                    
                    Append( inner_summand_list, List( [ 1 .. elem_b[1] ], i -> morphism ) );
                    
                od;
                
                morphism := CAP_INTERNAL_DirectSumForPermutationLists( inner_summand_list,
                              Support( TensorProductOnObjects( TensorProductOnObjects( elem_a[2], object_b ), object_c ) ) );
                
                Append( outer_summand_list, List( [ 1 .. elem_a[1] ], i -> morphism ) );
                
            od;
            
            morphism_5 := CAP_INTERNAL_DirectSumForPermutationLists( outer_summand_list, Support( new_source ) );
            
        fi;
        
        ## morphism_6
        
        morphism_6 := [ ];
        
        if Size( object_b_expanded_list ) > 1 then
            
            summand_list := [ ];
            
            for elem in object_a_list do
                
                morphism := distributivity_factoring_for_triple( elem[2], object_c, object_b_list, false );
                
                Append( summand_list, List( [ 1 .. elem[1] ], i -> morphism ) );
                
            od;
            
            morphism_6 := CAP_INTERNAL_DirectSumForPermutationLists( summand_list, Support( new_source ) );
            
        fi;
        
        ## morphism_7_inverse
        
        morphism_7_inverse := [ ];
        
        if Size( object_a_expanded_list ) > 1 then
            
            tensor_product := TensorProductOnObjects( object_b, object_c );
            
            morphism_7_inverse := 
              right_distributivity_expanding_permutation
                          ( tensor_product, object_a_list,
                            object_a, Support( new_source ), false );
            
        fi;
        
        first_permutation_morphism_list := [ ];
        
        first_permutation := IdentityMorphism( new_source );
        
        if not ( IsEmpty( morphism_1 ) and IsEmpty( morphism_2 ) and IsEmpty( morphism_3 ) ) then
            
            for chi in Support( new_source ) do
                
                perm1 := First( morphism_1, i -> i[2] = chi );
                
                if not perm1 = fail then
                    
                    perm1 := PermList( perm1[1] )^(-1);
                    
                else
                    
                    perm1 := ();
                    
                fi;
                
                perm2 := First( morphism_2, i -> i[2] = chi );
                
                if not perm2 = fail then
                    
                    perm2 := PermList( perm2[1] )^(-1);
                    
                else
                    
                    perm2 := ();
                    
                fi;
                
                perm3 := First( morphism_3, i -> i[2] = chi );
                
                if not perm3 = fail then
                    
                    perm3 := PermList( perm3[1] )^(-1);
                    
                else
                    
                    perm3 := ();
                    
                fi;
                
                dim := Multiplicity( new_source, chi );
                
                vector_space_object := VectorSpaceObject( dim, field );
                
                homalg_matrix := CertainRows(
                  HomalgIdentityMatrix( dim, field ),
                  ListPerm( perm1 * perm2 * perm3, dim )
                );
                
                Add( first_permutation_morphism_list, [ VectorSpaceMorphism( vector_space_object, homalg_matrix, vector_space_object ),
                     chi ] );
                
            od;
            
            first_permutation := SemisimpleCategoryMorphism( new_source, first_permutation_morphism_list, new_range );
            
        fi;
        
        second_permutation_morphism_list := [ ];
        
        second_permutation := IdentityMorphism( new_source );
        
        if not ( IsEmpty( morphism_5 ) and IsEmpty( morphism_6 ) and IsEmpty( morphism_7_inverse ) ) then
            
            for chi in Support( new_source ) do
                
                perm1 := First( morphism_5, i -> i[2] = chi );
                
                if not perm1 = fail then
                    
                    perm1 := PermList( perm1[1] )^(-1);
                    
                else
                    
                    perm1 := ();
                    
                fi;
                
                perm2 := First( morphism_6, i -> i[2] = chi );
                
                if not perm2 = fail then
                    
                    perm2 := PermList( perm2[1] )^(-1);
                    
                else
                    
                    perm2 := ();
                    
                fi;
                
                perm3 := First( morphism_7_inverse, i -> i[2] = chi );
                
                if not perm3 = fail then
                    
                    perm3 := PermList( perm3[1] ); ## the inverse!
                    
                else
                    
                    perm3 := ();
                    
                fi;
                
                dim := Multiplicity( new_source, chi );
                
                vector_space_object := VectorSpaceObject( dim, field );
                
                homalg_matrix := CertainRows(
                  HomalgIdentityMatrix( dim, field ),
                  ListPerm( perm1 * perm2 * perm3, dim )
                );
                
                Add( second_permutation_morphism_list, [ VectorSpaceMorphism( vector_space_object, homalg_matrix, vector_space_object ),
                     chi ] );
                
            od;
            
            second_permutation := SemisimpleCategoryMorphism( new_source, second_permutation_morphism_list, new_range );
            
        fi;
        
        return PreCompose( [ first_permutation, morphism_4, second_permutation ] );
        
    end );
    
    ## -- Helper functions for the braiding --
    
    ## the input are objects whose underlying list is of the form [ 1, irr ].
    braiding_on_irreducibles := function( object_1, object_2 )
      local irr_1, irr_2, object, exterior_power_list, exterior_power, object_list, morphism_list,
            elem, number_minus_1, number_1, diagonal, homalg_mat, vector_space;
      
      irr_1 := SemisimpleCategoryObjectList( object_1 )[1][2];
      
      irr_2 := SemisimpleCategoryObjectList( object_2 )[1][2];
      
      object := TensorProductOnObjects( object_1, object_2 );
      
      if IsYieldingIdentities( irr_1 ) or IsYieldingIdentities( irr_2 ) then
          
          return IdentityMorphism( object );
          
      fi;
      
      exterior_power_list := ExteriorPower( irr_1, irr_2 );
      
      if IsEmpty( exterior_power_list ) then
          
          return IdentityMorphism( object );
          
      fi;
      
      exterior_power := SemisimpleCategoryObject( exterior_power_list, category );
      
      object_list := SemisimpleCategoryObjectList( object );
      
      morphism_list := [ ];
      
      for elem in object_list do
          
          number_minus_1 := Multiplicity( exterior_power, elem[2] );
          
          number_1 := elem[1] - number_minus_1;
          
          diagonal := Concatenation( List( [ 1 .. number_1 ], i -> 1 ), List( [ 1 .. number_minus_1 ], i -> -1 ) );
          
          homalg_mat := HomalgDiagonalMatrix( diagonal, field );
          
          vector_space := VectorSpaceObject( elem[1], field );
          
          Add( morphism_list, [ VectorSpaceMorphism( vector_space, homalg_mat, vector_space ), elem[2] ] );
          
      od;
      
      return SemisimpleCategoryMorphism( object, morphism_list, object );
      
    end;
    
    ##
    InstallMethodWithCacheFromObject( CAP_INTERNAL_Braiding_On_Irreducibles,
      [ ObjectFilter( category ) and IsSemisimpleCategoryObject,
        ObjectFilter( category ) and IsSemisimpleCategoryObject ],
        
        braiding_on_irreducibles );
    
    
    ##
    AddBraidingWithGivenTensorProducts( category,
      function( object_a_tensored_object_b, object_a, object_b, object_b_tensored_object_a )
        local object_a_list, object_b_list, result_morphism, object_a_expanded_list, object_b_expanded_list,
              morphism, outer_summand_list, inner_summand_list, summand_list, elem, elem_a, elem_b;
        
        object_a_list := SemisimpleCategoryObjectListWithActualObjects( object_a );
        
        object_b_list := SemisimpleCategoryObjectListWithActualObjects( object_b );
        
        if IsEmpty( object_a_list ) or IsEmpty( object_b_list ) then
            
            return ZeroMorphism( object_a_tensored_object_b, object_b_tensored_object_a );
            
        fi;
        
        result_morphism := IdentityMorphism( object_a_tensored_object_b );
        
        object_a_expanded_list := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_a_list );
        
        object_b_expanded_list := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_b_list );
        
        ## morphism_1
        if Size( object_a_expanded_list ) > 1 then
            
            morphism := RightDistributivityExpanding( object_a_expanded_list, object_b );
            
            result_morphism := PreCompose( result_morphism, morphism );
            
        fi;
        
        ## morphism_2
        if Size( object_b_expanded_list ) > 1 then
            
            summand_list := [ ];
            
            for elem in object_a_list do
                
                morphism := LeftDistributivityExpanding( elem[2], object_b_expanded_list );
                
                Append( summand_list, List( [ 1 .. elem[1] ], i -> morphism ) );
                
            od;
            
            morphism := DirectSumFunctorial( summand_list );
            
            result_morphism := PreCompose( result_morphism, morphism );
            
        fi;
        
        ## morphism_3
        
        outer_summand_list := [ ];
        
        for elem_a in object_a_list do
            
            inner_summand_list := [ ];
            
            for elem_b in object_b_list do
                
                morphism := braiding_on_irreducibles( elem_a[2], elem_b[2] );
                
                Append( inner_summand_list, List( [ 1 .. elem_b[1] ], i -> morphism ) );
                
            od;
            
            morphism := DirectSumFunctorial( inner_summand_list );
            
            Append( outer_summand_list, List( [ 1 .. elem_a[1] ], i -> morphism ) );
            
        od;
        
        morphism := DirectSumFunctorial( outer_summand_list );
        
        result_morphism := PreCompose( result_morphism, morphism );
        
        ## morphism_4
        if Size( object_b_expanded_list ) > 1 then
            
            summand_list := [ ];
            
            for elem in object_a_list do
                
                morphism := RightDistributivityFactoring( object_b_expanded_list, elem[2] );
                
                Append( summand_list, List( [ 1 .. elem[1] ], i -> morphism ) );
                
            od;
            
            morphism := DirectSumFunctorial( summand_list );
            
            result_morphism := PreCompose( result_morphism, morphism );
            
        fi;
        
        ## morphism_5
        if Size( object_a_expanded_list ) > 1 then
            
            morphism := LeftDistributivityFactoring( object_b, object_a_expanded_list );
            
            result_morphism := PreCompose( result_morphism, morphism );
            
        fi;
        
        return result_morphism;
        
    end );
    
    AddLeftUnitorWithGivenTensorProduct( category,
      function( object, tensor_product )
        
        return IdentityMorphism( object );
        
    end );
    
    AddRightUnitorWithGivenTensorProduct( category,
      function( object, tensor_product )
        
        return IdentityMorphism( object );
        
    end );
    
    
    ##
    AddDualOnObjects( category, 
      function( object )
        local object_list, dual_list, elem;
        
        object_list := SemisimpleCategoryObjectList( object );
        
        dual_list := [ ];
        
        for elem in object_list do
            
            Add( dual_list, [ elem[1], Dual( elem[2] ) ] );
            
        od;
        
        return SemisimpleCategoryObject( dual_list, category );
        
    end );
    
    ##
    AddDualOnMorphismsWithGivenDuals( category,
      function( dual_source, morphism, dual_range )
        local morphism_list;
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        return SemisimpleCategoryMorphism(
                 dual_source,
                 List( morphism_list, elem -> [ DualOnMorphisms( elem[1] ), Dual( elem[2] ) ] ),
                 dual_range );
        
    end );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( category,
      function( unit, object, tensor_object )
        local object_list, dual_object, dual_object_list, object_expanded_list, elem,
              dual_object_expanded_list, dim, matrix_list, zero_list,
              summand_list, trivial_chi, vector_space, vector_space_morphism,
              i, result_morphism, morphism;
        
        object_list := SemisimpleCategoryObjectListWithActualObjects( object );
        
        if IsEmpty( object_list ) then
            
            return ZeroMorphism( unit, tensor_object );
            
        fi;
        
        dual_object := DualOnObjects( object );
        
        dual_object_list := SemisimpleCategoryObjectListWithActualObjects( dual_object );
        
        object_expanded_list := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_list );
        
        dual_object_expanded_list := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( dual_object_list );
        
        ## morphism_1
        
        trivial_chi := Support( unit )[1];
        
        matrix_list := [ ];
        
        for elem in object_list do
            
            Add( matrix_list, 1 );
            
            zero_list := List( [ 1 .. elem[1] ], i -> 0 );
            
            for i in [ 2 .. elem[1] ] do
                
                Append( matrix_list, zero_list );
                
                Add( matrix_list, 1 );
                
            od;
            
        od;
        
        dim := Multiplicity( tensor_object, trivial_chi );
        
        vector_space := VectorSpaceObject( dim, field );
        
        vector_space_morphism :=
          VectorSpaceMorphism( TensorUnit( UnderlyingCategoryForSemisimpleCategory( CapCategory( unit ) ) ),
                               HomalgMatrix( matrix_list, 1, dim, field ),
                               vector_space );
        
        result_morphism := SemisimpleCategoryMorphismSparse( unit, [ [ vector_space_morphism, trivial_chi ] ], tensor_object );
        
        ## morphism_2 and morphism_3
        if Size( object_expanded_list ) > 1 then
            
            ## morphism_2
            summand_list := [ ];
            
            for elem in object_list do
                
                morphism := LeftDistributivityFactoring( elem[2], dual_object_expanded_list );
                
                Append( summand_list, List( [ 1 .. elem[1] ], i -> morphism ) );
                
            od;
            
            morphism := DirectSumFunctorial( summand_list );
            
            result_morphism := PreCompose( result_morphism, morphism );
            
            ## morphism_3
            morphism := RightDistributivityFactoring( object_expanded_list, dual_object );
            
            result_morphism := PreCompose( result_morphism, morphism );
            
        fi;
        
        return result_morphism;
        
    end );
      
    ##
    AddEvaluationForDualWithGivenTensorProduct( category,
      function( tensor_object, object, unit )
        local object_list, dual_object, dual_object_list, object_expanded_list, elem,
              dual_object_expanded_list, trivial_chi, dim, vector_space, vector_space_morphism,
              result_morphism, summand_list, morphism, string, string_entry, i, zero_list;
        
        object_list := SemisimpleCategoryObjectListWithActualObjects( object );
        
        if IsEmpty( object_list ) then
            
            return ZeroMorphism( tensor_object, unit );
            
        fi;
        
        dual_object := DualOnObjects( object );
        
        dual_object_list := SemisimpleCategoryObjectListWithActualObjects( dual_object );
        
        object_expanded_list := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( object_list );
        
        dual_object_expanded_list := CAP_INTERNAL_ExpandSemisimpleCategoryObjectList( dual_object_list );
        
        ## morphism_3
        
        trivial_chi := Support( unit )[1];
        
        string := "";
        
        for elem in object_list do
            
            string_entry := Concatenation( ",", CAP_INTERNAL_EvaluationForDualOnIrreduciblesAsString( elem[2] ) );
            
            Append( string, string_entry );
            
            zero_list := Concatenation( List( [ 1 .. elem[1] ], i -> ",0" ) );
            
            for i in [ 2 .. elem[1] ] do
                
                Append( string, zero_list );
                
                Append( string, string_entry );
                
            od;
            
        od;
        
        Remove( string, 1 );
        
        string := Concatenation( "[", string, "]" );
        
        dim := Multiplicity( tensor_object, trivial_chi );
        
        vector_space := VectorSpaceObject( dim, field );
        
        vector_space_morphism :=
          VectorSpaceMorphism( vector_space,
                               HomalgMatrix( string, dim, 1, field ),
                               TensorUnit( UnderlyingCategoryForSemisimpleCategory( CapCategory( unit ) ) ) );
        
        result_morphism := SemisimpleCategoryMorphismSparse( tensor_object, [ [ vector_space_morphism, trivial_chi ] ], unit );
        
        ## morphism_1 and morphism_2
        if Size( object_expanded_list ) > 1 then
            
            ## morphism_2
            summand_list := [ ];
            
            for elem in dual_object_list do
                
                morphism := LeftDistributivityExpanding( elem[2], object_expanded_list );
                
                Append( summand_list, List( [ 1 .. elem[1] ], i -> morphism ) );
                
            od;
            
            morphism := DirectSumFunctorial( summand_list );
            
            result_morphism := PreCompose( morphism, result_morphism );
            
            ## morphism_1
            morphism := RightDistributivityExpanding( dual_object_expanded_list, object );
            
            result_morphism := PreCompose( morphism, result_morphism );
            
        fi;
        
        return result_morphism;
        
    end );
    
#     ##
#     AddMorphismToBidualWithGivenBidual( category,
#       function( object, bidual_of_object )
#         
#         return VectorSpaceMorphism( object,
#                                     HomalgIdentityMatrix( Dimension( object ), homalg_field ),
#                                     bidual_of_object
#                                   );
#         
#     end );
    
end );

##
InstallMethod( CAP_INTERNAL_EvaluationForDualOnIrreduciblesAsString,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local id_object, trivial_irreducible, naive_morphism, automorphism, morphism;
    
    id_object := IdentityMorphism( object );
    
    trivial_irreducible := Support( TensorUnit( CapCategory( object ) ) )[1];
    
    naive_morphism :=
      ComponentProjectionMorphism( TensorProductOnObjects( DualOnObjects( object ), object ), trivial_irreducible );
    
    automorphism := PreCompose( [
      LeftUnitorInverse( object ),
      TensorProductOnMorphisms( CoevaluationForDual( object ), id_object ),
      AssociatorLeftToRight( object, DualOnObjects( object ), object ),
      TensorProductOnMorphisms( id_object, naive_morphism ),
      RightUnitor( object ) ] );
    
    morphism := PreCompose( TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( object ) ), Inverse( automorphism ) ),
                            naive_morphism );
    
    morphism := Component( morphism, trivial_irreducible );
    
    return String( EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) )[1] );
    
end );


####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategory,
               [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool ],
               
  function( homalg_field, membership_function, tensor_unit, associator_filename, is_complete_data )
    local name;
    
    name := Concatenation( "The semisimple category with irreducibles given by ", NameFunction( membership_function ) );
    
    return SemisimpleCategory(
             homalg_field,
             membership_function,
             tensor_unit,
             associator_filename,
             is_complete_data,
             [ IsObject, IsObject, IsObject, name ] );
    
end );

##
InstallMethod( SemisimpleCategory,
               [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool, IsList ],
               
  function( homalg_field, membership_function, tensor_unit, associator_filename, is_complete_data, context_list )
    local name, stream, command, semisimple_category, underlying_category, associator_data;
    
    name := context_list[4];
    
    associator_filename :=
      Concatenation( PackageInfo( "GroupRepresentationsForCAP" )[1].InstallationPath,
                     "/gap/AssociatorsDatabase/",
                     associator_filename );
    
    stream := InputTextFile( associator_filename );
    
    command := ReadAll( stream );
    
    associator_data := EvalString( command );
    
    underlying_category := MatrixCategory( homalg_field );
    
    semisimple_category := CreateCapCategory( name );
    
    SetIsAbelianCategory( semisimple_category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( semisimple_category, true );
    
    SetUnderlyingCategoryForSemisimpleCategory( semisimple_category, underlying_category );
    
    SetMembershipFunctionForSemisimpleCategory( semisimple_category, membership_function );
    
    SetUnderlyingFieldForHomalgForSemisimpleCategory( semisimple_category, homalg_field );
    
    SetFilterObj( semisimple_category, IsSemisimpleCategory );
    
    SetFilterObj( semisimple_category, context_list[1] );
    
    SetGivenObjectFilterForSemisimpleCategory( semisimple_category, context_list[2] );
    
    SetGivenMorphismFilterForSemisimpleCategory( semisimple_category, context_list[3] );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY(
      semisimple_category, tensor_unit, associator_data, is_complete_data );
    
    Finalize( semisimple_category );
    
    return semisimple_category;
    
end );

