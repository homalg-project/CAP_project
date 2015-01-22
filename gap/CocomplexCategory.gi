#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsCocomplexRep",
                       IsCapCategoryObjectRep and IsCocomplex,
                       [ ] );

DeclareRepresentation( "IsCochainMapRep",
                       IsCapCategoryMorphismRep and IsCochainMap,
                       [ ] );

BindGlobal( "TheTypeOfCocomplexes",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCocomplexRep ) );

BindGlobal( "TheTypeOfCochainMaps",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCochainMapRep ) );

#############################
##
## Attributes
##
#############################

##
InstallMethod( CocomplexCategory,
               [ IsCapCategory ],
               
  function( category )
    local name, cocomplex_category;
    
    if not IsAbelianCategory( category ) then
        
      Error( "the category must be abelian" );
      
    fi;
    
    name := Name( category );
    
    name := Concatenation( "Cocomplex category of ", name );
    
    cocomplex_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( cocomplex_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_COCOMPLEX_CATEGORY( category );
    
    return cocomplex_category;
    
end );

#############################
##
## Add methods
##
#############################

## PreCompose
##
BindGlobal( "ADD_PRECOMPOSE_IN_COCOMPLEX_CATEGORY",
  
  function( category )
    
    AddPreCompose( CocomplexCategory( category ),
          
      function( mor_left, mor_right )
        local source, range;
        
        source := Source( mor_left );
        
        range := Range( mor_right );
        
        return CochainMap( source, PreCompose( UnderlyingZFunctorCell( mor_left ), UnderlyingZFunctorCell( mor_right ) ), range );
        
    end );
    
end );

## Identity
##
BindGlobal( "ADD_IDENTITY_MORPHISM_IN_COCOMPLEX_CATEGORY",
          
  function( category )
      
      AddIdentityMorphism( CocomplexCategory( category ),
          
          function( object )
            
            return CochainMap( object, IdentityMorphism( UnderlyingZFunctorCell( object ) ), object );
            
      end );
      
end );

## Inverse
##
BindGlobal( "ADD_INVERSE_IN_COCOMPLEX_CATEGORY",
          
  function( category )
    
    AddInverse( CocomplexCategory( category ),
        
        function( isomorphism )
          local source, range;
          
          source := Range( isomorphism );
          
          range := Source( isomorphism );
          
          return CochainMap( source, Inverse( UnderlyingZFunctorCell( isomorphism ) ), range );
          
    end );
    
end );

## MonoAsKernelLift
##
BindGlobal( "ADD_MONO_AS_KERNEL_LIFT_IN_COCOMPLEX_CATEGORY",
          
  function( category )
    
    AddMonoAsKernelLift( CocomplexCategory( category ),
        
        function( monomorphism, test_morphism )
          local source, range;
          
          source := Source( test_morphism );
          
          range := Source( monomorphism );
          
          return CochainMap( source, MonoAsKernelLift( UnderlyingZFunctorCell( monomorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
          
    end );
    
end );

## EpiAsCokernelColift
##
BindGlobal( "ADD_EPI_AS_COKERNEL_COLIFT_IN_COCOMPLEX_CATEGORY",
          
  function( category )
    
    AddEpiAsCokernelColift( CocomplexCategory( category ),
                         
      function( epimorphism, test_morphism )
        local source, range;
        
        source := Range( epimorphism );
        
        range := Range( test_morphism );
        
        return CochainMap( source, EpiAsCokernelColift( UnderlyingZFunctorCell( epimorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
        
    end );
    
end );

## KernelObject
##
BindGlobal( "ADD_KERNEL_OBJECT_IN_COCOMPLEX_CATEGORY",
          
  function( category )

      AddKernelObject( CocomplexCategory( category ),
        
        function( morphism )
          
          return AsCocomplex( KernelObject( UnderlyingZFunctorCell( morphism ) ) );
          
      end );
      
end );

## KernelEmbWithGivenKernel
BindGlobal( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_COCOMPLEX_CATEGORY",
  
  function( category )

      AddKernelEmbWithGivenKernel( CocomplexCategory( category ),
        
        function( morphism, kernel )
          local range;
          
          range := Source( morphism );
          
          return CochainMap( kernel, KernelEmb( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), range );
          
      end );
      
end );

## KernelLiftWithGivenKernel
BindGlobal( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_COCOMPLEX_CATEGORY",
  
  function( category )

      AddKernelLiftWithGivenKernel( CocomplexCategory( category ),
        
        function( morphism, test_morphism, kernel )
          local source;
          
          source := Source( test_morphism );
          
          return CochainMap( source, KernelLift( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), kernel );

      end );
      
end );

## Cokernel
##
BindGlobal( "ADD_COKERNEL_IN_COCOMPLEX_CATEGORY",
          
  function( category )

      AddCokernel( CocomplexCategory( category ),
        
        function( morphism )
          
          return AsCocomplex( Cokernel( UnderlyingZFunctorCell( morphism ) ) );
          
      end );
    
end );

## CokernelProjWithGivenCokernel
BindGlobal( "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_COCOMPLEX_CATEGORY",
  
  function( category )

      AddCokernelProjWithGivenCokernel( CocomplexCategory( category ),
        
        function( morphism, cokernel )
          local source;
          
          source := Range( morphism );
          
          return CochainMap( source, CokernelProj( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( cokernel ) ), cokernel );
          
      end );
      
end );

## CokernelColiftWithGivenCokernel
BindGlobal( "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_COCOMPLEX_CATEGORY",
  
  function( category )

      AddCokernelColiftWithGivenCokernel( CocomplexCategory( category ),
        
        function( morphism, test_morphism, cokernel )
          local range;
          
          range := Range( test_morphism );
          
          return CochainMap( cokernel, CokernelColift( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
          
      end );
      
end );

## Zero object
##
BindGlobal( "ADD_ZERO_OBJECT_IN_COCOMPLEX_CATEGORY",
            
  function( category )
    
    AddZeroObject( CocomplexCategory( category ),
      
      function( )
        
        return AsCocomplex( ZeroObject( ZFunctorCategory( category ) ) );
        
    end );
    
end );

## Terminal object
##
BindGlobal( "ADD_TERMINAL_OBJECT_IN_COCOMPLEX_CATEGORY",
            
  function( category )
    
    AddTerminalObject( CocomplexCategory( category ),
      
      function( )
        
        return AsCocomplex( TerminalObject( ZFunctorCategory( category ) ) );
        
    end );
    
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_COCOMPLEX_CATEGORY",
          
  function( category )
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( CocomplexCategory( category ),
      
      function( object, terminal_object )
        
        return CochainMap( object, UniversalMorphismIntoTerminalObject( UnderlyingZFunctorCell( object ), UnderlyingZFunctorCell( terminal_object ) ), terminal_object );
        
    end );
    
end );

## Initial object
##
BindGlobal( "ADD_INITIAL_OBJECT_IN_COCOMPLEX_CATEGORY",
            
  function( category )
    
    AddInitialObject( CocomplexCategory( category ),
      
      function( )
        
        return AsCocomplex( InitialObject( ZFunctorCategory( category ) ) );
        
    end );
    
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_COCOMPLEX_CATEGORY",
          
  function( category )
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( CocomplexCategory( category ),
      
      function( object, initial_object )
        
        return CochainMap( initial_object, UniversalMorphismFromInitialObject( UnderlyingZFunctorCell( object ), UnderlyingZFunctorCell( initial_object ) ), object );
    
    end );
    
end );

## Direct product
##
BindGlobal( "ADD_DIRECT_PRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddDirectProduct( CocomplexCategory( category ),
        
        function( object_list )
          
          return AsCocomplex( DirectProduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
          
      end );
      
end );

##
BindGlobal( "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddProjectionInFactorOfDirectProductWithGivenDirectProduct( CocomplexCategory( category ),
        
        function( object_list, projection_number, direct_product )
          local range;
          
          range := object_list[ projection_number ];
          
          return CochainMap( direct_product,
                             ProjectionInFactorOfDirectProduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ), projection_number, UnderlyingZFunctorCell( direct_product ) ),
                             range );
          
      end );
      
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( CocomplexCategory( category ),
        
        function( diagram, source, direct_product )
          
          return CochainMap( Source( source[1] ),
                   UniversalMorphismIntoDirectProduct(
                     List( diagram, obj -> UnderlyingZFunctorCell( obj ) ),
                     List( source, mor -> UnderlyingZFunctorCell( mor ) ),
                     UnderlyingZFunctorCell( direct_product ) 
                   ),
                   direct_product );
                   
      end );
      
end );

## Coproduct
##
BindGlobal( "ADD_COPRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddCoproduct( CocomplexCategory( category ),
        
        function( object_list )
          
          return AsCocomplex( Coproduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
          
      end );
      
end );

##
BindGlobal( "ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddInjectionOfCofactorOfCoproductWithGivenCoproduct( CocomplexCategory( category ),
        
        function( object_list, injection_number, coproduct )
          local source;
          
          source := object_list[ injection_number ];
          
          return CochainMap( source,
                             InjectionOfCofactorOfCoproduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ), injection_number, UnderlyingZFunctorCell( coproduct ) ),
                             coproduct );
          
      end );
      
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddUniversalMorphismFromCoproductWithGivenCoproduct( CocomplexCategory( category ),
        
        function( diagram, sink, coproduct )
          
          return CochainMap( coproduct,
                   UniversalMorphismFromCoproduct(
                     List( diagram, obj -> UnderlyingZFunctorCell( obj ) ),
                     List( sink, mor -> UnderlyingZFunctorCell( mor ) ),
                     UnderlyingZFunctorCell( coproduct )
                   ),
                   Range( sink[1] ) );
                   
      end );
      
end );

## Direct sum
##
BindGlobal( "ADD_DIRECT_SUM_IN_COCOMPLEX_CATEGORY",
          
  function( category )
    
    AddDirectSum( CocomplexCategory( category ),
      
      function( object_list )
        
        return AsCocomplex( DirectSum( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
        
    end );
    
end );

## Pullback
##
BindGlobal( "ADD_FIBER_PRODUCT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddFiberProduct( CocomplexCategory( category ),
        
        function( morphism_list )
          
          return AsCocomplex( FiberProduct( List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ) ) );
          
      end );
      
end );

##
BindGlobal( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddProjectionInFactorOfPullbackWithGivenPullback( CocomplexCategory( category ),
        
        function( morphism_list, projection_number, pullback )
          local range;
          
          range := Source( morphism_list[ projection_number ] );
          
          return CochainMap( pullback,
                   ProjectionInFactorOfPullback(
                     List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ),
                     projection_number,
                     UnderlyingZFunctorCell( pullback )
                   ),
                   range
                 );
          
      end );
    
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddUniversalMorphismIntoPullbackWithGivenPullback( CocomplexCategory( category ),
        
        function( diagram, source, pullback )
          
          return CochainMap( Source( source[1] ),
                   UniversalMorphismIntoPullback(
                     List( diagram, obj -> UnderlyingZFunctorCell( obj ) ),
                     List( source, mor -> UnderlyingZFunctorCell( mor ) ),
                     UnderlyingZFunctorCell( pullback )
                   ),
                   pullback );
                   
      end );
      
end );

## Pushout
##
BindGlobal( "ADD_PUSHOUT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddPushout( CocomplexCategory( category ),
        
        function( morphism_list )
          
          return AsCocomplex( Pushout( List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ) ) );
          
      end );
      
end );

