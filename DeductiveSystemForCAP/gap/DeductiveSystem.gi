# SPDX-License-Identifier: GPL-2.0-or-later
# DeductiveSystemForCAP: Deductive system for CAP
#
# Implementations
#

####################################
##
## Option records and functions
##
####################################

InstallValue( DEDUCTIVE_SYSTEM_OPTIONS,
              rec( resolve_variable_names := false ) );

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
                       IsCapCategoryObjectRep and IsDeductiveSystemObject,
                       [ ] );

BindGlobal( "TheTypeOfDeductiveSystemObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsDeductiveSystemObjectRep ) );

DeclareRepresentation( "IsDeductiveSystemMorphismRep",
                       IsCapCategoryMorphismRep and IsDeductiveSystemMorphism,
                       [ ] );

BindGlobal( "TheTypeOfDeductiveSystemMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsDeductiveSystemMorphismRep ) );

DeclareRepresentation( "IsDeductiveSystemTwoCellRep",
                       IsCapCategoryTwoCellRep and IsDeductiveSystemTwoCell,
                       [ ] );

BindGlobal( "TheTypeOfDeductiveTwoCell",
        NewType( TheFamilyOfCapCategoryTwoCells,
                IsDeductiveSystemTwoCellRep ) );

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
    
    AddInverseForMorphisms( deductive_system,
                
      function( morphism )
        
        return DeductiveSystemMorphism( Range( morphism ), "Inverse", [ morphism ], Source( morphism ) );
        
    end );
    
    AddLiftAlongMonomorphism( deductive_system,
                         
      function( monomorphism, test_morphism )
        
        return DeductiveSystemMorphism( Source( test_morphism ), "LiftAlongMonomorphism", [ monomorphism, test_morphism ], Source( monomorphism ) );
        
    end );
    
    AddColiftAlongEpimorphism( deductive_system,
                            
      function( epimorphism, test_morphism )
        
        return DeductiveSystemMorphism( Range( epimorphism ), "ColiftAlongEpimorphism", [ epimorphism, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddIsMonomorphism( deductive_system,
                       
      function( morphism )
        
        return IsMonomorphism( Evaluation( morphism ) );
        
    end );
    
    AddIsEpimorphism( deductive_system,
                      
      function( morphism )
        
        return IsEpimorphism( Evaluation( morphism ) );
        
    end );
    
    AddIsIsomorphism( deductive_system,
                      
      function( morphism )
        
        return IsIsomorphism( Evaluation( morphism ) );
        
    end );
    
    AddIsDominating( deductive_system,
                  
      function( subobject1, subobject2 )
        
        return IsDominating( Evaluation( subobject1 ), Evaluation( subobject2 ) );
        
    end );
    
    AddIsCodominating( deductive_system,
                    
      function( factorobject1, factorobject2 )
        
        return IsCodominating( Evaluation( factorobject1 ), Evaluation( factorobject2 ) );
        
    end );
    
    AddIsCongruentForMorphisms( deductive_system,
                            
      function( morphism1, morphism2 )
        
        return IsCongruentForMorphisms( Evaluation( morphism1 ), Evaluation( morphism2 ) );
        
    end );
    
    AddIsZeroForMorphisms( deductive_system,
                           
      function( morphism )
        
        return IsZero( Evaluation( morphism ) );
        
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
    
    AddKernelEmbedding( deductive_system,
                  
      function( morphism )
        
        return DeductiveSystemMorphism( KernelObject( morphism ), "KernelEmbedding", [ morphism ], Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( deductive_system,
                                 
      function( morphism, kernel )
        
        return DeductiveSystemMorphism( kernel, "KernelEmbedding", [ morphism ], Source( morphism ) );
        
    end );
    
    AddKernelLift( deductive_system,
                   
      function( morphism, test_object, test_morphism )
        
        return DeductiveSystemMorphism( Source( test_morphism ), "KernelLift", [ morphism, test_object, test_morphism ], KernelObject( morphism ) );
        
    end );
    
    AddKernelLiftWithGivenKernelObject( deductive_system,
                                  
      function( morphism, test_object, test_morphism, kernel )
        
        return DeductiveSystemMorphism( Source( test_morphism ), "KernelLift", [ morphism, test_object, test_morphism ], kernel );
        
    end );
    
    AddCokernelObject( deductive_system,
                 
      function( morphism )
        
        return DeductiveSystemObject( "CokernelObject", [ morphism ] );
        
    end );
    
    AddCokernelProjection( deductive_system,
                     
      function( morphism )
        
        return DeductiveSystemMorphism( Range( morphism ), "CokernelProjection", [ morphism ], CokernelObject( morphism ) );
        
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( deductive_system,
                                      
      function( morphism, cokernel )
        
        return DeductiveSystemMorphism( Range( morphism ), "CokernelProjection", [ morphism ], cokernel );
        
    end );
    
    AddCokernelColift( deductive_system,
                       
      function( morphism, test_object, test_morphism )
        
        return DeductiveSystemMorphism( CokernelObject( morphism ), "CokernelColift", [ morphism, test_object, test_morphism ], Range( test_morphism ) );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( deductive_system,
                                        
      function( morphism, test_object, test_morphism, cokernel )
        
        return DeductiveSystemMorphism( cokernel, "CokernelColift", [ morphism, test_object, test_morphism ], Range( test_morphism ) );
        
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
        
        return DeductiveSystemMorphism( object_product_list[ injection_number ], "InjectionOfCofactorOfCoproduct",  [ object_product_list, injection_number ], coproduct );
        
    end );
    
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( deductive_system,
                                              
      function( object_product_list, injection_number, coproduct )
        
        return DeductiveSystemMorphism( object_product_list[ injection_number ], "InjectionOfCofactorOfCoproduct", [ object_product_list, injection_number ], coproduct );
        
    end );
    
    AddUniversalMorphismFromCoproduct( deductive_system,
                                       
      function( diagram, test_object, sink )
        local coproduct;
        
        coproduct := Coproduct( List( sink, Source ) );
        
        return DeductiveSystemMorphism( coproduct, "UniversalMorphismFromCoproduct", [ diagram, test_object, sink ], Source( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( deductive_system,
                                                         
      function( diagram, test_object, sink, coproduct )
        
        return DeductiveSystemMorphism( coproduct, "UniversalMorphismFromCoproduct", [ diagram, test_object, sink ], Source( sink[ 1 ] ) );
        
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
                                           
      function( diagram, test_object, source )
        local direct_product;
        
        direct_product := DirectProduct( List( source, Range ) );
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoDirectProduct", [ diagram, test_object, source ], direct_product );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( deductive_system,
                                           
      function( diagram, test_object, source, direct_product )
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoDirectProduct", [ diagram, test_object, source ], direct_product );
        
    end );
    
    AddFiberProduct( deductive_system,
                 
      function( diagram )
        
        return DeductiveSystemObject( "FiberProduct", [ diagram ] );
        
    end );
    
    AddProjectionInFactorOfFiberProduct( deductive_system,
                                     
      function( diagram, projection_number )
        local pullback;
        
        pullback := FiberProduct( diagram );
        
        return DeductiveSystemMorphism( pullback, "ProjectionInFactorOfFiberProduct", [ diagram, projection_number ], Source( diagram[ projection_number ] ) );
        
    end );
    
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( deductive_system,
                                     
      function( diagram, projection_number, pullback )
        
        return DeductiveSystemMorphism( pullback, "ProjectionInFactorOfFiberProduct", [ diagram, projection_number ], Source( diagram[ projection_number ] ) );
        
    end );
    
    AddUniversalMorphismIntoFiberProduct( deductive_system,
                                      
      function( diagram, test_object, source )
        local pullback;
        
        pullback := FiberProduct( diagram );
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoFiberProduct", [ diagram, test_object, source ], pullback );
        
    end );
    
    AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( deductive_system,
                                      
      function( diagram, test_object, source, pullback )
        
        return DeductiveSystemMorphism( Source( source[ 1 ] ), "UniversalMorphismIntoFiberProduct", [ diagram, test_object, source ], pullback );
        
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
                                     
      function( diagram, test_object, sink )
        local pushout;
        
        pushout := Pushout( diagram );
        
        return DeductiveSystemMorphism( pushout, "UniversalMorphismFromPushout", [ diagram, test_object, sink ], Range( sink[ 1 ] ) );
        
    end );
    
    AddUniversalMorphismFromPushoutWithGivenPushout( deductive_system,
                                     
      function( diagram, test_object, sink, pushout )
        
        return DeductiveSystemMorphism( pushout, "UniversalMorphismFromPushout", [ diagram, test_object, sink ], Range( sink[ 1 ] ) );
        
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
    
    AddImageEmbeddingWithGivenImageObject( deductive_system,
                                     
      function( morphism, image_object )
        
        return DeductiveSystemMorphism( image_object, "ImageEmbedding", [ morphism ], Range( morphism ) );
        
    end );
    
    AddCoastrictionToImage( deductive_system,
                            
      function( morphism )
        local image_object;
        
        image_object := ImageObject( morphism );
        
        return DeductiveSystemMorphism( Source( morphism ), "CoastrictionToImage", [ morphism ], image_object );
        
    end );
    
    AddCoastrictionToImageWithGivenImageObject( deductive_system,
                            
      function( morphism, image_object )
        
        return DeductiveSystemMorphism( Source( morphism ), "CoastrictionToImage", [ morphism ], image_object );
        
    end );
    
    AddUniversalMorphismFromImage( deductive_system,
                                   
      function( morphism, test_factorization )
        local image_object;
        
        image_object := ImageObject( morphism );
        
        return DeductiveSystemMorphism( image_object, "UniversalMorphismFromImage", [ morphism, test_factorization ], Source( test_factorization[1] ) );
    end );
    
    AddUniversalMorphismFromImageWithGivenImageObject( deductive_system,
                                   
      function( morphism, test_factorization, image_object )
        
        return DeductiveSystemMorphism( image_object, "UniversalMorphismFromImage", [ morphism, test_factorization ], Source( test_factorization[1] ) );
    end );
    
end );

####################################
##
## Constructors
##
####################################

InstallMethod( DeductiveSystem,
               [ IsCapCategory ],
               
  function( category )
    local deductive_system;
    
    deductive_system := CreateCapCategory( Concatenation( "Deduction system of ", Name( category ) ) );
    
    SetTheoremRecord( deductive_system, TheoremRecord( category ) );
    
    SetUnderlyingCategory( deductive_system, category );
    
    INSTALL_PROPERTIES_FOR_DEDUCTIVE_SYSTEM( deductive_system, category );
    
    ADDS_FOR_DEDUCTIVE_SYSTEM( deductive_system, category );
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER_EVAL_RULES( category, deductive_system, "IsCapCategory" );
    
    return deductive_system;
    
end );

BindGlobal( "INSTALL_PROPERTIES_FOR_DEDUCTIVE_SYSTEM_INSTALL_HELPER",
            
  function( name, filter )
      
      InstallMethod( name,
                     [ filter ],
          
        function( cell )
          
          return name( Evaluation( cell ) );
          
      end );
      
end );

InstallGlobalFunction( INSTALL_PROPERTIES_FOR_DEDUCTIVE_SYSTEM,
                       
  function( deductive_category, category )
    local families, family, type, filter, filter_getter, property, type_list;
    
    families := category!.families;
    
    deductive_category!.properties_to_propagate := rec( cell := [ ], object := [ ], morphism := [ ], twocell := [ ] );
    
    for family in families do
        
        if IsBound( CATEGORIES_FAMILY_PROPERTIES.( family ) ) then
            
            for type in [ 1 .. 4 ] do
                
                filter := [ "IsDeductiveSystemCell", "IsDeductiveSystemObject", "IsDeductiveSystemMorphism", "IsDeductiveSystemTwoCell" ];
                
                filter := filter[ type ];
                
                filter_getter := [ CellFilter, ObjectFilter, MorphismFilter, TwoCellFilter ];
                
                filter_getter := filter_getter[ type ];
                
                type_list := [ "cell", "object", "morphism", "twocell" ];
                
                type := type_list[ type ];
                
                if IsBound( CATEGORIES_FAMILY_PROPERTIES.( family ).( type ) ) then
                    
                    for property in CATEGORIES_FAMILY_PROPERTIES.( family ).( type ) do
                        
                        Add( deductive_category!.properties_to_propagate.( type ), property[ 1 ] );
                        
                        if property[ 2 ] = true then
                            
                            DeclareProperty( property[ 1 ], ValueGlobal( filter ) and filter_getter( deductive_category ) );
                            
                        fi;
                        
                        property := ValueGlobal( property[ 1 ] );
                        
                        INSTALL_PROPERTIES_FOR_DEDUCTIVE_SYSTEM_INSTALL_HELPER( property, ValueGlobal( filter ) and filter_getter( deductive_category ) );
                        
                    od;
                    
                fi;
                
            od;
            
        fi;
        
    od;
    
end );

##
InstallMethod( InDeductiveSystem,
               [ IsCapCategoryObject ],
               
  function( object )
    local deductive_object, deductive_system, property, entry;
    
    deductive_object := ObjectifyWithAttributes( rec( ), TheTypeOfDeductiveSystemObject );
    
    SetEvaluation( deductive_object, object );
    
    SetHistory( deductive_object, deductive_object );
    
    deductive_system := DeductiveSystem( CapCategory( object ) );
    
    Add( deductive_system, deductive_object );
    
    for property in Concatenation( deductive_system!.properties_to_propagate.cell, deductive_system!.properties_to_propagate.object ) do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( object, property, deductive_object, property ) );
        
    od;
    
    return deductive_object;
    
end );

##
InstallMethod( DeductiveSystemObject,
               [ IsString, IsList ],
               
  function( func, argument_list )
    local deductive_object, resolved_history;
    
#     resolved_history := RESOLVE_HISTORY( argument_list );
    
    deductive_object := ObjectifyWithAttributes( rec( ), TheTypeOfDeductiveSystemObject,
                                                 History, rec( command := func, arguments := argument_list ) );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( func, argument_list, deductive_object );
    
    return deductive_object;
    
end );

##
InstallMethod( DeductiveSystemObject,
               [ IsCapCategory ],
               
  function( category )
    local deductive_system, deductive_object;
    
    deductive_system := DeductiveSystem( category );
    
    deductive_object := ObjectifyWithAttributes( rec( ), TheTypeOfDeductiveSystemObject );
    
    SetHistory( deductive_object, deductive_object );
    
    Add( deductive_system, deductive_object );
    
    return deductive_object;
    
end );
    

##
InstallMethod( InDeductiveSystem,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    local deductive_morphism, source, range, property, deductive_system;
    
    source := InDeductiveSystem( Source( morphism ) );
    
    range := InDeductiveSystem( Range( morphism ) );
    
    deductive_morphism := ObjectifyWithAttributes( rec( ), TheTypeOfDeductiveSystemMorphism,
                                                   Source, source,
                                                   Range, range );
    
    SetEvaluation( deductive_morphism, morphism );
    
    SetHistory( deductive_morphism, deductive_morphism );
    
    deductive_system := DeductiveSystem( CapCategory( morphism ) );
    
    Add( deductive_system, deductive_morphism );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ deductive_morphism ], source );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ deductive_morphism ], range );
    
    for property in Concatenation( deductive_system!.properties_to_propagate.cell, deductive_system!.properties_to_propagate.morphism ) do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( morphism, property, deductive_morphism, property ) );
        
    od;
    
    return deductive_morphism;
    
end );

##
InstallMethod( DeductiveSystemMorphism,
               [ IsDeductiveSystemObject, IsString, IsList, IsDeductiveSystemObject ],
               
  function( source, func, argument_list, range )
    local deductive_morphism, resolved_history;
    
#     resolved_history := RESOLVE_HISTORY( argument_list );
    
    deductive_morphism := ObjectifyWithAttributes( rec( ), TheTypeOfDeductiveSystemMorphism,
                                                   History, rec( command := func, arguments := argument_list ),
                                                   Source, source,
                                                   Range, range );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( func, argument_list, deductive_morphism );
    
    ## CHECK THIS
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ deductive_morphism ], source, CapCategory( source ) );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ deductive_morphism ], range, CapCategory( range ) );
    
    return deductive_morphism;
    
end );

##
InstallMethod( DeductiveSystemMorphism,
               [ IsDeductiveSystemObject, IsDeductiveSystemObject ],
               
  function( source, range )
    local deductive_system, deductive_morphism;
    
    deductive_morphism := ObjectifyWithAttributes( rec( ), TheTypeOfDeductiveSystemMorphism,
                                                   Source, source,
                                                   Range, range );
    
    SetHistory( deductive_morphism, deductive_morphism );
    
    Add( CapCategory( source ), deductive_morphism );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ deductive_morphism ], source, CapCategory( source ) );
    
    INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ deductive_morphism ], range, CapCategory( range ) );
    
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
        
        if IsDeductiveSystemCell( History( list ) ) and not HasEvaluation( list ) then
            
            Error( "cannot evaluate object since leaves in history do not have evaluation.\n If you continue from here, your results will be wrong." );
            
        fi;
        
        return Evaluation( list );
        
    elif IsRecord( list ) then
        
        return CallFuncList( ValueGlobal( list!.command ), List( list!.arguments, RECURSIVE_EVAL ) );
        
    elif IsList( list ) then
        
        return List( list, RECURSIVE_EVAL );
        
    fi;
    
    return list;
    
