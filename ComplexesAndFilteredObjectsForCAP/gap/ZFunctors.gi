# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesAndFilteredObjectsForCAP: Implementation of complexes, cocomplexes and filtered objects for CAP
#
# Implementations
#

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
## Technical stuff
##
#############################



#############################
##
## Attributes
##
#############################

InstallMethod( ZFunctorCategory,
               [ IsCapCategory ],
               
  function( category )
    local name, z_functor_category;
    
    if not IsFinalized( category ) then
        
        Error( "can only create z functor category of finalized category" );
        
        return;
        
    fi;
    
    name := Name( category );
    
    name := Concatenation( "Functors from integers into ", name );
    
    z_functor_category := CreateCapCategory( name : is_computable := false );
    
    z_functor_category!.category_as_first_argument := true;
    
    SetUnderlyingCategory( z_functor_category, category );
    
    SetZFunctorCategory( category, z_functor_category );
    
    INSTALL_OPERATIONS_FOR_ZFUNCTOR_CATEGORY( category );
    
    Finalize( z_functor_category );
    
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
          
          function( cat, mor_left, mor_right )
              
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
          
          function( cat, object )
              
              morphism_func := function( index )
                  
                  return IdentityMorphism( object[ index ] );
                  
              end;
              
              identity_mor := ZFunctorMorphism( object, morphism_func, object );
              
              return identity_mor;
              
      end );
  end );

## InverseForMorphisms
##
BindGlobal( "ADD_INVERSE_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, inverse;
    
    AddInverseForMorphisms( ZFunctorCategory( category ),
        
        function( cat, isomorphism )
            
            morphism_func := function( index )
                
                return InverseForMorphisms( isomorphism[ index ] );
                
            end;
            
            inverse := ZFunctorMorphism( Range( isomorphism ), morphism_func, Source( isomorphism ) );
            
            return inverse;
            
    end );
  end );

## LiftAlongMonomorphism
##
BindGlobal( "ADD_MONO_AS_KERNEL_LIFT_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, mono_as_kernel_lift;
    
    AddLiftAlongMonomorphism( ZFunctorCategory( category ),
                         
      function( cat, monomorphism, test_morphism )
        
        morphism_func := function( index ) return LiftAlongMonomorphism( monomorphism[ index ], test_morphism[ index ] );
        
      end;
      
      mono_as_kernel_lift := ZFunctorMorphism( Source( test_morphism ), morphism_func, Source( monomorphism ) );
      
      return mono_as_kernel_lift;
        
    end );
  end );

