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

InstallGlobalFunction( RESOLVE_HISTORY,
                       
  function( list )
    local new_list, i;
    
    new_list := [ ];
    
    for i in list do
        
        if IsDeductiveSystemCell( i ) then
            
            Add( new_list, History( i ) );
            
        elif IsList( i ) then
            
            Add( new_list, List( i, History ) );
            
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

DeclareRepresentation( "IsDeductiveSystemObjectRep",
                       IsHomalgCategoryObjectRep and IsDeductiveSystemObject,
                       [ ] );

BindGlobal( "TheTypeOfDeductiveSystemObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsDeductiveSystemObjectRep ) );

DeclareRepresentation( "IsDeductiveSystemMorphismRep",
                       IsHomalgCategoryMorphismRep and IsDeductiveSystemMorphism,
                       [ ] );

BindGlobal( "TheTypeOfDeductiveSystemMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsDeductiveSystemMorphismRep ) );

####################################
##
## Add methods
##
####################################

InstallGlobalFunction( ADDS_FOR_DEDUCTIVE_SYSTEM,
                       
  function( deductive_system, category )
    
    AddPreCompose( deductive_system,
                   
      function( left_morphism, right_morphism )
        
        return DeductiveSystemMorphism( Source( left_morphism ), "PreCompose", [ left_morphism, right_morphism ], Range( right_morphism ) );
        
    end );
    
    AddIdentityMorphism( deductive_system,
                         
      function( object )
        
        return DeductiveSystemMorphism( object, "IdentityMorphism", [ object ], object );
        
    end );
    
    AddInverse( deductive_system,
                
      function( morphism )
        
        return DeductiveSystemMorphism( Range( morphism ), "Inverse", [ morphism ], Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( deductive_system,
                         
      function( monomorphism, test_morphism )
        
        return DeductiveSystemMorphism( Source( test_morphism ), "MonoAsKernelLift", [ monomorphism, test_morphism ], Source( monomorphism ) );
        
    end );
    
    AddEpiAsCokernelColift( deductive_system,
                            
      function( epimorphism, test_morphism )
        
        return DeductiveSystemMorphism( Range( epimorphism ), "EpiAsCokernelColift", [ epimorphism, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddIsMonomorphism( deductive_system,
                       
      function( morphism )
        
        return IsMonomorphism( Eval( morphism ) );
        
    end );
    
    AddIsEpimorphism( deductive_system,
                      
      function( morphism )
        
        return IsEpimorphism( Eval( morphism ) );
        
    end );
    
    AddIsIsomorphism( deductive_system,
                      
      function( morphism )
        
        return IsIsomorphism( Eval( morphism ) );
        
    end );
    
    AddDominates( deductive_system,
                  
      function( subobject1, subobject2 )
        
        return Dominates( Eval( subobject1 ), Eval( subobject2 ) );
        
    end );
    
    AddCodominates( deductive_system,
                    
      function( factorobject1, factorobject2 )
        
        return Codominates( Eval( factorobject1 ), Eval( factorobject2 ) );
        
    end );
    
    AddIsEqualForMorphisms( deductive_system,
                            
      function( morphism1, morphism2 )
        
        return IsEqualForMorphisms( Eval( morphism1 ), Eval( morphism2 ) );
        
    end );
    
    AddIsZeroForMorphisms( deductive_system,
                           
      function( morphism )
        
        return IsZero( Eval( morphism ) );
        
    end );
    
    AddAdditionForMorphisms( deductive_system,
                             
      function( morphism1, morphism2 )
        
        return DeductiveSystemMorphism( Source( morphism1 ), "\+", [ morphism1, morphism2 ], Range( morphism1 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( deductive_system,
                                    
      function( morphism )
        
        return DeductiveSystemMorphism( Source( morphism ), "AdditiveInverse", [ morphism ], Range( morphism ) );
        
    end );
    
    AddZeroMorphism( deductive_system,
                     
      function( source, range )
        
        return DeductiveSystemMorphism( source, "ZeroMorphism", [ source, range ], range );
        
    end );
    
    ## HOLE: Well defined
    
    AddKernelObject( deductive_system,
               
      function( morphism )
        
        return DeductiveSystemObject( "KernelObject", [ morphism ] );
        
    end );
    
    AddKernelEmb( deductive_system,
                  
      function( morphism )
        
        return DeductiveSystemMorphism( KernelObject( morphism ), "KernelEmb", [ morphism ], Source( morphism ) );
        
    end );
    
    AddKernelEmbWithGivenKernel( deductive_system,
                                 
      function( morphism, kernel )
        
        return DeductiveSystemMorphism( kernel, "KernelEmb", [ morphism ], Source( morphism ) );
        
    end );
    
    AddKernelLift( deductive_system,
                   
      function( morphism, test_morphism )
        
        return DeductiveSystemMorphism( Source( test_morphism ), "KernelLift", [ morphism, test_morphism ], KernelObject( morphism ) );
        
    end );
    
    AddKernelLiftWithGivenKernel( deductive_system,
                                  
      function( morphism, test_morphism, kernel )
        
        return DeductiveSystemMorphism( Source( test_morphism ), "KernelLift", [ morphism, test_morphism ], kernel );
        
    end );
    
    AddCokernel( deductive_system,
                 
      function( morphism )
        
        return DeductiveSystemObject( "Cokernel", [ morphism ] );
        
    end );
    
    AddCokernelProj( deductive_system,
                     
      function( morphism )
        
        return DeductiveSystemMorphism( Range( morphism ), "CokernelProj", [ morphism ], Cokernel( morphism ) );
        
    end );
    
    AddCokernelProjWithGivenCokernel( deductive_system,
                                      
      function( morphism, cokernel )
        
        return DeductiveSystemMorphism( Range( morphism ), "CokernelProj", [ morphism ], cokernel );
        
    end );
    
    AddCokernelColift( deductive_system,
                       
      function( morphism, test_morphism )
        
        return DeductiveSystemMorphism( Cokernel( morphism ), "CokernelColift", [ morphism, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddCokernelColiftWithGivenCokernel( deductive_system,
                                        
      function( morphism, test_morphism, cokernel )
        
        return DeductiveSystemMorphism( cokernel, "AddCokernelColift", [ morphism, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddZeroObject( deductive_system,
                   
      function( ) 
        
        return DeductiveSystemObject( "ZeroObject", [ category ] );
        
    end );
    
    AddTerminalObject( deductive_system,
                       
      function( )
        
        return DeductiveSystemObject( "TerminalObject", [ category ] );
        
    end );
    
    AddUniversalMorphismIntoTerminalObject( deductive_system,
                                            
      function( object )
        
        return DeductiveSystemMorphism( object, "UniversalMorphismIntoTerminalObject", [ object ], TerminalObject( deductive_system ) );
        
    end );
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( deductive_system,
                                            
      function( object, terminal_object )
        
        return DeductiveSystemMorphism( object, "UniversalMorphismIntoTerminalObject", [ object ], terminal_object );
        
    end );
    
    AddInitialObject( deductive_system,
                      
      function( )
        
        return DeductiveSystemObject( "InitialObject", [ category ] );
        
    end );
    
    AddUniversalMorphismFromInitialObject( deductive_system,
                                           
      function( object )
        
        return DeductiveSystemMorphism( InitialObject( object ), "UniversalMorphismFromInitialObject", [ object ], object );
        
    end );
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( deductive_system,
                                                                 
      function( object, initial_object )
        
        return DeductiveSystemMorphism( initial_object, "UniversalMorphismFromInitialObject", [ object ], object );
        
    end );
    
    AddDirectSum( deductive_system,
                  
      function( object_product_list )
        
        return DeductiveSystemObject( "DirectSum", [ object_product_list ] );
        
    end );
    
    AddCoproduct( deductive_system,
                  
      function( object_product_list )
        
        return DeductiveSystemObject( "Coproduct", [ object_product_list ] );
        
    end );
    
    AddInjectionOfCofactorOfCoproduct( deductive_system,
                            
      function( object_product_list, injection_number )
        local coproduct;
        
        coproduct := Coproduct( object_product_list );
        
        return DeductiveSystemMorphism( object_product_list[ injection_number ], "InjectionOfCofactor",  [ object_product_list, injection_number ], coproduct );
        
    end );
    
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( deductive_system,
                                              
      function( object_product_list, injection_number, coproduct )
        
        return DeductiveSystemMorphism( object_product_list[ injection_number ], "InjectionOfCofactorOfCoproduct", [ object_product_list, injection_number ], coproduct );
        
    end );
    
    AddUniversalMorphismFromCoproduct( deductive_system,
                                       
      function( sink )
        local coproduct;
        
        coproduct := Coproduct( List( sink, Source ) );
        
        return DeductiveSystemMorphism( coproduct, "UniversalMorphismFromCoproduct", [ sink ], Source( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromCoproduct( deductive_system,
                                                         
      function( sink, coproduct )
        
        return DeductiveSystemMorphism( coproduct, "UniversalMorphismFromCoproduct", [ sink ], Source( sink[ 1 ] ) );
        
    end );
    
    AddDirectProduct( deductive_system,
                      
      function( object_product_list )
        
        return DeductiveSystemObject( "DirectProduct", [ object_product_list ] );
        
    end );
    
    AddProjectionInFactorOfDirectProduct( deductive_system,
                           
      function( object_product_list, projection_number )
        local direct_product;
        
        direct_product := DirectProduct( object_product_list );
        
        return DeductiveSystemMorphism( direct_product, "ProjectionInFactorOfDirectProduct", [ object_product_list, projection_number ], object_product_list[ projection_number ] );
        
    end );
    
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( deductive_system,
                                                 
      function( object_product_list, projection_number, direct_product )
        
        return DeductiveSystemMorphism( direct_product, "ProjectionInFactorOfDirectProduct", [ object_product_list, projection_number ], object_product_list[ projection_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProduct( deductive_system,
                                           
      function( source )
        local direct_product;
        
        direct_product := DirectProduct( List( source, Range ) );
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoDirectProduct", source, direct_product );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( deductive_system,
                                           
      function( source, direct_product )
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoDirectProduct", [ source ], direct_product );
        
    end );
    
    AddFiberProduct( deductive_system,
                 
      function( diagram )
        
        return DeductiveSystemObject( "FiberProduct", [ diagram ] );
        
    end );
    
    AddProjectionInFactorOfPullback( deductive_system,
                                     
      function( diagram, projection_number )
        local pullback;
        
        pullback := FiberProduct( diagram );
        
        return DeductiveSystemMorphism( pullback, "ProjectionInFactorOfPullback", [ diagram, projection_number ], Source( diagram[ projection_number ] ) );
        
    end );
    
    AddProjectionInFactorOfPullbackWithGivenPullback( deductive_system,
                                     
      function( diagram, projection_number, pullback )
        
        return DeductiveSystemMorphism( pullback, "ProjectionInFactorOfPullback", [ diagram, projection_number ], Source( diagram[ projection_number ] ) );
        
    end );
    
    AddUniversalMorphismIntoPullback( deductive_system,
                                      
      function( diagram, source )
        local pullback;
        
        pullback := FiberProduct( diagram );
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoPullback", [ diagram, source ], pullback );
        
    end );
    
    AddUniversalMorphismIntoPullbackWithGivenPullback( deductive_system,
                                      
      function( diagram, source, pullback )
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoPullback", [ diagram, source ], pullback );
        
    end );
    
    AddPushout( deductive_system,
                
      function( diagram )
        
        return DeductiveSystemObject( "Pushout", [ diagram ] );
        
    end );
    
    AddInjectionOfCofactorOfPushout( deductive_system,
                                     
      function( diagram, injection_number )
        local pushout;
        
        pushout := Pushout( diagram );
        
        return DeductiveSystemMorphism( Range( diagram[ injection_number ] ), "InjectionOfCofactorOfPushout", [ diagram, injection_number ], pushout );
        
    end );
    
    AddInjectionOfCofactorOfPushoutWithGivenPushout( deductive_system,
                                     
      function( diagram, injection_number, pushout )
        
        return DeductiveSystemMorphism( Range( diagram[ injection_number ] ), "InjectionOfCofactorOfPushout", [ diagram, injection_number ], pushout );
        
    end );
    
    AddUniversalMorphismFromPushout( deductive_system,
                                     
      function( diagram, sink )
        local pushout;
        
        pushout := Pushout( diagram );
        
        return DeductiveSystemMorphism( pushout, "UniversalMorphismFromPushout", [ diagram, sink ], Range( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromPushoutWithGivenPushout( deductive_system,
                                     
      function( diagram, sink, pushout )
        
        return DeductiveSystemMorphism( pushout, "UniversalMorphismFromPushout", [ diagram, sink ], Range( sink[ 1 ] ) );
        
    end );
    
    AddImageObject( deductive_system,
              
      function( morphism )
        
        return DeductiveSystemObject( "ImageObject", [ morphism ] );
        
    end );
    
    AddImageEmbedding( deductive_system,
                       
      function( morphism )
        local image_object;
        
        image_object := ImageObject( morphism );
        
        return DeductiveSystemMorphism( image_object, "ImageEmbedding", [ morphism ], Range( morphism ) );
        
    end );
    
    AddImageEmbeddingWithGivenImage( deductive_system,
                                     
      function( morphism, image_object )
        
        return DeductiveSystemMorphism( image_object, "ImageEmbedding", [ morphism ], Range( morphism ) );
        
    end );
    
end );

####################################
##
## Constructors
##
####################################

InstallMethod( DeductiveSystem,
               [ IsHomalgCategory ],
               
  function( category )
    local deductive_system;
    
    deductive_system := CreateHomalgCategory( Concatenation( "Deduction system of ", Name( category ) ) );
    
    SetUnderlyingHonestCategory( deductive_system, category );
    
    ADDS_FOR_DEDUCTIVE_SYSTEM( deductive_system, category );
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, "General" );
    
    return deductive_system;
    
end );

##
InstallMethod( InDeductiveSystem,
               [ IsHomalgCategoryObject ],
               
  function( object )
    local deductive_object;
    
    deductive_object := rec( );
    
    ObjectifyWithAttributes( deductive_object, TheTypeOfDeductiveSystemObject,
                             Eval, object );
    
    SetHistory( deductive_object, deductive_object );
    
    Add( DeductiveSystem( HomalgCategory( object ) ), deductive_object );
    
    return deductive_object;
    
end );

##
InstallMethod( DeductiveSystemObject,
               [ IsString, IsList ],
               
  function( func, argument_list )
    local deductive_object, resolved_history;
    
    deductive_object := rec( );
    
    resolved_history := RESOLVE_HISTORY( argument_list );
    
    ObjectifyWithAttributes( deductive_object, TheTypeOfDeductiveSystemObject,
                             History, [ func, resolved_history ] );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( func, argument_list, deductive_object );
    
    return deductive_object;
    
end );

##
InstallMethod( InDeductiveSystem,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local deductive_morphism, source, range;
    
    source := InDeductiveSystem( Source( morphism ) );
    
    range := InDeductiveSystem( Range( morphism ) );
    
    deductive_morphism := rec( );
    
    ObjectifyWithAttributes( deductive_morphism, TheTypeOfDeductiveSystemMorphism,
                             Source, source,
                             Range, range,
                             Eval, morphism );
    
    SetHistory( deductive_morphism, deductive_morphism );
    
    Add( DeductiveSystem( HomalgCategory( morphism ) ), deductive_morphism );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ deductive_morphism ], source );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ deductive_morphism ], range );
    
    return deductive_morphism;
    
end );

##
InstallMethod( DeductiveSystemMorphism,
               [ IsDeductiveSystemObject, IsString, IsList, IsDeductiveSystemObject ],
               
  function( source, func, argument_list, range )
    local deductive_morphism, resolved_history;
    
    deductive_morphism := rec( );
    
    resolved_history := RESOLVE_HISTORY( argument_list );
    
    ObjectifyWithAttributes( deductive_morphism, TheTypeOfDeductiveSystemMorphism,
                             History, [ func, resolved_history ],
                             Source, source,
                             Range, range );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( func, argument_list, deductive_morphism );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ deductive_morphism ], source, HomalgCategory( source ) );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ deductive_morphism ], range, HomalgCategory( range ) );
    
    return deductive_morphism;
    
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
    
    if IsDeductiveSystemCell( list ) then
        
        return Eval( list );
        
    elif IsList( list ) and Length( list ) = 2 and IsString( list[ 1 ] ) then
        
        return CallFuncList( ValueGlobal( list[ 1 ] ), List( list[ 2 ], RECURSIVE_EVAL ) );
        
    elif IsList( list ) then
        
        return List( list, RECURSIVE_EVAL );
        
    fi;
    
    return list;
    
end );

##
InstallMethod( Eval,
               [ IsDeductiveSystemCell ],
               
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
               [ IsDeductiveSystemObject ],
               
  function( cell )
    
    Print( "<An unevaluated object in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsDeductiveSystemMorphism ],
               
  function( cell )
    
    Print( "<An unevaluated morphism in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsDeductiveSystemCell and HasEval ],
               100000000000000, ##FIXME!!!!
               
  function( cell )
    
    Print( "<Deductive system hull of: " );
    
    ViewObj( Eval( cell ) );
    
    Print( ">" );
    
end );

