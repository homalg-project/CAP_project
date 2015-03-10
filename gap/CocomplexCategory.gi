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

DeclareRepresentation( "IsComplexRep",
                       IsCapCategoryObjectRep and IsComplex,
                       [ ] );

DeclareRepresentation( "IsChainMapRep",
                       IsCapCategoryMorphismRep and IsChainMap,
                       [ ] );

BindGlobal( "TheTypeOfComplexes",
        NewType( TheFamilyOfCapCategoryObjects,
                IsComplexRep ) );

BindGlobal( "TheTypeOfChainMaps",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsChainMapRep ) );


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
    
    if not IsAdditiveCategory( category ) then
        
      Error( "the category must be additive" );
      
    fi;
    
    name := Name( category );
    
    name := Concatenation( "Cocomplex category of ", name );
    
    cocomplex_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( cocomplex_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_COCOMPLEX_CATEGORY( category );
    
    return cocomplex_category;
    
end );

##
InstallMethod( ComplexCategory,
               [ IsCapCategory ],
               
  function( category )
    local name, complex_category;
    
    if not IsAdditiveCategory( category ) then
        
      Error( "the category must be additive" );
      
    fi;
    
    name := Name( category );
    
    name := Concatenation( "Complex category of ", name );
    
    complex_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( complex_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_COMPLEX_CATEGORY( category );
    
    return complex_category;
    
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
            
            return morphism_constructor( object, UniversalMorphismIntoTerminalObject( UnderlyingZFunctorCell( object ) ), terminal_object );
            
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
            
            return morphism_constructor( initial_object, UniversalMorphismFromInitialObject( UnderlyingZFunctorCell( object ) ), object );
        
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
    
    InstallGlobalFunction( ValueGlobal( Concatenation( "INSTALL_TODO_LIST_ENTRIES_FOR_", name_part, "_CATEGORY" ) ),
                
      function( category )
       local z_functor_category, todo_list_entries, entry, new_entry;
        
        z_functor_category := ZFunctorCategory( category );
        
        todo_list_entries := [
        
            [ [ "CanComputePreCompose" ], function( ) ValueGlobal( Concatenation(  "ADD_PRECOMPOSE_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeIdentityMorphism" ], function( ) ValueGlobal( Concatenation(  "ADD_IDENTITY_MORPHISM_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeZeroObject" ], function( ) ValueGlobal( Concatenation(  "ADD_ZERO_OBJECT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeKernel" ], function( ) ValueGlobal( Concatenation(  "ADD_KERNEL_OBJECT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeKernelEmb" ], function( ) ValueGlobal( Concatenation(  "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeKernelLift" ], function( ) ValueGlobal( Concatenation(  "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeCokernel" ], function( ) ValueGlobal( Concatenation(  "ADD_COKERNEL_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeCokernelProj" ], function( ) ValueGlobal( Concatenation(  "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeCokernelColift" ], function( ) ValueGlobal( Concatenation(  "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeTerminalObject" ], function( ) ValueGlobal( Concatenation(  "ADD_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeUniversalMorphismIntoTerminalObject" ], function( ) ValueGlobal( Concatenation(  "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeInitialObject" ], function( ) ValueGlobal( Concatenation(  "ADD_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeUniversalMorphismFromInitialObject" ], function( ) ValueGlobal( Concatenation(  "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeDirectProduct" ], function( ) ValueGlobal( Concatenation(  "ADD_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeProjectionInFactorOfDirectProduct" ],
              function( ) ValueGlobal( Concatenation(  "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeUniversalMorphismIntoDirectProduct" ],
              function( ) ValueGlobal( Concatenation(  "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeCoproduct" ], function( ) ValueGlobal( Concatenation(  "ADD_COPRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeInjectionOfCofactorOfCoproduct" ],
              function( ) ValueGlobal( Concatenation(  "ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeUniversalMorphismFromCoproduct" ],
              function( ) ValueGlobal( Concatenation(  "ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeDirectSum" ], function( ) ValueGlobal( Concatenation(  "ADD_DIRECT_SUM_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputePullback" ], function( ) ValueGlobal( Concatenation(  "ADD_FIBER_PRODUCT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeProjectionInFactorOfPullback" ],
              function( ) ValueGlobal( Concatenation(  "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeUniversalMorphismIntoPullback" ],
              function( ) ValueGlobal( Concatenation(  "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputePushout" ], function( ) ValueGlobal( Concatenation(  "ADD_PUSHOUT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeInjectionOfCofactorOfPushout" ],
              function( ) ValueGlobal( Concatenation(  "ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeUniversalMorphismFromPushout" ],
              function( ) ValueGlobal( Concatenation(  "ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeInverse" ], function( ) ValueGlobal( Concatenation(  "ADD_INVERSE_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeMonoAsKernelLift" ], function( ) ValueGlobal( Concatenation(  "ADD_MONO_AS_KERNEL_LIFT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeEpiAsCokernelColift" ], function( ) ValueGlobal( Concatenation(  "ADD_EPI_AS_COKERNEL_COLIFT_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeAdditionForMorphisms" ], function( ) ValueGlobal( Concatenation(  "ADD_ADDITION_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeAdditiveInverseForMorphisms" ], function( ) ValueGlobal( Concatenation(  "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
            [ [ "CanComputeZeroMorphism" ], function( ) ValueGlobal( Concatenation(  "ADD_ZERO_MORPHISM_IN_", name_part, "_CATEGORY" ) )( category ); end ],
            
        ];
        
        for entry in todo_list_entries do
            
            new_entry := ToDoListEntry(
              Concatenation( List( entry[1], can_compute -> [ z_functor_category, can_compute ] ), [ [ category, NameFunction( category_getter ) ] ] ),
              entry[2]
            );
            
            AddToToDoList( new_entry );
            
        od;
        
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
InstallMethod( \[\],
               [ IsComplexCell, IsInt ],
               
  function( complex_cell, index )
      
      return UnderlyingZFunctorCell( complex_cell )[ -index ];
      
end );

##
InstallMethod( Differential,
               [ IsCocomplex, IsInt ],
               
  function( complex, index )
      
      return Differential( UnderlyingZFunctorCell( complex ), index );
      
end );

##
InstallMethod( Differential,
               [ IsComplex, IsInt ],
               
  function( complex, index )
      
      return Differential( UnderlyingZFunctorCell( complex ), -index );
      
end );

#################################################
##
## Constructors
##
#################################################

BindGlobal( "AS_COMPLEX_OR_COCOMPLEX",
               
  function( z_functor_object, type, category_getter )
    local category, object;
    
    category := UnderlyingHonestCategory( CapCategory( z_functor_object ) );
    
    object := rec( );
    
    ObjectifyWithAttributes( object, type,
                             UnderlyingZFunctorCell, z_functor_object );
    
    Add( category_getter( category ), object );
    
    return object;
    
end );

##
InstallMethod( AsCocomplex,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    
    return AS_COMPLEX_OR_COCOMPLEX( z_functor_object, TheTypeOfCocomplexes, CocomplexCategory );
    
end );

##
InstallMethod( AsComplex,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    
    return AS_COMPLEX_OR_COCOMPLEX( z_functor_object, TheTypeOfComplexes, ComplexCategory );
    
end );

BindGlobal( "AS_CHAIN_OR_COCHAIN_MAP",
            
  function( z_functor_morphism, type, object_constructor, category_getter )
    local category, source, range, morphism;
    
    category := UnderlyingHonestCategory( CapCategory( z_functor_morphism ) );
    
    source := object_constructor( Source( z_functor_morphism ) );
    
    range := object_constructor( Range( z_functor_morphism ) );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, type,
                             UnderlyingZFunctorCell, z_functor_morphism,
                             Source, source,
                             Range, range );
    
    Add( category_getter( category ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( AsCochainMap,
               [ IsZFunctorMorphism ],
               
  function( z_functor_morphism )
    
    return AS_CHAIN_OR_COCHAIN_MAP( z_functor_morphism, TheTypeOfCochainMaps, AsCocomplex, CocomplexCategory );
    
end );

##
InstallMethod( AsChainMap,
               [ IsZFunctorMorphism ],
               
  function( z_functor_morphism )
    
    return AS_CHAIN_OR_COCHAIN_MAP( z_functor_morphism, TheTypeOfChainMaps, AsComplex, ComplexCategory );
    
end );

BindGlobal( "CHAIN_OR_COCHAIN_MAP",
            
  function( source, z_functor_morphism, range, type, category_getter )
    local category, morphism;
    
    category := UnderlyingHonestCategory( CapCategory( z_functor_morphism ) );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, type,
                             UnderlyingZFunctorCell, z_functor_morphism,
                             Source, source,
                             Range, range );
    
    Add( category_getter( category ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( CochainMap,
               [ IsCocomplex, IsZFunctorMorphism, IsCocomplex ],
               
  function( source, z_functor_morphism, range )
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfCochainMaps, CocomplexCategory );
    
end );

##
InstallMethod( CochainMap,
               [ IsCocomplex, IsFunction, IsCocomplex ],
               
  function( source, func, range )
    local z_functor_morphism;
    
    z_functor_morphism := ZFunctorMorphism( UnderlyingZFunctorCell( source ), func, UnderlyingZFunctorCell( range ) );
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfCochainMaps, CocomplexCategory );
    
end );

##
InstallMethod( ChainMap,
               [ IsComplex, IsZFunctorMorphism, IsComplex ],
               
  function( source, z_functor_morphism, range )
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfChainMaps, ComplexCategory );
    
end );

##
InstallMethod( ChainMap,
               [ IsComplex, IsFunction, IsComplex ],
               
  function( source, func, range )
    local twisted_morphism_func, z_functor_morphism;
    
    ## this is due to the convention in ZFunctors: i -> j iff i <= j,
    ## thus the function can be given with correct indices by the user
    twisted_morphism_func := function( i )
      
      return func(-i);
      
    end;
    
    z_functor_morphism := ZFunctorMorphism( UnderlyingZFunctorCell( source ), twisted_morphism_func, UnderlyingZFunctorCell( range ) );
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfChainMaps, ComplexCategory );
    
end );

##
InstallMethod( AsPointedCocomplexOp,
               [ IsCapCategoryObject, IsInt ],
               
  function( object, index )
      
      return AsCocomplex( AsZFunctorObject( object, index ) );
      
end );

##
InstallMethod( AsPointedComplexOp,
               [ IsCapCategoryObject, IsInt ],
               
  function( object, index )
      
      return AsComplex( AsZFunctorObject( object, index ) );
      
end );

##
InstallMethod( AsPointedCochainMapOp,
               [ IsCapCategoryMorphism, IsInt ],
               
  function( morphism, index )
      
      return AsCochainMap( AsZFunctorMorphism( morphism, index ) );
      
end );

##
InstallMethod( AsPointedChainMapOp,
               [ IsCapCategoryMorphism, IsInt ],
               
  function( morphism, index )
      
      return AsChainMap( AsZFunctorMorphism( morphism, index ) );
      
end );

#################################################
##
## Functors
##
#################################################

##
InstallMethodWithCache( ComplexToCocomplexFunctor,
                        [ IsCapCategory ],
                                  
  function( category )
    local complex_category, cocomplex_category, functor;
    
    complex_category := ComplexCategory( category );
    
    cocomplex_category := CocomplexCategory( category );
    
    functor := CapFunctor( Concatenation( "Complex to cocomplex functor of ", Name( category ) ), 
                           complex_category,
                           cocomplex_category );
    
    AddObjectFunction( functor,
      
      function( complex )
        local object_func, differential_func, z_functor_object;
        
        object_func := function( i )
          
          return complex[-i];
          
        end;
        
        differential_func := function( i )
          
          return Differential( complex, -i );
          
        end;
        
        z_functor_object := ZFunctorObject( object_func, differential_func, category );
        
        return AsCocomplex( z_functor_object );
        
    end );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local func;
        
        func := function( i )
          
          return morphism[-i];
          
        end;
        
        return ChainMap( new_source, func, new_range );
        
    end );
    
    return functor;
    
end );

##
InstallMethodWithCache( CocomplexToComplexFunctor,
                        [ IsCapCategory ],
                                  
  function( category )
    local cocomplex_category, complex_category, functor;
    
    cocomplex_category := CocomplexCategory( category );
    
    complex_category := ComplexCategory( category );
    
    functor := CapFunctor( Concatenation( "Cocomplex to complex functor of ", Name( category ) ), 
                           cocomplex_category,
                           complex_category );
    
    AddObjectFunction( functor,
      
      function( cocomplex )
        local object_func, differential_func, z_functor_object;
        
        object_func := function( i )
          
          return cocomplex[i];
          
        end;
        
        differential_func := function( i )
          
          return Differential( cocomplex, i );
          
        end;
        
        z_functor_object := ZFunctorObject( object_func, differential_func, category );
        
        #note that the interpretation of this z_functor_object as a complex will automatically
        #change the signs
        return AsComplex( z_functor_object );
        
    end );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local func;
        
        func := function( i )
          
          return morphism[-i];
          
        end;
        
        #here the signs have to be changed manually for this constructor
        #expects a function whose indices are compatible with new_source and new_range
        return ChainMap( new_source, func, new_range );
        
    end );
    
    return functor;
    
end );
