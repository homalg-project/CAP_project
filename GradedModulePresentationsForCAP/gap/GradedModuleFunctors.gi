#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#############################################################################

##
InstallMethodWithCache( ResolutionFunctor,
                        [ IsCapCategory, IsFunction, IsBool ],
                        
  function( source_category, kernel_hull_function, complex )
    local functor, object_function, morphism_function, recursion_function, constructor, category_constructor;
    
    
    if complex then
        constructor := AsComplex;
        category_constructor := ComplexCategory;
    else
        constructor := AsCocomplex;
        category_constructor := CocomplexCategory;
    fi;
    
    functor := CapFunctor( Concatenation( "ResolutionFunctor for ", Name( source_category ) ), source_category, category_constructor( source_category ) );
    
    recursion_function := function( morphism )
      local kernel_emb, kernel, cover;
        
        kernel_emb := KernelEmbedding( morphism );
        
        kernel := Source( kernel_emb );
        
        cover := kernel_hull_function( kernel );
        
        return PreCompose( cover, kernel_emb );
        
    end;
    
    ## functor object function
    object_function := function( object )
      local initial_morphism, z_functor;
        
        initial_morphism := kernel_hull_function( object );
        
        z_functor := ZFunctorObjectByInitialMorphismAndRecursiveFunction( initial_morphism, recursion_function, 0 );
        
        return constructor( z_functor );
        
    end;
    
    AddObjectFunction( functor, object_function );
    
    return functor;
    
end );

##
InstallMethod( ResolutionFunctorToComplex,
               [ IsCapCategory, IsFunction ],
               
  function( cat, func )
    return ResolutionFunctor( cat, func, true );
end );

##
InstallMethod( ResolutionFunctorToCocomplex,
               [ IsCapCategory, IsFunction ],
               
  function( cat, func )
    return ResolutionFunctor( cat, func, false );
end );

# InstallMethod( ResolutionToComplex,
#                [ IsCapCategoryObject, IsFunction ],
#                
#   function( object, kernel_hull_function )
#     local z_functor, complex;
#     
#     z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, CapCategory( object ) );
#     
#     complex := AsComplex( z_functor );
#     
#     connection_morphism := kernel_hull_function( object );
#     
#     object_function := function( i )
#         return Source( Differential( complex, i ) );
#     end;
#     
#     morphism_function := function( i )
#         
#         if i = 0 then
#             return UniversalMorphismIntoZeroObject( Source( connection_morphism ) );
#         if i = -1 then
#             return kernel_hull_function( KernelEmbedding( connection_morphism ) );
#         if i < -1 then
#             return kernel_hull_function( KernelEmbedding( Differential( complex, -i - 1 ) ) );
#         else
#             return IdentityMorphism( ZeroObject( CapCategory( object ) ) );
#         fi;
#         
#     end;
#     
#     z_functor!.object_func := object_function;
#     z_functor!.differential_func := morphism_function;
#     
#     return [ complex, connection_morphism ];
#     
# end );

InstallMethod( FreeResolutionComplex,
               [ IsCapCategoryObject ],
               
  function( module )
    return ResolutionTo( module, CoverByProjective, true );
end );

InstallMethod( FreeResolutionCocomplex,
               [ IsCapCategoryObject ],
               
  function( module )
    return ResolutionTo( module, CoverByProjective, false );
end );

InstallMethod( ResolutionTo,
               [ IsCapCategoryObject, IsFunction, IsBool ],
               
  function( object, kernel_hull_function, as_complex )
    local z_functor, complex, object_function, morphism_function, complex_constructor, connection_morphism;
    
    z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, CapCategory( object ) );
    
    if as_complex = true then
        complex_constructor := AsComplex;
    else
        complex_constructor := AsCocomplex;
    fi;
    
    complex := complex_constructor( z_functor );
    
    connection_morphism := kernel_hull_function( object );
    
    object_function := function( i )
        return Source( Differential( z_functor, i ) );
    end;
    
    morphism_function := function( i )
        local kernel;
        
        if i = 0 then
            return UniversalMorphismIntoZeroObject( Source( connection_morphism ) );
        elif i = -1 then
            kernel := KernelEmbedding( connection_morphism );
            return PreCompose( kernel_hull_function( Source( kernel ) ), kernel );
        elif i < -1 then
            kernel := KernelEmbedding( Differential( z_functor, i + 1 ) );
            return PreCompose( kernel_hull_function( Source( kernel ) ), kernel );
        else
            return IdentityMorphism( ZeroObject( CapCategory( object ) ) );
        fi;
        
    end;
    
    z_functor!.object_func := object_function;
    z_functor!.differential_func := morphism_function;
    
    return [ complex, connection_morphism ];
    