##
BindGlobal( "ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddInjectionOfCofactorOfPushoutWithGivenPushout( CocomplexCategory( category ),
        
        function( morphism_list, injection_number, pushout )
          local source;
          
          source := Range( morphism_list[ injection_number ] );
          
          return CochainMap( source,
                   InjectionOfCofactorOfPushout(
                     List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ),
                     injection_number,
                     UnderlyingZFunctorCell( pushout )
                   ),
                   pushout
                 );
          
      end );
    
end );

##
BindGlobal( "ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      
      AddUniversalMorphismFromPushoutWithGivenPushout( CocomplexCategory( category ),
        
        function( diagram, sink, pushout )

          return CochainMap( pushout,
                   UniversalMorphismFromPushout(
                     List( diagram, obj -> UnderlyingZFunctorCell( obj ) ),
                     List( sink, mor -> UnderlyingZFunctorCell( mor ) ),
                     UnderlyingZFunctorCell( pushout )
                   ),
                   Range( sink[1] ) );
                   
      end );
      
end );

## Addition for morphisms
##
BindGlobal( "ADD_ADDITION_FOR_MORPHISMS_IN_COCOMPLEX_CATEGORY",
         
    function( category )
      
      AddAdditionForMorphisms( CocomplexCategory( category ),
      
        function( morphism1, morphism2 )
          
          return CochainMap( Source( morphism1 ),
                 UnderlyingZFunctorCell( morphism1 ) + UnderlyingZFunctorCell( morphism2 ),
                 Range( morphism1 ) );
                 
      end );
      
end );