end );

##
InstallMethod( Evaluation,
               [ IsDeductiveSystemCell ],
               
  function( cell )
    local history, new_history, checks, eval, property, property_list, deductive_system;
    
    if IsBound( cell!.eval ) and IsBoundElmWPObj( cell!.eval, 1 ) then
        
        return ElmWPObj( cell!.eval, 1 );
        
    fi;
    
    history := History( cell );
    
    if IsBound( UnderlyingCategory( CapCategory( cell ) )!.eval_rules ) then
        
        new_history := APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE( history, UnderlyingCategory( CapCategory( cell ) )!.eval_rules );
        
    else
        
        new_history := fail;
        
    fi;
    
    if new_history <> fail then
        
        checks := new_history!.part_for_is_well_defined;
        
        new_history := new_history!.new_history;
        
    else
        
        checks := [ ];
        
        new_history := history;
        
    fi;
    
    SetHistory( cell, new_history );
    
    SetChecksFromLogic( cell, checks );
    
    eval := RECURSIVE_EVAL( new_history );
    
    cell!.eval := WeakPointerObj( [ eval ] );
    
    deductive_system := CapCategory( cell );
    
    if IsDeductiveSystemMorphism( cell ) then
        
        property_list := deductive_system!.properties_to_propagate.morphism;
        
    elif IsDeductiveSystemObject( cell ) then
        
        property_list := deductive_system!.properties_to_propagate.object;
        
    else
        
        property_list := [ ];
        
    fi;
    
    for property in Concatenation( deductive_system!.properties_to_propagate.cell, property_list ) do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( cell, property, eval, property ) );
        
    od;
    
    return eval;
    