end );

BindGlobal( "CAP_INTERNAL_HORSE_SHOE_HELPER",
  function( left_diff_i, right_diff_i, eps_prime, eps, eps_2prime, pi, iota )
    local ker_eps_prime, ker_eps, ker_eps_2prime, eps_prime_1_to_ker, eps_2prime_1_to_ker,
          iota0, pi0, ker_eps_prime_to_eps, ker_eps_to_eps_2prime, first_morphism, second_morphism,
          sum_morphism, differential_morphism, range_left_diff, range_right_diff;
    
    ker_eps_prime := KernelEmbedding( eps_prime );
    ker_eps := KernelEmbedding( eps );
    ker_eps_2prime := KernelEmbedding( eps_2prime );
    
    eps_prime_1_to_ker := KernelLift( eps_prime, left_diff_i );
    eps_2prime_1_to_ker := KernelLift( eps_2prime, right_diff_i );
    
    range_left_diff := Range( left_diff_i );
    range_right_diff := Range( right_diff_i );
    
    iota0 := InjectionOfCofactorOfDirectSum( [ range_left_diff, range_right_diff ], 1 );
    pi0 := ProjectionInFactorOfDirectSum( [ range_left_diff, range_right_diff ], 2 );
    
    ker_eps_prime_to_eps := KernelLift( eps, PreCompose( ker_eps_prime, iota0 ) );
    ker_eps_to_eps_2prime := KernelLift( eps_2prime , PreCompose( ker_eps, pi0 ) );
    
    first_morphism := PreCompose( eps_prime_1_to_ker, ker_eps_prime_to_eps );
    second_morphism := Lift( eps_2prime_1_to_ker, ker_eps_to_eps_2prime );
    
    sum_morphism := UniversalMorphismFromDirectSum( [ first_morphism, second_morphism ] );
    
    differential_morphism := PreCompose( sum_morphism, ker_eps );
    
    return differential_morphism;

end );

##
InstallMethod( HorseShoeLemma,
               [ IsCapCocomplex, IsCapCocomplex, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( left_complex, right_complex, eps_prime, iota, pi, eps_2prime )
    local middle_z_functor, middle_complex, kernel_resolution_morphism, cokernel_resolution_morphism, object_function,
          helper_function, morphism_function;
    
    middle_z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, CapCategory( eps_prime ) );
    middle_complex := AsCocomplex( middle_z_functor );
    
    kernel_resolution_morphism := function( i )
        
        return InjectionOfCofactorOfDirectSum( [ left_complex[ i ], right_complex[ i ] ], 1 );
        
    end;
    
    cokernel_resolution_morphism := function( i )
        
        return ProjectionInFactorOfDirectSum( [ left_complex[ i ], right_complex[ i ] ], 2 );
        
    end;
    
    kernel_resolution_morphism := CochainMap( left_complex, kernel_resolution_morphism, middle_complex );
    
    cokernel_resolution_morphism := CochainMap( middle_complex, cokernel_resolution_morphism, right_complex );
    
    object_function := function( i )
            return DirectSum( [ left_complex[ i ], right_complex[ i ] ] );
    end;
    
    morphism_function := function( i )
        local eps;
        
        if i > 0 then
            return IdentityMorphism( ZeroObject( CapCategory( eps_prime ) ) );
        fi;
        
        if i = 0 then
            return UniversalMorphismIntoZeroObject( middle_complex[ 0 ] );
        fi;
        
        if i = -1 then
            
            eps := Lift( eps_2prime, pi );
            eps := UniversalMorphismFromDirectSum( [ PreCompose( eps_prime, iota ), eps ] );
            
            return CAP_INTERNAL_HORSE_SHOE_HELPER( Differential( left_complex, -1 ),
                                                   Differential( right_complex, -1 ),
                                                   eps_prime, eps, eps_2prime, pi, iota );
            
        else
            
            return CAP_INTERNAL_HORSE_SHOE_HELPER( Differential( left_complex, i ),
                                                   Differential( right_complex, i ),
                                                   Differential( left_complex, i + 1 ),
                                                   Differential( middle_complex, i + 1 ),
                                                   Differential( right_complex, i + 1 ),
                                                   kernel_resolution_morphism[ i + 1 ],
                                                   cokernel_resolution_morphism[ i + 1 ] );
            
        fi;
        
    end;
    
    middle_z_functor!.object_func := object_function;
    middle_z_functor!.differential_func := morphism_function;
    
    return [ middle_complex, kernel_resolution_morphism, cokernel_resolution_morphism ];
    
end );

