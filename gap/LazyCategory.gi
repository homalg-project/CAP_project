#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsLazyCategoryObjectRep",
                       IsHomalgCategoryObjectRep and IsLazyCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfLazyCategoryObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsLazyCategoryObjectRep ) );

DeclareRepresentation( "IsLazyCategoryMorphismRep",
                       IsHomalgCategoryMorphismRep and IsLazyCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfLazyCategoryMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsLazyCategoryMorphismRep ) );

#################################
##
## Category constructor
##
#################################

BindGlobal( "ADDS_FOR_LAZY_CATEGORY",
            
  function( lazy_category, category )
    local EvalProductList, EvalAndRewrapProductList;
    
    #WARNING: The constructor LazyMorphismWithoutX must not be used, because
    #in a deductive system, source and target are not formal but actual
    #operations.
    #Furthermore, it is not necessary to derive source or target from the function.
    #If one is only interested in the source of an unevaluated morphism, the morphism
    #itself should not be evaluated.
    
    AddPreCompose( lazy_category,
                   
      function( left_morphism, right_morphism )
        local func;
        
        func := function( ) return PreCompose( Eval( left_morphism ), Eval( right_morphism ) ); end;
        
        return LazyMorphism( Source( left_morphism ), func, Range( right_morphism ) );
        
    end );
    
    AddIdentityMorphism( lazy_category,
                         
      function( object )
        local func;
        
        func := function( ) return IdentityMorphism( Eval( object ) ); end;
        
        return LazyMorphism( object, func, object );
        
    end );
    
    AddInverse( lazy_category,
                
      function( morphism )
        local func;
        
        func := function( ) return Inverse( Eval( morphism ) ); end;
        
        return LazyMorphism( Range( morphism ), func, Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( lazy_category,
                         
      function( monomorphism, test_morphism )
        local func;
        
        func := function( ) return MonoAsKernelLift( Eval( monomorphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphism( Source( test_morphism ), func, Source( monomorphism ) );
        
    end );
    
    AddEpiAsCokernelColift( lazy_category,
                            
      function( epimorphism, test_morphism )
        local func;
        
        func := function( ) return EpiAsCokernelColift( Eval( epimorphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphism( Range( epimorphism ), func, Range( test_morphism ) );
        
    end );
    
    AddIsMonomorphism( lazy_category,
                       
      function( morphism )
        
        return IsMonomorphism( Eval( morphism ) );
        
    end );
    
    AddIsEpimorphism( lazy_category,
                       
      function( morphism )
        
        return IsEpimorphism( Eval( morphism ) );
        
    end );
    
    AddIsIsomorphism( lazy_category,
                       
      function( morphism )
        
        return IsIsomorphism( Eval( morphism ) );
        
    end );
    
    AddDominates( lazy_category,
                  
      function( subobject1, subobject2 )
        
        return Dominates( Eval( subobject1 ), Eval( subobject2 ) );
        
    end );
    
    AddCodominates( lazy_category,
                  
      function( factorobject1, factorobject2 )
        
        return Codominates( Eval( factorobject1 ), Eval( factorobject2 ) );
        
    end );
    
    AddIsEqualForMorphisms( lazy_category,
                           
      function( morphism1, morphism2 )
        
        return IsEqualForMorphisms( Eval( morphism1 ), Eval( morphism2 ) );
        
    end );
    
    AddIsZeroForMorphisms( lazy_category,
                           
      function( morphism )
        
        return IsZero( Eval( morphism ) );
        
    end );
    
    AddAdditionForMorphisms( lazy_category,
                             
      function( morphism1, morphism2 )
        local func;
        
        func := function( ) return Eval( morphism1 ) + Eval( morphism2 ); end;
        
        return LazyMorphism( Source( morphism1 ), func, Range( morphism2 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( lazy_category,
                                   
      function( morphism )
        local func;
        
        func := function( ) return AdditiveInverse( Eval( morphism ) ); end;
        
        return LazyMorphism( Source( morphism ), func, Range( morphism ) );
        
    end );
    
    AddZeroMorphism( lazy_category,
                     
      function( source, range )
        local func;
        
        func := function( ) return ZeroMorphism( Eval( source ), Eval( range ) ); end;
        
        return LazyMorphism( source, func, range );
        
    end );
    
    AddIsWellDefinedForMorphisms( lazy_category,
                                  
      function( morphism )
        
        return IsWellDefined( Eval( morphism ) );
        
    end );
    
    AddKernelObject( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return KernelObject( Eval( morphism ) ); end;
        
        return LazyObject( func );
        
      end );
      
    AddKernelEmb( lazy_category,
                  
      function( morphism )
        local func;
        
        func := function( ) return KernelEmb( Eval( morphism ) ); end;
        
        return LazyMorphism( KernelObject( morphism ), func, Source( morphism ) );
        
    end );
    
    AddKernelEmbWithGivenKernel( lazy_category,
      
      function( morphism, kernel )
        local func;
        
        func := function( ) return KernelEmbWithGivenKernel( Eval( morphism ), Eval( kernel ) ); end;
        
        return LazyMorphism( kernel, func, Source( morphism ) );
        
    end );
    
    AddKernelLift( lazy_category,
      
      function( morphism, test_morphism )
        local func;
        
        func := function( ) return KernelLift( Eval( morphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphism( Source( test_morphism ), func, KernelObject( morphism ) );
        
    end );
    
    AddKernelLiftWithGivenKernel( lazy_category,
      
      function( morphism, test_morphism, kernel )
        local func;
        
        func := function( ) return KernelLiftWithGivenKernel( Eval( morphism ), Eval( test_morphism ), Eval( kernel ) ); end;
        
        return LazyMorphism( Source( test_morphism ), func, kernel );
        
    end );
    
    AddCokernel( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return Cokernel( Eval( morphism ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddCokernelProj( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return CokernelProj( Eval( morphism ) ); end;
        
        return LazyMorphism( Range( morphism ), func, Cokernel( morphism ) );
        
    end );
    
    AddCokernelProjWithGivenCokernel( lazy_category,
      
      function( morphism, cokernel )
        local func;
        
        func := function( ) return CokernelProjWithGivenCokernel( Eval( morphism ), Eval( cokernel ) ); end;
        
        return LazyMorphism( Range( morphism ), func, cokernel );
        
    end );
    
    AddCokernelColift( lazy_category,
      
      function( morphism, test_morphism )
        local func;
        
        func := function( ) return CokernelColift( Eval( morphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphism( Cokernel( morphism ), func, Range( test_morphism ) );
        
    end );
    
    AddCokernelColiftWithGivenCokernel( lazy_category,
      
      function( morphism, test_morphism, cokernel )
        local func;
        
        func := function( ) return CokernelColiftWithGivenCokernel( Eval( morphism ), Eval( test_morphism ), Eval( cokernel ) ); end;
        
        return LazyMorphism( cokernel, func, Range( test_morphism ) );
        
    end );
    
    AddZeroObject( lazy_category,
      
      function( )
        local func;
        
        func := function( ) return ZeroObject( UnderlyingBusyCategory( lazy_category ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddTerminalObject( lazy_category,
      
      function( )
        local func;
        
        func := function( ) return TerminalObject( UnderlyingBusyCategory( lazy_category ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddUniversalMorphismIntoTerminalObject( lazy_category,
      
      function( object )
        local func;
        
        func := function( ) return UniversalMorphismIntoTerminalObject( Eval( object ) ); end;
        
        return LazyMorphism( object, func, TerminalObject( object ) );
        
    end );
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( lazy_category,
      
      function( object, terminal_object )
        local func;
        
        func := function( ) return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( Eval( object ), Eval( terminal_object ) ); end;
        
        return LazyMorphism( object, func, terminal_object );
        
    end );
    
    AddInitialObject( lazy_category,
      
      function( )
        local func;
        
        func := function( ) return InitialObject( UnderlyingBusyCategory( lazy_category ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddUniversalMorphismFromInitialObject( lazy_category,
      
      function( object )
        local func;
        
        func := function( ) return UniversalMorphismFromInitialObject( Eval( object ) ); end;
        
        return LazyMorphism( InitialObject( object ), func, object );
        
    end );
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( lazy_category,
      
      function( object, initial_object )
        local func;
        
        func := function( ) return UniversalMorphismFromInitialObjectWithGivenInitialObject( Eval( object ), Eval( initial_object ) ); end;
        
        return LazyMorphism( initial_object, func, object );
        
    end );
    
    #auxiliary functions
    ## FIXME: superfluous
    EvalProductList := function( product_list )
      
      return List( product_list, Eval );
      
    end;
    
    ## FIXME: superfluous
    EvalAndRewrapProductList := function( product_list )
      local evaluation_list;
      
      evaluation_list := List( product_list, Eval );
      
      return evaluation_list;
      
    end;
    
    # object_product_list is an object in the product category of the lazy category
    AddDirectSum( lazy_category,
      
      function( object_product_list )
        local func;
        
        func := function( ) return CallFuncList( DirectSum, EvalProductList( object_product_list ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddCoproduct( lazy_category,
      
      function( object_product_list )
        local func;
        
        func := function( ) return CallFuncList( Coproduct, EvalProductList( object_product_list ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddInjectionOfCofactorOfCoproduct( lazy_category,
      
      function( object_product_list, injection_number )
        local func, coproduct;
        
        func := function( ) return InjectionOfCofactor( EvalAndRewrapProductList( object_product_list ), injection_number ); end;
        
        coproduct := CallFuncList( Coproduct, Components( object_product_list ) );
        
        return LazyMorphism( object_product_list[ injection_number ], func, coproduct );
        
    end );
    
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( lazy_category,
      
      function( object_product_list, injection_number, coproduct )
        local func;
        
        func := function( ) 
        
          return InjectionOfCofactorOfCoproductWithGivenCoproduct( EvalAndRewrapProductList( object_product_list ), injection_number, Eval( coproduct ) ); 
          
        end;
        
        return LazyMorphism( object_product_list[ injection_number ], func, coproduct );
        
    end );
    
    AddUniversalMorphismFromCoproduct( lazy_category,
      
      function( sink )
        local func, coproduct;
        
        func := function( ) return CallFuncList( UniversalMorphismFromCoproduct, EvalProductList( sink ) ); end;
        
        coproduct := CallFuncList( Coproduct, List( Components( sink ), Source ) );
        
        return LazyMorphism( coproduct, func, Source( sink[1] ) );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( lazy_category,
      
      function( sink, coproduct )
        local func;
        
        func := function( ) return UniversalMorphismFromCoproductWithGivenCoproduct( EvalAndRewrapProductList( sink ), Eval( coproduct ) ); end;
        
        return LazyMorphism( coproduct, func, Source( sink[1] ) );
        
    end );
    
    AddDirectProduct( lazy_category,
      
      function( object_product_list )
        local func;
        
        func := function( ) return CallFuncList( DirectProduct, EvalProductList( object_product_list ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddProjectionInFactorOfDirectProduct( lazy_category,
      
      function( object_product_list, projection_number )
        local func, direct_product;
        
        func := function( ) return ProjectionInFactor( EvalAndRewrapProductList( object_product_list ), projection_number ); end;
        
        direct_product := CallFuncList( DirectProduct, Components( object_product_list ) );
        
        return LazyMorphism( direct_product, func, object_product_list[ projection_number ] );
        
    end );
    
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( lazy_category,
      
      function( object_product_list, projection_number, direct_product )
        local func;
        
        func := function( ) 
          
          return ProjectionInFactorOfDirectProductWithGivenDirectProduct( EvalAndRewrapProductList( object_product_list ), projection_number, Eval( direct_product ) );
        
        end;
        
        return LazyMorphism( direct_product, func, object_product_list[ projection_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProduct( lazy_category,
      
      function( source )
        local func, direct_product;
        
        func := function( ) return CallFuncList( UniversalMorphismIntoDirectProduct, EvalProductList( source ) ); end;
        
        direct_product := CallFuncList( DirectProduct, List( Components( source ), Range ) );
        
        return LazyMorphism( Source( source[1] ), func, direct_product );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( lazy_category,
      
      function( source, direct_product )
        local func;
        
        func := function( ) 
          
          return UniversalMorphismIntoDirectProductWithGivenDirectProduct( EvalAndRewrapProductList( source ), Eval( direct_product ) );
        
        end;
        
        return LazyMorphism(  Source( source[1] ), func, direct_product );
        
    end );
    
    AddFiberProduct( lazy_category,
      
      function( diagram )
        local func;
        
        func := function( ) return CallFuncList( FiberProduct, EvalProductList( diagram ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddProjectionInFactorOfPullback( lazy_category,
      
      function( diagram, projection_number )
        local func, pullback;
        
        func := function( ) return ProjectionInFactor( EvalAndRewrapProductList( diagram ), projection_number ); end;
        
        pullback := CallFuncList( FiberProduct, Components( diagram ) );
        
        return LazyMorphism( pullback, func, Source( diagram[ projection_number ] ) );
        
    end );
    
    AddProjectionInFactorOfPullbackWithGivenPullback( lazy_category,
      
      function( diagram, projection_number, pullback )
        local func;
        
        func := function( ) 
          
          return ProjectionInFactorOfPullbackWithGivenPullback( EvalAndRewrapProductList( diagram ), projection_number, Eval( pullback ) );
          
        end;
        
        return LazyMorphism( pullback, func, Source( diagram[ projection_number ] ) );
        
    end );
    
    AddUniversalMorphismIntoPullback( lazy_category,
      
      function( diagram, source )
        local func, pullback;
        
        func := function( ) 
          
          return CallFuncList( UniversalMorphismIntoPullback, 
                   Concatenation( [ EvalAndRewrapProductList( diagram ) ], EvalProductList( source ) )
                 );
                 
        end;
        
        pullback := CallFuncList( FiberProduct, Components( diagram ) );
        
        return LazyMorphism( Source( source[1] ), func, pullback );
        
    end );
    
    AddUniversalMorphismIntoPullbackWithGivenPullback( lazy_category,
      
      function( diagram, source, pullback )
        local func;
        
        func := function( )
          
          return UniversalMorphismIntoPullbackWithGivenPullback(
                   EvalAndRewrapProductList( diagram ), EvalAndRewrapProductList( source ), Eval( pullback )
                 );
        end;
        
        return LazyMorphism( Source( source[1] ), func, pullback );
      
    end );
    
    AddPushout( lazy_category,
      
      function( diagram )
        local func;
        
        func := function( ) return CallFuncList( Pushout, EvalProductList( diagram ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddInjectionOfCofactorOfPushout( lazy_category,
      
      function( diagram, injection_number )
        local func, pushout;
        
        func := function( ) return InjectionOfCofactor( EvalAndRewrapProductList( diagram ), injection_number ); end;
        
        pushout := CallFuncList( Pushout, Components( diagram ) );
        
        return LazyMorphism( Range( diagram[ injection_number ] ), func, pushout );
        
    end );
    
    AddInjectionOfCofactorOfPushoutWithGivenPushout( lazy_category,
      
      function( diagram, injection_number, pushout )
        local func;
        
        func := function( ) 
          
          return InjectionOfCofactorOfPushoutWithGivenPushout( EvalAndRewrapProductList( diagram ), injection_number, Eval( pushout ) );
        
        end;
        
        return LazyMorphism( Range( diagram[ injection_number ] ), func, pushout );
        
    end );
    
    AddUniversalMorphismFromPushout( lazy_category,
      
      function( diagram, sink )
        local func, pushout;
        
        func := function( )
          
          return CallFuncList( UniversalMorphismFromPushout,
                   Concatenation( [ EvalAndRewrapProductList( diagram ) ], EvalProductList( sink ) )
                 );
                 
        end;
        
        pushout := CallFuncList( Pushout, Components( diagram ) );
        
        return LazyMorphism( pushout, func, Range( sink[1] ) );
        
    end );
    
    AddUniversalMorphismFromPushoutWithGivenPushout( lazy_category,
      
      function( diagram, sink, pushout )
        local func;
        
        func := function( )
          
          return UniversalMorphismFromPushoutWithGivenPushout( 
                   EvalAndRewrapProductList( diagram ), EvalAndRewrapProductList( sink ), Eval( pushout )
                 );
                 
        end;
        
        return LazyMorphism( pushout, func, Range( sink[1] ) );
        
    end );
    
    AddImageObject( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return ImageObject( Eval( morphism ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddImageEmbedding( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return ImageEmbedding( Eval( morphism ) ); end;
        
        return LazyMorphism( ImageObject( morphism ), func, Range( morphism ) );
        
    end );
    
    AddImageEmbeddingWithGivenImage( lazy_category,
      
      function( morphism, image )
        local func;
        
        func := function( ) return ImageEmbeddingWithGivenImage( Eval( morphism ), Eval( image ) ); end;
        
        return LazyMorphism( image, func, Range( morphism ) );
        
    end );
    
end );

InstallMethod( LazyCategory,
               [ IsHomalgCategory ],
               
  function( category )
    local lazy_category;
    
    lazy_category := CreateHomalgCategory( Concatenation( "Lazy category of ", Name( category ) ) );
    
    SetUnderlyingBusyCategory( lazy_category, category );
    
    ADDS_FOR_LAZY_CATEGORY( lazy_category, category );
    
    return lazy_category;
    
end );

InstallMethod( Lazy,
               [ IsHomalgCategoryObject ],
               
  function( cell )
    local lazy_cell;
    
    lazy_cell := rec( );
    
    ObjectifyWithAttributes( lazy_cell, TheTypeOfLazyCategoryObject );
    
    SetEval( lazy_cell, cell );
    
    Add( LazyCategory( HomalgCategory( cell ) ), lazy_cell );
    
    return lazy_cell;
    
end );

InstallMethod( Lazy,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local lazy_morphism;
    
    lazy_morphism := rec( );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetEval( lazy_morphism, morphism );
    
    SetSource( lazy_morphism, Lazy( Source( morphism ) ) );
    
    SetRange( lazy_morphism, Lazy( Range( morphism ) ) );
    
    Add( LazyCategory( HomalgCategory( morphism ) ), lazy_morphism );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyObject,
                       
  function( evaluate_function )
    local lazy_object;
    
    lazy_object := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_object, TheTypeOfLazyCategoryObject );
    
    return lazy_object;
    
end );

InstallGlobalFunction( LazyMorphism,
                       
  function( source, evaluate_function, range )
    local lazy_morphism, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetSource( lazy_morphism, source );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyMorphismWithoutSourceAndRange,
                       
  function( evaluate_function )
    local lazy_morphism, source, range, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    source := LazyObject( function( ) return Source( Eval( lazy_morphism ) ); end );
    
    SetSource( lazy_morphism, source );
    
    range := LazyObject( function( ) return Range( Eval( lazy_morphism ) ); end );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyMorphismWithoutSource,
                       
  function( evaluate_function, range )
    local lazy_morphism, source, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    source := LazyObject( function( ) return Source( Eval( lazy_morphism ) ); end );
    
    SetSource( lazy_morphism, source );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyMorphismWithoutRange,
                       
  function( source, evaluate_function )
    local lazy_morphism, range, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetSource( lazy_morphism, source );
    
    range := LazyObject( function( ) return Range( Eval( lazy_morphism ) ); end );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

#################################
##
## Dummy Constructors
##
#################################

##
InstallMethod( Object,
               [ IsHomalgCategory ],
               
  function( category )
    local object;
    
    object := rec( );
    
    ObjectifyWithAttributes( object, TheTypeOfLazyCategoryObject );
    
    Add( LazyCategory( category ), object );
    
    return object;
    
end );

##
InstallMethod( Object,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return Object( HomalgCategory( cell ) );
    
end );

##
InstallMethod( Morphism,
               [ IsHomalgCategoryObject, IsHomalgCategory, IsHomalgCategoryObject ],
               
  function( source, category, range )
    local lazy_category, morphism, entry;
    
    lazy_category := LazyCategory( category );
    
    if not ObjectFilter( lazy_category )( source ) then
        
        Error( "source must lie in lazy category" );
        
    fi;
    
    if not ObjectFilter( lazy_category )( source ) then
        
        Error( "range must lie in lazy category" );
        
    fi;
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfLazyCategoryMorphism,
                             Source, source,
                             Range, range );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    Add( lazy_category, morphism );
    
    return morphism;
    
end );

InstallMethod( Morphism,
               [ IsHomalgCategoryObject, IsHomalgCategoryCell, IsHomalgCategoryObject ],
               
  function( source, cell, range )
    
    return Morphism( source, HomalgCategory( cell ), range );
    
end );

InstallMethod( Morphism,
               [ IsHomalgCategory ],
               
  function( category )
    local lazy_category, source, range, morphism, entry;
    
    lazy_category := LazyCategory( category );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfLazyCategoryMorphism );
    
    source := LazyObject( function( ) return Source( Eval( morphism ) ); end );
    
    SetSource( morphism, source );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    range := LazyObject( function( ) return Range( Eval( morphism ) ); end );
    
    SetRange( morphism, range );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    Add( lazy_category, morphism );
    
    return morphism;
    
end );

InstallMethod( Morphism,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return Morphism( HomalgCategory( cell ) );
    
end );

#################################
##
## Cell attributes
##
#################################

InstallMethod( Eval,
               [ IsLazyCategoryCell ],
               
  function( cell )
    
    return cell!.evaluate_function( );
    
end );

#################################
##
## View
##
#################################

InstallMethod( ViewObj,
               [ IsLazyCategoryObject ],
               
  function( cell )
    
    Print( "<An unevaluated object in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsLazyCategoryMorphism ],
               
  function( cell )
    
    Print( "<An unevaluated morphism in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsLazyCategoryCell and HasEval ],
               100000000000000, ##FIXME!!!!
               
  function( cell )
    
    Print( "Lazy hull of:\n" );
    
    ViewObj( Eval( cell ) );
    
end );
