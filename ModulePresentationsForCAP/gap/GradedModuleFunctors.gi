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

InstallMethod( FreeResolutionComplexOfModule,
               [ IsCapCategoryObject ],
               
  function( module )
    return ResolutionTo( module, CoverByFreeModule, true );
end );

InstallMethod( FreeResolutionCocomplexOfModule,
               [ IsCapCategoryObject ],
               
  function( module )
    return ResolutionTo( module, CoverByFreeModule, false );
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
  function( left_diff_i, right_diff_i, eps_prime, eps, eps_2prime, pi, iota, i )
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

InstallMethod( InternalHomOnComplexWithObject,
               [ IsCapComplex, IsCapCategoryObject ],
  
  function( complex, object )
    local object_func, morphism_func, id_of_object;
    
    id_of_object := IdentityMorphism( object );
    
    object_func := i -> InternalHomOnObjects( complex[ i ], object );
    
    morphism_func := i -> InternalHomOnMorphisms( Differential( complex, i + 1 ), id_of_object );
    
    return AsCocomplex( ZFunctorObject( object_func, morphism_func, CapCategory( object ) ) );
    
end );

InstallMethod( InternalHomOnCocomplexWithObject,
               [ IsCapCocomplex, IsCapCategoryObject ],
               
  function( cocomplex, object )
    local object_func, morphism_func, id_of_object;
    
    id_of_object := IdentityMorphism( object );
    
    object_func := i -> InternalHomOnObjects( cocomplex[ - i ], object );
    
    morphism_func := i -> InternalHomOnMorphisms( Differential( cocomplex, -i - 1 ), id_of_object );
    
    return AsComplex( ZFunctorObject( object_func, morphism_func, CapCategory( object ) ) );
    
end );

InstallMethod( InternalHomOnCochainMapWithObject,
               [ IsCapCochainMap, IsCapComplex, IsCapComplex, IsCapCategoryObject ],
               
  function( cochain_map, new_source, new_range, object )
    local id_of_object, morphism_func;
    
    id_of_object := IdentityMorphism( object );
    
    morphism_func := i -> InternalHomOnMorphisms( cochain_map[ i ], id_of_object );
    
    return ChainMap( new_source, morphism_func, new_range );
    
end );

InstallMethod( InternalHomOnCocomplexCocomplexWithObject,
               [ IsCapCocomplex, IsCapCategoryObject ],
               
  function( cocomplex, object )
    local object_func, morphism_func, id_of_object, new_complex, new_z_functor;
    
    new_z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, ComplexCategory( CapCategory( object ) ) );
    new_complex := AsComplex( new_z_functor );
    
    object_func := i -> InternalHomOnCocomplexWithObject( cocomplex[ - i ], object );
    
    new_z_functor!.object_func := object_func;
    
    morphism_func := i -> InternalHomOnCochainMapWithObject( Differential( cocomplex, -i - 1 ), new_complex[ i ], new_complex[ i - 1 ], object );
    
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

