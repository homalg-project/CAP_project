
###########################
##
## Methods returning a boolean
##
###########################

##
AddDerivationToCAP( IsZeroForObjects,
                    [ [ IsEqualForMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ZeroMorphism, 1 ] ],
                 
  function( object )
  
    return IsEqualForMorphisms( IdentityMorphism( object ), ZeroMorphism( object, object ) );
    
end : Description := "IsZeroForObjects by comparing identity morphism with zero morphism" );

##
AddDerivationToCAP( IsMonomorphism,
                    [ [ IsZeroForObjects, 1 ],
                      [ KernelObject, 1 ] ],
  function( morphism )
    
    return IsZero( KernelObject( morphism ) );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "IsMonomorphism by deciding if the kernel is a zero object" );

##
AddDerivationToCAP( IsMonomorphism,
                    [ [ IsIsomorphism, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ UniversalMorphismIntoFiberProduct, 1 ] ],
                 
  function( morphism )
    local pullback_diagram, pullback_projection_1, pullback_projection_2, identity, diagonal_morphism;
      
      pullback_diagram := [ morphism, morphism ];
      
      identity := IdentityMorphism( Source( morphism ) );
      
      diagonal_morphism := UniversalMorphismIntoFiberProduct( pullback_diagram, identity, identity );
      
      return IsIsomorphism( diagonal_morphism );
    
end : Description := "IsMonomorphism by deciding if the diagonal morphism is an isomorphism" );

##
AddDerivationToCAP( IsEpimorphism,
                    [ [ IsZeroForObjects, 1 ],
                      [ Cokernel, 1 ] ],
  function( morphism )
    
    return IsZero( Cokernel( morphism ) );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "IsEpimorphism by deciding if the cokernel is a zero object" );

##
AddDerivationToCAP( IsEpimorphism,
                    [ [ IdentityMorphism, 1 ],
                      [ UniversalMorphismFromPushout, 1 ],
                      [ IsIsomorphism, 1 ] ],
                 
  function( morphism )
    local pushout_diagram, identity, codiagonal_morphism;
      
      pushout_diagram := [ morphism, morphism ];
      
      identity := IdentityMorphism( Range( morphism ) );
      
      codiagonal_morphism := UniversalMorphismFromPushout( pushout_diagram, identity, identity );
      
      return IsIsomorphism( codiagonal_morphism );
    
end : Description := "IsEpimorphism by deciding if the codiagonal morphism is an isomorphism" );

##
AddDerivationToCAP( IsIsomorphism,
                    [ [ IsMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ] ],
                 
  function( morphism )
    
    return IsMonomorphism( morphism ) and IsEpimorphism( morphism );
    
end : CategoryFilter := IsAbelianCategory,
      Description := "IsIsomorphism by deciding if it is a mono and an epi" );

##
AddDerivationToCAP( IsEqualAsSubobjects,
                    [ [ Dominates, 2 ] ],
               
  function( sub1, sub2 );
    
    return Dominates( sub1, sub2 ) and Dominates( sub2, sub1 );
    
end : Description := "IsEqualAsSubobjects(sub1, sub2) if sub1 dominates sub2 and vice versa" );

##
AddDerivationToCAP( IsEqualAsFactorobjects,
                    [ [ Codominates, 2 ] ],
                                  
  function( factor1, factor2 )
    
    return Codominates( factor1, factor2 ) and Codominates( factor1, factor2 );
    
end : Description := "IsEqualAsFactorobjects(factor1, factor2) if factor1 dominates factor2 and vice versa" );

##
AddDerivationToCAP( Dominates,
                    [ [ CokernelProj, 2 ],
                      [ Codominates, 1 ] ],
                                  
  function( sub1, sub2 )
    local cokernel_projection_1, cokernel_projection_2;
    
    cokernel_projection_1 := CokernelProj( sub1 );
    
    cokernel_projection_2 := CokernelProj( sub2 );
    
    return Codominates( cokernel_projection_1, cokernel_projection_2 );
    
end : Description := "Dominates using Codominates and duality by cokernel" );

##
AddDerivationToCAP( Dominates,
                    [ [ CokernelProj, 1 ],
                      [ PreCompose, 1 ],
                      [ IsZeroForMorphisms, 1 ] ],
                                  
  function( sub1, sub2 )
    local cokernel_projection, composition;
    
    cokernel_projection := CokernelProj( sub2 );
    
    composition := PreCompose( sub1, cokernel_projection );
    
    return IsZero( composition );
    
end : Description := "Dominates(sub1, sub2) by deciding if sub1 composed with CokernelProj(sub2) is zero" );

