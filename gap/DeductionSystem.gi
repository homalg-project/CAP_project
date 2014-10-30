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

InstallGlobalFunction( ADD_THEOREM_TO_CATEGORY,
                       
  function( category, implication_record )
    local theorem_record, name;
    
    theorem_record := TheoremRecord( category );
    
    name := implication_record.Function;
    
    if not IsBound( theorem_record.( name ) ) then
        
        theorem_record.( name ) := [ implication_record ];
        
    else
        
        Add( theorem_record.( name ), implication_record );
        
    fi;
    
end );

InstallGlobalFunction( SANITIZE_RECORD,
                       
  function( record, arguments, result_object )
    local object, index_list, i, value_function, value;
    
    if not IsBound( record!.Object ) then
        
        object := "result";
        
    else
        
        object := record!.Object;
        
    fi;
    
    if IsString( object ) and LowercaseString( object ) = "result" then
        
        object := result_object;
        
    elif IsInt( object ) then
        
        object := arguments[ object ];
        
    elif IsList( object ) then
        
        index_list := object;
        
        object := arguments;
        
        for i in index_list do
            
            object := object[ i ];
            
        od;
        
    else
        
        Error( "wrong object type" );
        
    fi;
    
    if IsBound( record!.ValueFunction ) then
        
        value_function := record!.ValueFunction;
        
    else
        
        value_function := IdFunc;
        
    fi;
    
    if IsBound( record!.Value ) then
        
        value := record!.Value;
        
    else
        
        value := true;
        
    fi;
    
    if not IsBound( record!.compare_function ) then
        
        return [ object, value_function, value ];
        
    else
        
        return [ object, value_function, value, record!.compare_function ];
        
    fi;
    
end );