## ColiftAlongEpimorphism
##
BindGlobal( "ADD_EPI_AS_COKERNEL_COLIFT_IN_Z_FUNCTORS",
          
  function( category )
    local morphism_func, epi_as_cokernel_colift;
    
    AddColiftAlongEpimorphism( ZFunctorCategory( category ),
                         
      function( cat, epimorphism, test_morphism )
        
        morphism_func := function( index ) return ColiftAlongEpimorphism( epimorphism[ index ], test_morphism[ index ] );
        
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
        
        function( cat, morphism )
          
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

## KernelEmbeddingWithGivenKernelObject
BindGlobal( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, kernel_emb;

      AddKernelEmbeddingWithGivenKernelObject( ZFunctorCategory( category ),
        
        function( cat, morphism, kernel )
          
          morphism_func := function( index )
              
              return KernelEmbedding( morphism[ index ] );
              
          end;
          
          kernel_emb := ZFunctorMorphism( kernel, morphism_func, Source( morphism ) );
          
          return kernel_emb;
          
      end );
end );

## KernelLiftWithGivenKernelObject
BindGlobal( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, kernel_lift;

      AddKernelLiftWithGivenKernelObject( ZFunctorCategory( category ),
        
        function( cat, morphism, test_object, test_morphism, kernel )
          
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

      AddCokernelObject( ZFunctorCategory( category ),
        
        function( cat, morphism )
          
          object_func := function( index )
              
              return CokernelObject( morphism[ index ] );
              
          end;
          
          differential_func := function( index )
              local cohomological_index;
              
              cohomological_index := index + 1;
              
              return CokernelObjectFunctorial(
                
                morphism[ index ],
                Differential( Range( morphism ), index ),
                morphism[ cohomological_index ]
                
              );
              
          end;
          
          cokernel_object := ZFunctorObject( object_func, differential_func, category );
          
          return cokernel_object;
          
      end );
      
end );

## CokernelProjectionWithGivenCokernel
BindGlobal( "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, cokernel_proj;

      AddCokernelProjectionWithGivenCokernelObject( ZFunctorCategory( category ),
        
        function( cat, morphism, cokernel )
          
          morphism_func := function( index )
              
              return CokernelProjection( morphism[ index ] );
              
          end;
          
          cokernel_proj := ZFunctorMorphism( Range( morphism ), morphism_func, cokernel );
          
          return cokernel_proj;
          
      end );
end );

## CokernelColiftWithGivenCokernel
BindGlobal( "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS",
  
  function( category )
      local morphism_func, cokernel_colift;

      AddCokernelColiftWithGivenCokernelObject( ZFunctorCategory( category ),
        
        function( cat, morphism, test_object, test_morphism, cokernel )
          
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
      
      function( cat )
        
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
      
      function( cat )
        
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
      
      function( cat, object, terminal_object )
        
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
      
      function( cat )
        
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
      
      function( cat, object, initial_object )
        
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
        
        function( cat, object_list )
            
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
        
        function( cat, object_list, projection_number, direct_product )
          
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
        
        function( cat, diagram, test_object, source, direct_product )
          
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
        
        function( cat, object_list )
            
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
        
        function( cat, object_list, injection_number, coproduct )
          
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
        
        function( cat, diagram, test_object, sink, coproduct )
          
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
      
      function( cat, object_list )
        
        object_func := function( index ) return DirectSum( List( object_list, obj -> obj[ index ] ) ); end;
        
        differential_func := function( index ) return DirectSumFunctorial( List( object_list, obj -> Differential( obj, index ) ) ); end;
            
        direct_sum_object := ZFunctorObject( object_func, differential_func, category );
            
        return direct_sum_object;
            
      end );
end );

## FiberProduct
##
BindGlobal( "ADD_FIBER_PRODUCT_IN_Z_FUNCTORS",
          
    function( category )
      local object_func, differential_func, pullback_object;
      
      AddFiberProduct( ZFunctorCategory( category ),
        
        function( cat, morphism_list )
            
            object_func := function( index ) return FiberProduct( List( morphism_list, mor -> mor[ index ] ) ); end;
            
            differential_func := function( index )
              local cohomological_index;
              
              cohomological_index := index + 1;
              
              return FiberProductFunctorial( List( morphism_list, mor -> [ mor[ index ], Differential( Source( mor ), index ), mor[ cohomological_index ] ] ) );
              
            end;
            
            
            pullback_object := ZFunctorObject( object_func, differential_func, category );
            
            return pullback_object;
            
      end );
end );

##
BindGlobal( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, projection;
      
      AddProjectionInFactorOfFiberProductWithGivenFiberProduct( ZFunctorCategory( category ),
        
        function( cat, morphism_list, projection_number, pullback )
          
          differential_func := function( index )
            
            return ProjectionInFactorOfFiberProduct( List( morphism_list, mor-> mor[index] ), projection_number );
            
          end;
          
          projection := ZFunctorMorphism( pullback, differential_func, Source( morphism_list[ projection_number ] ) );
          
          return projection;
          
      end );
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS",
          
    function( category )
      local differential_func, universal_morphism;
      
      AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( ZFunctorCategory( category ),
        
        function( cat, diagram, test_object, source, pullback )
          
          differential_func := function( index )
              
              return UniversalMorphismIntoFiberProduct(
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
        
        function( cat, morphism_list )
            
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
        
        function( cat, morphism_list, injection_number, pushout )
          
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
        
        function( cat, diagram, test_object, sink, pushout )
          
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
      
        function( cat, morphism1, morphism2 )
          
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
                                    
        function( cat, morphism )
          
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
                     
        function( cat, source, range )
          
          differential_func := function( index ) return ZeroMorphism( source[ index ], range[ index ] ); end;
          
          zero_morphism := ZFunctorMorphism( source, differential_func, range );
        
          return zero_morphism;
        
    end );
    
end );

##
InstallGlobalFunction( INSTALL_OPERATIONS_FOR_ZFUNCTOR_CATEGORY,
            
  function( category )
    local install_entries, entry, weight_list;
    
    install_entries := [
        [ [ "PreCompose" ], ADD_PRECOMPOSE_IN_Z_FUNCTORS ],
        
        [ [ "IdentityMorphism" ], ADD_IDENTITY_MORPHISM_IN_Z_FUNCTORS ],
        
        [ [ "ZeroObject" ], ADD_ZERO_OBJECT_IN_Z_FUNCTORS ],
        
        [ [ "KernelObject", "KernelObjectFunctorialWithGivenKernelObjects" ], ADD_KERNEL_OBJECT_IN_Z_FUNCTORS ],
        
        [ [ "KernelEmbedding" ], ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS ],
        
        [ [ "KernelLift" ], ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_Z_FUNCTORS ],
        
        [ [ "CokernelObject", "CokernelObjectFunctorialWithGivenCokernelObjects" ], ADD_COKERNEL_IN_Z_FUNCTORS ],
        
        [ [ "CokernelProjection" ], ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS ],
        
        [ [ "CokernelColift" ], ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_Z_FUNCTORS ],
        
        [ [ "TerminalObject", "TerminalObjectFunctorial" ], ADD_TERMINAL_OBJECT_IN_Z_FUNCTORS ],
        
        [ [ "UniversalMorphismIntoTerminalObject" ], ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_Z_FUNCTORS ],
        
        [ [ "InitialObject", "InitialObjectFunctorial" ], ADD_INITIAL_OBJECT_IN_Z_FUNCTORS ],
        
        [ [ "UniversalMorphismFromInitialObject" ], ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_Z_FUNCTORS ],
        
        [ [ "DirectProduct", "DirectProductFunctorialWithGivenDirectProducts" ], ADD_DIRECT_PRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "ProjectionInFactorOfDirectProduct" ],
          ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "UniversalMorphismIntoDirectProduct" ],
          ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "Coproduct", "CoproductFunctorialWithGivenCoproducts" ], ADD_COPRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "InjectionOfCofactorOfCoproduct" ],
          ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "UniversalMorphismFromCoproduct" ],
          ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "DirectSum", "DirectSumFunctorialWithGivenDirectSums" ], ADD_DIRECT_SUM_IN_Z_FUNCTORS ],
        
        [ [ "FiberProduct", "FiberProductFunctorialWithGivenFiberProducts" ], ADD_FIBER_PRODUCT_IN_Z_FUNCTORS ],
        
        [ [ "ProjectionInFactorOfFiberProduct" ],
          ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS ],
        
        [ [ "UniversalMorphismIntoFiberProduct" ],
          ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_Z_FUNCTORS ],
        
        [ [ "Pushout", "PushoutFunctorialWithGivenPushouts" ], ADD_PUSHOUT_IN_Z_FUNCTORS ],
        
        [ [ "InjectionOfCofactorOfPushout" ],
          ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_Z_FUNCTORS ],
        
        [ [ "UniversalMorphismFromPushout" ],
          ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_Z_FUNCTORS ],
        
        [ [ "InverseForMorphisms" ], ADD_INVERSE_IN_Z_FUNCTORS ],
        
        [ [ "LiftAlongMonomorphism" ], ADD_MONO_AS_KERNEL_LIFT_IN_Z_FUNCTORS ],
        
        [ [ "ColiftAlongEpimorphism" ], ADD_EPI_AS_COKERNEL_COLIFT_IN_Z_FUNCTORS ],
        
        [ [ "AdditionForMorphisms" ], ADD_ADDITION_FOR_MORPHISMS_IN_Z_FUNCTORS ],
        
        [ [ "AdditiveInverseForMorphisms" ], ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_Z_FUNCTORS ],
        
        [ [ "ZeroMorphism" ], ADD_ZERO_MORPHISM_IN_Z_FUNCTORS ],
        
    ];
    
    weight_list := category!.derivations_weight_list;
    
    for entry in install_entries do
        
        if ForAll( entry[ 1 ], i -> CurrentOperationWeight( weight_list, i ) < infinity ) then
            
            entry[ 2 ]( category );
            
        fi;
        
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
    local object, objectified_object;
    
    object := rec( objects_positive := WeakPointerObj( [ ] ),
                   objects_nonpositive := WeakPointerObj( [ ] ),
                   differentials_positive := WeakPointerObj( [ ] ),
                   differentials_nonpositive := WeakPointerObj( [ ] ),
                   object_func := object_func,
                   differential_func := differential_func );
    
    objectified_object := ObjectifyWithAttributes( object, TheTypeOfZFunctorObject );
    
    Add( ZFunctorCategory( category ), objectified_object );
    
    return objectified_object;
    