end );

InstallMethod( HasEvaluation,
               [ IsDeductiveSystemCell ],
               
  function( cell )
    
    return IsBound( cell!.eval ) and IsBoundElmWPObj( cell!.eval, 1 );
    
end );

InstallMethod( SetEvaluation,
               [ IsDeductiveSystemCell, IsCapCategoryCell ],
               
  function( cell, value )
    
    cell!.eval := WeakPointerObj( [ value ] );
    
end );

#################################
##
## Special Adds
##
#################################

# InstallMethod( Add,
#                [ IsCapCategory, IsDeductiveSystemObject ],
#                
#   function( deductive_system, object )
#     local property;
#     
#     if HasEvaluation( object ) then
#         
#         TryNextMethod();
#         
#     fi;
#     
#     AddToToDoList( ToDoListEntryToMaintainEqualAttributes( [ [ object, "HasEvaluation",  ] ], [ object, [ Eval, object ] ], Concatenation( deductive_system!.properties_to_propagate.cell, deductive_system!.properties_to_propagate.object ) ) );
#     
#     TryNextMethod();
#     
# end );
# 
# InstallMethod( Add,
#                [ IsCapCategory, IsDeductiveSystemMorphism ],
#                
#   function( deductive_system, morphism )
#     local property;
#     
#     if HasEval( morphism ) then
#         
#         TryNextMethod();
#         
#     fi;
#     
#     AddToToDoList( ToDoListEntryToMaintainEqualAttributes( [ [ morphism, "Eval" ] ], [ morphism, [ Eval, morphism ] ], Concatenation( deductive_system!.properties_to_propagate.cell, deductive_system!.properties_to_propagate.morphism ) ) );
#     
#     TryNextMethod();
#     
# end );

