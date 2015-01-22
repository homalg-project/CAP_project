#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsZFunctorObjectRep",
                       IsCapCategoryObjectRep and IsZFunctorObject,
                       [ ] );

BindGlobal( "TheTypeOfZFunctorObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsZFunctorObjectRep ) );

DeclareRepresentation( "IsZFunctorMorphismRep",
                       IsCapCategoryMorphismRep and IsZFunctorMorphism,
                       [ ] );

BindGlobal( "TheTypeOfZFunctorMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsZFunctorMorphismRep ) );

#############################
##
## Attributes
##
#############################

InstallMethod( ZFunctorCategory,
               [ IsCapCategory ],
               
  function( category )
    local name, z_functor_category;
    
    name := Name( category );
    
    name := Concatenation( "Functors from integers into ", name );
    
    z_functor_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( z_functor_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_ZFUNCTOR_CATEGORY( category );
    
    return z_functor_category;
    
end );

#############################
##
## Getter
##
############################
##
## No setter are installed:
## All differentials and objects of a ZFunctor are determined
## after its construction. Thus, they should behave
## like an infinite family of attributes. But the user is not supposed to
## set attributes manually in order to construct an object.
## For example: Z := ZeroObject( ZFunctorCategory( ) ) must not be
## seen as a "dummy" object for which I can set Z[i] arbitrarily,
## for Z already knows that it is a zero object.

InstallMethod( \[\],
               [ IsZFunctorObject, IsInt ],
               
  function( object, index )
    local object_weak_pointer_list, list_index, part;
    
    if index > 0 then
        
        object_weak_pointer_list := object!.objects_positive;
        
        list_index := index;
        
    else
        
        object_weak_pointer_list := object!.objects_nonpositive;
        
        list_index := -index + 1;
        
    fi;
      
    if IsBoundElmWPObj( object_weak_pointer_list, list_index ) then
        
        return ElmWPObj( object_weak_pointer_list, list_index );
        
    fi;
  
    part := object!.object_func( index );
    
    SetElmWPObj( object_weak_pointer_list, list_index, part );
    
    return part;
    
end );

InstallMethod( Differential,
               [ IsZFunctorObject, IsInt ],
               
  function( object, index )
    local differential_weak_pointer_list, list_index, part;
    
    if index > 0 then
        
        differential_weak_pointer_list := object!.differentials_positive;
        
        list_index := index;
        
    else
        
        differential_weak_pointer_list := object!.differentials_nonpositive;
        
        list_index := -index + 1;
        
    fi;
      
    if IsBoundElmWPObj( differential_weak_pointer_list, list_index ) then
        
        return ElmWPObj( differential_weak_pointer_list, list_index );
        
    fi;
  
    part := object!.differential_func( index );
    
    SetElmWPObj( differential_weak_pointer_list, list_index, part );
    
    return part;
    
end );

InstallMethod( \[\],
               [ IsZFunctorMorphism, IsInt ],
               
  function( morphism, index )
    local morphisms_weak_pointer_list, list_index, part;
    
    if index > 0 then
        
        morphisms_weak_pointer_list := morphism!.morphisms_positive;
        
        list_index := index;
        
    else
        
        morphisms_weak_pointer_list := morphism!.morphisms_nonpositive;
        
        list_index := -index + 1;
        
    fi;
      
    if IsBoundElmWPObj( morphisms_weak_pointer_list, list_index ) then
        
        return ElmWPObj( morphisms_weak_pointer_list, list_index );
        
    fi;
  
    part := morphism!.morphism_func( index );
    
    SetElmWPObj( morphisms_weak_pointer_list, list_index, part );
    
    return part;
    
end );

#############################
##
## Add functions
##
#############################

## PreCompose
##
BindGlobal( "ADD_PRECOMPOSE_IN_Z_FUNCTORS",
        
  function( category )
      local morphism_func, precompose_mor;
      
      AddPreCompose( ZFunctorCategory( category ),
          
          function( mor_left, mor_right )
              
              morphism_func := function( index )
                  
                  return PreCompose( mor_left[ index ], mor_right[ index ] );
                  
              end;
              
              precompose_mor := ZFunctorMorphism( Source( mor_left ), morphism_func, Range( mor_right ) );
              
              return precompose_mor;
              
      end );
  end );

## Identity
##
BindGlobal( "ADD_IDENTITY_MORPHISM_IN_Z_FUNCTORS",
          
  function( category )
      local morphism_func, identity_mor;
      
      AddIdentityMorphism( ZFunctorCategory( category ),
          
          function( object )
              
              morphism_func := function( index )
                  
                  return IdentityMorphism( object[ index ] );
                  
              end;
              
              identity_mor := ZFunctorMorphism( object, morphism_func, object );
              
              return identity_mor;
              
      end );
  end );

## Inverse
##
BindGlobal( "ADD_INVERSE_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, inverse;
    
    AddInverse( ZFunctorCategory( category ),
        
        function( isomorphism )
            
            morphism_func := function( index )
                
                return Inverse( isomorphism[ index ] );
                
            end;
            
            inverse := ZFunctorMorphism( Range( isomorphism ), morphism_func, Source( isomorphism ) );
            
            return inverse;
            
    end );
  end );

## MonoAsKernelLift
##
BindGlobal( "ADD_MONO_AS_KERNEL_LIFT_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, mono_as_kernel_lift;
    
    AddMonoAsKernelLift( ZFunctorCategory( category ),
                         
      function( monomorphism, test_morphism )
        
        morphism_func := function( index ) return MonoAsKernelLift( monomorphism[ index ], test_morphism[ index ] );
        
      end;
      
      mono_as_kernel_lift := ZFunctorMorphism( Source( test_morphism ), morphism_func, Source( monomorphism ) );
      
      return mono_as_kernel_lift;
        
    end );
  end );

## EpiAsCokernelColift
##
BindGlobal( "ADD_EPI_AS_COKERNEL_COLIFT_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, epi_as_cokernel_colift;
    
    AddEpiAsCokernelColift( ZFunctorCategory( category ),
                         
      function( epimorphism, test_morphism )
        
        morphism_func := function( index ) return EpiAsCokernelColift( epimorphism[ index ], test_morphism[ index ] );
        
      end;
      
      epi_as_cokernel_colift := ZFunctorMorphism( Range( epimorphism ), morphism_func, Range( test_morphism ) );
      
      return epi_as_cokernel_colift;
        
    end );
  end );

## KernelObject
##
BindGlobal( "ADD_KERNEL_OBJECT_IN_Z_FUNCTORS",
          
  function( category )
      local object_func, differential_func, kernel_object;

      AddKernelObject( ZFunctorCategory( category ),
        
        function( morphism )
          
          object_func := function( index )
              
              return KernelObject( morphism[ index ] );
              
          end;
          
          differential_func := function( index )
              local cohomological_index;
              
              cohomological_index := index + 1;
              
              return KernelObjectFunctorial(
                
                morphism[ index ],
                Differential( Source( morphism ), index ),
                morphism[ cohomological_index ]
                
              );
              
          end;
          
          kernel_object := ZFunctorObject( object_func, differential_func, category );
          
          return kernel_object;
          
      end );
      
end );

## KernelEmbWithGivenKernel
BindGlobal( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, kernel_emb;

      AddKernelEmbWithGivenKernel( ZFunctorCategory( category ),
        
        function( morphism, kernel )
          
          morphism_func := function( index )
              
              return KernelEmb( morphism[ index ] );
              
          end;
          
          kernel_emb := ZFunctorMorphism( kernel, morphism_func, Source( morphism ) );
          
          return kernel_emb;
          
      end );
end );

## KernelLiftWithGivenKernel
BindGlobal( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, kernel_lift;

      AddKernelLiftWithGivenKernel( ZFunctorCategory( category ),
        
        function( morphism, test_morphism, kernel )
          
          morphism_func := function( index )
              
              return KernelLift( morphism[ index ], test_morphism[ index ] );
              
          end;
          
          kernel_lift := ZFunctorMorphism( Source( test_morphism ), morphism_func, kernel );
          
          return kernel_lift;
          
      end );
end );

## Cokernel
##
BindGlobal( "ADD_COKERNEL_IN_Z_FUNCTORS",
          
  function( category )
      local object_func, differential_func, cokernel_object;

      AddCokernel( ZFunctorCategory( category ),
        
        function( morphism )
          
          object_func := function( index )
              
              return Cokernel( morphism[ index ] );
              
          end;
          
          differential_func := function( index )
              local cohomological_index;
              
              cohomological_index := index + 1;
              
              return CokernelFunctorial(
                
                morphism[ index ],
                Differential( Range( morphism ), index ),
                morphism[ cohomological_index ]
                
              );
              
          end;
          
          cokernel_object := ZFunctorObject( object_func, differential_func, category );
          
          return cokernel_object;
          
      end );
      
end );

## CokernelProjWithGivenCokernel
BindGlobal( "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, cokernel_proj;

      AddCokernelProjWithGivenCokernel( ZFunctorCategory( category ),
        
        function( morphism, cokernel )
          
          morphism_func := function( index )
              
              return CokernelProj( morphism[ index ] );
              
          end;
          
          cokernel_proj := ZFunctorMorphism( Range( morphism ), morphism_func, cokernel );
          
          return cokernel_proj;
          
      end );
end );

## CokernelColiftWithGivenCokernel
BindGlobal( "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, cokernel_colift;

      AddCokernelColiftWithGivenCokernel( ZFunctorCategory( category ),
        
        function( morphism, test_morphism, cokernel )
          
          morphism_func := function( index )
              
              return CokernelColift( morphism[ index ], test_morphism[ index ] );
              
          end;
          
          cokernel_colift := ZFunctorMorphism( cokernel, morphism_func, Range( test_morphism ) );
          
          return cokernel_colift;
          
      end );
end );

## Zero Object
##
BindGlobal( "ADD_ZERO_OBJECT_IN_Z_FUNCTORS",
            
  function( category )
    local object_func, differential_func, zero_object;
    
    AddZeroObject( ZFunctorCategory( category ),
      
      function( )
        
        object_func := function( index ) return ZeroObject( category ); end;
        
        differential_func := function( index ) return IdentityMorphism( ZeroObject( category ) ); end;
        
        zero_object := ZFunctorObject( object_func, differential_func, category );
        
        return zero_object;
        
    end );
    
end );

## Terminal object
##
BindGlobal( "ADD_TERMINAL_OBJECT_IN_Z_FUNCTORS",
            
  function( category )
    local object_func, differential_func, terminal_object;
    
    AddTerminalObject( ZFunctorCategory( category ),
      
      function( )
        
        object_func := function( index ) return TerminalObject( category ); end;
        
        differential_func := function( index ) return TerminalObjectFunctorial( category ); end;
        
        terminal_object := ZFunctorObject( object_func, differential_func, category );
        
        return terminal_object;
        
    end );
    
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, universal_morphism;
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( ZFunctorCategory( category ),
      
      function( object, terminal_object )
        
        morphism_func := function( index ) return UniversalMorphismIntoTerminalObject( object[ index ] ); end;
        
        universal_morphism := ZFunctorMorphism( object, morphism_func, terminal_object );
        
        return universal_morphism;
        
    end );
    
end );

## Initial object
##
BindGlobal( "ADD_INITIAL_OBJECT_IN_Z_FUNCTORS",
            
  function( category )
    local object_func, differential_func, initial_object;
    
    AddInitialObject( ZFunctorCategory( category ),
      
      function( )
        
        object_func := function( index ) return InitialObject( category ); end;
        
        differential_func := function( index ) return InitialObjectFunctorial( category ); end;
        
        initial_object := ZFunctorObject( object_func, differential_func, category );
        
        return initial_object;
        
    end );
    
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, universal_morphism;
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( ZFunctorCategory( category ),
      
      function( object, initial_object )
        
        morphism_func := function( index ) return UniversalMorphismFromInitialObject( object[ index ] ); end;
        
        universal_morphism := ZFunctorMorphism( initial_object, morphism_func, object );
        
        return universal_morphism;
        
    end );
    
end );

## Direct product
##
BindGlobal( "ADD_DIRECT_PRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local object_func, differential_func, direct_product_object;
      
      AddDirectProduct( ZFunctorCategory( category ),
        
        function( object_list )
            
            object_func := function( index ) return DirectProduct( List( object_list, obj -> obj[ index ] ) ); end;
            
            differential_func := function( index ) return DirectProductFunctorial( List( object_list, obj -> Differential( obj, index ) ) ); end;
            
            direct_product_object := ZFunctorObject( object_func, differential_func, category );
            
            return direct_product_object;
            
      end );
end );

##
BindGlobal( "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, projection;
      
      AddProjectionInFactorOfDirectProductWithGivenDirectProduct( ZFunctorCategory( category ),
        
        function( object_list, projection_number, direct_product )
          
          differential_func := function( index )
            
            return ProjectionInFactorOfDirectProduct( List( object_list, obj-> obj[index] ), projection_number );
            
          end;
          
          projection := ZFunctorMorphism( direct_product, differential_func, object_list[ projection_number ] );
          
          return projection;
          
      end );
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, universal_morphism;
      
      AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( ZFunctorCategory( category ),
        
        function( diagram, source, direct_product )
          
          differential_func := function( index )
              
              return UniversalMorphismIntoDirectProduct(
                       List( diagram, mor -> mor[ index ] ),
                       List( source, mor -> mor[ index ] )
                     );
              
          end;
          
          universal_morphism := ZFunctorMorphism( Source( source[1] ), differential_func, direct_product );
          
          return universal_morphism;
          
      end );
      
end );

## Coproduct
##
BindGlobal( "ADD_COPRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local object_func, differential_func, coproduct_object;
      
      AddCoproduct( ZFunctorCategory( category ),
        
        function( object_list )
            
            object_func := function( index ) return Coproduct( List( object_list, obj -> obj[ index ] ) ); end;
            
            differential_func := function( index ) return CoproductFunctorial( List( object_list, obj -> Differential( obj, index ) ) ); end;
            
            coproduct_object := ZFunctorObject( object_func, differential_func, category );
            
            return coproduct_object;
            
      end );
end );

##
BindGlobal( "ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, injection;
      
      AddInjectionOfCofactorOfCoproductWithGivenCoproduct( ZFunctorCategory( category ),
        
        function( object_list, injection_number, coproduct )
          
          differential_func := function( index )
            
            return InjectionOfCofactorOfCoproduct( List( object_list, obj-> obj[index] ), injection_number );
            
          end;
          
          injection := ZFunctorMorphism( object_list[ injection_number ], differential_func, coproduct );
          
          return injection;
          
      end );
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, universal_morphism;
      
      AddUniversalMorphismFromCoproductWithGivenCoproduct( ZFunctorCategory( category ),
        
        function( diagram, sink, coproduct )
          
          differential_func := function( index )
              
              return UniversalMorphismFromCoproduct(
                       List( diagram, mor -> mor[ index ] ),
                       List( sink, mor -> mor[ index ] )
                     );
              
          end;
          
          universal_morphism := ZFunctorMorphism( coproduct, differential_func, Range( sink[1] ) );
          
          return universal_morphism;
          
      end );
      
end );

## Direct sum
##
BindGlobal( "ADD_DIRECT_SUM_IN_Z_FUNCTORS",
          
  function( category )
    local object_func, differential_func, direct_sum_object;
    
    AddDirectSum( ZFunctorCategory( category ),
      
      function( object_list )
        
        object_func := function( index ) return DirectSum( List( object_list, obj -> obj[ index ] ) ); end;
        
        differential_func := function( index ) return DirectSumFunctorial( List( object_list, obj -> Differential( obj, index ) ) ); end;
            
        direct_sum_object := ZFunctorObject( object_func, differential_func, category );
            
        return direct_sum_object;
            
      end );
end );

## Pullback
##
BindGlobal( "ADD_FIBER_PRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local object_func, differential_func, pullback_object;
      
      AddFiberProduct( ZFunctorCategory( category ),
        
        function( morphism_list )
            
            object_func := function( index ) return FiberProduct( List( morphism_list, mor -> mor[ index ] ) ); end;
            
            differential_func := function( index ) 
              local cohomological_index;
              
              cohomological_index := index + 1;
              
              return PullbackFunctorial( List( morphism_list, mor -> [ mor[ index ], Differential( Source( mor ), index ), mor[ cohomological_index ] ] ) ); 
              
            end;
            
            
            pullback_object := ZFunctorObject( object_func, differential_func, category );
            
            return pullback_object;
            
      end );
end );

##
BindGlobal( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, projection;
      
      AddProjectionInFactorOfPullbackWithGivenPullback( ZFunctorCategory( category ),
        
        function( morphism_list, projection_number, pullback )
          
          differential_func := function( index )
            
            return ProjectionInFactorOfPullback( List( morphism_list, mor-> mor[index] ), projection_number );
            
          end;
          
          projection := ZFunctorMorphism( pullback, differential_func, Source( morphism_list[ projection_number ] ) );
          
          return projection;
          
      end );
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, universal_morphism;
      
      AddUniversalMorphismIntoPullbackWithGivenPullback( ZFunctorCategory( category ),
        
        function( diagram, source, pullback )
          
          differential_func := function( index )
              
              return UniversalMorphismIntoPullback(
                       List( diagram, mor -> mor[ index ] ),
                       List( source, mor -> mor[ index ] )
                     );
              
          end;
          
          universal_morphism := ZFunctorMorphism( Source( source[1] ), differential_func, pullback );
          
          return universal_morphism;
          
      end );
      
end );

## Pushout
##
BindGlobal( "ADD_PUSHOUT_IN_Z_FUNCTORS",
          
    function( category )
      local object_func, differential_func, pushout_object;
      
      AddPushout( ZFunctorCategory( category ),
        
        function( morphism_list )
            
            object_func := function( index ) return Pushout( List( morphism_list, mor -> mor[ index ] ) ); end;
            
            differential_func := function( index ) 
              local cohomological_index;
              
              cohomological_index := index + 1;
              
              return PushoutFunctorial( List( morphism_list, mor -> [ mor[ index ], Differential( Range( mor ), index ), mor[ cohomological_index ] ] ) ); 
              
            end;
            
            
            pushout_object := ZFunctorObject( object_func, differential_func, category );
            
            return pushout_object;
            
      end );
end );

##
BindGlobal( "ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, injection;
      
      AddInjectionOfCofactorOfPushoutWithGivenPushout( ZFunctorCategory( category ),
        
        function( morphism_list, injection_number, pushout )
          
          differential_func := function( index )
            
            return InjectionOfCofactorOfPushout( List( morphism_list, mor-> mor[index] ), injection_number );
            
          end;
          
          injection := ZFunctorMorphism( Range( morphism_list[ injection_number ] ), differential_func, pushout );
          
          return injection;
          
      end );
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, universal_morphism;
      
      AddUniversalMorphismFromPushoutWithGivenPushout( ZFunctorCategory( category ),
        
        function( diagram, sink, pushout )
          
          differential_func := function( index )
              
              return UniversalMorphismFromPushout(
                       List( diagram, mor -> mor[ index ] ),
                       List( sink, mor -> mor[ index ] )
                     );
              
          end;
          
          universal_morphism := ZFunctorMorphism( pushout, differential_func, Range( sink[1] ) );
          
          return universal_morphism;
          
      end );
      
end );

## Addition for morphisms
##
BindGlobal( "ADD_ADDITION_FOR_MORPHISMS_IN_Z_FUNCTORS",
         
    function( category )
      local differential_func, sum_of_morphisms;
      
      AddAdditionForMorphisms( ZFunctorCategory( category ),
      
        function( morphism1, morphism2 )
          
          differential_func := function( index )
              
              return morphism1[ index ] + morphism2[ index ];
              
          end;
          
          sum_of_morphisms := ZFunctorMorphism( Source( morphism1 ), differential_func, Range( morphism1 ) );
          
          return sum_of_morphisms;
        
    end );
    
end );

## Additive inverse
##
BindGlobal( "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, additive_inverse;
      
      AddAdditiveInverseForMorphisms( ZFunctorCategory( category ),
                                    
        function( morphism )
          
          differential_func := function( index ) return AdditiveInverse( morphism[ index ] ); end;
          
          additive_inverse := ZFunctorMorphism( Source( morphism ), differential_func, Range( morphism ) );
           
          return additive_inverse;
        
      end );
        
end );
    
## Zero morphism
##
BindGlobal( "ADD_ZERO_MORPHISM_IN_Z_FUNCTORS",
        
    function( category )
      local differential_func, zero_morphism;

      AddZeroMorphism( ZFunctorCategory( category ),
                     
        function( source, range )
          
          differential_func := function( index ) return ZeroMorphism( source[ index ], range[ index ] ); end;
          
          zero_morphism := ZFunctorMorphism( source, differential_func, range );
        
          return zero_morphism;
        
    end );
    
end );

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_ZFUNCTOR_CATEGORY,
            
  function( category )
    local todo_list_entries, entry, new_entry;
    
    todo_list_entries := [
        [ [ "CanComputePreCompose" ], function( ) ADD_PRECOMPOSE_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeIdentityMorphism" ], function( ) ADD_IDENTITY_MORPHISM_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeZeroObject" ], function( ) ADD_ZERO_OBJECT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeKernel", "CanComputeKernelObjectFunctorial" ], function( ) ADD_KERNEL_OBJECT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeKernelEmb" ], function( ) ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeKernelLift" ], function( ) ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeCokernel", "CanComputeCokernelFunctorial" ], function( ) ADD_COKERNEL_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeCokernelProj" ], function( ) ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeCokernelColift" ], function( ) ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeTerminalObject", "CanComputeTerminalObjectFunctorial" ], function( ) ADD_TERMINAL_OBJECT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeUniversalMorphismIntoTerminalObject" ], function( ) ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeInitialObject", "CanComputeInitialObjectFunctorial" ], function( ) ADD_INITIAL_OBJECT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeUniversalMorphismFromInitialObject" ], function( ) ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeDirectProduct", "CanComputeDirectProductFunctorial" ], function( ) ADD_DIRECT_PRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeProjectionInFactorOfDirectProduct" ],
          function( ) ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeUniversalMorphismIntoDirectProduct" ],
          function( ) ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeCoproduct", "CanComputeCoproductFunctorial" ], function( ) ADD_COPRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeInjectionOfCofactorOfCoproduct" ],
          function( ) ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeUniversalMorphismFromCoproduct" ],
          function( ) ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeDirectSum", "CanComputeDirectSumFunctorial" ], function( ) ADD_DIRECT_SUM_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputePullback", "CanComputePullbackFunctorial" ], function( ) ADD_FIBER_PRODUCT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeProjectionInFactorOfPullback" ],
          function( ) ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeUniversalMorphismIntoPullback" ],
          function( ) ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputePushout", "CanComputePushoutFunctorial" ], function( ) ADD_PUSHOUT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeInjectionOfCofactorOfPushout" ],
          function( ) ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeUniversalMorphismFromPushout" ],
          function( ) ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeInverse" ], function( ) ADD_INVERSE_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeMonoAsKernelLift" ], function( ) ADD_MONO_AS_KERNEL_LIFT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeEpiAsCokernelColift" ], function( ) ADD_EPI_AS_COKERNEL_COLIFT_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeAdditionForMorphisms" ], function( ) ADD_ADDITION_FOR_MORPHISMS_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeAdditiveInverseForMorphisms" ], function( ) ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_Z_FUNCTORS( category ); end ],
        
        [ [ "CanComputeZeroMorphism" ], function( ) ADD_ZERO_MORPHISM_IN_Z_FUNCTORS( category ); end ],
        
    ];
    
    for entry in todo_list_entries do
        
        new_entry := ToDoListEntry(
          Concatenation( List( entry[1], can_compute -> [ category, can_compute ] ), [ [ category, "ZFunctorCategory" ] ] ),
          entry[2]
        );
        
        AddToToDoList( new_entry );
        
    od;
    