end );

InstallMethod( ZFunctorObjectExtendedByInitialAndIdentity,
               [ IsZFunctorObject, IsInt, IsInt ],
               
  function( object, lower_bound, upper_bound )
      
      return ZFunctorObjectExtendedByInitialAndIdentity( object!.object_func, object!.differential_func, UnderlyingCategory( CapCategory( object ) ), lower_bound, upper_bound );
      
end );

##
InstallMethod( ZFunctorObjectExtendedByInitialAndIdentity,
               [ IsFunction, IsFunction, IsCapCategory, IsInt, IsInt ],
               
  function( object_func, differential_func, category, lower_bound, upper_bound )
    local object, new_object_func, new_differential_func;
    
    new_object_func := function( i )
        
        if i < lower_bound then
            
            return InitialObject( category );
            
        elif i >= upper_bound then
            
            return object_func( upper_bound );
            
        else
            
            return object_func( i );
            
        fi;
        
    end;
    
    new_differential_func := function( i )
        
        if i < lower_bound - 1 then
            
            return IdentityMorphism( InitialObject( category ) );
            
        elif i = lower_bound - 1 then
            
            return UniversalMorphismFromInitialObject( object_func( lower_bound ) );
            
        elif i >= upper_bound then
            
            return IdentityMorphism( object_func( upper_bound ) );
            
        else
            
            return differential_func( i );
            
        fi;
        
    end;
    
    return ZFunctorObject( new_object_func, new_differential_func, category );
    
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
    
    return ZFunctorObject( object_func, differential_func, CapCategory( object ) );
    
end );