##
AddDerivationToCAP( Codominates,
                    [ [ KernelEmb, 2 ],
                      [ Dominates, 1 ] ],
                                  
  function( factor1, factor2 )
    local kernel_embedding_1, kernel_embedding_2;
    
    kernel_embedding_1 := KernelEmb( factor1 );
    
    kernel_embedding_2 := KernelEmb( factor2 );
    
    return Dominates( kernel_embedding_2, kernel_embedding_1 );
    
end : Description := "Codominates using Dominates and duality by kernel" );

##
AddDerivationToCAP( Codominates,
                    [ [ KernelEmb, 1 ],
                      [ PreCompose, 1 ],
                      [ IsZeroForMorphisms, 1 ] ],
                                  
  function( factor1, factor2 )
    local kernel_embedding, composition;
    
    kernel_embedding := KernelEmb( factor2 );
    
    composition := PreCompose( kernel_embedding, factor1 );
    
    return IsZero( composition );
    
end : Description := "Codominates(factor1, factor2) by deciding if KernelEmb(factor2) composed with factor1 is zero" );

###########################
##
## Methods returning a morphism where the source and range can directly be read of from the input
##
###########################

##
AddDerivationToCAP( ZeroMorphism,
                    [ [ PreCompose, 1 ],
                      [ UniversalMorphismIntoTerminalObject, 1 ],
                      [ UniversalMorphismFromInitialObject, 1 ] ],
                 
  function( obj_source, obj_range )
    
    return PreCompose( UniversalMorphismIntoTerminalObject( obj_source ), UniversalMorphismFromInitialObject( obj_range ) );
    
  end : CategoryFilter := IsAdditiveCategory,
        Description := "Zero morphism by composition of morphism into and from zero object" );

##
AddDerivationToCAP( PostCompose,
                    [ [ PreCompose, 1 ] ],
                    
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end : Description := "PostCompose using PreCompose and swapping arguments" );

##
AddDerivationToCAP( Inverse,
                    [ [ IdentityMorphism, 1 ],
                      [ MonoAsKernelLift, 1 ] ],
                                       
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );
        
end : Description := "Inverse using MonoAsKernelLift of an identity morphism" );

##
AddDerivationToCAP( Inverse,
                    [ [ IdentityMorphism, 1 ],
                      [ EpiAsCokernelColift, 1 ] ],
                                       
  function( mor )
    local identity_of_source;
    
    identity_of_source := IdentityMorphism( Source( mor ) );
    
    return EpiAsCokernelColift( mor, identity_of_source );
      
end : Description := "Inverse using EpiAsCokernelColift of an identity morphism" );

##
AddDerivationToCAP( KernelLiftWithGivenKernelObject,
                    [ [ MonoAsKernelLift, 1 ],
                      [ KernelEmbWithGivenKernelObject, 1 ] ],
                      
    function( mor, test_morphism, kernel )
      
      return MonoAsKernelLift( KernelEmbWithGivenKernelObject( mor, kernel ), test_morphism );
      
end : Description := "KernelLiftWithGivenKernelObject using MonoAsKernelLift and KernelEmbWithGivenKernelObject" );

##
AddDerivationToCAP( CokernelColiftWithGivenCokernel,
                    [ [ EpiAsCokernelColift, 1 ],
                      [ CokernelProjWithGivenCokernel, 1 ] ],
                                           
    function( mor, test_morphism, cokernel )
      
      return EpiAsCokernelColift( CokernelProjWithGivenCokernel( mor, cokernel ), test_morphism );
      
end : Description := "CokernelColiftWithGivenCokernel using EpiAsCokernelColift and CokernelProjWithGivenCokernel" );