end );

#############################
##
## Constructors
##
#############################

##
InstallMethod( ZFunctorObject,
               [ IsFunction, IsFunction, IsCapCategory ],
               
  function( object_func, differential_func, category )
    local object;
    
    object := rec( objects_positive := WeakPointerObj( [ ] ),
                   objects_nonpositive := WeakPointerObj( [ ] ),
                   differentials_positive := WeakPointerObj( [ ] ),
                   differentials_nonpositive := WeakPointerObj( [ ] ),
                   object_func := object_func,
                   differential_func := differential_func );
    
    ObjectifyWithAttributes( object, TheTypeOfZFunctorObject );
    
    Add( ZFunctorCategory( category ), object );
    
    return object;
    
end );

##
InstallMethod( AsZFunctorObjectOp,
               [ IsCapCategoryObject, IsInt ],
               
  function( object, embedding_index )
    local object_func, differential_func, z_functor_object, objects_positive, objects_nonpositive;
    
    object_func := function( index )
        if index = embedding_index then
            
            return object;
            
        elif index < embedding_index then
            
            return InitialObject( object );
        
        else
            
            return TerminalObject( object );
            
        fi;
        
    end;
    
    differential_func := function( index )
      local cohomological_index;
      
      cohomological_index := index + 1;
      
      if index = embedding_index then
          
          return UniversalMorphismIntoTerminalObject( object );
          
      elif cohomological_index = embedding_index then
          
          return UniversalMorphismFromInitialObject( object );
          
      elif index < embedding_index - 1 then
          
          return InitialObjectFunctorial( CapCategory( object ) );
          
      else
          
          return TerminalObjectFunctorial( CapCategory( object ) );
          
      fi;
    end;
    
    objects_positive := WeakPointerObj( [ ] );
    
    objects_nonpositive := WeakPointerObj( [ ] );
    
    if embedding_index > 0 then
        
        SetElmWPObj( objects_positive, embedding_index, object );
        
    else
        
        SetElmWPObj( objects_nonpositive, -embedding_index + 1, object );
        
    fi;
    
    z_functor_object := rec( objects_positive := objects_positive,
                             objects_nonpositive := objects_nonpositive,
                             differentials_positive := WeakPointerObj( [ ] ),
                             differentials_nonpositive := WeakPointerObj( [ ] ),
                             object_func := object_func,
                             differential_func := differential_func );
    
    ObjectifyWithAttributes( z_functor_object, TheTypeOfZFunctorObject );
    
    Add( ZFunctorCategory( CapCategory( object ) ), z_functor_object );
    
    return z_functor_object;
    
end );

