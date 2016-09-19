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
                        [ IsCapCategory, IsFunction ],
                        
  function( source_category, kernel_hull_function )
    local functor, object_function, morphism_function, recursion_function;
    
    functor := CapFunctor( Concatenation( "ResolutionFunctor for ", Name( source_category ) ), source_category, ComplexCategory( source_category ) );
    
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
        
        return AsComplex( z_functor );
        
    end;
    
    AddObjectFunction( functor, object_function );
    
    return functor;
    
end );

##
InstallMethod( HorseShoeLemma,
               [ IsCapComplex, IsCapComplex, IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( kernel_resolution, cokernel_resolution, kernel_morphism, cokernel_morphism )
    local resolution_complex, kernel_resolution_morphism, cokernel_resolution_morphism;
    
    resolution_complex := DirectSum( kernel_resolution, cokernel_resolution );
    
    kernel_resolution_morphism := function( i )
        
        return InjectionOfCofactorOfDirectSum( [ kernel_resolution[ i ], cokernel_resolution[ i ] ], 1 );
        
    end;
    
    cokernel_resolution_morphism := function( i )
        
        return ProjectionInFactorOfDirectSum( [ kernel_resolution[ i ], cokernel_resolution[ i ] ], 2 );
        
    end;
    
    kernel_resolution_morphism := ChainMap( kernel_resolution, kernel_resolution_morphism, resolution_complex );
    
    cokernel_resolution_morphism := ChainMap( resolution_complex, cokernel_resolution_morphism, cokernel_resolution );
    
    return [ resolution_complex, kernel_resolution_morphism, cokernel_resolution_morphism ];
    
end );

##
InstallMethod( CartanEilenbergResolution,
               [ IsCapComplex, IsCapFunctor ],
               
  function( complex, projective_resolution_functor )
    local object_function, morphism_function, bicomplex, helper_function;
    
    helper_function := function( i )
        local delta_ip1, delta_i, first_morphism, second_morphism, first_complex,
              second_complex, horse_shoe, third_morphism, fourth_morphism, third_complex, second_horse_shoe;
        
        delta_ip1 := Differential( complex, i + 1 );
        delta_i := Differential( complex, i );
        
        first_morphism := KernelLift( delta_i, ImageEmbedding( delta_ip1 ) );
        second_morphism := PreCompose( KernelEmbedding( delta_i ), CokernelProjection( delta_ip1 ) );
        
        first_complex := ApplyFunctor( projective_resolution_functor, Source( first_morphism ) );
        second_complex := ApplyFunctor( projective_resolution_functor, Range( second_morphism ) );
        
        horse_shoe := HorseShoeLemma( first_complex, second_complex, first_morphism, second_morphism );
        
        third_morphism := KernelEmbedding( delta_i );
        fourth_morphism := CoastrictionToImage( delta_i );
        
        third_complex := ApplyFunctor( projective_resolution_functor, Range( fourth_morphism ) );
        
        second_horse_shoe := HorseShoeLemma( horse_shoe[ 1 ], third_complex, third_morphism, fourth_morphism );
        
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
        
        those_boots1 := helper_function( i + 1 );
        those_boots2 := helper_function( i );
        
        return PreCompose( those_boots2[ 2 ][ 3 ], PreCompose( those_boots1[ 1 ][ 1 ], those_boots1[ 2 ][ 1 ] ) );
        
    end;
    
    bicomplex := ZFunctorObject( i -> object_function( - i ), i -> morphism_function( - i ), CapCategory( complex ) );
    
    return AsComplex( bicomplex );
    
end );