#
AddDerivationToCAP( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                    [ [ AdditionForMorphisms, 1 ],
                      [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ], ## nr_components would be the correct number
                      [ PreCompose, 2 ] ], ## nr_components would be the correct number
                                       
  function( diagram, source, direct_product )
    local nr_components;
    
    nr_components := Length( source );
  
    return Sum( List( [ 1 .. nr_components ], 
     i -> PreCompose( source[ i ], InjectionOfCofactorOfCoproductWithGivenCoproduct( diagram, i, direct_product ) ) ) );
  
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismIntoDirectProductWithGivenDirectProduct using the injections of the direct sum" );

##
AddDerivationToCAP( UniversalMorphismFromCoproductWithGivenCoproduct,
                    [ [ AdditionForMorphisms, 1 ],
                      [ PreCompose, 2 ], ## nr_components would be the correct number
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ] ], ## nr_components would be the correct number
                      
  function( diagram, sink, coproduct )
    local nr_components;
    
    nr_components := Length( sink );
    
    return Sum( List( [ 1 .. nr_components ], 
      i -> PreCompose( ProjectionInFactorOfDirectProductWithGivenDirectProduct( diagram, i, coproduct ), sink[ i ] ) ) );
  
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismFromCoproductWithGivenCoproduct using projections of the direct sum" );

##
AddDerivationToCAP( AdditionForMorphisms,
                    [ [ UniversalMorphismIntoDirectProduct, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ UniversalMorphismFromCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                      
  function( mor1, mor2 )
    local return_value, B, identity_morphism_B, componentwise_morphism, addition_morphism;
    
    B := Range( mor1 );
    
    componentwise_morphism := UniversalMorphismIntoDirectProduct( mor1, mor2 );
    
    identity_morphism_B := IdentityMorphism( B );
    
    addition_morphism := UniversalMorphismFromCoproduct( identity_morphism_B, identity_morphism_B );
    
    return PreCompose( componentwise_morphism, addition_morphism );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "AdditionForMorphisms(mor1, mor2) as the composition of (mor1,mor2) with the codiagonal morphism" );

###########################
##
## Methods returning a morphism with source or range constructed within the method!
## If there is a method available which only constructs this source or range,
## one has to be sure that this source is equal to that construction (by IsEqualForObjects)
##
###########################

##
AddDerivationToCAP( KernelLift,
                    [ [ MonoAsKernelLift, 1 ],
                      [ KernelEmb, 1 ] ],
  function( mor, test_morphism )
    local kernel_lift, kernel;
    
    kernel_lift := MonoAsKernelLift( KernelEmb( mor ), test_morphism );
    
    return kernel_lift;
    
end : Description := "KernelLift using MonoAsKernelLift and KernelEmb" );

##
AddDerivationToCAP( KernelEmb,
                    [ [ KernelEmbWithGivenKernelObject, 1 ],
                      [ KernelObject, 1 ] ],
                      
  function( mor )
    
    return KernelEmbWithGivenKernelObject( mor, KernelObject( mor ) );
    
end : Description := "KernelEmb using KernelEmbWithGivenKernelObject and KernelObject" );

##
AddDerivationToCAP( KernelLift,
                    [ [ KernelLiftWithGivenKernelObject, 1 ],
                      [ KernelObject, 1 ] ],
               
  function( morphism, test_morphism )
    
    return KernelLiftWithGivenKernelObject( morphism, test_morphism, KernelObject( morphism ) );
    
end : Description := "KernelLift using KernelLiftWithGivenKernelObject and KernelObject" );

##
AddDerivationToCAP( KernelObjectFunctorial,
                    [ [ KernelLift, 1 ],
                      [ PreCompose, 1 ],
                      [ KernelEmb, 1 ] ],
                                  
  function( alpha, mu, alpha_p )
    
    return KernelLift(
                alpha_p,
                PreCompose( KernelEmb( alpha ), mu )
              );
    
end : Description := "KernelObjectFunctorial using the universality of the kernel" );

##
AddDerivationToCAP( CokernelColift,
                    [ [ EpiAsCokernelColift, 1 ],
                      [ CokernelProj, 1 ] ],
                                  
  function( mor, test_morphism )
    
    return EpiAsCokernelColift( CokernelProj( mor ), test_morphism );
    
end : Description := "CokernelColift using EpiAsCokernelColift and CokernelProj" );

##
AddDerivationToCAP( CokernelProj,
                    [ [ CokernelProjWithGivenCokernel, 1 ] ],
                    
  function( mor )
    
    return CokernelProjWithGivenCokernel( mor, Cokernel( mor ) );
    
end : Description := "CokerneProj using CokernelProjWithGivenCokernel and Cokernel" );

##
AddDerivationToCAP( CokernelColift,
                    [ [ CokernelColiftWithGivenCokernel, 1 ],
                      [ Cokernel, 1 ] ],
               
  function( morphism, test_morphism )
    
    return CokernelColiftWithGivenCokernel( morphism, test_morphism, Cokernel( morphism ) );
    
end : Description := "CokernelColift using CokernelColiftWithGivenCokernel and Cokernel" );

##
AddDerivationToCAP( CokernelFunctorial,
                    [ [ CokernelColift, 1 ],
                      [ PreCompose, 1 ],
                      [ CokernelProj, 1 ] ],
                                  
  function( alpha, nu, alpha_p )
    
    return CokernelColift(
                alpha,
                PreCompose( nu, CokernelProj( alpha_p ) )
              );
    
end : Description := "CokernelFunctorial using the universality of the cokernel" );

##
AddDerivationToCAP( UniversalMorphismFromCoproduct,
                    [ [ UniversalMorphismFromCoproductWithGivenCoproduct, 1 ],
                      [ Coproduct, 1 ] ],
                                       
  function( diagram, sink )
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( diagram, sink, CallFuncList( Coproduct, List( sink, Source ) ) );
    
end : Description := "UniversalMorphismFromCoproduct using UniversalMorphismFromCoproductWithGivenCoproduct and Coproduct" );

##
AddDerivationToCAP( InjectionOfCofactorOfCoproduct,
                    [ [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 1 ],
                      [ Coproduct, 1 ] ],
                                         
  function( object_product_list, injection_number )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct( object_product_list, injection_number, CallFuncList( Coproduct, object_product_list ) );
    
end : Description := "InjectionOfCofactorOfCoproduct using InjectionOfCofactorOfCoproductWithGivenCoproduct and Coproduct" );

##
AddDerivationToCAP( CoproductFunctorial,
                    [ [ PreCompose, 2 ], ## Length( morphism_list ) would be the correct number
                      [ InjectionOfCofactorOfCoproduct, 2 ], ## Length( morphism_list ) would be the correct number
                      [ UniversalMorphismFromCoproduct, 1 ] ], 
                                  
  function( morphism_list, caching_object )
    local coproduct_diagram, sink, diagram;
        
        coproduct_diagram := List( morphism_list, mor -> Range( mor ) );
        
        sink := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( morphism_list[i], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
        
        diagram := List( morphism_list, mor -> Source( mor ) );
        
        return UniversalMorphismFromCoproduct( diagram, sink );
        
end : Description := "CoproductFunctorial using the universality of the coproduct" );

##
AddDerivationToCAP( UniversalMorphismIntoDirectProduct,
                    [ [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 1 ],
                      [ DirectProduct, 1 ] ],
                                       
  function( diagram, source )
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( diagram, source, CallFuncList( DirectProduct, List( source, Range ) ) );
    
end : Description := "DirectProduct using UniversalMorphismIntoDirectProductWithGivenDirectProduct and DirectProduct" );

##
AddDerivationToCAP( ProjectionInFactorOfDirectProduct,
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 1 ],
                      [ DirectProduct, 1 ] ],
                                         
  function( object_product_list, projection_number )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct( object_product_list, projection_number, CallFuncList( DirectProduct, object_product_list ) );
    
end : Description := "ProjectionInFactorOfDirectProduct using ProjectionInFactorOfDirectProductWithGivenDirectProduct and DirectProduct" );

##
AddDerivationToCAP( DirectProductFunctorial,
                    [ [ PreCompose, 2 ], ## Length( morphism_list ) would be the correct number
                      [ ProjectionInFactorOfDirectProduct, 2 ], ## Length( morphism_list ) would be the correct number
                      [ UniversalMorphismIntoDirectProduct, 1 ] ],
                                  
  function( morphism_list, caching_object )
    local direct_product_diagram, source, diagram;
        
        direct_product_diagram := List( morphism_list, mor -> Source( mor ) );
        
        source := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), morphism_list[i] ) );
        
        diagram := List( morphism_list, mor -> Range( mor ) );
        
        return UniversalMorphismIntoDirectProduct( diagram, source );
        