##
InstallMethod( ZFunctorMorphism,
               [ IsZFunctorObject, IsFunction, IsZFunctorObject ],
               
  function( source, func, range )
    local morphism;
    
    morphism := rec( morphisms_positive := WeakPointerObj( [ ] ),
                     morphisms_nonpositive := WeakPointerObj( [ ] ),
                     morphism_func := func );
    
    ObjectifyWithAttributes( morphism, TheTypeOfZFunctorMorphism,
                             Source, source,
                             Range, range );
    
    Add( CapCategory( source ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( AsZFunctorMorphismOp,
               [ IsCapCategoryMorphism, IsInt ],
               
  function( morphism, embedding_index )
    local morphism_func, morphisms_positive, morphisms_nonpositive, z_functor_morphism, source, range;
    
    morphism_func := function( index )
        
        if index = embedding_index then
            
            return morphism;
            
        elif index < embedding_index then
            
            return InitialObjectFunctorial( CapCategory( morphism ) );
            
        else
            
            return TerminalObjectFunctorial( CapCategory( morphism ) );
            
        fi;
    end;
    
    morphisms_positive := WeakPointerObj( [ ] );
    
    morphisms_nonpositive := WeakPointerObj( [ ] );
    
    if embedding_index > 0 then
        
        SetElmWPObj( morphisms_positive, embedding_index, morphism );
        
    else
        
        SetElmWPObj( morphisms_nonpositive, -embedding_index + 1, morphism );
    
    fi;
    
    z_functor_morphism := rec( morphisms_positive := morphisms_positive,
                     morphisms_nonpositive := morphisms_nonpositive,
                     morphism_func := morphism_func );
    
    source := AsZFunctorObject( Source( morphism ), embedding_index );
    
    range := AsZFunctorObject( Range( morphism ), embedding_index );
    
    ObjectifyWithAttributes( z_functor_morphism, TheTypeOfZFunctorMorphism,
                             Source, source,
                             Range, range );
    
    Add( CapCategory( source ), z_functor_morphism );
    
    return z_functor_morphism;
    
end );
