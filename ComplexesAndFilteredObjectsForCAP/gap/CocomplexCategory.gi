# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesAndFilteredObjectsForCAP: Implementation of complexes, cocomplexes and filtered objects for CAP
#
# Implementations
#

DeclareRepresentation( "IsCapCocomplexRep",
                       IsCapCategoryObjectRep and IsCapCocomplex,
                       [ ] );

DeclareRepresentation( "IsCapCochainMapRep",
                       IsCapCategoryMorphismRep and IsCapCochainMap,
                       [ ] );

BindGlobal( "TheTypeOfCocomplexes",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapCocomplexRep ) );

BindGlobal( "TheTypeOfCochainMaps",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapCochainMapRep ) );

DeclareRepresentation( "IsCapComplexRep",
                       IsCapCategoryObjectRep and IsCapComplex,
                       [ ] );

DeclareRepresentation( "IsCapChainMapRep",
                       IsCapCategoryMorphismRep and IsCapChainMap,
                       [ ] );

BindGlobal( "TheTypeOfComplexes",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapComplexRep ) );

BindGlobal( "TheTypeOfChainMaps",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapChainMapRep ) );


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
    
    SetUnderlyingCategory( cocomplex_category, category );
    
    SetCocomplexCategory( category, cocomplex_category );
    
    INSTALL_OPERATIONS_FOR_COCOMPLEX_CATEGORY( category );
    
    Finalize( cocomplex_category );
    
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
    
    SetUnderlyingCategory( complex_category, category );
    
    SetComplexCategory( category, complex_category );
    
    INSTALL_OPERATIONS_FOR_COMPLEX_CATEGORY( category );
    
    Finalize( complex_category );
    
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

    ## InverseForMorphisms
    ##
    BindGlobal( Concatenation( "ADD_INVERSE_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddInverseForMorphisms( category_getter( category ),
            
            function( isomorphism )
              local source, range;
              
              source := Range( isomorphism );
              
              range := Source( isomorphism );
              
              return morphism_constructor( source, Inverse( UnderlyingZFunctorCell( isomorphism ) ), range );
              
        end );
        
    end );

    ## LiftAlongMonomorphism
    ##
    BindGlobal( Concatenation( "ADD_MONO_AS_KERNEL_LIFT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddLiftAlongMonomorphism( category_getter( category ),
            
            function( monomorphism, test_morphism )
              local source, range;
              
              source := Source( test_morphism );
              
              range := Source( monomorphism );
              
              return morphism_constructor( source, LiftAlongMonomorphism( UnderlyingZFunctorCell( monomorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
              
        end );
        
    end );

    ## ColiftAlongEpimorphism
    ##
    BindGlobal( Concatenation( "ADD_EPI_AS_COKERNEL_COLIFT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddColiftAlongEpimorphism( category_getter( category ),
                             
          function( epimorphism, test_morphism )
            local source, range;
            
            source := Range( epimorphism );
            
            range := Range( test_morphism );
            
            return morphism_constructor( source, ColiftAlongEpimorphism( UnderlyingZFunctorCell( epimorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
            
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

    ## KernelEmbeddingWithGivenKernelObject
    BindGlobal( Concatenation( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddKernelEmbeddingWithGivenKernelObject( category_getter( category ),
            
            function( morphism, kernel )
              local range;
              
              range := Source( morphism );
              
              return morphism_constructor( kernel, KernelEmbeddingWithGivenKernelObject( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), range );
              
          end );
          
    end );

    ## KernelLiftWithGivenKernelObject
    BindGlobal( Concatenation( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddKernelLiftWithGivenKernelObject( category_getter( category ),
            
            function( morphism, test_object, test_morphism, kernel )
              local source;
              
              source := Source( test_morphism );
              
              return morphism_constructor( source, KernelLiftWithGivenKernelObject( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), kernel );

          end );
          
    end );

    ## Cokernel
    ##
    BindGlobal( Concatenation( "ADD_COKERNEL_IN_", name_part, "_CATEGORY" ),
              
      function( category )

          AddCokernelObject( category_getter( category ),
            
            function( morphism )
              
              return object_constructor( CokernelObject( UnderlyingZFunctorCell( morphism ) ) );
              
          end );
        
    end );

    ## CokernelProjectionWithGivenCokernel
    BindGlobal( Concatenation( "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddCokernelProjectionWithGivenCokernelObject( category_getter( category ),
            
            function( morphism, cokernel )
              local source;
              
              source := Range( morphism );
              
              return morphism_constructor( source, CokernelProjectionWithGivenCokernelObject( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( cokernel ) ), cokernel );
              
          end );
          
    end );

    ## CokernelColiftWithGivenCokernel
    BindGlobal( Concatenation( "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddCokernelColiftWithGivenCokernelObject( category_getter( category ),
            
            function( morphism, test_object, test_morphism, cokernel )
              local range;
              
              range := Range( test_morphism );
              
              return morphism_constructor( cokernel, CokernelColiftWithGivenCokernelObject( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
              
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
            
            return morphism_constructor( object,
                     UniversalMorphismIntoTerminalObjectWithGivenTerminalObject(
                       UnderlyingZFunctorCell( object ), UnderlyingZFunctorCell( terminal_object ) ), terminal_object );
            
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
            
            return morphism_constructor( initial_object,
                     UniversalMorphismFromInitialObjectWithGivenInitialObject(
                       UnderlyingZFunctorCell( object ), UnderlyingZFunctorCell( initial_object ) ), object );
        
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
                                 ProjectionInFactorOfDirectProductWithGivenDirectProduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ), projection_number, UnderlyingZFunctorCell( direct_product ) ),
                                 range );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( category_getter( category ),
            
            function( diagram, test_object, source, direct_product )
              
              return morphism_constructor( Source( source[1] ),
                       UniversalMorphismIntoDirectProductWithGivenDirectProduct(
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
                                 InjectionOfCofactorOfCoproductWithGivenCoproduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ), injection_number, UnderlyingZFunctorCell( coproduct ) ),
                                 coproduct );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddUniversalMorphismFromCoproductWithGivenCoproduct( category_getter( category ),
            
            function( diagram, test_object, sink, coproduct )
              
              return morphism_constructor( coproduct,
                       UniversalMorphismFromCoproductWithGivenCoproduct(
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

    ## FiberProduct
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
          
          AddProjectionInFactorOfFiberProductWithGivenFiberProduct( category_getter( category ),
            
            function( morphism_list, projection_number, pullback )
              local range;
              
              range := Source( morphism_list[ projection_number ] );
              
              return morphism_constructor( pullback,
                       ProjectionInFactorOfFiberProductWithGivenFiberProduct(
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
          
          AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( category_getter( category ),
            
            function( diagram, test_object, source, pullback )
              
              return morphism_constructor( Source( source[1] ),
                       UniversalMorphismIntoFiberProductWithGivenFiberProduct(
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
                       InjectionOfCofactorOfPushoutWithGivenPushout(
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
            
            function( diagram, test_object, sink, pushout )

              return morphism_constructor( pushout,
                       UniversalMorphismFromPushoutWithGivenPushout(
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
    
    InstallGlobalFunction( ValueGlobal( Concatenation( "INSTALL_OPERATIONS_FOR_", name_part, "_CATEGORY" ) ),
                
      function( category )
       local z_functor_category, install_entries, entry, weight_list;
        
        z_functor_category := ZFunctorCategory( category );
        
        install_entries := [
        
            [ [ "PreCompose" ], ValueGlobal( Concatenation( "ADD_PRECOMPOSE_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "IdentityMorphism" ], ValueGlobal( Concatenation( "ADD_IDENTITY_MORPHISM_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ZeroObject" ], ValueGlobal( Concatenation( "ADD_ZERO_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "KernelObject" ], ValueGlobal( Concatenation( "ADD_KERNEL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "KernelEmbedding" ], ValueGlobal( Concatenation( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "KernelLift" ], ValueGlobal( Concatenation( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "CokernelObject" ], ValueGlobal( Concatenation( "ADD_COKERNEL_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "CokernelProjection" ], ValueGlobal( Concatenation( "ADD_COKERNEL_PROJ_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "CokernelColift" ], ValueGlobal( Concatenation( "ADD_COKERNEL_COLIFT_WITH_GIVEN_COKERNEL_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "TerminalObject" ], ValueGlobal( Concatenation( "ADD_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismIntoTerminalObject" ], ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "InitialObject" ], ValueGlobal( Concatenation( "ADD_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismFromInitialObject" ], ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "DirectProduct" ], ValueGlobal( Concatenation( "ADD_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ProjectionInFactorOfDirectProduct" ],
              ValueGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismIntoDirectProduct" ],
              ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "Coproduct" ], ValueGlobal( Concatenation( "ADD_COPRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "InjectionOfCofactorOfCoproduct" ],
              ValueGlobal( Concatenation( "ADD_INJECTION_OF_COFACTOR_OF_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismFromCoproduct" ],
              ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_COPRODUCT_WITH_GIVEN_COPRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "DirectSum" ], ValueGlobal( Concatenation( "ADD_DIRECT_SUM_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "FiberProduct" ], ValueGlobal( Concatenation( "ADD_FIBER_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ProjectionInFactorOfFiberProduct" ],
              ValueGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismIntoFiberProduct" ],
              ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "Pushout" ], ValueGlobal( Concatenation( "ADD_PUSHOUT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "InjectionOfCofactorOfPushout" ],
              ValueGlobal( Concatenation( "ADD_INJECTION_OF_COFACTOR_OF_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismFromPushout" ],
              ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_PUSHOUT_WITH_GIVEN_PUSHOUT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "InverseForMorphisms" ], ValueGlobal( Concatenation( "ADD_INVERSE_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "LiftAlongMonomorphism" ], ValueGlobal( Concatenation( "ADD_MONO_AS_KERNEL_LIFT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ColiftAlongEpimorphism" ], ValueGlobal( Concatenation( "ADD_EPI_AS_COKERNEL_COLIFT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "AdditionForMorphisms" ], ValueGlobal( Concatenation( "ADD_ADDITION_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "AdditiveInverseForMorphisms" ], ValueGlobal( Concatenation( "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ZeroMorphism" ], ValueGlobal( Concatenation( "ADD_ZERO_MORPHISM_IN_", name_part, "_CATEGORY" ) ) ],
            
        ];
        
        weight_list := z_functor_category!.derivations_weight_list;
        
        for entry in install_entries do
            
            if ForAll( entry[ 1 ], i -> CurrentOperationWeight( weight_list, i ) < infinity ) then
                
                entry[ 2 ]( category );
                
            fi;
            
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
               [ IsCapCocomplexCell, IsInt ],
               
  function( cocomplex_cell, index )
      
      return UnderlyingZFunctorCell( cocomplex_cell )[ index ];
      
end );

##
InstallMethod( \[\],
               [ IsCapComplexCell, IsInt ],
               
  function( complex_cell, index )
      
      return UnderlyingZFunctorCell( complex_cell )[ -index ];
      
end );

##
InstallMethod( Differential,
               [ IsCapCocomplex, IsInt ],
               
  function( complex, index )
      
      return Differential( UnderlyingZFunctorCell( complex ), index );
      
end );

##
InstallMethod( Differential,
               [ IsCapComplex, IsInt ],
               
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
    
    category := UnderlyingCategory( CapCategory( z_functor_object ) );
    
    object := ObjectifyWithAttributes( rec( ), type,
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
InstallMethod( CocomplexFromMorphismList,
               [ IsList, IsInt ],
               
  function( morphism_list, start_position )
    
    return AsCocomplex( ZFunctorObjectFromMorphismList( morphism_list, start_position ) );
    
end );

##
InstallMethod( CocomplexFromMorphismList,
               [ IsList ],
               
  function( morphism_list )
    
    return CocomplexFromMorphismList( morphism_list, 0 );
    
end );

##
InstallMethod( AsComplex,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    
    return AS_COMPLEX_OR_COCOMPLEX( z_functor_object, TheTypeOfComplexes, ComplexCategory );
    
end );

##
InstallMethod( ComplexFromMorphismList,
               [ IsList, IsInt ],
               
  function( morphism_list, start_position )
    
    return AsComplex( ZFunctorObjectFromMorphismList( Reversed( morphism_list ), -start_position ) );
    
end );


## given a morphism list [ P_0 <-- P_1, ..., P_n-2 <-- P_n-1 ],
## this method returns the complex P_0 <-- P_1 <-- ... <-- P_n-1
InstallMethod( ComplexFromMorphismList,
               [ IsList ],
               
  function( morphism_list )
    
    return ComplexFromMorphismList( morphism_list, Length( morphism_list ) );
    
end );

BindGlobal( "AS_CHAIN_OR_COCHAIN_MAP",
            
  function( z_functor_morphism, type, object_constructor, category_getter )
    local category, source, range, morphism;
    
    category := UnderlyingCategory( CapCategory( z_functor_morphism ) );
    
    source := object_constructor( Source( z_functor_morphism ) );
    
    range := object_constructor( Range( z_functor_morphism ) );
    
    morphism := ObjectifyWithAttributes( rec( ), type,
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
    
    category := UnderlyingCategory( CapCategory( z_functor_morphism ) );
    
    morphism := ObjectifyWithAttributes( rec( ), type,
                                         UnderlyingZFunctorCell, z_functor_morphism,
                                         Source, source,
                                         Range, range );
    
    Add( category_getter( category ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( CochainMap,
               [ IsCapCocomplex, IsZFunctorMorphism, IsCapCocomplex ],
               
  function( source, z_functor_morphism, range )
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfCochainMaps, CocomplexCategory );
    
end );

##
InstallMethod( CochainMap,
               [ IsCapCocomplex, IsFunction, IsCapCocomplex ],
               
  function( source, func, range )
    local z_functor_morphism;
    
    z_functor_morphism := ZFunctorMorphism( UnderlyingZFunctorCell( source ), func, UnderlyingZFunctorCell( range ) );
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfCochainMaps, CocomplexCategory );
    
end );

##
InstallMethod( CochainMap,
               [ IsCapCocomplex, IsList, IsInt, IsCapCocomplex ],
               
  function( source, morphism_list, start_position, range )
    local z_functor_morphism;
    
    z_functor_morphism := ZFunctorMorphism(
                            UnderlyingZFunctorCell( source ),
                            morphism_list,
                            start_position,
                            UnderlyingZFunctorCell( range )
                          );
    
    return CochainMap( source, z_functor_morphism, range );
    
end );

##
InstallMethod( CochainMap,
               [ IsCapCocomplex, IsList, IsCapCocomplex ],
               
  function( source, morphism_list, range )
    
    return CochainMap( source, morphism_list, 0, range );
    
end );

##
InstallMethod( ChainMap,
               [ IsCapComplex, IsZFunctorMorphism, IsCapComplex ],
               
  function( source, z_functor_morphism, range )
    
    return CHAIN_OR_COCHAIN_MAP( source, z_functor_morphism, range, TheTypeOfChainMaps, ComplexCategory );
    
end );

##
InstallMethod( ChainMap,
               [ IsCapComplex, IsFunction, IsCapComplex ],
               
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
InstallMethod( ChainMap,
               [ IsCapComplex, IsList, IsInt, IsCapComplex ],
               
  function( source, morphism_list, start_position, range )
    local z_functor_morphism;
    
    z_functor_morphism := ZFunctorMorphism(
                            UnderlyingZFunctorCell( source ),
                            morphism_list,
                            -start_position,
                            UnderlyingZFunctorCell( range )
                          );
    
    return ChainMap( source, z_functor_morphism, range );
    
end );

##
InstallMethod( ChainMap,
               [ IsCapComplex, IsList, IsCapComplex ],
               
  function( source, morphism_list, range )
    
    return ChainMap( source, morphism_list, Length( morphism_list ) - 1, range );
    
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

##
InstallMethod( HomologyFunctorOp,
               [ IsCapCategory, IsInt ],
               
  function( category, index )
      local complex_category, functor;
      
      complex_category := ComplexCategory( category );
      
      functor := CapFunctor( Concatenation( String( index ), "-th homology functor of ", Name( category ) ),
                             complex_category,
                             category );
      
      AddObjectFunction( functor,
        
        function( complex )
          local pre_differential, post_differential, image_embedding, kernel_lift;
          
          pre_differential := Differential( complex, index + 1 );
          
          post_differential := Differential( complex, index );
          
          image_embedding := ImageEmbedding( pre_differential );
          
          kernel_lift := KernelLift( post_differential, image_embedding );
          
          return CokernelObject( kernel_lift );
          
      end );
      
      AddMorphismFunction( functor,
          
          function( new_source, chain_map, new_range )
            local source_complex, range_complex, alpha, alpha_p, mu,
                  mor_between_kernel, image_embedding_source, image_embedding_range,
                  kernel_lift_source, kernel_lift_range, cokernel_proj_range;
            
            source_complex := Source( chain_map );
            
            range_complex := Range( chain_map );
            
            alpha := Differential( source_complex, index );
            
            alpha_p := Differential( range_complex, index );
            
            mu := chain_map[ index ];
            
            mor_between_kernel := KernelObjectFunctorial( alpha, mu, alpha_p );
            
            image_embedding_source := ImageEmbedding( Differential( source_complex, index + 1 ) );
            
            image_embedding_range := ImageEmbedding( Differential( range_complex, index + 1 ) );
            
            kernel_lift_source := KernelLift( alpha, image_embedding_source );
            
            kernel_lift_range := KernelLift( alpha_p, image_embedding_range );
            
            cokernel_proj_range := CokernelProjection( kernel_lift_range );
            
            return CokernelColift( kernel_lift_source,
                                   PreCompose( mor_between_kernel, cokernel_proj_range )
                                 );
            
      end );
      
      return functor;
      
end );

##
InstallMethod( CohomologyFunctorOp,
               [ IsCapCategory, IsInt ],
               
  function( category, index )
      local cocomplex_category, functor;
      
      cocomplex_category := CocomplexCategory( category );
      
      functor := CapFunctor( Concatenation( String( index ), "-th cohomology functor of ", Name( category ) ),
                             cocomplex_category,
                             category );
      
      AddObjectFunction( functor,
        
        function( cocomplex )
          local pre_differential, post_differential, image_embedding, kernel_lift;
          
          pre_differential := Differential( cocomplex, index - 1 );
          
          post_differential := Differential( cocomplex, index );
          
          image_embedding := ImageEmbedding( pre_differential );
          
          kernel_lift := KernelLift( post_differential, image_embedding );
          
          return CokernelObject( kernel_lift );
          
      end );
      
      AddMorphismFunction( functor,
          
          function( new_source, chain_map, new_range )
            local source_cocomplex, range_cocomplex, alpha, alpha_p, mu,
                  mor_between_kernel, image_embedding_source, image_embedding_range,
                  kernel_lift_source, kernel_lift_range, cokernel_proj_range;
            
            source_cocomplex := Source( chain_map );
            
            range_cocomplex := Range( chain_map );
            
            alpha := Differential( source_cocomplex, index );
            
            alpha_p := Differential( range_cocomplex, index );
            
            mu := chain_map[ index ];
            
            mor_between_kernel := KernelObjectFunctorial( alpha, mu, alpha_p );
            
            image_embedding_source := ImageEmbedding( Differential( source_cocomplex, index - 1 ) );
            
            image_embedding_range := ImageEmbedding( Differential( range_cocomplex, index - 1 ) );
            
            kernel_lift_source := KernelLift( alpha, image_embedding_source );
            
            kernel_lift_range := KernelLift( alpha_p, image_embedding_range );
            
            cokernel_proj_range := CokernelProjection( kernel_lift_range );
            
            return CokernelColift( kernel_lift_source,
                                   PreCompose( mor_between_kernel, cokernel_proj_range )
                                 );
            
      end );
      
      return functor;
      
end );