##
InstallMethod( CartanEilenbergResolution,
               [ IsCapCocomplex, IsFunction ],
               
  function( complex, projective_resolution_function )
    local object_function, morphism_function, bicomplex, helper_function, bicomplex_z_func;
    
    bicomplex_z_func := ZFunctorObject( ReturnTrue, ReturnTrue, CapCategory( complex ) );
    bicomplex := AsCocomplex( bicomplex_z_func );
    
    helper_function := function( i )
        local delta_im1, delta_i, first_morphism, second_morphism, first_complex,
              second_complex, horse_shoe, third_morphism, fourth_morphism, third_complex, second_horse_shoe,
              eps;
        
        delta_im1 := Differential( complex, i - 1 );
        delta_i := Differential( complex, i );
        
        first_morphism := KernelLift( delta_i, ImageEmbedding( delta_im1 ) );
        second_morphism := CokernelProjection( first_morphism );
        
        first_complex := projective_resolution_function( Source( first_morphism ) );
        
        second_complex := projective_resolution_function( Range( second_morphism ) );
        
        horse_shoe := HorseShoeLemma( first_complex[ 1 ], second_complex[ 1 ],
                                      first_complex[ 2 ],
                                      first_morphism, second_morphism,
                                      second_complex[ 2 ] );
        
        third_morphism := KernelEmbedding( delta_i );
        fourth_morphism := CoastrictionToImage( delta_i );
        
        eps := Lift( second_complex[ 2 ], second_morphism );
        eps := UniversalMorphismFromDirectSum( [ PreCompose( first_complex[ 2 ], first_morphism ), eps ] );
        
        third_complex := projective_resolution_function( Range( fourth_morphism ) );
        
        second_horse_shoe := HorseShoeLemma( horse_shoe[ 1 ], third_complex[ 1 ], eps, third_morphism, fourth_morphism, third_complex[ 2 ] );
        
        return [ horse_shoe, second_horse_shoe ];
        
    end;
    
    object_function := function( i )
      local those_boots, return_complex, old_diff_func, underlying_cell;
        
        those_boots := helper_function( i );
        
        return_complex := those_boots[ 2 ][ 1 ];
        
        if i mod 2 = 1 then
            underlying_cell := UnderlyingZFunctorCell( return_complex );
            old_diff_func := underlying_cell!.differential_func;
            underlying_cell!.differential_func := function( i ) return - old_diff_func( i ); end;
        fi;
        
        return return_complex;
        
    end;
    
    morphism_function := function( i )
      local those_boots1, those_boots2;
        
        those_boots1 := helper_function( i );
        those_boots2 := helper_function( i + 1 );
        
        return PreCompose( those_boots1[ 2 ][ 3 ], PreCompose( those_boots2[ 1 ][ 2 ], those_boots2[ 2 ][ 2 ] ) );
        
    end;
    
    bicomplex_z_func!.object_func := object_function;
    bicomplex_z_func!.differential_func := morphism_function;
    
    return bicomplex;
    
end );

InstallMethod( DualOnComplex,
               [ IsCapComplex ],
  
  function( complex )
    local object_func, morphism_func;
    
    object_func := i -> DualOnObjects( complex[ i ] );
    
    morphism_func := i -> DualOnMorphisms( Differential( complex, i + 1 ) );
    
    return AsCocomplex( ZFunctorObject( object_func, morphism_func, UnderlyingCategory( CapCategory( complex ) ) ) );
    
end );

InstallMethod( DualOnCocomplex,
               [ IsCapCocomplex ],
               
  function( cocomplex )
    local object_func, morphism_func, id_of_object;
    
    object_func := i -> DualOnObjects( cocomplex[ - i ] );
    
    morphism_func := i -> DualOnMorphisms( Differential( cocomplex, -i - 1 ) );
    
    return AsComplex( ZFunctorObject( object_func, morphism_func, UnderlyingCategory( CapCategory( cocomplex ) ) ) );
    
end );

InstallMethod( DualOnCochainMap,
               [ IsCapCochainMap, IsCapComplex, IsCapComplex ],
               
  function( cochain_map, new_source, new_range )
    local id_of_object, morphism_func;
    
    morphism_func := i -> DualOnMorphisms( cochain_map[ i ] );
    
    return ChainMap( new_source, morphism_func, new_range );
    
end );