#################################
##
## View
##
#################################

InstallMethod( ViewObj,
               [ IsDeductiveSystemObject ],
               
  function( cell )
    
    Print( "<" );
    
    Print( String( cell ) );
    
    Print( ">" );
    
end );

InstallMethod( String,
               [ IsDeductiveSystemObject ],
               
   function( cell )
     
     return Concatenation( "An unevaluated object in " , Name( CapCategory( cell ) ) );
     
end );

InstallMethod( ViewObj,
               [ IsDeductiveSystemMorphism ],
               
  function( cell )
    
    Print( "<" );
    
    Print( String( cell ) );
    
    Print( ">" );
    
end );

InstallMethod( String,
               [ IsDeductiveSystemMorphism ],
               
   function( cell )
     
     return Concatenation( "An unevaluated morphism in " , Name( CapCategory( cell ) ) );
     
end );

## Those two methods can cause errors.
InstallMethod( ViewObj,
               [ IsDeductiveSystemCell ],
               1000000, ##FIXME!!!!
               
  function( cell )
    
    if HasEvaluation( cell ) then
        
        Print( "<Deductive system hull of: " );
        
        ViewObj( Evaluation( cell ) );
        
        Print( ">" );
        
    else
        
        TryNextMethod();
        
    fi;
    
end );

