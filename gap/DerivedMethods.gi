###########################
##
## Derivations taken from CategoryObjects.gi
##
###########################
##
InstallTrueMethodAndStoreImplication( CanComputeZeroMorphism, CanComputePreCompose
                                       and CanComputeUniversalMorphismIntoTerminalObject
                                       and CanComputeUniversalMorphismFromInitialObject
                                       and IsAdditiveCategory );

InstallMethodWithToDoForIsWellDefined( ZeroMorphism,
                                       [ IsCapCategoryObject
                                     and CanComputePreCompose
                                     and CanComputeUniversalMorphismIntoTerminalObject
                                     and IsAdditiveCategory,
                                         IsCapCategoryObject
                                     and CanComputeUniversalMorphismFromInitialObject
                                     and IsAdditiveCategory ],
                                       -99999, #FIXME
                                  
  function( obj_source, obj_range )
    
    return PreCompose( UniversalMorphismIntoTerminalObject( obj_source ), UniversalMorphismFromInitialObject( obj_range ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallTrueMethodAndStoreImplication( CanComputeIsZeroForObjects, CanComputeIdentityMorphism and CanComputeZeroMorphism and CanComputeIsEqualForMorphisms );

InstallMethod( IsZero,
               [ IsCapCategoryObject and CanComputeIdentityMorphism and CanComputeZeroMorphism and CanComputeIsEqualForMorphisms ],
               -9999, #FIXME
               
  function( object )
    
    return IsEqualForMorphisms( IdentityMorphism( object ), ZeroMorphism( object, object ) );
    
end );

###########################
##
## Derivations taken from CategoryMorphisms.gi
##
###########################

##
InstallTrueMethodAndStoreImplication( CanComputeIsMonomorphism, CanComputeKernel and CanComputeIsZeroForObjects and IsAdditiveCategory );

InstallMethod( IsMonomorphism,
               [ IsCapCategoryMorphism and CanComputeKernel and CanComputeIsZeroForObjects and IsAdditiveCategory ],
               -9900, #FIXME
               
  function( morphism )
    
    return IsZero( KernelObject( morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeIsMonomorphism, 
                   CanComputeIsIsomorphism
                   and CanComputeIdentityMorphism
                   and CanComputeProjectionInFactorOfPullback
                   and CanComputePreCompose
                   and CanComputeUniversalMorphismIntoPullback );

InstallMethod( IsMonomorphism,
               [ IsCapCategoryMorphism
                 and CanComputeIsIsomorphism
                 and CanComputeIdentityMorphism
                 and CanComputeProjectionInFactorOfPullback
                 and CanComputePreCompose
                 and CanComputeUniversalMorphismIntoPullback ],
                 -9999, #FIXME
                 
  function( morphism )
    local pullback_diagram, pullback_projection_1, pullback_projection_2, identity, diagonal_morphism;
      
      pullback_diagram := [ morphism, morphism ];
      
      pullback_projection_1 := ProjectionInFactorOfPullback( pullback_diagram, 1 );
      
      pullback_projection_2 := ProjectionInFactorOfPullback( pullback_diagram, 2 );
      
      identity := IdentityMorphism( Source( morphism ) );
      
      diagonal_morphism := UniversalMorphismIntoPullback( pullback_diagram, identity, identity );
      
      return IsIsomorphism( diagonal_morphism );
    
end );

#
InstallTrueMethodAndStoreImplication( CanComputeIsEpimorphism, CanComputeCokernel and CanComputeIsZeroForObjects and IsAdditiveCategory );

InstallMethod( IsEpimorphism,
               [ IsCapCategoryMorphism and CanComputeCokernel and CanComputeIsZeroForObjects and IsAdditiveCategory ],
               -9900, #FIXME
               
  function( morphism )
    
    return IsZero( Cokernel( morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeIsEpimorphism,
                   CanComputeIsIsomorphism
                   and CanComputeIdentityMorphism
                   and CanComputeInjectionOfCofactorOfPushout
                   and CanComputePreCompose
                   and CanComputeUniversalMorphismFromPushout );

InstallMethod( IsEpimorphism,
               [ IsCapCategoryMorphism
                 and CanComputeIsIsomorphism
                 and CanComputeIdentityMorphism
                 and CanComputeInjectionOfCofactorOfPushout
                 and CanComputePreCompose
                 and CanComputeUniversalMorphismFromPushout ],
                 -9999, #FIXME
                 
  function( morphism )
    local pushout_diagram, pushout_injection_1, pushout_injection_2, identity, codiagonal_morphism;
      
      pushout_diagram := [ morphism, morphism ];
      
      pushout_injection_1 := InjectionOfCofactorOfPushout( pushout_diagram, 1 );
      
      pushout_injection_2 := InjectionOfCofactorOfPushout( pushout_diagram, 2 );
      
      identity := IdentityMorphism( Range( morphism ) );
      
      codiagonal_morphism := UniversalMorphismFromPushout( pushout_diagram, identity, identity );
      
      return IsIsomorphism( codiagonal_morphism );
    
end );

##
InstallTrueMethodAndStoreImplication( SetCanComputeIsIsomorphism, CanComputeIsMonomorphism and CanComputeIsEpimorphism and IsAbelianCategory );#TODO: weaker?

InstallMethod( IsIsomorphism,
               [ IsCapCategoryMorphism and CanComputeIsMonomorphism and CanComputeIsEpimorphism and IsAbelianCategory ],
               -9999, #FIXME
               
  function( morphism )
    
    return IsMonomorphism( morphism ) and IsEpimorphism( morphism );
    
end );

InstallTrueMethodAndStoreImplication( CanComputeEqualityOfSubobjects, CanComputeDominates );

##
InstallMethodWithCacheFromObject( IsEqualAsSubobject,
                                  [ IsCapCategoryMorphism and IsSubobject
                                    and SetCanComputeDominates,
                                    IsCapCategoryMorphism and IsSubobject ],
                                  
  function( sub1, sub2 );
    
    ##or should this be IsIdenticalObj?
    if not IsEqualForObjects( Range( sub1 ), Range( sub2 ) ) then
        
        return false;
        
    fi;
    
    return Dominates( sub1, sub2 ) and Dominates( sub2, sub1 );
    
end );

InstallTrueMethodAndStoreImplication( CanComputeEqualityOfFactorobjects, CanComputeCodominates );

##
InstallMethodWithCacheFromObject( IsEqualAsFactorobject,
                                  [ IsCapCategoryMorphism and IsFactorobject
                                    and CanComputeCodominates, 
                                    IsCapCategoryMorphism and IsFactorobject ],
                                  
  function( factor1, factor2 )
    
    ##or should this be IsIdenticalObj?
    if not IsEqualForObjects( Source( factor1 ), Source( factor2 ) ) then
        
        return false;
        
    fi;
    
    return Codominates( factor1, factor2 ) and Codominates( factor1, factor2 );
    
end );

InstallTrueMethodAndStoreImplication( CanComputeDominates, CanComputeCokernelProj and CanComputeCodominates and IsPreAbelianCategory );

##
InstallMethodWithCacheFromObject( Dominates,
                                  [ IsCapCategoryMorphism and IsSubobject
                                    and CanComputeCokernelProj
                                    and CanComputeCodominates
                                    and IsPreAbelianCategory,
                                    IsCapCategoryMorphism and IsSubobject ],
                                    -9999, # FIXME (has to be the lowest Dominates fallback method)
                                  
  function( sub1, sub2 )
    local cokernel_projection_1, cokernel_projection_2;
    
    cokernel_projection_1 := CokernelProj( sub1 );
    
    cokernel_projection_2 := CokernelProj( sub2 );
    
    return Codominates( cokernel_projection_1, cokernel_projection_2 );
    
end );

InstallTrueMethodAndStoreImplication( CanComputeDominates, CanComputeCokernelProj and CanComputeIsZeroForMorphisms and CanComputePreCompose );

##
InstallMethodWithCacheFromObject( Dominates,
                                  [ IsCapCategoryMorphism and IsSubobject 
                                    and CanComputeCokernelProj
                                    and CanComputeIsZeroForMorphisms
                                    and CanComputePreCompose, 
                                    IsCapCategoryMorphism and IsSubobject ],
                                    -9000, # FIXME
                                  
  function( sub1, sub2 )
    local cokernel_projection, composition;
    
    cokernel_projection := CokernelProj( sub2 );
    
    composition := PreCompose( sub1, cokernel_projection );
    
    return IsZero( composition );
    
end );


InstallTrueMethodAndStoreImplication( CanComputeCodominates, CanComputeKernelEmb and CanComputeDominates and IsPreAbelianCategory );

##
InstallMethodWithCacheFromObject( Codominates,
                                  [ IsCapCategoryMorphism and IsFactorobject
                                    and CanComputeKernelEmb
                                    and CanComputeDominates
                                    and IsPreAbelianCategory,
                                    IsCapCategoryMorphism and IsFactorobject ],
                                    -9999, # FIXME (has to be the lowest Codominates fallback method)
                                  
  function( factor1, factor2 )
    local kernel_embedding_1, kernel_embedding_2;
    
    kernel_embedding_1 := KernelEmb( factor1 );
    
    kernel_embedding_2 := KernelEmb( factor2 );
    
    return Dominates( kernel_embedding_2, kernel_embedding_1 );
    
end );

InstallTrueMethodAndStoreImplication( CanComputeCodominates, CanComputeKernelEmb and CanComputeIsZeroForMorphisms and CanComputePreCompose );

##
InstallMethodWithCacheFromObject( Codominates,
                                  [ IsCapCategoryMorphism and IsFactorobject
                                    and CanComputeKernelEmb
                                    and CanComputeIsZeroForMorphisms
                                    and CanComputePreCompose,
                                    IsCapCategoryMorphism and IsFactorobject ],
                                    -9000, # FIXME
                                  
  function( factor1, factor2 )
    local kernel_embedding, composition;
    
    kernel_embedding := KernelEmb( factor2 );
    
    composition := PreCompose( kernel_embedding, factor1 );
    
    return IsZero( composition );
    
end );

## PostCompose
##
InstallTrueMethodAndStoreImplication( CanComputePostCompose, CanComputePreCompose );

InstallMethodWithCacheFromObject( PostCompose,
                                  [ IsCapCategoryMorphism and CanComputePreCompose,
                                  IsCapCategoryMorphism and CanComputePreCompose ],
               
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end : ArgumentNumber := 1 );

## Inverse
##
InstallTrueMethodAndStoreImplication( CanComputeInverse, CanComputeMonoAsKernelLift and CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( InverseOp,
                                       [ IsCapCategoryMorphism and CanComputeMonoAsKernelLift and CanComputeIdentityMorphism ],
                                       -9999, #FIXME
                                       
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );
        
end );


##
InstallTrueMethodAndStoreImplication( CanComputeInverse, CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( InverseOp,
                                       [ IsCapCategoryMorphism and CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism ],
                                       -9998, #FIXME
                                       
  function( mor )
    local identity_of_source;
    
    identity_of_source := IdentityMorphism( Source( mor ) );
    
    return EpiAsCokernelColift( mor, identity_of_source );
      
end );

## FIXME: IsAbelianCategory too restrictive
InstallTrueMethodAndStoreImplication( CanComputeEpiMonoFactorization, IsAbelianCategory and CanComputeKernelEmb and CanComputeCokernelProj and CanComputeCokernelColift );

InstallMethodWithToDoForIsWellDefined( EpiMonoFactorization,
                                       [ IsCapCategoryMorphism ],
                                       
  function( morphism )
    local kernel_embedding, epimorphism, monomorphism;
    
    kernel_embedding := KernelEmb( morphism );
    
    epimorphism := CokernelProj( kernel_embedding );
    
    monomorphism := CokernelColift( kernel_embedding, morphism );
    
    return [ epimorphism, monomorphism ];
    
end );

###########################
##
## Derivations taken from UniversalObjects.gi
##
###########################

####################################
## Derived Methods for Kernel
####################################
##
InstallTrueMethodAndStoreImplication( CanComputeKernelLift, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

InstallMethodWithCacheFromObject( KernelLift,
                                  [ IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                                    -9999, #FIXME
                                    
  function( mor, test_morphism )
    local kernel_lift, kernel;
    
    ## KernelEmb passes its kernel object to the kernel lift
    kernel_lift := MonoAsKernelLift( KernelEmb( mor ), test_morphism );
    
    return kernel_lift;
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeKernelLiftWithGivenKernel, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

InstallMethodWithCacheFromObject( KernelLiftWithGivenKernel,
                                  [ IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsCapCategoryObject and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                                  -9999, #FIXME
                                           
    function( mor, test_morphism, kernel )
      
      return MonoAsKernelLift( KernelEmb( kernel ), test_morphism );
      
end );

##
InstallTrueMethodAndStoreImplication( CanComputeKernel, CanComputeKernelEmb );

InstallMethod( KernelObject,
               [ IsCapCategoryMorphism and CanComputeKernelEmb ],
               -9999, #FIXME
               
  function( mor )
    
    return Source( KernelEmb( mor ) );
    
end );


##
InstallTrueMethodAndStoreImplication( CanComputeKernelEmb, CanComputeKernel and CanComputeKernelEmbWithGivenKernel );

InstallMethod( KernelEmb,
               [ IsCapCategoryMorphism and CanComputeKernel and CanComputeKernelEmbWithGivenKernel ],
               -9999, #FIXME
               
  function( mor )
    
    return KernelEmbWithGivenKernel( mor, KernelObject( mor ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeKernelLift, CanComputeKernel and CanComputeKernelLiftWithGivenKernel );

InstallMethod( KernelLift,
               [ IsCapCategoryMorphism and CanComputeKernel and CanComputeKernelLiftWithGivenKernel,
                 IsCapCategoryMorphism ],
               -9999, #FIXME
               
  function( morphism, test_morphism )
    
    return KernelLiftWithGivenKernel( morphism, test_morphism, KernelObject( morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeKernelObjectFunctorial,
                   CanComputeKernelLift and CanComputeKernelEmb and CanComputePreCompose );

InstallMethodWithCacheFromObject( KernelObjectFunctorial,
                                  [ IsCapCategoryMorphism and CanComputeKernelLift and CanComputeKernelEmb and CanComputePreCompose,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism ],
                                  
  function( alpha, mu, alpha_p )
    
    return KernelLift(
                alpha_p,
                PreCompose( KernelEmb( alpha ), mu )
              );
    
end );

####################################
## Derived Methods for Cokernel
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeCokernelColift, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

InstallMethodWithCacheFromObject( CokernelColift,
                                  [ IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                                  -9999, #FIXME
                                  
  function( mor, test_morphism )
    
    return EpiAsCokernelColift( CokernelProj( mor ), test_morphism );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeCokernelColiftWithGivenCokernel, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

InstallMethodWithCacheFromObject( CokernelColiftWithGivenCokernel,
                                  [ IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsCapCategoryObject and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                                           
    function( mor, test_morphism, cokernel )
      
      return EpiAsCokernelColift( CokernelProj( cokernel ), test_morphism );
      
end );


##
InstallTrueMethodAndStoreImplication( CanComputeCokernel, CanComputeCokernelProj );

InstallMethod( Cokernel,
               [ IsCapCategoryMorphism and CanComputeCokernelProj ],
               -9999, #FIXME
                                  
  function( mor )
    
    return Range( CokernelProj( mor ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeCokernelProj, CanComputeCokernel and CanComputeCokernelProjWithGivenCokernel );

InstallMethod( CokernelProj,
               [ IsCapCategoryMorphism and CanComputeCokernel and CanComputeCokernelProjWithGivenCokernel ],
               -9999, #FIXME
               
  function( mor )
    
    return CokernelProjWithGivenCokernel( mor, Cokernel( mor ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeCokernelColift, CanComputeCokernel and CanComputeCokernelColiftWithGivenCokernel );

InstallMethod( CokernelColift,
               [ IsCapCategoryMorphism and CanComputeCokernel and CanComputeCokernelColiftWithGivenCokernel,
                 IsCapCategoryMorphism ],
               -9999, #FIXME
               
  function( morphism, test_morphism )
    
    return CokernelColiftWithGivenCokernel( morphism, test_morphism, Cokernel( morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeCokernelFunctorial,
                   CanComputeCokernelColift and CanComputeCokernelProj and CanComputePreCompose );

InstallMethodWithCacheFromObject( CokernelFunctorial,
                                  [ IsCapCategoryMorphism and CanComputeCokernelColift and CanComputeCokernelProj and CanComputePreCompose,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism ],
                                  
  function( alpha, nu, alpha_p )
    
    return CokernelColift(
                alpha,
                PreCompose( nu, CokernelProj( alpha_p ) )
              );
    
end );

####################################
## Derived Methods for Coproduct
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeCoproduct, CanComputeInjectionOfCofactorOfCoproduct );

##
## this methods is installed using the (cache of the (object of the second argument) )
InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                       [ IsList,
                                         IsCapCategoryObject and CanComputeInjectionOfCofactorOfCoproduct ],
                                        -9999, #FIXME
                                        
  function( object_product_list, method_selection_object )
    
    return Range( InjectionOfCofactorOfCoproduct( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromCoproduct,
                   CanComputeCoproduct and CanComputeUniversalMorphismFromCoproductWithGivenCoproduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductOp,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject and CanComputeCoproduct and CanComputeUniversalMorphismFromCoproductWithGivenCoproduct ],
                                         -9999, #FIXME
                                       
  function( diagram, sink, method_selection_object )
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( diagram, sink, CallFuncList( Coproduct, List( sink, Source ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeInjectionOfCofactorOfCoproduct, CanComputeCoproduct and CanComputeInjectionOfCofactorOfCoproductWithGivenCoproduct );

InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfCoproductOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and CanComputeCoproduct and CanComputeInjectionOfCofactorOfCoproductWithGivenCoproduct, ],
                                         -9999, #FIXME
                                         
  function( object_product_list, injection_number, method_selection_object )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct( object_product_list, injection_number, CallFuncList( Coproduct, object_product_list ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeCoproductFunctorial,
                   CanComputeCoproduct and CanComputePreCompose and CanComputeInjectionOfCofactorOfCoproduct
                   and CanComputeUniversalMorphismFromCoproduct );

InstallMethodWithCacheFromObject( CoproductFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputeCoproduct
                                    and CanComputePreCompose
                                    and CanComputeInjectionOfCofactorOfCoproduct
                                    and CanComputeUniversalMorphismFromCoproduct ],
                                  
  function( morphism_list, caching_object )
    local coproduct_diagram, sink, diagram;
        
        coproduct_diagram := List( morphism_list, mor -> Range( mor ) );
        
        sink := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( morphism_list[i], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
        
        diagram := List( morphism_list, mor -> Source( mor ) );
        
        return UniversalMorphismFromCoproduct( diagram, sink );
        
end : ArgumentNumber := 2 );

####################################
## Derived Methods for DirectProduct
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeDirectProduct, CanComputeProjectionInFactorOfDirectProduct );

##
InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                       [ IsList,
                                         IsCapCategoryObject and CanComputeProjectionInFactorOfDirectProduct ],
                                        -9999, #FIXME
                                        
  function( object_product_list, method_selection_object )
    
    return Source( ProjectionInFactorOfDirectProduct( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoDirectProduct,
                   CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject and CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct ],
                                         -9999, #FIXME
                                       
  function( diagram, source, method_selection_object )
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( diagram, source, CallFuncList( DirectProduct, List( source, Range ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeProjectionInFactorOfDirectProduct, CanComputeDirectProduct and CanComputeProjectionInFactorOfDirectProductWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfDirectProductOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and CanComputeDirectProduct and CanComputeProjectionInFactorOfDirectProductWithGivenDirectProduct ],
                                         -9999, #FIXME
                                         
  function( object_product_list, projection_number, method_selection_object )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct( object_product_list, projection_number, CallFuncList( DirectProduct, object_product_list ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeDirectProductFunctorial,
                   CanComputeDirectProduct and CanComputePreCompose and CanComputeProjectionInFactorOfDirectProduct 
                   and CanComputeUniversalMorphismIntoDirectProduct );

InstallMethodWithCacheFromObject( DirectProductFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputeDirectProduct
                                    and CanComputePreCompose
                                    and CanComputeProjectionInFactorOfDirectProduct
                                    and CanComputeUniversalMorphismIntoDirectProduct ],
                                  
  function( morphism_list, caching_object )
    local direct_product_diagram, source, diagram;
        
        direct_product_diagram := List( morphism_list, mor -> Source( mor ) );
        
        source := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), morphism_list[i] ) );
        
        diagram := List( morphism_list, mor -> Range( mor ) );
        
        return UniversalMorphismIntoDirectProduct( diagram, source );
        
end : ArgumentNumber := 2 );

####################################
## Derived Methods due to DirectSum
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeDirectProduct,
                   CanComputeDirectSum );

InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                       [ IsList, IsCapCategoryObject and CanComputeDirectSum ],
                                       -9999 + 1, #FIXME
                                       
  function( object_product_list, method_selection_object )
    
    return DirectSumOp( object_product_list, method_selection_object );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethodAndStoreImplication( CanComputeCoproduct,
                   CanComputeDirectSum );

InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                       [ IsList, IsCapCategoryObject and CanComputeDirectSum ],
                                       -9999 + 1, #FIXME
                                       
  function( object_product_list, method_selection_object )
    
    return DirectSumOp( object_product_list, method_selection_object );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2  );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct,
                   IsAdditiveCategory
                   and CanComputeInjectionOfCofactorOfCoproduct
                   and CanComputeAdditionForMorphisms 
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject 
                                     and IsAdditiveCategory
                                     and CanComputeInjectionOfCofactorOfCoproduct 
                                     and CanComputeAdditionForMorphisms
                                     and CanComputePreCompose ],
                                       -9999 - 1, #FIXME
                                       
  function( diagram, source, direct_product )
    local nr_components;
    
    nr_components := Length( source );
  
    return Sum( List( [ 1 .. nr_components ], 
     i -> PreCompose( source[ i ], InjectionOfCofactorOfCoproductWithGivenCoproduct( diagram, i, direct_product ) ) ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3  );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromCoproductWithGivenCoproduct,
                   IsAdditiveCategory
                   and CanComputeProjectionInFactorOfDirectProduct
                   and CanComputeAdditionForMorphisms 
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductWithGivenCoproduct,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject
                                     and IsAdditiveCategory
                                     and CanComputeProjectionInFactorOfDirectProduct
                                     and CanComputeAdditionForMorphisms
                                     and CanComputePreCompose ],
                                       -9999 - 1, #FIXME
                                       
  function( diagram, sink, coproduct )
    local nr_components;
    
    nr_components := Length( sink );
    
    return Sum( List( [ 1 .. nr_components ], 
      i -> PreCompose( ProjectionInFactorOfDirectProductWithGivenDirectProduct( diagram, i, coproduct ), sink[ i ] ) ) );
  
end  : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeAdditionForMorphisms,
                   IsAdditiveCategory
                   and CanComputeDirectSum
                   and CanComputeUniversalMorphismIntoDirectProduct
                   and CanComputeIdentityMorphism
                   and CanComputeUniversalMorphismFromCoproduct
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( \+,
                                       [ IsCapCategoryMorphism
                                     and IsAdditiveCategory
                                     and CanComputeDirectSum
                                     and CanComputeUniversalMorphismIntoDirectProduct
                                     and CanComputeIdentityMorphism
                                     and CanComputeUniversalMorphismFromCoproduct
                                     and CanComputePreCompose,
                                         IsCapCategoryMorphism ],
                                         -9999,
                                         
  function( mor1, mor2 )
    local return_value, B, direct_sum, componentwise_morphism, addition_morphism;
        
    if not IsIdenticalObj( CapCategory( mor1 ), CapCategory( mor2 ) ) or not IsEqualForObjects( Source( mor1 ), Source( mor2 ) ) or not IsEqualForObjects( Range( mor1 ), Range( mor2 ) ) then
      
      Error( "morphisms are not addable" );
      
    fi;
    
    B := Range( mor1 );
    
    direct_sum := DirectSum( B, B );
    
    componentwise_morphism := UniversalMorphismIntoDirectProduct( mor1, mor2 );
    
    addition_morphism := UniversalMorphismFromCoproduct( IdentityMorphism( B ), IdentityMorphism( B ) );
    
    return PreCompose( componentwise_morphism, addition_morphism );
    
end );

####################################
## Derived Methods for TerminalObject
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoTerminalObject,
                   CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject );

InstallMethod( UniversalMorphismIntoTerminalObject,
               [ IsCapCategoryObject and CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject ],
               -9999, #FIXME
              
  function( test_source )
    
    return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( CapCategory( test_source ) ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                   CanComputeZeroMorphism
                   and IsAdditiveCategory );

InstallMethod( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
               [ IsCapCategoryObject
                 and CanComputeZeroMorphism
                 and IsAdditiveCategory,
                 IsCapCategoryObject ],
                 -9999, #FIXME
                 
  function( test_source, terminal_object )
    
    return ZeroMorphism( test_source, terminal_object );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeTerminalObject, CanComputeZeroObject );

##
InstallMethod( TerminalObject,
               [ IsCapCategoryObject and CanComputeZeroObject ],
               - 9999, # FIXME
               
  function( object )
    
    return ZeroObject( object );
    
end );

##
InstallMethod( TerminalObject,
               [ IsCapCategory and CanComputeZeroObject ],
               -9999,
               
  function( category )
    
    return ZeroObject( category );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeTerminalObjectFunctorial,
                   CanComputeTerminalObject and CanComputeIdentityMorphism );

InstallMethod( TerminalObjectFunctorial,
               [ IsCapCategory and CanComputeTerminalObject and CanComputeIdentityMorphism ],
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return IdentityMorphism( terminal_object );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeTerminalObjectFunctorial,
                   CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObject );

InstallMethod( TerminalObjectFunctorial,
               [ IsCapCategory and CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObject ],
                 -9999,
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return UniversalMorphismIntoTerminalObject( terminal_object );
    
end );

####################################
## Derived Methods for InitialObject
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromInitialObject,
                   CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject );

InstallMethod( UniversalMorphismFromInitialObject,
               [ IsCapCategoryObject and CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject ],
               -9999, #FIXME
              
  function( test_sink )
    
    return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( CapCategory( test_sink ) ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject,
                   CanComputeZeroMorphism
                   and IsAdditiveCategory );

InstallMethod( UniversalMorphismFromInitialObjectWithGivenInitialObject,
               [ IsCapCategoryObject
                 and CanComputeZeroMorphism
                 and IsAdditiveCategory,
                 IsCapCategoryObject ],
                 -9999, #FIXME
                 
  function( test_sink, initial_object )
    
    return ZeroMorphism( initial_object, test_sink );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeInitialObject, CanComputeZeroObject );

##
InstallMethod( InitialObject,
               [ IsCapCategoryObject and CanComputeZeroObject ],
               - 9999, # FIXME
               
  function( object )
    
    return ZeroObject( object );
    
end );

##
InstallMethod( InitialObject,
               [ IsCapCategory and CanComputeZeroObject ],
               -9999,
               
  function( category )
    
    return ZeroObject( category );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeInitialObjectFunctorial,
                   CanComputeInitialObject and CanComputeIdentityMorphism );

InstallMethod( InitialObjectFunctorial,
               [ IsCapCategory and CanComputeInitialObject and CanComputeIdentityMorphism ],
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return IdentityMorphism( initial_object );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeInitialObjectFunctorial,
                   CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObject );

InstallMethod( InitialObjectFunctorial,
               [ IsCapCategory and CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObject ],
                 -9999,
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return UniversalMorphismFromInitialObject( initial_object );
    
end );

####################################
## Derived Methods for Pullback
####################################

##
InstallTrueMethodAndStoreImplication( CanComputePullback, CanComputeDirectProduct and 
                                       CanComputeProjectionInFactorOfDirectProduct and 
                                       CanComputePreCompose and
                                       CanComputeAdditionForMorphisms and
                                       CanComputeAdditiveInverseForMorphisms and
                                       CanComputeKernel );

##
InstallMethodWithToDoForIsWellDefined( PullbackOp,
                                       [ IsList,
                                         IsCapCategoryMorphism and
                                         CanComputeDirectProduct and 
                                         CanComputeProjectionInFactorOfDirectProduct and 
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeKernel ],
                                         -9999, #FIXME
                                         
  function( diagram, method_selection_morphism )
    local base, direct_product_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2, pullback, diff;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Range( c ), base ) ) then
    
      Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
      
    fi;
    
    direct_product_diagram := List( diagram, Source );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), diagram[ i ] ) );
    
    mor1 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    diff := mor1 - mor2;
    
    pullback := KernelObject( diff );
    
    if IsBound( pullback!.Genesis.PullbackAsKernelDiagram ) then
        
        Error( "pullback has two origins, which leads to inconsistencies." );
        
    fi;
    
    #unfortunately this is necessary here
    AddToGenesis(  pullback, "PullbackAsKernelDiagram", diff );
    
    AddToGenesis( pullback, "PullbackDiagram", diagram );
    
    SetFilterObj( pullback, WasCreatedAsPullback );
    
    return pullback;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethodAndStoreImplication( CanComputeProjectionInFactorOfPullback, CanComputeProjectionInFactorOfPullbackWithGivenPullback and 
                                                           CanComputePullback );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryMorphism and
                                         CanComputeProjectionInFactorOfPullbackWithGivenPullback and
                                         CanComputePullback ],
                                         
  function( diagram, projection_number, method_selection_morphism )
  
    return ProjectionInFactorOfPullbackWithGivenPullback( diagram, projection_number, PullbackOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeProjectionInFactorOfPullbackWithGivenPullback, CanComputeKernelEmb and
                                                                  CanComputeProjectionInFactorOfDirectProduct and
                                                                  CanComputePullback );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
# Of course, as mentioned in the introduction of this chapter, the user should never only install 
# the constructor of a universal object without also implementing the WithGiven-methods.
InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackWithGivenPullback,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and
                                         CanComputeKernelEmb and
                                         CanComputeProjectionInFactorOfDirectProduct and
                                         CanComputePullback ],
                                         -9999,
                                         
  function( diagram, projection_number, pullback )
    local embedding_in_direct_product, direct_product, direct_product_diagram, projection;
  
    if not WasCreatedAsKernel( pullback ) or not IsBound( Genesis( pullback )!.PullbackAsKernelDiagram ) then
    
      Error( "pullback had to be created as a kernel" );
    
    fi;
    
    embedding_in_direct_product := KernelEmb( Genesis( pullback )!.PullbackAsKernelDiagram );
    
    direct_product := Range( embedding_in_direct_product );
    
    if not WasCreatedAsDirectProduct( direct_product ) then
    
      Error( "pullback had to be created as a kernel of a morphism with a direct product as source" );
    
    fi;
    
    direct_product_diagram := direct_product!.Genesis.DirectFactors;
    
    projection := ProjectionInFactorOfDirectProductWithGivenDirectProduct( direct_product_diagram, projection_number, direct_product );
    
    return PreCompose( embedding_in_direct_product, projection );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoPullbackWithGivenPullback, CanComputeUniversalMorphismIntoDirectProduct and
                                                                             CanComputeKernelLift );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackWithGivenPullback,
                                       [
                                         IsList,
                                         IsList,
                                         IsCapCategoryObject
                                       ],
                                       
  function( diagram, source, pullback )
    local test_function;
    
    if not WasCreatedAsKernel( pullback ) then
      
      Error( "pullback had to be created as a kernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismIntoDirectProduct, source );
    
    return KernelLift( pullback, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoPullback, CanComputeUniversalMorphismIntoPullbackWithGivenPullback and 
                                                            CanComputePullback );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism ],
                                             
  function( diagram, source, method_selection_morphism )
    
    return UniversalMorphismIntoPullbackWithGivenPullback( diagram, source, PullbackOp( diagram, method_selection_morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputePullbackFunctorial,
                   CanComputePullback
                   and CanComputePreCompose
                   and CanComputeProjectionInFactorOfPullback
                   and CanComputeUniversalMorphismIntoPullback );

InstallMethodWithCacheFromObject( PullbackFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputePullback
                                    and CanComputePreCompose
                                    and CanComputeProjectionInFactorOfPullback
                                    and CanComputeUniversalMorphismIntoPullback ],
                                  
  function( morphism_of_morphisms, base_morphism )
    local pullback_diagram, source, diagram;
        
        pullback_diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        source := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( ProjectionInFactorOfPullback( pullback_diagram, i ), morphism_of_morphisms[i][2] ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        return UniversalMorphismIntoPullback( diagram, source );
        
end : ArgumentNumber := 2 );

####################################
## Derived Methods for Pushout
####################################

##
InstallTrueMethodAndStoreImplication( CanComputePushout, CanComputeCoproduct and 
                                      CanComputeInjectionOfCofactorOfCoproduct and 
                                      CanComputePreCompose and
                                      CanComputeAdditionForMorphisms and
                                      CanComputeAdditiveInverseForMorphisms and
                                      CanComputeCokernel );

##
InstallMethodWithToDoForIsWellDefined( PushoutOp,
                                       [ IsList,
                                         IsCapCategoryMorphism and
                                         CanComputeCoproduct and
                                         CanComputeInjectionOfCofactorOfCoproduct and
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeCokernel ],
                                         -9999, #FIXME
                                         
  function( diagram, method_selection_morphism )
    local cobase, coproduct_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2, pushout, diff;
    
    cobase := Source( diagram[1] );
        
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
       Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
    fi;
    
    coproduct_diagram := List( diagram, Range );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( diagram[ i ], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
    
    mor1 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    diff := mor1 - mor2;
    
    pushout := Cokernel( diff );
    
    if IsBound( pushout!.Genesis.PushoutAsCokernelDiagram ) then
        
        Error( "pushout has two origins, which leads to inconsistencies." );
        
    fi;
    
    #unfortunately this is necessary here
    AddToGenesis( pushout, "PushoutAsCokernelDiagram", diff );
    
    AddToGenesis( pushout, "PushoutDiagram", diagram );
    
    SetFilterObj( pushout, WasCreatedAsPushout );
    
    return pushout;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

#
InstallTrueMethodAndStoreImplication( CanComputeInjectionOfCofactorOfPushout, CanComputeInjectionOfCofactorOfPushoutWithGivenPushout and 
                                                           CanComputePushout );

InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfPushoutOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryMorphism and
                                         CanComputeInjectionOfCofactorOfPushoutWithGivenPushout and
                                         CanComputePushout ],
                                         
  function( diagram, injection_number, method_selection_morphism )
    
    return InjectionOfCofactorOfPushoutWithGivenPushout( diagram, injection_number, PushoutOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

# ##
InstallTrueMethodAndStoreImplication( CanComputeInjectionOfCofactorOfPushoutWithGivenPushout, CanComputeCokernelProj and
                                                                  CanComputeInjectionOfCofactorOfCoproduct and
                                                                  CanComputePushout );

# FIXME: WARNING: This method only applies if the pushout was created as a cokernel. If the
# user gives his own pushout method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfPushoutWithGivenPushout,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and
                                         CanComputeCokernelProj and
                                         CanComputeInjectionOfCofactorOfCoproduct and
                                         CanComputePushout ],
                                         -9999,
                                         
  function( diagram, injection_number, pushout )
    local projection_from_coproduct, coproduct, coproduct_diagram, injection;
  
    if not WasCreatedAsCokernel( pushout ) or not IsBound( Genesis( pushout )!.PushoutAsCokernelDiagram ) then
    
      Error( "pushout had to be created as a cokernel" );
    
    fi;
    
    projection_from_coproduct := CokernelProj( Genesis( pushout )!.PushoutAsCokernelDiagram );
    
    coproduct := Source( projection_from_coproduct );
    
    if not WasCreatedAsCoproduct( coproduct ) then
    
      Error( "pushout had to be created as a cokernel of a morphism with a coproduct as range" );
    
    fi;
    
    coproduct_diagram := coproduct!.Genesis.Cofactors;
    
    injection := InjectionOfCofactorOfCoproductWithGivenCoproduct( coproduct_diagram, injection_number, coproduct );
    
    return PreCompose( injection, projection_from_coproduct );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromPushoutWithGivenPushout, CanComputeUniversalMorphismFromCoproduct and
                                                                           CanComputeCokernelColift );

# FIXME: WARNING: This method only applies if the pushout was created as a cokernel. If the
# user gives his own pushout method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutWithGivenPushout,
                                       [
                                         IsList,
                                         IsList,
                                         IsCapCategoryObject
                                       ],
                                       
  function( diagram, sink, pushout )
    local test_function;
    
    if not WasCreatedAsCokernel( pushout ) then
      
      Error( "pushout had to be created as a cokernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismFromCoproduct, sink );
    
    return CokernelColift( pushout, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromPushout, CanComputeUniversalMorphismFromPushoutWithGivenPushout and 
                                                           CanComputePushout );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism ],
                                             
  function( diagram, sink, method_selection_morphism )
    
    return UniversalMorphismFromPushoutWithGivenPushout( diagram, sink, PushoutOp( diagram, method_selection_morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputePushoutFunctorial,
                   CanComputePushout
                   and CanComputePreCompose
                   and CanComputeInjectionOfCofactorOfPushout
                   and CanComputeUniversalMorphismFromPushout );

InstallMethodWithCacheFromObject( PushoutFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputePushout
                                    and CanComputePreCompose
                                    and CanComputeInjectionOfCofactorOfPushout
                                    and CanComputeUniversalMorphismFromPushout ],
                                  
  function( morphism_of_morphisms, cobase_morphism )
    local pushout_diagram, sink, diagram;
        
        pushout_diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        sink := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( morphism_of_morphisms[i][2], InjectionOfCofactorOfPushout( pushout_diagram, i ) ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        return UniversalMorphismFromPushout( diagram, sink );
        
end : ArgumentNumber := 2 );

####################################
## Derived Methods for Image
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeImage, CanComputeImageEmbedding );

InstallMethod( ImageObject,
               [ IsCapCategoryMorphism and CanComputeImageEmbedding ],
               -9999, #FIXME
                                    
  function( mor )
    local image;
    
    ## ImageEmbedding creates an ImageObject as source
    image := Source( ImageEmbedding( mor ) );
    
    return image;
    
end );

## Note: As long as the above derived ImageObject-function is used,
## there is no need to implement ImageEmbeddingWithGivenImage in order
## to keep these methods consistent.
##
InstallTrueMethodAndStoreImplication( CanComputeImageEmbedding, CanComputeKernelEmb and CanComputeCokernelProj );

InstallMethod( ImageEmbedding,
               [ IsCapCategoryMorphism and CanComputeImageEmbedding ],
               -9999, #FIXME
                                    
  function( mor )
    local image_embedding, image;
    
    ## consistency check
    if HasImageObject( mor ) then
      
      return ImageEmbeddingWithGivenImage( mor, ImageObject( mor ) );
      
    fi;
    
    image_embedding := KernelEmb( CokernelProj( mor ) );
    
    image := Source( image_embedding );
    
    AddToGenesis( image, "ImageDiagram", mor );
    
    SetFilterObj( image, WasCreatedAsImage );
    
    SetImageObject( mor, image );
    
    return image_embedding;
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeImageEmbedding, CanComputeImageEmbeddingWithGivenImage and CanComputeImage );

InstallMethod( ImageEmbedding,
               [ IsCapCategoryMorphism
                 and CanComputeImageEmbeddingWithGivenImage
                 and CanComputeImage ],
                 -9900, #FIXME
                 
  function( morphism )
    
    return ImageEmbeddingWithGivenImage( ImageObject( morphism ), morphism );
  
end );


##
InstallTrueMethodAndStoreImplication( CanComputeCoastrictionToImage, CanComputeCoastrictionToImageWithGivenImage and CanComputeImage );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryMorphism
                 and CanComputeCoastrictionToImageWithGivenImage 
                 and CanComputeImage ],
                 -9900, #FIXME
                 
  function( morphism )
    
    return CoastrictionToImageWithGivenImage( Image( morphism ), morphism );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeCoastrictionToImage,
                   CanComputeImageEmbedding
                   and CanComputeMonoAsKernelLift );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryMorphism
                 and CanComputeImageEmbedding
                 and CanComputeMonoAsKernelLift ],
                 -9999, #FIXME
                 
  function( morphism )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return MonoAsKernelLift( image_embedding, morphism );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromImage,
                   CanComputeUniversalMorphismFromImageWithGivenImage
                   and CanComputeImage );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImage,
               [ IsCapCategoryMorphism
                 and CanComputeUniversalMorphismFromImageWithGivenImage
                 and CanComputeImage,
                 IsList ],
                 -9900, #FIXME
                 
  function( morphism, test_factorization )
    
    return UniversalMorphismFromImageWithGivenImage( morphism, test_factorization, ImageObject( morphism ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 1 );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismFromImage,
                   CanComputeMonoAsKernelLift
                   and CanComputeImageEmbedding );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImage,
               [ IsCapCategoryMorphism
                 and CanComputeMonoAsKernelLift
                 and CanComputeImageEmbedding,
                 IsList ],
                 -9999, #FIXME
                 
  function( morphism, test_factorization )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return MonoAsKernelLift( test_factorization[2], image_embedding );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 1 );