InstallGlobalFunction( INSTALL_TODO_FOR_LOGICAL_THEOREMS,
                       
  function( method_name, arguments, result_object )
    local current_argument, crisp_category, deduction_category, theorem_list,
          current_theorem, todo_list_source, range, is_valid_theorem, sanitized_source,
          entry, current_source;
    
    if Length( arguments ) = 0 then
        
        Error( "Cannot figure out which category to use here" );
        
    fi;
    
    current_argument := arguments[ 1 ];
    
    if IsHomalgCategory( current_argument ) then
       
        crisp_category := current_argument;
        
        deduction_category := DeductionSystem( crisp_category );
        
    elif IsHomalgCategoryCell( current_argument ) then
        
        deduction_category := HomalgCategory( current_argument );
        
        crisp_category := UnderlyingHonestCategory( deduction_category );
        
    elif IsList( current_argument ) then
        
        deduction_category := HomalgCategory( current_argument[ 1 ] );
        
        crisp_category := UnderlyingHonestCategory( deduction_category );
        
    else
        
        Error( "this should not happen: wrong arguments" );
        
    fi;
    
    if not IsBound( TheoremRecord( crisp_category).( method_name ) ) then
        
        return;
        
    fi;
    
    theorem_list := TheoremRecord( crisp_category ).( method_name );
    
    for current_theorem in theorem_list do
        
        todo_list_source := [ ];
        
        is_valid_theorem := true;
        
        for current_source in current_theorem.Source do
            
            sanitized_source := SANITIZE_RECORD( current_source, arguments, result_object );
            
            if IsBound( current_source!.Type ) and LowercaseString( current_source!.Type ) = "testdirect" then
                
                if ( Length( sanitized_source ) = 3 and not sanitized_source[ 2 ]( sanitized_source[ 1 ] ) = sanitized_source[ 3 ] )
                   or ( Length( sanitized_source ) = 4 and not sanitized_source[ 4 ]( sanitized_source[ 2 ]( sanitized_source[ 1 ] ), sanitized_source[ 3 ] ) ) then
                    
                    is_valid_theorem := false;
                    
                    break;
                      
                fi;
                
            else
                
                sanitized_source[ 2 ] := NameFunction( sanitized_source[ 2 ] );
                
                Add( todo_list_source, sanitized_source );
                
            fi;
            
        od;
        
        if is_valid_theorem = false then
            
            continue;
            
        fi;
        
        range := SANITIZE_RECORD( current_theorem!.Range, arguments, result_object );
        
        if Length( todo_list_source ) = 0 then
            
            Setter( range[ 2 ] )( range[ 1 ], range[ 3 ] );
            
            continue;
            
        fi;
        
        entry := ToDoListEntry( todo_list_source, range[ 1 ], NameFunction( range[ 2 ] ), range[ 3 ] );
        
        AddToToDoList( entry );
        
    od;
    
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
    
    AddIsEqualForMorphisms( deduction_system,
                            
      function( morphism1, morphism2 )
        
        return IsEqualForMorphisms( Eval( morphism1 ), Eval( morphism2 ) );
        
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
    
    AddKernelObject( deduction_system,
               
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
        
        return DeductionSystemObject( "DirectSum", [ object_product_list ] );
        
    end );
    
    AddCoproduct( deduction_system,
                  
      function( object_product_list )
        
        return DeductionSystemObject( "Coproduct", [ object_product_list ] );
        
    end );
    
    AddInjectionOfCofactorOfCoproduct( deduction_system,
                            
      function( object_product_list, injection_number )
        local coproduct;
        
        coproduct := Coproduct( object_product_list );
        
        return DeductionSystemMorphism( object_product_list[ injection_number ], "InjectionOfCofactor",  [ object_product_list, injection_number ], coproduct );
        
    end );
    
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( deduction_system,
                                              
      function( object_product_list, injection_number, coproduct )
        
        return DeductionSystemMorphism( object_product_list[ injection_number ], "InjectionOfCofactorOfCoproductWithGivenCoproduct", [ object_product_list, injection_number, coproduct ], coproduct );
        
    end );
    
    AddUniversalMorphismFromCoproduct( deduction_system,
                                       
      function( sink )
        local coproduct;
        
        coproduct := Coproduct( List( sink, Source ) );
        
        return DeductionSystemMorphism( coproduct, "UniversalMorphismFromCoproduct", [ sink ], Source( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( deduction_system,
                                                         
      function( sink, coproduct )
        
        return DeductionSystemMorphism( coproduct, "UniversalMorphismFromCoproductWithGivenCoproduct", [ sink, coproduct ], Source( sink[ 1 ] ) );
        
    end );
    
    AddDirectProduct( deduction_system,
                      
      function( object_product_list )
        
        return DeductionSystemObject( "DirectProduct", [ object_product_list ] );
        
    end );
    
    AddProjectionInFactorOfDirectProduct( deduction_system,
                           
      function( object_product_list, projection_number )
        local direct_product;
        
        direct_product := DirectProduct( object_product_list );
        
        return DeductionSystemMorphism( direct_product, "ProjectionInFactor", [ object_product_list, projection_number ], object_product_list[ projection_number ] );
        
    end );
    
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( deduction_system,
                                                 
      function( object_product_list, projection_number, direct_product )
        
        return DeductionSystemMorphism( direct_product, "ProjectionInFactor", [ object_product_list, projection_number ], object_product_list[ projection_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProduct( deduction_system,
                                           
      function( source )
        local direct_product;
        
        direct_product := DirectProduct( List( source, Range ) );
        
        return DeductionSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoDirectProduct", source, direct_product );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( deduction_system,
                                           
      function( source, direct_product )
        
        return DeductionSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoDirectProductWithGivenDirectProduct", [ source, direct_product ], direct_product );
        
    end );
    
    AddFiberProduct( deduction_system,
                 
      function( diagram )
        
        return DeductionSystemObject( "FiberProduct", [ diagram ] );
        
    end );
    
    AddProjectionInFactorOfPullback( deduction_system,
                                     
      function( diagram, projection_number )
        local pullback;
        
        pullback := FiberProduct( diagram );
        
        return DeductionSystemMorphism( pullback, "ProjectionInFactorOfPullback", [ diagram, projection_number ], Source( diagram[ projection_number ] ) );
        
    end );
    
    AddProjectionInFactorOfPullbackWithGivenPullback( deduction_system,
                                     
      function( diagram, projection_number, pullback )
        
        return DeductionSystemMorphism( pullback, "ProjectionInFactorOfPullbackWithGivenPullback", [ diagram, projection_number, pullback ], Source( diagram[ projection_number ] ) );
        
    end );
    
    AddUniversalMorphismIntoPullback( deduction_system,
                                      
      function( diagram, source )
        local pullback;
        
        pullback := FiberProduct( diagram );
        
        return DeductionSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoPullback", [ diagram, source ], pullback );
        
    end );
    
    AddUniversalMorphismIntoPullbackWithGivenPullback( deduction_system,
                                      
      function( diagram, source, pullback )
        
        return DeductionSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoPullbackWithGivenPullback", [ diagram, source, pullback ], pullback );
        
    end );
    
    AddPushout( deduction_system,
                
      function( diagram )
        
        return DeductionSystemObject( "Pushout", [ diagram ] );
        
    end );
    
    AddInjectionOfCofactorOfPushout( deduction_system,
                                     
      function( diagram, injection_number )
        local pushout;
        
        pushout := Pushout( diagram );
        
        return DeductionSystemMorphism( Range( diagram[ injection_number ] ), "InjectionOfCofactorOfPushout", [ diagram, injection_number ], pushout );
        
    end );
    
    AddInjectionOfCofactorOfPushoutWithGivenPushout( deduction_system,
                                     
      function( diagram, injection_number, pushout )
        
        return DeductionSystemMorphism( Range( diagram[ injection_number ] ), "InjectionOfCofactorOfPushoutWithGivenPushout", [ diagram, injection_number, pushout ], pushout );
        
    end );
    
    AddUniversalMorphismFromPushout( deduction_system,
                                     
      function( diagram, sink )
        local pushout;
        
        pushout := Pushout( diagram );
        
        return DeductionSystemMorphism( pushout, "UniversalMorphismFromPushout", [ diagram, sink ], Range( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromPushoutWithGivenPushout( deduction_system,
                                     
      function( diagram, sink, pushout )
        
        return DeductionSystemMorphism( pushout, "UniversalMorphismFromPushoutWithGivenPushout", [ diagram, sink, pushout ], Range( sink[ 1 ] ) );
        
    end );
    
    AddImageObject( deduction_system,
              
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
InstallMethod( InDeductionSystem,
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
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( func, argument_list, deduction_object );
    
    return deduction_object;
    
end );

##
InstallMethod( InDeductionSystem,
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
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( func, argument_list, deduction_morphism );
    
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