##
InstallMethod( String,
               [ IsDeductiveSystemCell ],
               1000000,
               
  function( cell )
    
    if HasEvaluation( cell ) then
        
        return Concatenation( "Deductive system hull of ", String( cell ) );
        
    fi;
    
    TryNextMethod();
    
end );

#####################################
##
## Print history
##
#####################################

##
InstallGlobalFunction( "HistoryToString",
                       
  function( history )
    local string, resolve_variable_names, gvars;
    
    resolve_variable_names := ValueOption( "ResolveVariableNames" );
    
    if IsRecord( history ) then
        
        return Concatenation( history!.command, "( ", JoinStringsWithSeparator( List( history!.arguments, HistoryToString ), "," ), " )" );
        
    elif IsList( history ) then
        
        string := List( history, HistoryToString );
        
        string := JoinStringsWithSeparator( string, ", " );
        
        return Concatenation( "[ ", string, " ]" );
        
    elif IsCapCategoryCell( history ) and resolve_variable_names = true then
        
        gvars := NamesGVars( );
        
        for string in gvars do
            
            if IsBoundGlobal( string ) and IsIdenticalObj( ValueGlobal( string ), history ) and not string in [ "last", "last2", "last3" ] then
                
                return string;
                
            fi;
            
        od;
        
    fi;
    
    return String( history );
    
end );