InstallMethod( DualOnCocomplexCocomplex,
               [ IsCapCocomplex ],
               
  function( cocomplex )
    local object_func, morphism_func, id_of_object, new_complex, new_z_functor;
    
    new_z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, ComplexCategory( UnderlyingCategory( UnderlyingCategory( CapCategory( cocomplex ) )  ) ));
    new_complex := AsComplex( new_z_functor );
    
    object_func := i -> DualOnCocomplex( cocomplex[ - i ] );
    
    new_z_functor!.object_func := object_func;
    
    morphism_func := i -> DualOnCochainMap( Differential( cocomplex, -i - 1 ), new_complex[ i ], new_complex[ i - 1 ] );
    
    new_z_functor!.differential_func := morphism_func;
    
    return new_complex;
    
end );

InstallMethod( TransposeComplexOfComplex,
               [ IsCapComplex ],
               
  function( complex )
    local new_total_complex, new_z_functor, object_func, morphism_func;
    
    new_z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, UnderlyingCategory( CapCategory( complex ) ) );
    new_total_complex := AsComplex( new_z_functor );
    
    object_func := function( i )
      local object_func, morphism_func;
        
        object_func := function( j )
            
            return complex[ -j ][ -i ];
            
        end;
        
        morphism_func := function( j )
            
            return Differential( complex, -j )[ -i ];
            
        end;
        
        return AsComplex( ZFunctorObject( object_func, morphism_func, UnderlyingCategory( UnderlyingCategory( CapCategory( complex ) ) ) ) );
        
    end;
    
    morphism_func := function( i )
      local morphism_func;
        
        morphism_func := function( j )
            
            return Differential( complex[ j ], -i );
            
        end;
        
        return ChainMap( new_total_complex[ -i ], morphism_func, new_total_complex[ -i + 1 ] );
        
    end;
    
    new_z_functor!.object_func := object_func;
    new_z_functor!.differential_func := morphism_func;
    
    return new_total_complex;
    
end );

InstallMethod( ResolutionLength,
               [ IsCapComplex ],
               
  function( complex )
    local i;
    
    i := 0;
    
    while not IsZeroForObjects( complex[ i ] ) do
        i := i + 1;
    od;
    
    return i;
    
end );

## 4th quadrant complex, number of non-zero columns
InstallMethodWithCache( TotalComplexOfBicomplex,
               [ IsCapComplex, IsInt ],
               
  function( bicomplex, length )
    local object_function, morphism_function, z_functor_object, new_complex;
    
    z_functor_object := ZFunctorObject( ReturnTrue, ReturnTrue, UnderlyingCategory( UnderlyingCategory( CapCategory( bicomplex ) ) ) );
    new_complex := AsComplex( z_functor_object );
    
    morphism_function := function( i )
      local source_summands, range_summands, nr_range_summands, nr_source_summands,
            source_projections, range_injections, horizontal_morphisms, vertical_morphisms,
            end_horizontal, end_vertical;
        
        i := -i;
        
        nr_source_summands := length - i + 1;
        nr_range_summands := length - i + 1 + 1;
        
        source_summands := List( [ 0 .. length - i ], j -> bicomplex[ j + i ][ -j ] );
        range_summands := List( [ 0 .. length - i + 1 ], j -> bicomplex[ j + i - 1 ][ -j ] );
        
        source_projections := List( [ 1 .. nr_source_summands ], j -> ProjectionInFactorOfDirectSum( source_summands, j ) );
        range_injections := List( [ 1 .. nr_range_summands ], j -> InjectionOfCofactorOfDirectSum( range_summands, j ) );
        
        horizontal_morphisms := List( [ 0 .. length - i  ], j -> Differential( bicomplex, j + i )[ -j ] );
        vertical_morphisms := List( [ 0 .. length - i ], j -> Differential( bicomplex[ j + i ], -j ) );
        
        horizontal_morphisms := List( [ 1 .. Length( horizontal_morphisms ) ], j -> PreCompose( source_projections[ j ], horizontal_morphisms[ j ] ) );
        vertical_morphisms := List( [ 1 .. Length( vertical_morphisms ) ], j -> PreCompose( source_projections[ j ], vertical_morphisms[ j ] ) );
        
        horizontal_morphisms := List( [ 1 .. Length( horizontal_morphisms ) ], j -> PreCompose( horizontal_morphisms[ j ], range_injections[ j ] ) );
        vertical_morphisms := List( [ 1 .. Length( vertical_morphisms ) ], j -> PreCompose( vertical_morphisms[ j ], range_injections[ j + 1 ] ) );
        
        end_horizontal := Sum( horizontal_morphisms );
        end_vertical := Sum( vertical_morphisms );
        
        return end_horizontal + end_vertical;
        
    end;
    
    object_function := function( i )
        
        i := - i;
        
        return DirectSum( List( [ 0 .. length - i ], j -> bicomplex[ j + i ][ -j ] ) );
        
    end;
    
    z_functor_object!.differential_func := morphism_function;
    z_functor_object!.object_func := object_function;
    
    return new_complex;
    
end );

