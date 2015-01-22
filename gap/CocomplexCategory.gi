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


BindGlobal( "INSTALL_ALL_ADDS_COMPLEX_COCOMPLEX",
            
  function( name_part, object_constructor, morphism_constructor, category_getter )
    
    ## PreCompose
    ##
    BindGlobal( Concatenation( "ADD_PRECOMPOSE_IN_", name_part, "_CATEGORY" ),
      
      function( category )
        
        AddPreCompose( category_getter( category ),
              
          function( mor_left, mor_right )
            local source, range;
            
            source := Source( mor_left );
            
            range := Range( mor_right );
            
            return morphism_constructor( source, PreCompose( UnderlyingZFunctorCell( mor_left ), UnderlyingZFunctorCell( mor_right ) ), range );
            
        end );
        
    end );

    ## Identity
    ##
    BindGlobal( Concatenation( "ADD_IDENTITY_MORPHISM_IN_", name_part, "_CATEGORY" ),
              
      function( category )
          
          AddIdentityMorphism( category_getter( category ),
              
              function( object )
                
                return morphism_constructor( object, IdentityMorphism( UnderlyingZFunctorCell( object ) ), object );
                
          end );
          
    end );

    ## Inverse
    ##
    BindGlobal( Concatenation( "ADD_INVERSE_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddInverse( category_getter( category ),
            
            function( isomorphism )
              local source, range;
              
              source := Range( isomorphism );
              
              range := Source( isomorphism );
              
              return morphism_constructor( source, Inverse( UnderlyingZFunctorCell( isomorphism ) ), range );
              
        end );
        
    end );

    ## MonoAsKernelLift
    ##
    BindGlobal( Concatenation( "ADD_MONO_AS_KERNEL_LIFT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddMonoAsKernelLift( category_getter( category ),
            
            function( monomorphism, test_morphism )
              local source, range;
              
              source := Source( test_morphism );
              
              range := Source( monomorphism );
              
              return morphism_constructor( source, MonoAsKernelLift( UnderlyingZFunctorCell( monomorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
              
        end );
        
    end );

    ## EpiAsCokernelColift
    ##
    BindGlobal( Concatenation( "ADD_EPI_AS_COKERNEL_COLIFT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddEpiAsCokernelColift( category_getter( category ),
                             
          function( epimorphism, test_morphism )
            local source, range;
            
            source := Range( epimorphism );
            
            range := Range( test_morphism );
            
            return morphism_constructor( source, EpiAsCokernelColift( UnderlyingZFunctorCell( epimorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
            
        end );
        
    end );

    ## KernelObject
    ##
    BindGlobal( Concatenation( "ADD_KERNEL_OBJECT_IN_", name_part, "_CATEGORY" ),
              
      function( category )

          AddKernelObject( category_getter( category ),
            
            function( morphism )
              
              return object_constructor( KernelObject( UnderlyingZFunctorCell( morphism ) ) );
              
          end );
          
    end );

    ## KernelEmbWithGivenKernel
    BindGlobal( Concatenation( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddKernelEmbWithGivenKernel( category_getter( category ),
            
            function( morphism, kernel )
              local range;
              
              range := Source( morphism );
              
              return morphism_constructor( kernel, KernelEmb( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), range );
              
          end );
          
    end );

    ## KernelLiftWithGivenKernel
    BindGlobal( Concatenation( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddKernelLiftWithGivenKernel( category_getter( category ),
            
            function( morphism, test_morphism, kernel )
              local source;
              
              source := Source( test_morphism );
              
              return morphism_constructor( source, KernelLift( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), kernel );

          end );
          
    end );

    ## Cokernel
    ##
    BindGlobal( Concatenation( "ADD_COKERNEL_IN_", name_part, "_CATEGORY" ),
              
      function( category )

          AddCokernel( category_getter( category ),
            
            function( morphism )
              
              return object_constructor( Cokernel( UnderlyingZFunctorCell( morphism ) ) );
              
          end );
        
    end );

    ## CokernelProjWithGivenCokernel
    BindGlobal( Concatenation( "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddCokernelProjWithGivenCokernel( category_getter( category ),
            
            function( morphism, cokernel )
              local source;
              
              source := Range( morphism );
              
              return morphism_constructor( source, CokernelProj( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( cokernel ) ), cokernel );
              
          end );
          
    end );

    ## CokernelColiftWithGivenCokernel
    BindGlobal( Concatenation( "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddCokernelColiftWithGivenCokernel( category_getter( category ),
            
            function( morphism, test_morphism, cokernel )
              local range;
              
              range := Range( test_morphism );
              
              return morphism_constructor( cokernel, CokernelColift( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
              
          end );
          
    end );

    ## Zero object
    ##
    BindGlobal( Concatenation( "ADD_ZERO_OBJECT_IN_", name_part, "_CATEGORY" ),
                
      function( category )
        
        AddZeroObject( category_getter( category ),
          
          function( )
            
            return object_constructor( ZeroObject( ZFunctorCategory( category ) ) );
            
        end );
        
    end );

    ## Terminal object
    ##
    BindGlobal( Concatenation( "ADD_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ),
                
      function( category )
        
        AddTerminalObject( category_getter( category ),
          
          function( )
            
            return object_constructor( TerminalObject( ZFunctorCategory( category ) ) );
            
        end );
        
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category_getter( category ),
          
          function( object, terminal_object )
            
            return morphism_constructor( object, UniversalMorphismIntoTerminalObject( UnderlyingZFunctorCell( object ), UnderlyingZFunctorCell( terminal_object ) ), terminal_object );
            
        end );
        
    end );

    ## Initial object
    ##
    BindGlobal( Concatenation( "ADD_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ),
                
      function( category )
        
        AddInitialObject( category_getter( category ),
          
          function( )
            
            return object_constructor( InitialObject( ZFunctorCategory( category ) ) );
            
        end );
        
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddUniversalMorphismFromInitialObjectWithGivenInitialObject( category_getter( category ),
          
          function( object, initial_object )
            
            return morphism_constructor( initial_object, UniversalMorphismFromInitialObject( UnderlyingZFunctorCell( object ), UnderlyingZFunctorCell( initial_object ) ), object );
        
        end );
        
    end );

    ## Direct product
    ##
    BindGlobal( Concatenation( "ADD_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddDirectProduct( category_getter( category ),
            
            function( object_list )
              
              return object_constructor( DirectProduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddProjectionInFactorOfDirectProductWithGivenDirectProduct( category_getter( category ),
            
            function( object_list, projection_number, direct_product )
              local range;
              
              range := object_list[ projection_number ];
              
              return morphism_constructor( direct_product,
                                 ProjectionInFactorOfDirectProduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ), projection_number, UnderlyingZFunctorCell( direct_product ) ),
                                 range );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( category_getter( category ),
            
            function( diagram, source, direct_product )
              
              return morphism_constructor( Source( source[1] ),
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
    BindGlobal( Concatenation( "ADD_COPRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddCoproduct( category_getter( category ),
            
            function( object_list )
              
              return object_constructor( Coproduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddInjectionOfCofactorOfCoproductWithGivenCoproduct( category_getter( category ),
            
            function( object_list, injection_number, coproduct )
              local source;
              
              source := object_list[ injection_number ];
              
              return morphism_constructor( source,
                                 InjectionOfCofactorOfCoproduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ), injection_number, UnderlyingZFunctorCell( coproduct ) ),
                                 coproduct );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddUniversalMorphismFromCoproductWithGivenCoproduct( category_getter( category ),
            
            function( diagram, sink, coproduct )
              
              return morphism_constructor( coproduct,
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
    BindGlobal( Concatenation( "ADD_DIRECT_SUM_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddDirectSum( category_getter( category ),
          
          function( object_list )
            
            return object_constructor( DirectSum( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
            
        end );
        
    end );

    ## Pullback
    ##
    BindGlobal( Concatenation( "ADD_FIBER_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddFiberProduct( category_getter( category ),
            
            function( morphism_list )
              
              return object_constructor( FiberProduct( List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ) ) );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddProjectionInFactorOfPullbackWithGivenPullback( category_getter( category ),
            
            function( morphism_list, projection_number, pullback )
              local range;
              
              range := Source( morphism_list[ projection_number ] );
              
              return morphism_constructor( pullback,
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
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddUniversalMorphismIntoPullbackWithGivenPullback( category_getter( category ),
            
            function( diagram, source, pullback )
              
              return morphism_constructor( Source( source[1] ),
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
    BindGlobal( Concatenation( "ADD_PUSHOUT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddPushout( category_getter( category ),
            
            function( morphism_list )
              
              return object_constructor( Pushout( List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ) ) );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddInjectionOfCofactorOfPushoutWithGivenPushout( category_getter( category ),
            
            function( morphism_list, injection_number, pushout )
              local source;
              
              source := Range( morphism_list[ injection_number ] );
              
              return morphism_constructor( source,
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
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddUniversalMorphismFromPushoutWithGivenPushout( category_getter( category ),
            
            function( diagram, sink, pushout )

              return morphism_constructor( pushout,
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
    BindGlobal( Concatenation( "ADD_ADDITION_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ),
             
        function( category )
          
          AddAdditionForMorphisms( category_getter( category ),
          
            function( morphism1, morphism2 )
              
              return morphism_constructor( Source( morphism1 ),
                     UnderlyingZFunctorCell( morphism1 ) + UnderlyingZFunctorCell( morphism2 ),
                     Range( morphism1 ) );
                     
          end );
          
    end );

    ## Additive inverse
    ##
    BindGlobal( Concatenation( "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          local differential_func, additive_inverse;
          
          AddAdditiveInverseForMorphisms( category_getter( category ),
                                        
            function( morphism )
              
              return morphism_constructor( Source( morphism ), -UnderlyingZFunctorCell( morphism ), Range( morphism ) );
              
          end );
          
    end );

    ## Zero morphism
    ##
    BindGlobal( Concatenation( "ADD_ZERO_MORPHISM_IN_", name_part, "_CATEGORY" ),
            
        function( category )
          local differential_func, zero_morphism;

          AddZeroMorphism( category_getter( category ),
                         
            function( source, range )
              
              return morphism_constructor( source, ZeroMorphism( UnderlyingZFunctorCell( source ), UnderlyingZFunctorCell( range ) ), range );
              
          end );
          
    end );
    
end );

BindGlobal( "INSTALL_ALL_ADDS_COMPLEX_COCOMPLEX_NOW",
            
  function( )
    local install_list, i;
    
    install_list := [ [ "COMPLEX", AsComplex, ChainMap, ComplexCategory ],
                      [ "COCOMPLEX", AsCocomplex, CochainMap, CocomplexCategory ] ];
                      
    for i in install_list do
        
        CallFuncList( INSTALL_ALL_ADDS_COMPLEX_COCOMPLEX, i );
        
    od;
    
end );

INSTALL_ALL_ADDS_COMPLEX_COCOMPLEX_NOW( );


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