##
InstallGlobalFunction( PRINT_HISTORY_RECURSIVE,
                       
  function( history )
    local string, resolve_variable_names, gvars;
    
    resolve_variable_names := ValueOption( "ResolveVariableNames" );
    
    if IsCapCategoryCell( history ) and IsRecord( History( history ) ) then
        
        history := History( history );
        
    fi;
    
    if IsRecord( history ) then
        
        string := List( history!.arguments, PRINT_HISTORY_RECURSIVE );
        
        string := List( string, i -> ReplacedString( i, "\n", "\n*  " ) );
        
        string := List( string, i -> Concatenation( "** ", i, "\n" ) );
        
        string := JoinStringsWithSeparator( string, "" );
        
        string := Concatenation( history!.command, "(\n", string, ")" );
        
        return string;
        
    elif IsList( history ) then
        
        string := List( history, PRINT_HISTORY_RECURSIVE );
        
        string := List( string, i -> ReplacedString( i, "\n", "\n*  " ) );
        
        string := List( string, i -> Concatenation( "** ", i, "\n" ) );
        
        string := JoinStringsWithSeparator( string, "" );
        
        string := Concatenation( "[\n", string, "]" );
        
        return string;
        
    elif IsCapCategoryCell( history ) and resolve_variable_names = true then
        
        gvars := NamesUserGVars( );
        
        for string in gvars do
            
            if IsBoundGlobal( string ) and IsIdenticalObj( ValueGlobal( string ), history ) and not string in [ "last", "last2", "last3" ] then
                
                return string;
                
            fi;
            
        od;
        
    fi;
    
#     InfoOfObject( history );
    
    return String( history );
    
end );

InstallGlobalFunction( PrintHistoryClean,
                       
  function( history )
    
    if IsCapCategoryCell( history ) then
        
        Print( PRINT_HISTORY_RECURSIVE( History( history ) ) );
        
    else
        
        Print( PRINT_HISTORY_RECURSIVE( history ) );
        
    fi;
    
end );

InstallGlobalFunction( PrintHistory,
                       
  function( history )
    
    PrintHistoryClean( history : ResolveVariableNames := true );
    
end );