##
InstallMethod( ZFunctorObjectFromMorphismList,
               [ IsList ],
               
  function( morphism_list )
    
    return ZFunctorObjectFromMorphismList( morphism_list, 0 );
    
end );

##
InstallMethod( ZFunctorObjectFromMorphismList,
               [ IsList, IsInt ],
               
  function( morphism_list, start_position )
    local category, object_func, morphism_func, list_length;
    
    if Length( morphism_list ) = 0 then
        
        Error( "empty list is not allowed" );
        
    fi;
    
    category := CapCategory( morphism_list[ 1 ] );
    
    list_length := Length( morphism_list );
    
    object_func := function( i )
        
        if i < start_position then
            
            return InitialObject( category );
            
        elif i = start_position then
            
            return Source( morphism_list[ 1 ] );
            
        elif i <= start_position + list_length then
            
            return Range( morphism_list[ i - start_position ] );
            
        else
            
            return TerminalObject( category );
            
        fi;
        
    end;
    
    morphism_func := function( i )
        
        if i < start_position - 1 then
            
            return IdentityMorphism( InitialObject( category ) );
            
        elif i = start_position - 1 then
            
            return UniversalMorphismFromInitialObject( Source( morphism_list[ 1 ] ) );
            
        elif i < start_position + list_length then
            
            return morphism_list[ i - start_position + 1 ];
            
        elif i = start_position + list_length then
            
            return UniversalMorphismIntoTerminalObject( Range( morphism_list[ list_length ] ) );
            
        else
            
            return IdentityMorphism( TerminalObject( category ) );
            
        fi;
        
    end;
    
    return ZFunctorObject( object_func, morphism_func, category );
    
end );