end : Description := "DirectProductFunctorial using universality of direct product" );

##
AddDerivationToCAP( DirectSumFunctorial,
                    [ [ DirectProductFunctorial, 1 ] ],
                 
  function( morphism_list )
    
    return DirectProductFunctorial( morphism_list );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "DirectSumFunctorial using DirectProductFunctorial");

##
AddDerivationToCAP( DirectSumFunctorial,
                    [ [ CoproductFunctorial, 1 ] ],
                                  
  function( morphism_list )
    
    return CoproductFunctorial( morphism_list );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "DirectSumFunctorial using CoproductFunctorial" );

###########################
##
## Methods returning an object
##
###########################

##
AddDerivationToCAP( KernelObject,
                    [ [ KernelEmb, 1 ] ],
                    
  function( mor )
    
    return Source( KernelEmb( mor ) );
    
end : Description := "KernelObject as the source of KernelEmb" );

##
AddDerivationToCAP( Cokernel,
                    [ [ CokernelProj, 1 ] ],
                                  
  function( mor )
    
    return Range( CokernelProj( mor ) );
    
end : Description := "Cokernel as the range of CokernelProj" );

##
AddDerivationToCAP( Coproduct,
                    [ [ InjectionOfCofactorOfCoproduct, 1 ] ],
                                        
  function( object_product_list )
    
    return Range( InjectionOfCofactorOfCoproduct( object_product_list, 1 ) );
    
end : Description := "Coproduct as the range of the first injection" );