InstallMethodWithCache( EmbeddingInObjectOfTotalComplex,
                        [ IsCapComplex, IsInt, IsInt, IsInt ],
               
  function( bicomplex, length, position, embedding_number )
    local object_list;
    
    object_list := List( [ 0 .. length - position ], j -> bicomplex[ j + position ][ -j ] );
    
    return InjectionOfCofactorOfDirectSum( object_list, embedding_number );
    
end );

# InstallMethod( ProjectionOfObjectOfTotalComplex,
#                [ IsCapComplex, IsInt, IsInt, IsInt ],
#                
#   function( bicomplex, length, position, embedding_number )
#     local object_list;
#     
#     object_list := List( [ 0 .. length - position ], j -> bicomplex[ j + position ][ -j ] );
#     
#     return ProjectionInFactorOfDirectSum( object_list, embedding_number );
#     
# end );

InstallMethodWithCache( ConnectingMorphismFromCocomplexToCartanEilenbergResolution,
                        [ IsCapCocomplex, IsInt, IsFunction ],
               
  function( cocomplex, position, projective_resolution_function )
    local delta_im1, delta_i, first_morphism, second_morphism, first_complex,
          second_complex, third_morphism, third_complex, fourth_morphism, eps, eps2;
    
    delta_im1 := Differential( cocomplex, position - 1 );
    delta_i := Differential( cocomplex, position );
    
    first_morphism := KernelLift( delta_i, ImageEmbedding( delta_im1 ) );
    second_morphism := CokernelProjection( first_morphism );
    
    first_complex := projective_resolution_function( Source( first_morphism ) );
    
    second_complex := projective_resolution_function( Range( second_morphism ) );
    
    third_morphism := KernelEmbedding( delta_i );
    fourth_morphism := CoastrictionToImage( delta_i );
    
    eps := Lift( second_complex[ 2 ], second_morphism );
    eps := UniversalMorphismFromDirectSum( [ PreCompose( first_complex[ 2 ], first_morphism ), eps ] );
    
    third_complex := projective_resolution_function( Range( fourth_morphism ) );
    
    eps2 := Lift( third_complex[ 2 ], fourth_morphism );
    eps2 := UniversalMorphismFromDirectSum( [ PreCompose( eps, third_morphism ), eps2 ] );
    
    return eps2;
    
end );

InstallMethodWithCache( GeneralizedEmbeddingOfHomology,
                        [ IsCapComplex, IsInt ],
               
  function( complex, i )
    local differential_i, differential_ip1, image_embedding, kernel_lift,
          map_to_homology, kernel_emb;
    
    differential_i := Differential( complex, i );
    differential_ip1 := Differential( complex, i + 1 );
    
    image_embedding := ImageEmbedding( differential_ip1 );
    kernel_lift := KernelLift( differential_i, image_embedding );
    
    map_to_homology := CokernelProjection( kernel_lift );
    kernel_emb := KernelEmbedding( differential_i );
    
    return GeneralizedMorphismWithSourceAid( map_to_homology, kernel_emb );
    
end );

InstallMethodWithCache( GeneralizedMorphismBetweenHomologies,
                        [ IsCapComplex, IsCapComplex, IsCapCategoryMorphism, IsInt ],
               
  function( source_complex, range_complex, connecting_morphism, i )
    local source_embedding, range_embedding, generalized_connection;
    
    source_embedding := GeneralizedEmbeddingOfHomology( source_complex, i );
    range_embedding := GeneralizedEmbeddingOfHomology( range_complex, i );
    
    generalized_connection := AsGeneralizedMorphism( connecting_morphism );
    
    return PreCompose( PreCompose( source_embedding, generalized_connection ), PseudoInverse( range_embedding ) );
    
end );