##
InstallMethod( ZFunctorMorphism,
               [ IsZFunctorObject, IsFunction, IsZFunctorObject ],
               
  function( source, func, range )
    local morphism, objectified_morphism;
    
    morphism := rec( morphisms_positive := WeakPointerObj( [ ] ),
                     morphisms_nonpositive := WeakPointerObj( [ ] ),
                     morphism_func := func );
    
    objectified_morphism := ObjectifyWithAttributes( morphism, TheTypeOfZFunctorMorphism,
                                                     Source, source,
                                                     Range, range );
    
    Add( CapCategory( source ), objectified_morphism );
    
    return objectified_morphism;
    
end );

InstallMethod( ZFunctorMorphism,
               [ IsZFunctorObject, IsList, IsZFunctorObject ],
               
  function( source, list, range )
      
      return ZFunctorMorphism( source, list, 0, range );
      
end );

##
InstallMethod( ZFunctorMorphism,
               [ IsZFunctorObject, IsList, IsInt, IsZFunctorObject ],
               
  function( source, morphism_list, start_position, range )
    local list_length, morphism_func;
    
    list_length := Length( morphism_list );
    
    if list_length = 0 then
        
        return ZeroMorphism( source, range );
        
    fi;
    
    morphism_func := function( i )
        
        if i >= start_position and i < start_position + list_length then
            
            return morphism_list[ i - start_position + 1 ];
            
        else
            
            return ZeroMorphism( source[ i ], range[ i ] );
            
        fi;
        
    end;
    
    return ZFunctorMorphism( source, morphism_func, range );
    
end );

##
InstallMethod( ZFunctorMorphismExtendedByInitialAndIdentity,
               [ IsZFunctorObject, IsFunction, IsZFunctorObject, IsInt, IsInt ],
               
  function( source, morphism_func, range, lower_bound, upper_bound )
    local underlying_category, new_morphism_func;
    
    underlying_category := UnderlyingCategory( CapCategory( source ) );
    
    new_morphism_func := function( i )
        
        if i < lower_bound then
            
            return IdentityMorphism( InitialObject( underlying_category ) );
            
        elif i < upper_bound then
            
            return morphism_func( i );
            
        else
            
            return morphism_func( upper_bound );
            
        fi;
        
    end;
    
    return ZFunctorMorphism( source, new_morphism_func, range );
    
end );

##
InstallMethod( ZFunctorMorphismExtendedByInitialAndIdentity,
               [ IsZFunctorMorphism, IsInt, IsInt ],
               
  function( morphism, lower_bound, upper_bound )
    
    return ZFunctorMorphismExtendedByInitialAndIdentity( Source( morphism ), morphism!.morphism_func, Range( morphism ), lower_bound, upper_bound );
    
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
    
    source := AsZFunctorObject( Source( morphism ), embedding_index );
    
    range := AsZFunctorObject( Range( morphism ), embedding_index );
    
    return ZFunctorMorphism( source, morphism_func, range );
    
end );

## Use with caution, depends on GAPs stategy for closures
InstallMethod( ZFunctorObjectByInitialMorphismAndRecursiveFunction,
               [ IsCapCategoryMorphism, IsFunction, IsInt ],
               
  function( initial_morphism, recursion_function, position_of_initial_morphism )
    local z_functor, category, differential_func, object_func;
    
    category := CapCategory( initial_morphism );
    
    z_functor := ZFunctorObject( ReturnTrue, ReturnTrue, CapCategory( initial_morphism ) );
    
    differential_func := function( i )
        
        if i = position_of_initial_morphism then
            return initial_morphism;
        elif i < position_of_initial_morphism then
            return recursion_function( Differential( z_functor, i + 1 ) );
        elif i = position_of_initial_morphism + 1 then
            return ZeroMorphism( Range( initial_morphism ), ZeroObject( category ) );
        else
            return IdentityMorphism( ZeroObject( category ) );
        fi;
        
    end;
    
    object_func := function( i )
        
        return Source( Differential( z_functor, i ) );
        
    end;
    
    z_functor!.differential_func := differential_func;
    z_functor!.object_func := object_func;
    
    return z_functor;
    
end );
    
    