## Additive inverse
##
BindGlobal( "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_COCOMPLEX_CATEGORY",
          
    function( category )
      local differential_func, additive_inverse;
      
      AddAdditiveInverseForMorphisms( CocomplexCategory( category ),
                                    
        function( morphism )
          
          return CochainMap( Source( morphism ), -UnderlyingZFunctorCell( morphism ), Range( morphism ) );
          
      end );
      
end );

## Zero morphism
##
BindGlobal( "ADD_ZERO_MORPHISM_IN_COCOMPLEX_CATEGORY",
        
    function( category )
      local differential_func, zero_morphism;

      AddZeroMorphism( CocomplexCategory( category ),
                     
        function( source, range )
          
          return CochainMap( source, ZeroMorphism( UnderlyingZFunctorCell( source ), UnderlyingZFunctorCell( range ) ), range );
          
      end );
      
end );
##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_COCOMPLEX_CATEGORY,
            
  function( category )
   local z_functor_category, todo_list_entries, entry, new_entry;
    
    z_functor_category := ZFunctorCategory( category );
    
    todo_list_entries := [
    
        [ [ "CanComputePreCompose" ], function( ) ADD_PRECOMPOSE_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeIdentityMorphism" ], function( ) ADD_IDENTITY_MORPHISM_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeZeroObject" ], function( ) ADD_ZERO_OBJECT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeKernel" ], function( ) ADD_KERNEL_OBJECT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeKernelEmb" ], function( ) ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeKernelLift" ], function( ) ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeCokernel" ], function( ) ADD_COKERNEL_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeCokernelProj" ], function( ) ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeCokernelColift" ], function( ) ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeTerminalObject" ], function( ) ADD_TERMINAL_OBJECT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeUniversalMorphismIntoTerminalObject" ], function( ) ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeInitialObject" ], function( ) ADD_INITIAL_OBJECT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeUniversalMorphismFromInitialObject" ], function( ) ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeDirectProduct" ], function( ) ADD_DIRECT_PRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeProjectionInFactorOfDirectProduct" ],
          function( ) ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeUniversalMorphismIntoDirectProduct" ],
          function( ) ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeCoproduct" ], function( ) ADD_COPRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeInjectionOfCofactorOfCoproduct" ],
          function( ) ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeUniversalMorphismFromCoproduct" ],
          function( ) ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeDirectSum" ], function( ) ADD_DIRECT_SUM_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputePullback" ], function( ) ADD_FIBER_PRODUCT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeProjectionInFactorOfPullback" ],
          function( ) ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeUniversalMorphismIntoPullback" ],
          function( ) ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputePushout" ], function( ) ADD_PUSHOUT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeInjectionOfCofactorOfPushout" ],
          function( ) ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeUniversalMorphismFromPushout" ],
          function( ) ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeInverse" ], function( ) ADD_INVERSE_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeMonoAsKernelLift" ], function( ) ADD_MONO_AS_KERNEL_LIFT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeEpiAsCokernelColift" ], function( ) ADD_EPI_AS_COKERNEL_COLIFT_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeAdditionForMorphisms" ], function( ) ADD_ADDITION_FOR_MORPHISMS_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeAdditiveInverseForMorphisms" ], function( ) ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_COCOMPLEX_CATEGORY( category ); end ],
        
        [ [ "CanComputeZeroMorphism" ], function( ) ADD_ZERO_MORPHISM_IN_COCOMPLEX_CATEGORY( category ); end ],
        
    ];
    
    for entry in todo_list_entries do
        
        new_entry := ToDoListEntry(
          Concatenation( List( entry[1], can_compute -> [ z_functor_category, can_compute ] ), [ [ category, "CocomplexCategory" ] ] ),
          entry[2]
        );
        
        AddToToDoList( new_entry );
        
    od;
    