InstallMethod( GeneralizedEmbeddingOfSpectralSequenceEntry,
               [ IsCapComplex, IsInt, IsInt, IsCapComplex, IsCapCocomplex, IsCapCategoryMorphism ], 
  
  function( trhomCE, diag_number, page, homCE, homres, connection_mor )
    local homhomres, resolution_len, tot, connection_at_0, connection_at_1, homcon_at_0, homcon_at_1,
          emb0, emb1, homcon_at_0_in_tot, homcon_at_1_in_tot, homology_iso, M_as_homology,
          M_to_M_as_homology, M_to_hom_of_tot, entry, homology_proj_of_tot, emb01;
    
    homhomres := DualOnCocomplex( homres );
    
    resolution_len := ResolutionLength( homhomres );

    tot := TotalComplexOfBicomplex( homCE, resolution_len );

    connection_at_0 := ConnectingMorphismFromCocomplexToCartanEilenbergResolution( homres, 0, FreeResolutionCocomplex );
    connection_at_1 := ConnectingMorphismFromCocomplexToCartanEilenbergResolution( homres, 1, FreeResolutionCocomplex );

    homcon_at_0 := DualOnMorphisms( connection_at_0 );
    homcon_at_1 := DualOnMorphisms( connection_at_1 );

    emb0 := EmbeddingInObjectOfTotalComplex( homCE, resolution_len, 0, 1 );
    emb1 := EmbeddingInObjectOfTotalComplex( homCE, resolution_len, 1, 1 );

    homcon_at_0_in_tot := PreCompose( homcon_at_0, emb0 );
    homcon_at_1_in_tot := PreCompose( homcon_at_1, emb1 );

    homology_iso := GeneralizedMorphismBetweenHomologies( homhomres, tot, homcon_at_0_in_tot, 0 );

    homology_iso := HonestRepresentative( homology_iso );

    M_as_homology := HonestRepresentative( PseudoInverse( GeneralizedEmbeddingOfHomology( homhomres, 0 ) ) );

    M_to_M_as_homology := ColiftAlongEpimorphism( connection_mor, M_as_homology );

    M_to_hom_of_tot := PreCompose( M_to_M_as_homology, homology_iso );

    entry := SpectralSequenceEntry( trhomCE, page, -diag_number, diag_number );

    homology_proj_of_tot := PseudoInverse( GeneralizedEmbeddingOfHomology( tot, 0 ) );

    emb01 := EmbeddingInObjectOfTotalComplex( homCE, resolution_len, 0, diag_number + 1 );

    return PreCompose( PreCompose( PreCompose( entry, AsGeneralizedMorphism( emb01 ) ), homology_proj_of_tot ), AsGeneralizedMorphism( Inverse( M_to_hom_of_tot ) ) );
    
end );
  
InstallMethod( PurityFiltrationBySpectralSequence,
               [ IsCapComplex, IsInt, IsCapComplex, IsCapCocomplex, IsCapCategoryMorphism ],
               
  function( trhomCE, page, homCE, homres, connection_mor )
    local homhomres, resolution_len, embedding_list, combined_image_embeddings,
          pi_list, functors, i, mp, nu, mp_mat, eta_0, iota_i, eta, kappa, rho, iso, iso_inv;
    
    homhomres := DualOnCocomplex( homres );
    
    resolution_len := ResolutionLength( homhomres );
    
    embedding_list := List( [ 0 .. resolution_len ], i -> GeneralizedEmbeddingOfSpectralSequenceEntry( trhomCE, i, page, homCE, homres, connection_mor ) );
    
    Print( "Computed embeddings\n" );
    
    for i in Reversed( [ 1 .. Length( embedding_list ) ] ) do
        if IsZeroForObjects( UnderlyingHonestObject( Source( embedding_list[ i ] ) ) ) then
            Print( "found a zero\n" );
            Remove( embedding_list, i );
        fi;
    od;
    
    Print( "Removed irrelevant embeddings" );
    
    embedding_list := Reversed( embedding_list );
    
    combined_image_embeddings := List( embedding_list, GeneralizedImageEmbedding );
    
    functors := ValueOption( "Functors" );
    if functors <> fail then
        for i in functors do
            combined_image_embeddings := List( combined_image_embeddings, j -> PreCompose( Inverse( ApplyNaturalTransformation( i, Source( j ) ) ), j ) );
        od;
    fi;
    
    Print( "First functors applied\n" );
    
    pi_list := List( [ 2 .. Length( embedding_list ) ], i -> PreCompose( AsGeneralizedMorphism( combined_image_embeddings[ i ] ), 
                                                                         PseudoInverse( embedding_list[ i ] ) ) );
    
    pi_list := List( pi_list, HonestRepresentative );
    
    if functors <> fail then
        for i in functors do
            pi_list := List( pi_list, j -> PreCompose( j, ApplyNaturalTransformation( i, Range( j ) ) ) );
        od;
    fi;
    
    Print( "second functors applied\n" );
    
    ## inital_step
    
    for i in [ 2 .. Length( combined_image_embeddings ) ] do
        
        nu := CoverByProjective( Range( pi_list[ i - 1 ] ) );
        
        eta_0 := Lift( nu, pi_list[ i - 1] );
        
        mp_mat := KernelEmbedding( nu );
        
        iota_i := LiftAlongMonomorphism( combined_image_embeddings[ i ], combined_image_embeddings[ i - 1 ] );
        
        eta := Lift( PreCompose( mp_mat, eta_0 ), iota_i );
        
        kappa := UniversalMorphismIntoDirectSum( mp_mat, eta );
        
        rho := UniversalMorphismFromDirectSum( -eta_0, iota_i );
        
        ## from new to old
        iso := CokernelColift( kappa, rho );
        
        combined_image_embeddings[ i ] := PreCompose( iso, combined_image_embeddings[ i ] );
        
    od;
    
    return combined_image_embeddings[ Length( combined_image_embeddings ) ];
    
end );

