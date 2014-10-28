#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

####################################
##
## Auxiliary functions
##
####################################

InstallGlobalFunction( "RESOLVE_HISTORY",
                       
  function( list )
    local new_list, i;
    
    new_list := [ ];
    
    for i in list do
        
        if IsDeductionSystemCell( i ) then
            
            Add( new_list, History( i ) );
            
        else
            
            Add( new_list, i );
            
        fi;
        
    od;
    
    return new_list;
    
end );

####################################
##
## Reps and types
##
####################################

DeclareRepresentation( "IsDeductionSystemObjectRep",
                       IsHomalgCategoryObjectRep and IsDeductionSystemObject,
                       [ ] );

BindGlobal( "TheTypeOfDeductionSystemObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsDeductionSystemObjectRep ) );

DeclareRepresentation( "IsDeductionSystemMorphismRep",
                       IsHomalgCategoryMorphismRep and IsDeductionSystemMorphism,
                       [ ] );

BindGlobal( "TheTypeOfDeductionSystemMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsDeductionSystemMorphismRep ) );

####################################
##
## Add methods
##
####################################

InstallGlobalFunction( ADDS_FOR_DEDUCTION_SYSTEM,
                       
  function( deduction_system, category )
    
    AddPreCompose( deduction_system,
                   
      function( left_morphism, right_morphism )
        
        return DeductionSystemMorphism( Source( left_morphism ), "PreCompose", [ left_morphism, right_morphism ], Range( right_morphism ) );
        
    end );
    
    AddIdentityMorphism( deduction_system,
                         
      function( object )
        
        return DeductionSystemMorphism( object, "IdentityMorphism", [ object ], object );
        
    end );
    
    AddInverse( deduction_system,
                
      function( morphism )
        
        return DeductionSystemMorphism( Range( morphism ), "Inverse", [ morphism ], Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( deduction_system,
                         
      function( monomorphism, test_morphism )
        
        return DeductionSystemMorphism( Source( test_morphism ), "MonoAsKernelLift", [ monomorphism, test_morphism ], Source( monomorphism ) );
        
    end );
    
    AddEpiAsCokernelColift( deduction_system,
                            
      function( epimorphism, test_morphism )
        
        return DeductionSystemMorphism( Range( epimorphism ), "EpiAsCokernelColift", [ epimorphism, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddIsMonomorphism( deduction_system,
                       
      function( morphism )
        
        return IsMonomorphism( Eval( morphism ) );
        
    end );
    
    AddIsEpimorphism( deduction_system,
                      
      function( morphism )
        
        return IsEpimorphism( Eval( morphism ) );
        
    end );
    
    AddIsIsomorphism( deduction_system,
                      
      function( morphism )
        
        return IsIsomorphism( Eval( morphism ) );
        
    end );
    
    AddDominates( deduction_system,
                  
      function( subobject1, subobject2 )
        
        return Dominates( Eval( subobject1 ), Eval( subobject2 ) );
        
    end );
    
    AddCodominates( deduction_system,
                    
      function( factorobject1, factorobject2 )
        
        return Codominates( Eval( factorobject1 ), Eval( factorobject2 ) );
        
    end );
    
    AddEqualityOfMorphisms( deduction_system,
                            
      function( morphism1, morphism2 )
        
        return EqualityOfMorphisms( Eval( morphism1 ), Eval( morphism2 ) );
        
    end );
    
    AddIsZeroForMorphisms( deduction_system,
                           
      function( morphism )
        
        return IsZero( Eval( morphism ) );
        
    end );
    
    AddAdditionForMorphisms( deduction_system,
                             
      function( morphism1, morphism2 )
        
        return DeductionSystemMorphism( Source( morphism1 ), "\+", [ morphism1, morphism2 ], Range( morphism1 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( deduction_system,
                                    
      function( morphism )
        
        return DeductionSystemMorphism( Source( morphism ), "AdditiveInverse", [ morphism ], Range( morphism ) );
        
    end );
    
    AddZeroMorphism( deduction_system,
                     
      function( source, range )
        
        return DeductionSystemMorphism( source, "ZeroMorphism", [ source, range ], range );
        
    end );
    
    ## HOLE: Well defined
    
    AddKernel( deduction_system,
               
      function( morphism )
        
        return DeductionSystemObject( "KernelObject", [ morphism ] );
        
    end );
    
    AddKernelEmb( deduction_system,
                  
      function( morphism )
        
        return DeductionSystemMorphism( KernelObject( morphism ), "KernelEmb", [ morphism ], Source( morphism ) );
        
    end );
    
    AddKernelEmbWithGivenKernel( deduction_system,
                                 
      function( morphism, kernel )
        
        return DeductionSystemMorphism( kernel, "KernelEmbWithGivenKernel", [ morphism, kernel ], Source( morphism ) );
        
    end );
    
    AddKernelLift( deduction_system,
                   
      function( morphism, test_morphism )
        
        return DeductionSystemMorphism( Source( test_morphism ), "KernelLift", [ morphism, test_morphism ], KernelObject( morphism ) );
        
    end );
    
    AddKernelLiftWithGivenKernel( deduction_system,
                                  
      function( morphism, test_morphism, kernel )
        
        return DeductionSystemMorphism( Source( test_morphism ), "KernelLiftWithGivenKernel", [ morphism, test_morphism, kernel ], kernel );
        
    end );
    
    AddCokernel( deduction_system,
                 
      function( morphism )
        
        return DeductionSystemObject( "Cokernel", [ morphism ] );
        
    end );
    
    AddCokernelProj( deduction_system,
                     
      function( morphism )
        
        return DeductionSystemMorphism( Range( morphism ), "CokernelProj", [ morphism ], Cokernel( morphism ) );
        
    end );
    
    AddCokernelProjWithGivenCokernel( deduction_system,
                                      
      function( morphism, cokernel )
        
        return DeductionSystemMorphism( Range( morphism ), "CokernelProjWithGivenCokernel", [ morphism, cokernel ], cokernel );
        
    end );
    
    AddCokernelColift( deduction_system,
                       
      function( morphism, test_morphism )
        
        return DeductionSystemMorphism( Cokernel( morphism ), "CokernelColift", [ morphism, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddCokernelColiftWithGivenCokernel( deduction_system,
                                        
      function( morphism, test_morphism, cokernel )
        
        return DeductionSystemMorphism( cokernel, "AddCokernelColiftWithGivenCokernel", [ morphism, test_morphism, cokernel ], Range( test_morphism ) );
        
    end );
    
    AddZeroObject( deduction_system,
                   
      function( ) 
        
        return DeductionSystemObject( "ZeroObject", [ category ] );
        
    end );
    
    AddTerminalObject( deduction_system,
                       
      function( )
        
        return DeductionSystemObject( "TerminalObject", [ category ] );
        
    end );
    
    AddUniversalMorphismIntoTerminalObject( deduction_system,
                                            
      function( object )
        
        return DeductionSystemMorphism( object, "UniversalMorphismIntoTerminalObject", [ object ], TerminalObject( deduction_system ) );
        
    end );
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( deduction_system,
                                            
      function( object, terminal_object )
        
        return DeductionSystemMorphism( object, "UniversalMorphismIntoTerminalObject", [ object ], terminal_object );
        
    end );
    
    AddInitialObject( deduction_system,
                      
      function( )
        
        return DeductionSystemObject( "InitialObject", [ category ] );
        
    end );
    
    AddUniversalMorphismFromInitialObject( deduction_system,
                                           
      function( object )
        
        return DeductionSystemMorphism( InitialObject( object ), "UniversalMorphismFromInitialObject", [ object ], object );
        
    end );
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( deduction_system,
                                                                 
      function( object, initial_object )
        
        return DeductionSystemMorphism( initial_object, "UniversalMorphismFromInitialObjectWithGivenInitialObject", [ object, initial_object ], object );
        
    end );
    
    AddDirectSum( deduction_system,
                  
      function( object_product_list )
        
        return DeductionSystemObject( "DirectSum", Components( object_product_list ) );
        
    end );
    
    AddCoproduct( deduction_system,
                  
      function( object_product_list )
        
        return DeductionSystemObject( "Coproduct", Components( object_product_list ) );
        
    end );
    
    AddInjectionOfCofactor( deduction_system,
                            
      function( object_product_list, injection_number )
        local components, coproduct;
        
        components := Components( object_product_list );
        
        ## Rethink this!!
        coproduct := CallFuncList( Coproduct, components );
        
        return DeductionSystemMorphism( components[ injection_number ], "InjectionOfCofactor",  [ [ "Product", components ], injection_number ], coproduct );
        
    end );
    
    AddInjectionOfCofactorWithGivenCoproduct( deduction_system,
                                              
      function( object_product_list, injection_number, coproduct )
        local components;
        
        components := Components( object_product_list );
        
        return DeductionSystemMorphism( components[ injection_number ], "InjectionOfCofactorWithGivenCoproduct", [ [ "Product", components ], injection_number, coproduct ], coproduct );
        
    end );
    
    AddUniversalMorphismFromCoproduct( deduction_system,
                                       
      function( sink )
        local components, coproduct;
        
        components := Components( sink );
        
        coproduct := Coproduct( List( components, Source ) );
        
        return DeductionSystemMorphism( coproduct, "UniversalMorphismFromCoproduct", components, Source( components[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( deduction_system,
                                                         
      function( sink, coproduct )
        local components;
        
        components := Components( sink );
        
        return DeductionSystemMorphism( coproduct, "UniversalMorphismFromCoproductWithGivenCoproduct", [ [ "Product", components ], coproduct ], Source( components[ 1 ] ) );
        
    end );
    
    AddDirectProduct( deduction_system,
                      
      function( object_product_list )
        
        return DeductionSystemObject( "DirectProduct", Components( object_product_list ) );
        
    end );
    
    AddProjectionInFactor( deduction_system,
                           
      function( object_product_list, projection_number )
        local components, direct_product;
        
        components := Components( object_product_list );
        
        direct_product := CallFuncList( DirectProduct, components );
        
        return DeductionSystemMorphism( direct_product, "ProjectionInFactor", [ [ "Product", components ], projection_number ], components[ projection_number ] );
        
    end );
    
    AddProjectionInFactorWithGivenDirectProduct( deduction_system,
                                                 
      function( object_product_list, projection_number, direct_product )
        local components;
        
        components := Components( object_product_list );
        
        return DeductionSystemMorphism( direct_product, "ProjectionInFactor", [ [ "Product", components ], projection_number ], components[ projection_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProduct( deduction_system,
                                           
      function( source )
        local components, direct_product;
        
        components := Components( source );
        
        direct_product := CallFuncList( DirectProduct, List( components, Range ) );
        
        return DeductionSystemMorphism( Source( components[ 1 ] ), "UniversalMorphismIntoDirectProduct", components, direct_product );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( deduction_system,
                                           
      function( source, direct_product )
        local components;
        
        components := Components( source );
        
        return DeductionSystemMorphism( Source( components[ 1 ] ), "UniversalMorphismIntoDirectProductWithGivenDirectProduct", [ [ "Product", components ], direct_product ], direct_product );
        
    end );
    
    AddPullback( deduction_system,
                 
      function( diagram )
        local components;
        
        components := Components( diagram );
        
        return DeductionSystemObject( "FiberProduct", components );
        
    end );
    
    AddProjectionInFactorOfPullback( deduction_system,
                                     
      function( diagram, projection_number )
        local components, pullback;
        
        components := Components( diagram );
        
        pullback := CallFuncList( FiberProduct, components );
        
        return DeductionSystemMorphism( pullback, "ProjectionInFactorOfPullback", [ [ "Product", components ], projection_number ], Source( components[ projection_number ] ) );
        
    end );
    
    AddProjectionInFactorOfPullbackWithGivenPullback( deduction_system,
                                     
      function( diagram, projection_number, pullback )
        local components;
        
        components := Components( diagram );
        
        return DeductionSystemMorphism( pullback, "ProjectionInFactorOfPullbackWithGivenPullback", [ [ "Product", components ], projection_number, pullback ], Source( components[ projection_number ] ) );
        
    end );
    
    AddUniversalMorphismIntoPullback( deduction_system,
                                      
      function( diagram, source )
        local components_diagram, components_source, pullback;
        
        components_diagram := Components( diagram );
        
        components_source := Components( source );
        
        pullback := CallFuncList( FiberProduct, diagram );
        
        return DeductionSystemMorphism( Source( components_source[ 1 ] ), "UniversalMorphismIntoPullback", Concatenation( [ [ "Product", components_diagram ] ], components_source ), pullback );
        
    end );
    
    AddUniversalMorphismIntoPullbackWithGivenPullback( deduction_system,
                                      
      function( diagram, source, pullback )
        local components_diagram, components_source;
        
        components_diagram := Components( diagram );
        
        components_source := Components( source );
        
        return DeductionSystemMorphism( Source( components_source[ 1 ] ), "UniversalMorphismIntoPullbackWithGivenPullback", [ [ "Product", components_diagram ], [ "Product", components_source ], pullback ], pullback );
        
    end );
    
    AddPushout( deduction_system,
                
      function( diagram )
        local components;
        
        components := Components( diagram );
        
        return DeductionSystemObject( "Pushout", components );
        
    end );
    
    AddInjectionOfCofactorOfPushout( deduction_system,
                                     
      function( diagram, injection_number )
        local components, pushout;
        
        components := Components( diagram );
        
        pushout := CallFuncList( Pushout, components );
        
        return DeductionSystemMorphism( Range( components[ injection_number ] ), "InjectionOfCofactorOfPushout", [ [ "Product", components ], injection_number ], pushout );
        
    end );
    
    AddInjectionOfCofactorOfPushoutWithGivenPushout( deduction_system,
                                     
      function( diagram, injection_number, pushout )
        local components;
        
        components := Components( diagram );
        
        return DeductionSystemMorphism( Range( components[ injection_number ] ), "InjectionOfCofactorOfPushoutWithGivenPushout", [ [ "Product", components ], injection_number, pushout ], pushout );
        
    end );
    
    AddUniversalMorphismFromPushout( deduction_system,
                                     
      function( diagram, sink )
        local components_diagram, components_sink, pushout;
        
        components_diagram := Components( diagram );
        
        components_sink := Components( sink );
        
        pushout := CallFuncList( Pushout, components_diagram );
        
        return DeductionSystemMorphism( pushout, "UniversalMorphismFromPushout", Concatenation( [ [ "Product", components_diagram ] ], components_sink ), Range( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromPushoutWithGivenPushout( deduction_system,
                                     
      function( diagram, sink, pushout )
        local components_diagram, components_sink;
        
        components_diagram := Components( diagram );
        
        components_sink := Components( sink );
        
        return DeductionSystemMorphism( pushout, "UniversalMorphismFromPushout", [ [ "Product", components_diagram ], [ "Product", components_sink ], pushout ], Range( sink[ 1 ] ) );
        
    end );
    
    AddImage( deduction_system,
              
      function( morphism )
        
        return DeductionSystemObject( "ImageObject", [ morphism ] );
        
    end );
    
    AddImageEmbedding( deduction_system,
                       
      function( morphism )
        local image_object;
        
        image_object := ImageObject( morphism );
        
        return DeductionSystemMorphism( image_object, "ImageEmbedding", [ morphism ], Range( morphism ) );
        
    end );
    
    AddImageEmbeddingWithGivenImage( deduction_system,
                                     
      function( morphism, image_object )
        
        return DeductionSystemMorphism( image_object, "ImageEmbeddingWithGivenImage", [ morphism, image_object ], Range( morphism ) );
        
    end );
    
end );

####################################
##
## Constructors
##
####################################

InstallMethod( DeductionSystem,
               [ IsHomalgCategory ],
               
  function( category )
    local deduction_system;
    
    deduction_system := CreateHomalgCategory( Concatenation( "Deduction system of ", Name( category ) ) );
    
    SetUnderlyingHonestCategory( deduction_system, category );
    
    ADDS_FOR_DEDUCTION_SYSTEM( deduction_system, category );
    
    return deduction_system;
    
end );

##
InstallMethod( AsDeductionSystemObject,
               [ IsHomalgCategoryObject ],
               
  function( object )
    local deduction_object;
    
    deduction_object := rec( );
    
    ObjectifyWithAttributes( deduction_object, TheTypeOfDeductionSystemObject,
                             Eval, object );
    
    SetHistory( deduction_object, deduction_object );
    
    Add( DeductionSystem( HomalgCategory( object ) ), deduction_object );
    
    return deduction_object;
    
end );

##
InstallMethod( DeductionSystemObject,
               [ IsString, IsList ],
               
  function( func, argument_list )
    local deduction_object, resolved_history;
    
    deduction_object := rec( );
    
    resolved_history := RESOLVE_HISTORY( argument_list );
    
    ObjectifyWithAttributes( deduction_object, TheTypeOfDeductionSystemObject,
                             History, [ func, resolved_history ] );
    
    return deduction_object;
    
end );

##
InstallMethod( AsDeductionSystemMorphism,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local deduction_morphism, source, range;
    
    source := AsDeductionSystemObject( Source( morphism ) );
    
    range := AsDeductionSystemObject( Range( morphism ) );
    
    deduction_morphism := rec( );
    
    ObjectifyWithAttributes( deduction_morphism, TheTypeOfDeductionSystemMorphism,
                             Source, source,
                             Range, range,
                             Eval, morphism );
    
    SetHistory( deduction_morphism, deduction_morphism );
    
    Add( DeductionSystem( HomalgCategory( morphism ) ), deduction_morphism );
    
    return deduction_morphism;
    
end );

##
InstallMethod( DeductionSystemMorphism,
               [ IsDeductionSystemObject, IsString, IsList, IsDeductionSystemObject ],
               
  function( source, func, argument_list, range )
    local deduction_morphism, resolved_history;
    
    deduction_morphism := rec( );
    
    resolved_history := RESOLVE_HISTORY( argument_list );
    
    ObjectifyWithAttributes( deduction_morphism, TheTypeOfDeductionSystemMorphism,
                             History, [ func, resolved_history ],
                             Source, source,
                             Range, range );
    
    return deduction_morphism;
    
end );

#################################
##
## Eval
##
#################################

BindGlobal( "APPLY_LOGIC_TO_HISTORY",
            
  function( history )
    
    return [ history, [ ] ];
    
end );

## FIXME: This can be done more efficient, but not today.
InstallGlobalFunction( RECURSIVE_EVAL,
            
  function( list )
    
    if IsDeductionSystemCell( list ) then
        
        return Eval( list );
        
    elif IsList( list ) and Length( list ) = 2 and IsString( list[ 1 ] ) then
        
        return CallFuncList( ValueGlobal( list[ 1 ] ), List( list[ 2 ], RECURSIVE_EVAL ) );
        
    fi;
    
    return list;
    
end );

##
InstallMethod( Eval,
               [ IsDeductionSystemCell ],
               
  function( cell )
    local history, new_history, checks, eval;
    
    history := History( cell );
    
    history := APPLY_LOGIC_TO_HISTORY( history );
    
    new_history := history[ 1 ];
    
    checks := history[ 2 ];
    
    SetHistory( cell, new_history );
    
    SetChecksFromLogic( cell, checks );
    
    eval := RECURSIVE_EVAL( new_history );
    
    SetChecksFromLogic( eval, checks );
    
    return eval;
    
end );

#################################
##
## View
##
#################################

InstallMethod( ViewObj,
               [ IsDeductionSystemObject ],
               
  function( cell )
    
    Print( "<An unevaluated object in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsDeductionSystemMorphism ],
               
  function( cell )
    
    Print( "<An unevaluated morphism in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsDeductionSystemCell and HasEval ],
               100000000000000, ##FIXME!!!!
               
  function( cell )
    
    Print( "<Deductive system hull of: " );
    
    ViewObj( Eval( cell ) );
    
    Print( ">" );
    
end );

