
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

##
AddDerivationToCAP( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                    [ [ ZeroMorphism, 1 ] ],
                 
  function( test_source, terminal_object )
    
    return ZeroMorphism( test_source, terminal_object );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject computing the zero morphism");

##
AddDerivationToCAP( UniversalMorphismFromInitialObjectWithGivenInitialObject,
                    [ [ ZeroMorphism, 1 ] ],
                 
  function( test_sink, initial_object )
    
    return ZeroMorphism( initial_object, test_sink );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismFromInitialObjectWithGivenInitialObject computing the zero morphism" );

##
AddDerivationToCAP( ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                    [ [ FiberProductEmbeddingInDirectSum, 1 ],
                      [ ProjectionInFactorOfDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                      
  function( diagram, projection_number, pullback )
    local embedding_in_direct_product, direct_product, direct_product_diagram, projection;
    
    embedding_in_direct_product := FiberProductEmbeddingInDirectSum( diagram );
    
    direct_product_diagram := List( diagram, Source );
    
    projection := ProjectionInFactorOfDirectProduct( direct_product_diagram, projection_number );
    
    return PreCompose( embedding_in_direct_product, projection );
    
end : Description := "ProjectionInFactorOfFiberProductWithGivenFiberProduct by composing the embedding of fiber product in the direct product with the direct sum projection" );


##
AddDerivationToCAP( InjectionOfCofactorOfPushoutWithGivenPushout,
                    [ [ DirectSumProjectionInPushout, 1 ],
                      [ InjectionOfCofactorOfCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                                         
  function( diagram, injection_number, pushout )
    local projection_from_coproduct, coproduct, coproduct_diagram, injection;
    
    projection_from_coproduct := DirectSumProjectionInPushout( diagram );
    
    coproduct_diagram := List( diagram, Range );
    
    injection := InjectionOfCofactorOfCoproduct( coproduct_diagram, injection_number );
    
    return PreCompose( injection, projection_from_coproduct );
    
end : Description := "InjectionOfCofactorOfPushoutWithGivenPushout by composing the coproduct injection with the direct sum projection to the pushout" );


##
AddDerivationToCAP( MonoAsKernelLift,
                    [ [ Lift, 1 ] ],
                    
  function( alpha, beta )
    
    ## Caution with the order of the arguments!
    return Lift( beta, alpha );
    
end : Description := "MonoAsKernelLift using Lift" );

##
AddDerivationToCAP( EpiAsCokernelColift,
                    [ [ Lift, 1 ] ],
                    
  function( alpha, beta )
    
    return Colift( alpha, beta );
    
end : Description := "EpiAsCokernelColift using Colift" );

##
AddDerivationToCAP( IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                    [ [ IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( diagram ) );
    
end : Description := "IsomorphismFromFiberProductToKernelOfDiagonalDifference as the inverse of IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct" );

##
AddDerivationToCAP( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct,
                    [ [ IsomorphismFromFiberProductToKernelOfDiagonalDifference, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromFiberProductToKernelOfDiagonalDifference( diagram ) );
    
end : Description := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct as the inverse of IsomorphismFromFiberProductToKernelOfDiagonalDifference" );

##
AddDerivationToCAP( IsomorphismFromCokernelOfDiagonalDifferenceToPushout,
                    [ [ IsomorphismFromPushoutToCokernelOfDiagonalDifference, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromPushoutToCokernelOfDiagonalDifference( diagram ) );
    
end : Description := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout as the inverse of IsomorphismFromPushoutToCokernelOfDiagonalDifference" );

##
AddDerivationToCAP( IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                    [ [ IsomorphismFromCokernelOfDiagonalDifferenceToPushout , 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromCokernelOfDiagonalDifferenceToPushout( diagram ) );
    
end : Description := "IsomorphismFromPushoutToCokernelOfDiagonalDifference as the inverse of IsomorphismFromCokernelOfDiagonalDifferenceToPushout" );


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
    
end : Description := "UniversalMorphismIntoDirectProduct using UniversalMorphismIntoDirectProductWithGivenDirectProduct and DirectProduct" );

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

##
AddDerivationToCAP( UniversalMorphismIntoTerminalObject,
                    [ [ UniversalMorphismIntoTerminalObjectWithGivenTerminalObject, 1 ],
                      [ TerminalObject, 1 ] ],
  function( test_source )
    
    return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( CapCategory( test_source ) ) );
    
end : Description := "UniversalMorphismIntoTerminalObject using UniversalMorphismIntoTerminalObjectWithGivenTerminalObject and TerminalObject");

##
AddDerivationToCAP( TerminalObjectFunctorial,
                    [ [ TerminalObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return IdentityMorphism( terminal_object );
    
end : Description := "TerminalObjectFunctorial using the identity morphism of terminal object" );

##
AddDerivationToCAP( TerminalObjectFunctorial,
                    [ [ TerminalObject, 1 ],
                      [ UniversalMorphismIntoTerminalObject, 1 ] ],
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return UniversalMorphismIntoTerminalObject( terminal_object );
    
end : Description := "TerminalObjectFunctorial using the universality of terminal object" );

##
AddDerivationToCAP( UniversalMorphismFromInitialObject,
                    [ [ UniversalMorphismFromInitialObjectWithGivenInitialObject, 1 ],
                      [ InitialObject, 1 ] ],
              
  function( test_sink )
    
    return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( CapCategory( test_sink ) ) );
    
end : Description := "UniversalMorphismFromInitialObject using UniversalMorphismFromInitialObjectWithGivenInitialObject and InitialObject" );

##
AddDerivationToCAP( InitialObjectFunctorial,
                    [ [ InitialObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return IdentityMorphism( initial_object );
    
end : Description := "InitialObjectFunctorial using the identity morphism of initial object" );

##
AddDerivationToCAP( InitialObjectFunctorial,
                    [ [ InitialObject, 1 ],
                      [ UniversalMorphismFromInitialObject, 1 ] ],
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return UniversalMorphismFromInitialObject( initial_object );
    
end : Description := "InitialObjectFunctorial using the universality of the initial object" );

##
AddDerivationToCAP( DirectProductDiagonalDifference,
                    [ [ PreCompose, 2 ], ## Length( diagram ) would be the correct number here
                      [ ProjectionInFactorOfDirectProduct, 2 ], ## Length( diagram ) would be the correct number here
                      [ UniversalMorphismIntoDirectProduct, 2 ], ## 2*(Length( diagram ) - 1) would be the correct number here
                      [ AdditiveInverseForMorphisms,1 ],
                      [ AdditionForMorphisms, 1 ] ],
                    
  function( diagram, method_selection_morphism )
    local direct_product_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2;
    
    direct_product_diagram := List( diagram, Source );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), diagram[ i ] ) );
    
    mor1 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    return mor1 - mor2;
    
end : Description := "DirectProductDiagonalDifference using the operations defining this morphism" );



##
AddDerivationToCAP( ProjectionInFactorOfFiberProduct,
                    [ [ FiberProductEmbeddingInDirectSum, 1 ],
                      [ ProjectionInFactorOfDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                      
  function( diagram, projection_number )
    local embedding_in_direct_product, direct_product, direct_product_diagram, projection;
    
    embedding_in_direct_product := FiberProductEmbeddingInDirectSum( diagram );
    
    direct_product_diagram := List( diagram, Source );
    
    projection := ProjectionInFactorOfDirectProduct( direct_product_diagram, projection_number );
    
    return PreCompose( embedding_in_direct_product, projection );
    
end : Description := "ProjectionInFactorOfFiberProduct by composing the direct sum embedding with the direct sum projection" );


##
AddDerivationToCAP( FiberProductFunctorial,
                    [ [ PreCompose, 2 ], ## Length( morphism_of_morphisms ) would be the right number
                      [ ProjectionInFactorOfFiberProduct, 2 ], ## Length( morphism_of_morphisms ) would be the right number,
                      [ UniversalMorphismIntoFiberProduct, 1 ] ],
                                  
  function( morphism_of_morphisms, base_morphism )
    local pullback_diagram, source, diagram;
        
        pullback_diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        source := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, i ), morphism_of_morphisms[i][2] ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        return UniversalMorphismIntoFiberProduct( diagram, source );
        
end : Description := "FiberProductFunctorial using the universality of the fiber product" );

##
AddDerivationToCAP( CoproductDiagonalDifference,
                    [ [ InjectionOfCofactorOfCoproduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ UniversalMorphismFromCoproduct, 2 ], ## 2*( Length( diagram ) - 1 ) would be the correct number 
                      [ AdditiveInverseForMorphisms, 1 ],
                      [ AdditionForMorphisms, 1 ] ],
                    
  function( diagram, method_selection_morphism )
    local cobase, coproduct_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2;
    
    coproduct_diagram := List( diagram, Range );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( diagram[ i ], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
    
    mor1 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    return mor1 - mor2;
    
end : Description := "CoproductDiagonalDifference using the operations defining this morphism" );


##
AddDerivationToCAP( InjectionOfCofactorOfPushout,
                    [ [ DirectSumProjectionInPushout, 1 ],
                      [ InjectionOfCofactorOfCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                                         
  function( diagram, injection_number )
    local projection_from_coproduct, coproduct, coproduct_diagram, injection;
    
    projection_from_coproduct := DirectSumProjectionInPushout( diagram );
    
    coproduct_diagram := List( diagram, Range );
    
    injection := InjectionOfCofactorOfCoproduct( coproduct_diagram, injection_number );
    
    return PreCompose( injection, projection_from_coproduct );
    
end : Description := "InjectionOfCofactorOfPushout by composing the coproduct injection with the direct sum projection to the pushout" );


##
AddDerivationToCAP( PushoutFunctorial,
                    [ [ PreCompose, 2 ], ## Length( morphism_of_morphisms ) would be the correct number here
                      [ InjectionOfCofactorOfPushout, 2 ], ## Length( morphism_of_morphisms ) would be the correct number here
                      [ UniversalMorphismFromPushout, 1 ] ],
                                  
  function( morphism_of_morphisms, cobase_morphism )
    local pushout_diagram, sink, diagram;
        
        pushout_diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        sink := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( morphism_of_morphisms[i][2], InjectionOfCofactorOfPushout( pushout_diagram, i ) ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        return UniversalMorphismFromPushout( diagram, sink );
        
end : Description := "PushoutFunctorial using the universality of the pushout" );

##
AddDerivationToCAP( ImageEmbedding,
                    [ [ ImageEmbeddingWithGivenImageObject, 1 ],
                      [ ImageObject, 1 ] ],
                      
  function( morphism )
    
    return ImageEmbeddingWithGivenImageObject( morphism, ImageObject( morphism ) );
  
end : Description := "ImageEmbedding using ImageEmbeddingWithGivenImageObject and ImageObject" );


##
AddDerivationToCAP( CoastrictionToImage,
                    [ [ CoastrictionToImageWithGivenImageObject, 1 ],
                      [ ImageObject, 1 ] ],
                 
  function( morphism )
    
    return CoastrictionToImageWithGivenImageObject( morphism, ImageObject( morphism ) );
    
end : Description := "CoastrictionToImage using CoastrictionToImageWithGivenImageObject and ImageObject" );

##
AddDerivationToCAP( CoastrictionToImage,
                    [ [ ImageEmbedding, 1 ],
                      [ MonoAsKernelLift, 1 ] ],
                 
  function( morphism )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return MonoAsKernelLift( image_embedding, morphism );
    
end : Description := "CoastrictionToImage using that image embedding can be seen as a kernel" );

##
AddDerivationToCAP( UniversalMorphismFromImage,
                    [ [ UniversalMorphismFromImageWithGivenImageObject, 1 ],
                      [ ImageObject, 1 ] ],
                      
  function( morphism, test_factorization )
    
    return UniversalMorphismFromImageWithGivenImageObject( morphism, test_factorization, ImageObject( morphism ) );
    
end : Description := "UniversalMorphismFromImage using UniversalMorphismFromImageWithGivenImageObject and ImageObject" );

## FIXME: maybe the first entry of the list test_factorization can be ommitted here
##
AddDerivationToCAP( UniversalMorphismFromImage,
                    [ [ ImageEmbedding, 1 ],
                      [ MonoAsKernelLift, 1 ] ],
                      
  function( morphism, test_factorization )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return MonoAsKernelLift( test_factorization[2], image_embedding );
    
end : Description := "UniversalMorphismFromImage using ImageEmbedding and MonoAsKernelLift" );

##
AddDerivationToCAP( FiberProductEmbeddingInDirectSum,
                    [ [ KernelEmb, 1 ],
                      [ DirectProductDiagonalDifference, 1 ],
                      [ IsomorphismFromFiberProductToKernelOfDiagonalDifference, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( diagram )
    local kernel_of_diagonal_difference;
    
    kernel_of_diagonal_difference := KernelEmb( DirectProductDiagonalDifference( diagram ) );
    
    return PreCompose( IsomorphismFromFiberProductToKernelOfDiagonalDifference( diagram ),
                       kernel_of_diagonal_difference );
    
end : Description := "FiberProductEmbeddingInDirectSum as the kernel embedding of DirectProductDiagonalDifference" );

##
AddDerivationToCAP( UniversalMorphismIntoFiberProduct,
                    [ [ UniversalMorphismIntoDirectProduct, 1 ],
                      [ DirectProductDiagonalDifference, 1 ],
                      [ KernelLift, 1 ],
                      [ PreCompose, 1 ],
                      [ IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct, 1 ] ],
                                       
  function( diagram, source )
    local test_function, direct_product_diagonal_difference, kernel_lift;
    
    test_function := CallFuncList( UniversalMorphismIntoDirectProduct, source );
    
    direct_product_diagonal_difference := DirectProductDiagonalDifference( diagram );
    
    kernel_lift := KernelLift( direct_product_diagonal_difference, test_function );
    
    return PreCompose(
             kernel_lift,
             IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( diagram )
           );
    
end : Description := "UniversalMorphismIntoFiberProduct using the universality of the kernel representation of the pullback" );

##
AddDerivationToCAP( DirectSumProjectionInPushout,
                    [ [ CokernelProj, 1 ],
                      [ CoproductDiagonalDifference, 1 ],
                      [ IsomorphismFromCokernelOfDiagonalDifferenceToPushout, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( diagram )
    local cokernel_proj_of_diagonal_difference;
    
    cokernel_proj_of_diagonal_difference := CokernelProj( CoproductDiagonalDifference( diagram ) );
    
    return PreCompose( cokernel_proj_of_diagonal_difference,
                       IsomorphismFromCokernelOfDiagonalDifferenceToPushout( diagram ) );
    
end : Description := "DirectSumProjectionInPushout as the cokernel projection of CoproductDiagonalDifference" );

##
AddDerivationToCAP( UniversalMorphismFromPushout,
                    [ [ UniversalMorphismFromCoproduct, 1 ],
                      [ CoproductDiagonalDifference, 1 ],
                      [ CokernelColift, 1 ],
                      [ IsomorphismFromPushoutToCokernelOfDiagonalDifference, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( diagram, sink )
    local test_function, coproduct_diagonal_difference, cokernel_colift;
    
    test_function := CallFuncList( UniversalMorphismFromCoproduct, sink );
    
    coproduct_diagonal_difference := CoproductDiagonalDifference( diagram );
    
    cokernel_colift := CokernelColift( coproduct_diagonal_difference, test_function );
    
    return PreCompose( IsomorphismFromPushoutToCokernelOfDiagonalDifference( diagram ),
                       cokernel_colift );
    
end : Description := "UniversalMorphismFromPushout using the universality of the cokernel representation of the pushout" );

##
AddDerivationToCAP( ImageEmbedding,
                    [ [ KernelEmb, 1 ],
                      [ CokernelProj, 1 ],
                      [ IsomorphismFromImageObjectToKernelOfCokernel, 1 ],
                      [ PreCompose, 1 ] ],
                      
  function( mor )
    local image_embedding;
    
    image_embedding := KernelEmb( CokernelProj( mor ) );
    
    return PreCompose( IsomorphismFromImageObjectToKernelOfCokernel( mor ),
                       image_embedding );
    
end : CategoryFilter := IsAbelianCategory, ##FIXME: PreAbelian?
      Description := "ImageEmbedding as the kernel embedding of the cokernel projection"
);

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

##
AddDerivationToCAP( TerminalObject,
                    [ [ ZeroObject, 1 ] ],
               
  function( category )
    
    return ZeroObject( category );
    
end : Description := "TerminalObject equals ZeroObject" );

##
AddDerivationToCAP( InitialObject,
                    [ [ ZeroObject, 1 ] ],
               
  function( category )
    
    return ZeroObject( category );
    
end : Description := "InitialObject equals ZeroObject" );

##
AddDerivationToCAP( FiberProduct,
                    [ [ FiberProductEmbeddingInDirectSum, 1 ] ],
                    
function( diagram )
    
    return Source( FiberProductEmbeddingInDirectSum( diagram ) );
    
end : Description := "FiberProduct as the source of FiberProductEmbeddingInDirectSum" );

##
AddDerivationToCAP( Pushout,
                    [ [ DirectSumProjectionInPushout, 1 ] ],
                    
  function( diagram )
    
    return Range( DirectSumProjectionInPushout( diagram ) );
    
end : Description := "Pushout as the range of DirectSumProjectionInPushout" );

##
AddDerivationToCAP( ImageObject,
                    [ [ ImageEmbedding, 1 ] ],
                    
  function( mor )
    local image;
    
    image := Source( ImageEmbedding( mor ) );
    
    return image;
    
end : Description := "ImageObject as the source of ImageEmbedding" );

####################################
## Final derived methods
####################################

## Final methods for FiberProduct

##
AddFinalDerivation( IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                    [ [ DirectProductDiagonalDifference, 1 ], 
                      [ KernelObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      FiberProductEmbeddingInDirectSum,
                      IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                      IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct ],
                    
  function( diagram )
    local kernel_of_diagonal_difference;
    
    kernel_of_diagonal_difference := KernelObject( DirectProductDiagonalDifference( diagram ) );
    
    return IdentityMorphism( kernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromFiberProductToKernelOfDiagonalDifference as the identity of the kernel of diagonal difference" );

##
AddFinalDerivation( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct,
                    [ [ DirectProductDiagonalDifference, 1 ], 
                      [ KernelObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      FiberProductEmbeddingInDirectSum,
                      IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                      IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct ],
                    
  function( diagram )
    local kernel_of_diagonal_difference;
    
    kernel_of_diagonal_difference := KernelObject( DirectProductDiagonalDifference( diagram ) );
    
    return IdentityMorphism( kernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct as the identity of the kernel of diagonal difference" );

## Final methods for Pushout

##
AddFinalDerivation( IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                    [ [ Cokernel, 1 ],
                      [ CoproductDiagonalDifference, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      DirectSumProjectionInPushout,
                      IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                      IsomorphismFromCokernelOfDiagonalDifferenceToPushout ],
                    
  function( diagram )
    local cokernel_of_diagonal_difference;
    
    cokernel_of_diagonal_difference := Cokernel( CoproductDiagonalDifference( diagram ) );
    
    return IdentityMorphism( cokernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromPushoutToCokernelOfDiagonalDifference as the identity of the cokernel of diagonal difference" );

##
AddFinalDerivation( IsomorphismFromCokernelOfDiagonalDifferenceToPushout,
                    [ [ Cokernel, 1 ],
                      [ CoproductDiagonalDifference, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      DirectSumProjectionInPushout,
                      IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                      IsomorphismFromCokernelOfDiagonalDifferenceToPushout ],
                    
  function( diagram )
    local cokernel_of_diagonal_difference;
    
    cokernel_of_diagonal_difference := Cokernel( CoproductDiagonalDifference( diagram ) );
    
    return IdentityMorphism( cokernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout as the identity of the cokernel of diagonal difference" );

## Final methods for Image

##
AddFinalDerivation( IsomorphismFromImageObjectToKernelOfCokernel,
                    [ [ KernelObject, 1 ],
                      [ CokernelProj, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ ImageObject,
                      ImageEmbedding,
                      ImageEmbeddingWithGivenImageObject,
                      CoastrictionToImage,
                      CoastrictionToImageWithGivenImageObject,
                      UniversalMorphismFromImage,
                      UniversalMorphismFromImageWithGivenImageObject,
                      IsomorphismFromImageObjectToKernelOfCokernel ],
                    
  function( mor )
    local kernel_of_cokernel;
    
    kernel_of_cokernel := KernelObject( CokernelProj( mor ) );
    
    return IdentityMorphism( kernel_of_cokernel );
    
end : Description := "IsomorphismFromImageObjectToKernelOfCokernel as the identity of the kernel of the cokernel" );