##
InstallMethod( FunctorGradedDualLeft,
                [ IsHomalgGradedRing ], 
   function( ring )
     local category, functor;
     
     category := GradedLeftPresentations( ring );
     
     functor := CapFunctor( Concatenation( "Hom(-,R) functor for ", Name( category ) ), Opposite( category ), category );
     
     AddObjectFunction( functor, 
     
        function( obj )
        local object, mat, N, M, mor; 
        
        object := Opposite( obj );
        
        mat := UnderlyingMatrix( UnderlyingPresentationObject( object ) );
           
        N := GradedFreeLeftPresentation( NrColumns( mat ), ring, -GeneratorDegrees( object ) );
           
        M := GradedFreeLeftPresentation( NrRows( mat ), ring, -NonTrivialDegreePerRow( mat, GeneratorDegrees( object ) ) );
           
        mor := GradedPresentationMorphism( N, Involution( mat ), M );
           
        return KernelObject( mor );
           
        end );
           
    AddMorphismFunction( functor, 
    
        function( new_source, morphism_, new_range )
        local morphism, matrix_of_morphism, mor1, mor2, mor, mor3, matrix_of_the_source, matrix_of_the_range, g;
           
        morphism := Opposite( morphism_ );
        
        matrix_of_morphism := UnderlyingMatrix( UnderlyingPresentationMorphism( morphism ) );
           
           
        mor2 := GradedPresentationMorphism( 
                    GradedFreeLeftPresentation( NrColumns( matrix_of_morphism ), ring, -GeneratorDegrees( Range( morphism ) ) ),
                    Involution( matrix_of_morphism ), 
                    GradedFreeLeftPresentation( NrRows( matrix_of_morphism ), ring, -GeneratorDegrees( Source( morphism ) ) ) );
        
        matrix_of_the_range := UnderlyingMatrix( UnderlyingPresentationObject( Range( morphism ) ) );
        
        g := GradedPresentationMorphism( 
                    GradedFreeLeftPresentation( NrColumns( matrix_of_the_range ), ring, -GeneratorDegrees( Range( morphism ) ) ),
                    Involution( matrix_of_the_range ), 
                    GradedFreeLeftPresentation( NrRows( matrix_of_the_range ), ring, 
                                    -NonTrivialDegreePerRow( matrix_of_the_range, GeneratorDegrees( Range( morphism ) ) ) ) );
                                    
        mor1 := KernelEmbedding( g );
           
        mor := PreCompose( mor1, mor2 );
           
        matrix_of_the_source := UnderlyingMatrix( Source( morphism ) );
           
        mor3 := GradedPresentationMorphism( 
                    GradedFreeLeftPresentation( NrColumns( matrix_of_the_source ), ring, -GeneratorDegrees( Source( morphism ) ) ),
                    Involution( matrix_of_the_source ), 
                    GradedFreeLeftPresentation( NrRows( matrix_of_the_source ), ring, 
                                    -NonTrivialDegreePerRow( matrix_of_the_source, GeneratorDegrees( Source( morphism ) ) ) ) );
            
        return KernelLift( mor3, mor );
           
        end );
           
   return functor;
   
end );