end );



#############################
##
## Getter
##
############################
##
## No setter are installed:
## For an explanation see ZFunctor category.

##
InstallMethod( \[\],
               [ IsCocomplexCell, IsInt ],
               
  function( cocomplex_cell, index )
      
      return UnderlyingZFunctorCell( cocomplex_cell )[ index ];
      
end );

##
InstallMethod( Differential,
               [ IsCocomplex, IsInt ],
               
  function( cocomplex, index )
      
      return Differential( UnderlyingZFunctorCell( cocomplex ), index );
      
end );

#################################################
##
## Constructors
##
#################################################

##
InstallMethod( AsCocomplex,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    local category, object;
    
    category := UnderlyingHonestCategory( CapCategory( z_functor_object ) );
    
    object := rec( );
    
    ObjectifyWithAttributes( object, TheTypeOfCocomplexes,
                             UnderlyingZFunctorCell, z_functor_object );
    
    Add( CocomplexCategory( category ), object );
    
    return object;
    
end );

##
InstallMethod( AsCochainMap,
               [ IsZFunctorMorphism ],
               
  function( z_functor_morphism )
    local category, source, range, morphism;
    
    category := UnderlyingHonestCategory( CapCategory( z_functor_morphism ) );
    
    source := AsCocomplex( Source( z_functor_morphism ) );
    
    range := AsCocomplex( Range( z_functor_morphism ) );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfCochainMaps,
                             UnderlyingZFunctorCell, z_functor_morphism,
                             Source, source,
                             Range, range );
    
    Add( CocomplexCategory( category ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( CochainMap,
               [ IsCocomplex, IsZFunctorMorphism, IsCocomplex ],
               
  function( source, z_functor_morphism, range )
    local category, morphism;
    
    category := UnderlyingHonestCategory( CapCategory( z_functor_morphism ) );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfCochainMaps,
                             UnderlyingZFunctorCell, z_functor_morphism,
                             Source, source,
                             Range, range );
    
    Add( CocomplexCategory( category ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( AsPointedCocomplexOp,
               [ IsCapCategoryObject, IsInt ],
               
  function( object, index )
      
      return AsCocomplex( AsZFunctorObject( object, index ) );
      
end );

##
InstallMethod( AsPointedCochainMapOp,
               [ IsCapCategoryMorphism, IsInt ],
               
  function( morphism, index )
      
      return AsCochainMap( AsZFunctorMorphism( morphism, index ) );
      
end );