##
AddDerivationToCAP( DirectProduct,
                    [ [ ProjectionInFactorOfDirectProduct, 1 ] ],
                                        
  function( object_product_list )
    
    return Source( ProjectionInFactorOfDirectProduct( object_product_list, 1 ) );
    
end : Description := "DirectProduct as Source of ProjectionInFactorOfDirectProduct" );

## should we add IsAdditiveCategory?
AddDerivationToCAP( DirectProduct,
                    [ [ DirectSum, 1 ] ],
  function( object_product_list )
    
    return DirectSum( object_product_list );
    
end : Description := "DirectProduct equals DirectSum" );

## should we add IsAdditiveCategory?
AddDerivationToCAP( Coproduct,
                    [ [ DirectSum, 1 ] ],
  function( object_product_list )
    
    return DirectSum( object_product_list );
    
end : Description := "Coproduct equals DirectSum"  );


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
## Derived Methods for FiberProduct
####################################

##
InstallTrueMethodAndStoreImplication( CanComputeFiberProduct, CanComputeDirectProduct and 
                                       CanComputeProjectionInFactorOfDirectProduct and 
                                       CanComputePreCompose and
                                       CanComputeAdditionForMorphisms and
                                       CanComputeAdditiveInverseForMorphisms and
                                       CanComputeKernelObject );

##
InstallMethodWithToDoForIsWellDefined( FiberProductOp,
                                       [ IsList,
                                         IsCapCategoryMorphism and
                                         CanComputeDirectProduct and 
                                         CanComputeProjectionInFactorOfDirectProduct and 
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeKernelObject ],
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
    
    if IsBound( pullback!.Genesis.FiberProductAsKernelObjectDiagram ) then
        
        Error( "pullback has two origins, which leads to inconsistencies." );
        
    fi;
    
    #unfortunately this is necessary here
    AddToGenesis(  pullback, "FiberProductAsKernelObjectDiagram", diff );
    
    AddToGenesis( pullback, "FiberProductDiagram", diagram );
    
    SetFilterObj( pullback, WasCreatedAsFiberProduct );
    
    return pullback;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethodAndStoreImplication( CanComputeProjectionInFactorOfFiberProduct, CanComputeProjectionInFactorOfFiberProductWithGivenFiberProduct and 
                                                           CanComputeFiberProduct );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfFiberProductOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryMorphism and
                                         CanComputeProjectionInFactorOfFiberProductWithGivenFiberProduct and
                                         CanComputeFiberProduct ],
                                         
  function( diagram, projection_number, method_selection_morphism )
  
    return ProjectionInFactorOfFiberProductWithGivenFiberProduct( diagram, projection_number, FiberProductOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeProjectionInFactorOfFiberProductWithGivenFiberProduct, CanComputeKernelEmb and
                                                                  CanComputeProjectionInFactorOfDirectProduct and
                                                                  CanComputeFiberProduct );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