##
InstallMethod( FunctorGradedDualRight,
                 [ IsHomalgGradedRing ], 
    function( ring )
      local category, functor;
      
      category := GradedRightPresentations( ring );
      
      functor := CapFunctor( Concatenation( "Hom(-,R) functor for ", Name( category ) ), Opposite( category ), category );
      
      AddObjectFunction( functor, 
      
            function( obj )
            local object, mat, N, M, mor; 
            
            object := Opposite( obj );
            
            mat := UnderlyingMatrix( UnderlyingPresentationObject( object ) );
            
            N := GradedFreeRightPresentation( NrRows( mat ), ring, -GeneratorDegrees( object ) );
            
            M := GradedFreeRightPresentation( NrColumns( mat ), ring, -NonTrivialDegreePerColumn( mat, GeneratorDegrees( object ) ) );
            
            mor := GradedPresentationMorphism( N, Involution( mat ), M );
            
            return KernelObject( mor );
            
            end );
            
     AddMorphismFunction( functor, 
     
            function( new_source, morphism_, new_range )
            local morphism, matrix_of_morphism, mor1, mor2, mor, mor3, matrix_of_the_source, matrix_of_the_range, g;
            
            morphism := Opposite( morphism_ );
            
            matrix_of_morphism := UnderlyingMatrix( UnderlyingPresentationMorphism( morphism ) );
            
            mor2 := GradedPresentationMorphism( GradedFreeRightPresentation( NrRows( matrix_of_morphism ), ring, -GeneratorDegrees( Range( morphism ) ) )
                                          , Involution( matrix_of_morphism ), 
                                            GradedFreeRightPresentation( NrColumns( matrix_of_morphism ), ring, -GeneratorDegrees( Source( morphism ) ) ) );
            
            matrix_of_the_range := UnderlyingMatrix( UnderlyingPresentationObject( Range( morphism ) ) );
            
            g := GradedPresentationMorphism( GradedFreeRightPresentation( NrRows( matrix_of_the_range ), ring, -GeneratorDegrees( Range( morphism )))
                                          , Involution( matrix_of_the_range ), 
                 GradedFreeRightPresentation( NrColumns( matrix_of_the_range ), ring, 
                                            -NonTrivialDegreePerColumn( matrix_of_the_range, GeneratorDegrees( Range( morphism ) ) ) ) ); 
            
            mor1 := KernelEmbedding( g );
            
            mor := PreCompose( mor1, mor2 );
            
            matrix_of_the_source := UnderlyingMatrix( Source( morphism ) );
            
            mor3 := GradedPresentationMorphism( GradedFreeRightPresentation( NrRows( matrix_of_the_source ), ring, -GeneratorDegrees( Source( morphism ) ) )
                                          , Involution( matrix_of_the_source ), 
                    GradedFreeRightPresentation( NrColumns( matrix_of_the_source ), ring, 
                                            -NonTrivialDegreePerColumn( matrix_of_the_source, GeneratorDegrees( Source( morphism ) ) ) ) );
             
            return KernelLift( mor3, mor );
            
            end );
            
    return functor;
    
end );
 

###
InstallMethod( FunctorDoubleGradedDualLeft,
                 [ IsHomalgGradedRing ], 
    function( ring )
      local category, functor, dual_functor;
      
      category := GradedLeftPresentations( ring );
      
      functor := CapFunctor( Concatenation( "Hom(Hom(-,R),R) functor for ", Name( category ) ), category, category );
      
      dual_functor := FunctorGradedDualLeft( ring );
     
      AddObjectFunction( functor, 
      
            function( object )
            
              return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( object ) ) ) );
              
            end );
            
     AddMorphismFunction( functor, 
     
            function( new_source, morphism, new_range )
            
              return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( morphism ) ) ) );
            
            end );
            
    return functor;
    
 end );

 
##
InstallMethod( FunctorDoubleGradedDualRight,
                 [ IsHomalgGradedRing ], 
    function( ring )
      local category, functor, dual_functor;
      
      category := GradedRightPresentations( ring );
      
      functor := CapFunctor( Concatenation( "Hom(Hom(-,R),R) functor for ", Name( category ) ), category, category );
      
      dual_functor := FunctorGradedDualRight( ring );
     
      AddObjectFunction( functor, 
      
            function( object )
            
              return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( object ) ) ) );
              
            end );
            
     AddMorphismFunction( functor, 
     
            function( new_source, morphism, new_range )
            
              return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( morphism ) ) ) );
            
            end );
            
    return functor;
    
end );