# Of course, as mentioned in the introduction of this chapter, the user should never only install 
# the constructor of a universal object without also implementing the WithGiven-methods.
InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and
                                         CanComputeKernelEmb and
                                         CanComputeProjectionInFactorOfDirectProduct and
                                         CanComputeFiberProduct ],
                                         -9999,
                                         
  function( diagram, projection_number, pullback )
    local embedding_in_direct_product, direct_product, direct_product_diagram, projection;
  
    if not WasCreatedAsKernelObject( pullback ) or not IsBound( Genesis( pullback )!.FiberProductAsKernelObjectDiagram ) then
    
      Error( "pullback had to be created as a kernel" );
    
    fi;
    
    embedding_in_direct_product := KernelEmb( Genesis( pullback )!.FiberProductAsKernelObjectDiagram );
    
    direct_product := Range( embedding_in_direct_product );
    
    if not WasCreatedAsDirectProduct( direct_product ) then
    
      Error( "pullback had to be created as a kernel of a morphism with a direct product as source" );
    
    fi;
    
    direct_product_diagram := direct_product!.Genesis.DirectProductDiagram;
    
    projection := ProjectionInFactorOfDirectProductWithGivenDirectProduct( direct_product_diagram, projection_number, direct_product );
    
    return PreCompose( embedding_in_direct_product, projection );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoFiberProductWithGivenFiberProduct, CanComputeUniversalMorphismIntoDirectProduct and
                                                                             CanComputeKernelLift );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                                       [
                                         IsList,
                                         IsList,
                                         IsCapCategoryObject
                                       ],
                                       
  function( diagram, source, pullback )
    local test_function;
    
    if not WasCreatedAsKernelObject( pullback ) then
      
      Error( "pullback had to be created as a kernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismIntoDirectProduct, source );
    
    return KernelLift( pullback, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethodAndStoreImplication( CanComputeUniversalMorphismIntoFiberProduct, CanComputeUniversalMorphismIntoFiberProductWithGivenFiberProduct and 
                                                            CanComputeFiberProduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoFiberProductOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism ],
                                             
  function( diagram, source, method_selection_morphism )
    
    return UniversalMorphismIntoFiberProductWithGivenFiberProduct( diagram, source, FiberProductOp( diagram, method_selection_morphism ) );
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeFiberProductFunctorial,
                   CanComputeFiberProduct
                   and CanComputePreCompose
                   and CanComputeProjectionInFactorOfFiberProduct
                   and CanComputeUniversalMorphismIntoFiberProduct );

InstallMethodWithCacheFromObject( FiberProductFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputeFiberProduct
                                    and CanComputePreCompose
                                    and CanComputeProjectionInFactorOfFiberProduct
                                    and CanComputeUniversalMorphismIntoFiberProduct ],
                                  
  function( morphism_of_morphisms, base_morphism )
    local pullback_diagram, source, diagram;
        
        pullback_diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        source := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, i ), morphism_of_morphisms[i][2] ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        return UniversalMorphismIntoFiberProduct( diagram, source );
        
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
    
    coproduct_diagram := coproduct!.Genesis.CoproductDiagram;
    
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
InstallTrueMethodAndStoreImplication( CanComputeImageObject, CanComputeImageEmbedding );

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
## there is no need to implement ImageEmbeddingWithGivenImageObject in order
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
      
      return ImageEmbeddingWithGivenImageObject( mor, ImageObject( mor ) );
      
    fi;
    
    image_embedding := KernelEmb( CokernelProj( mor ) );
    
    image := Source( image_embedding );
    
    AddToGenesis( image, "ImageDiagram", mor );
    
    SetFilterObj( image, WasCreatedAsImageObject );
    
    SetImageObject( mor, image );
    
    return image_embedding;
    
end );

##
InstallTrueMethodAndStoreImplication( CanComputeImageEmbedding, CanComputeImageEmbeddingWithGivenImageObject and CanComputeImageObject );

InstallMethod( ImageEmbedding,
               [ IsCapCategoryMorphism
                 and CanComputeImageEmbeddingWithGivenImageObject
                 and CanComputeImageObject ],
                 -9900, #FIXME
                 
  function( morphism )
    
    return ImageEmbeddingWithGivenImageObject( ImageObject( morphism ), morphism );
  
end );


##
InstallTrueMethodAndStoreImplication( CanComputeCoastrictionToImage, CanComputeCoastrictionToImageWithGivenImageObject and CanComputeImageObject );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryMorphism
                 and CanComputeCoastrictionToImageWithGivenImageObject 
                 and CanComputeImageObject ],
                 -9900, #FIXME
                 
  function( morphism )
    
    return CoastrictionToImageWithGivenImageObject( Image( morphism ), morphism );
    
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
                   CanComputeUniversalMorphismFromImageWithGivenImageObject
                   and CanComputeImageObject );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImage,
               [ IsCapCategoryMorphism
                 and CanComputeUniversalMorphismFromImageWithGivenImageObject
                 and CanComputeImageObject,
                 IsList ],
                 -9900, #FIXME
                 
  function( morphism, test_factorization )
    
    return UniversalMorphismFromImageWithGivenImageObject( morphism, test_factorization, ImageObject( morphism ) );
    
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



