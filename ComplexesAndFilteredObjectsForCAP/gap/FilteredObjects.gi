# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesAndFilteredObjectsForCAP: Implementation of complexes, cocomplexes and filtered objects for CAP
#
# Implementations
#

DeclareRepresentation( "IsAscendingFilteredObjectRep",
                       IsCapCategoryObjectRep and IsAscendingFilteredObject,
                       [ ] );

DeclareRepresentation( "IsAscendingFilteredMorphismRep",
                       IsCapCategoryMorphismRep and IsAscendingFilteredMorphism,
                       [ ] );

BindGlobal( "TheTypeOfAscendingFilteredObjectes",
        NewType( TheFamilyOfCapCategoryObjects,
                IsAscendingFilteredObjectRep ) );

BindGlobal( "TheTypeOfAscendingFilteredMorphisms",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsAscendingFilteredMorphismRep ) );

DeclareRepresentation( "IsDescendingFilteredObjectRep",
                       IsCapCategoryObjectRep and IsDescendingFilteredObject,
                       [ ] );

DeclareRepresentation( "IsDescendingFilteredMorphismRep",
                       IsCapCategoryMorphismRep and IsDescendingFilteredMorphism,
                       [ ] );

BindGlobal( "TheTypeOfDescendingFilteredObjectes",
        NewType( TheFamilyOfCapCategoryObjects,
                IsDescendingFilteredObjectRep ) );

BindGlobal( "TheTypeOfDescendingFilteredMorphisms",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsDescendingFilteredMorphismRep ) );


#############################
##
## Attributes
##
#############################

##
InstallMethod( CategoryOfAscendingFilteredObjects,
               [ IsCapCategory ],
               
  function( category )
    local name, filtered_objects_category;
    
    name := Name( category );
    
    name := Concatenation( "Ascending filtered object category of ", name );
    
    filtered_objects_category := CreateCapCategory( name : is_computable := false );
    
    SetUnderlyingCategory( filtered_objects_category, category );
    
    SetCategoryOfAscendingFilteredObjects( category, filtered_objects_category );
    
    INSTALL_OPERATIONS_FOR_ASCENDING_FILTERED_OBJECTS_CATEGORY( category );
    
    Finalize( filtered_objects_category );
    
    return filtered_objects_category;
    
end );

##
InstallMethod( CategoryOfDescendingFilteredObjects,
               [ IsCapCategory ],
               
  function( category )
    local name, filtered_objects_category;
    
    name := Name( category );
    
    name := Concatenation( "Descending filtered object category of ", name );
    
    filtered_objects_category := CreateCapCategory( name : is_computable := false );
    
    SetUnderlyingCategory( filtered_objects_category, category );
    
    SetCategoryOfDescendingFilteredObjects( category, filtered_objects_category );
    
    INSTALL_OPERATIONS_FOR_DESCENDING_FILTERED_OBJECTS_CATEGORY( category );
    
    Finalize( filtered_objects_category );
    
    return filtered_objects_category;
    
end );

#############################
##
## Add methods
##
#############################


BindGlobal( "INSTALL_ALL_ADDS_FILTERED",
            
  function( name_part, object_constructor, morphism_constructor, category_getter )
    
    ## PreCompose
    ##
    BindGlobal( Concatenation( "ADD_PRECOMPOSE_IN_", name_part, "_CATEGORY" ),
      
      function( category )
        
        AddPreCompose( category_getter( category ),
              
          function( cat, mor_left, mor_right )
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
              
              function( cat, object )
                
                return morphism_constructor( object, IdentityMorphism( UnderlyingZFunctorCell( object ) ), object );
                
          end );
          
    end );

    ## InverseForMorphisms
    ##
    BindGlobal( Concatenation( "ADD_INVERSE_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddInverseForMorphisms( category_getter( category ),
            
            function( cat, isomorphism )
              local source, range;
              
              source := Range( isomorphism );
              
              range := Source( isomorphism );
              
              return morphism_constructor( source, InverseForMorphisms( UnderlyingZFunctorCell( isomorphism ) ), range );
              
        end );
        
    end );

    ## LiftAlongMonomorphism
    ##
    BindGlobal( Concatenation( "ADD_MONO_AS_KERNEL_LIFT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddLiftAlongMonomorphism( category_getter( category ),
            
            function( cat, monomorphism, test_morphism )
              local source, range;
              
              source := Source( test_morphism );
              
              range := Source( monomorphism );
              
              return morphism_constructor( source, LiftAlongMonomorphism( UnderlyingZFunctorCell( monomorphism ), UnderlyingZFunctorCell( test_morphism ) ), range );
              
        end );
        
    end );
    
    ## KernelObject
    ##
    BindGlobal( Concatenation( "ADD_KERNEL_OBJECT_IN_", name_part, "_CATEGORY" ),
              
      function( category )

          AddKernelObject( category_getter( category ),
            
            function( cat, morphism )
              
              return object_constructor( KernelObject( UnderlyingZFunctorCell( morphism ) ) );
              
          end );
          
    end );

    ## KernelEmbeddingWithGivenKernelObject
    BindGlobal( Concatenation( "ADD_KERNEL_EMB_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddKernelEmbeddingWithGivenKernelObject( category_getter( category ),
            
            function( cat, morphism, kernel )
              local range;
              
              range := Source( morphism );
              
              return morphism_constructor( kernel, KernelEmbedding( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), range );
              
          end );
          
    end );

    ## KernelLiftWithGivenKernelObject
    BindGlobal( Concatenation( "ADD_KERNEL_LIFT_WITH_GIVEN_KERNEL_IN_", name_part, "_CATEGORY" ),
      
      function( category )

          AddKernelLiftWithGivenKernelObject( category_getter( category ),
            
            function( cat, morphism, test_object, test_morphism, kernel )
              local source;
              
              source := Source( test_morphism );
              
              return morphism_constructor( source, KernelLift( UnderlyingZFunctorCell( morphism ), UnderlyingZFunctorCell( kernel ) ), kernel );

          end );
          
    end );
    
    ## Zero object
    ##
    BindGlobal( Concatenation( "ADD_ZERO_OBJECT_IN_", name_part, "_CATEGORY" ),
                
      function( category )
        
        AddZeroObject( category_getter( category ),
          
          function( cat )
            
            return object_constructor( ZeroObject( ZFunctorCategory( category ) ) );
            
        end );
        
    end );

    ## Terminal object
    ##
    BindGlobal( Concatenation( "ADD_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ),
                
      function( category )
        
        AddTerminalObject( category_getter( category ),
          
          function( cat )
            
            return object_constructor( TerminalObject( ZFunctorCategory( category ) ) );
            
        end );
        
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category_getter( category ),
          
          function( cat, object, terminal_object )
            
            return morphism_constructor( object, UniversalMorphismIntoTerminalObject( UnderlyingZFunctorCell( object ) ), terminal_object );
            
        end );
        
    end );

    ## Initial object
    ##
    BindGlobal( Concatenation( "ADD_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ),
                
      function( category )
        
        AddInitialObject( category_getter( category ),
          
          function( cat )
            
            return object_constructor( InitialObject( ZFunctorCategory( category ) ) );
            
        end );
        
    end );

    ##
    BindGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ),
              
      function( category )
        
        AddUniversalMorphismFromInitialObjectWithGivenInitialObject( category_getter( category ),
          
          function( cat, object, initial_object )
            
            return morphism_constructor( initial_object, UniversalMorphismFromInitialObject( UnderlyingZFunctorCell( object ) ), object );
        
        end );
        
    end );

    ## Direct product
    ##
    BindGlobal( Concatenation( "ADD_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddDirectProduct( category_getter( category ),
            
            function( cat, object_list )
              
              return object_constructor( DirectProduct( List( object_list, obj -> UnderlyingZFunctorCell( obj ) ) ) );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddProjectionInFactorOfDirectProductWithGivenDirectProduct( category_getter( category ),
            
            function( cat, object_list, projection_number, direct_product )
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
            
            function( cat, diagram, test_object, source, direct_product )
              
              return morphism_constructor( Source( source[1] ),
                       UniversalMorphismIntoDirectProduct(
                         List( diagram, obj -> UnderlyingZFunctorCell( obj ) ),
                         List( source, mor -> UnderlyingZFunctorCell( mor ) ),
                         UnderlyingZFunctorCell( direct_product )
                       ),
                       direct_product );
                       
          end );
          
    end );
    
    ## FiberProduct
    ##
    BindGlobal( Concatenation( "ADD_FIBER_PRODUCT_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddFiberProduct( category_getter( category ),
            
            function( cat, morphism_list )
              
              return object_constructor( FiberProduct( List( morphism_list, mor -> UnderlyingZFunctorCell( mor ) ) ) );
              
          end );
          
    end );

    ##
    BindGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ),
              
        function( category )
          
          AddProjectionInFactorOfFiberProductWithGivenFiberProduct( category_getter( category ),
            
            function( cat, morphism_list, projection_number, pullback )
              local range;
              
              range := Source( morphism_list[ projection_number ] );
              
              return morphism_constructor( pullback,
                       ProjectionInFactorOfFiberProduct(
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
            
            function( cat, diagram, test_object, source, pullback )
              
              return morphism_constructor( Source( source[1] ),
                       UniversalMorphismIntoFiberProduct(
                         List( diagram, obj -> UnderlyingZFunctorCell( obj ) ),
                         List( source, mor -> UnderlyingZFunctorCell( mor ) ),
                         UnderlyingZFunctorCell( pullback )
                       ),
                       pullback );
                       
          end );
          
    end );
    
    ## Addition for morphisms
    ##
    BindGlobal( Concatenation( "ADD_ADDITION_FOR_MORPHISMS_IN_", name_part, "_CATEGORY" ),
             
        function( category )
          
          AddAdditionForMorphisms( category_getter( category ),
          
            function( cat, morphism1, morphism2 )
              
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
                                        
            function( cat, morphism )
              
              return morphism_constructor( Source( morphism ), -UnderlyingZFunctorCell( morphism ), Range( morphism ) );
              
          end );
          
    end );

    ## Zero morphism
    ##
    BindGlobal( Concatenation( "ADD_ZERO_MORPHISM_IN_", name_part, "_CATEGORY" ),
            
        function( category )
          local differential_func, zero_morphism;

          AddZeroMorphism( category_getter( category ),
                         
            function( cat, source, range )
              
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
            
            [ [ "TerminalObject" ], ValueGlobal( Concatenation( "ADD_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismIntoTerminalObject" ], ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_WITH_GIVEN_TERMINAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "InitialObject" ], ValueGlobal( Concatenation( "ADD_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismFromInitialObject" ], ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_WITH_GIVEN_INITIAL_OBJECT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "DirectProduct" ], ValueGlobal( Concatenation( "ADD_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ProjectionInFactorOfDirectProduct" ],
              ValueGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismIntoDirectProduct" ],
              ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT_WITH_GIVEN_DIRECT_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "FiberProduct" ], ValueGlobal( Concatenation( "ADD_FIBER_PRODUCT_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "ProjectionInFactorOfFiberProduct" ],
              ValueGlobal( Concatenation( "ADD_PROJECTION_IN_FACTOR_OF_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "UniversalMorphismIntoFiberProduct" ],
              ValueGlobal( Concatenation( "ADD_UNIVERSAL_MORPHISM_INTO_PULLBACK_WITH_GIVEN_PULLBACK_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "InverseForMorphisms" ], ValueGlobal( Concatenation( "ADD_INVERSE_IN_", name_part, "_CATEGORY" ) ) ],
            
            [ [ "LiftAlongMonomorphism" ], ValueGlobal( Concatenation( "ADD_MONO_AS_KERNEL_LIFT_IN_", name_part, "_CATEGORY" ) ) ],
            
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

BindGlobal( "INSTALL_ALL_ADDS_FILTERED_NOW",
            
  function( )
    local install_list, i;
    
    install_list := [ [ "DESCENDING_FILTERED_OBJECTS", AsDescendingFilteredObject, DescendingFilteredMorphism, CategoryOfDescendingFilteredObjects ],
                      [ "ASCENDING_FILTERED_OBJECTS", AsAscendingFilteredObject, AscendingFilteredMorphism, CategoryOfAscendingFilteredObjects ] ];
                      
    for i in install_list do
        
        CallFuncList( INSTALL_ALL_ADDS_FILTERED, i );
        
    od;
    
end );

INSTALL_ALL_ADDS_FILTERED_NOW( );


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
               [ IsAscendingFilteredObjectCategoryCell, IsInt ],
               
  function( ascending_filtered_cell, index )
      
      return UnderlyingZFunctorCell( ascending_filtered_cell )[ index ];
      
end );

##
InstallMethod( \[\],
               [ IsDescendingFilteredObjectCategoryCell, IsInt ],
               
  function( descending_filtered_cell, index )
      
      return UnderlyingZFunctorCell( descending_filtered_cell )[ -index ];
      
end );

##
InstallMethod( Embedding,
               [ IsAscendingFilteredObject, IsInt ],
               
  function( ascending_filtered_object, index )
      
      return Differential( UnderlyingZFunctorCell( ascending_filtered_object ), index );
      
end );

##
InstallMethod( Embedding,
               [ IsDescendingFilteredObject, IsInt ],
               
  function( descending_filtered_object, index )
      
      return Differential( UnderlyingZFunctorCell( descending_filtered_object ), -index );
      
end );

#################################################
##
## Constructors
##
#################################################

BindGlobal( "AS_ASCENDING_OR_DESCENDING_FILTERED_OBJECT",
               
  function( z_functor_object, type, category_getter )
    local category, object;
    
    category := UnderlyingCategory( CapCategory( z_functor_object ) );
    
    object := ObjectifyWithAttributes( rec( ), type,
                                       UnderlyingZFunctorCell, z_functor_object );
    
    Add( category_getter( category ), object );
    
    return object;
    
end );

##
InstallMethod( AsAscendingFilteredObject,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    
    return AS_ASCENDING_OR_DESCENDING_FILTERED_OBJECT( z_functor_object, TheTypeOfAscendingFilteredObjectes, CategoryOfAscendingFilteredObjects );
    
end );

##
InstallMethod( AsDescendingFilteredObject,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    
    return AS_ASCENDING_OR_DESCENDING_FILTERED_OBJECT( z_functor_object, TheTypeOfDescendingFilteredObjectes, CategoryOfDescendingFilteredObjects );
    
end );

BindGlobal( "AS_FILTERED_MORPHISM",
            
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
InstallMethod( AsAscendingFilteredMorphism,
               [ IsZFunctorMorphism ],
               
  function( z_functor_morphism )
    
    return AS_FILTERED_MORPHISM( z_functor_morphism, TheTypeOfAscendingFilteredMorphisms, AsAscendingFilteredObject, CategoryOfAscendingFilteredObjects );
    
end );

##
InstallMethod( AsDescendingFilteredMorphism,
               [ IsZFunctorMorphism ],
               
  function( z_functor_morphism )
    
    return AS_FILTERED_MORPHISM( z_functor_morphism, TheTypeOfDescendingFilteredMorphisms, AsDescendingFilteredObject, CategoryOfDescendingFilteredObjects );
    
end );

BindGlobal( "FILTERED_MORPHISM",
            
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
InstallMethod( AscendingFilteredMorphism,
               [ IsAscendingFilteredObject, IsZFunctorMorphism, IsAscendingFilteredObject ],
               
  function( source, z_functor_morphism, range )
    
    return FILTERED_MORPHISM( source, z_functor_morphism, range, TheTypeOfAscendingFilteredMorphisms, CategoryOfAscendingFilteredObjects );
    
end );

##
InstallMethod( AscendingFilteredMorphism,
               [ IsAscendingFilteredObject, IsFunction, IsAscendingFilteredObject ],
               
  function( source, morphism_func, range )
    local z_functor_morphism;
    
    z_functor_morphism := ZFunctorMorphism( UnderlyingZFunctorCell( source ), morphism_func, UnderlyingZFunctorCell( range ) );
    
    return FILTERED_MORPHISM( source, z_functor_morphism, range, TheTypeOfAscendingFilteredMorphisms, CategoryOfAscendingFilteredObjects );
    
end );

##
InstallMethod( DescendingFilteredMorphism,
               [ IsDescendingFilteredObject, IsZFunctorMorphism, IsDescendingFilteredObject ],
               
  function( source, z_functor_morphism, range )
    
    return FILTERED_MORPHISM( source, z_functor_morphism, range, TheTypeOfDescendingFilteredMorphisms, CategoryOfDescendingFilteredObjects );
    
end );

##
InstallMethod( DescendingFilteredMorphism,
               [ IsDescendingFilteredObject, IsFunction, IsDescendingFilteredObject ],
               
  function( source, morphism_func, range )
    local twisted_morphism_func, z_functor_morphism;
    
    ## this is due to the convention in ZFunctors: i -> j iff i <= j,
    ## thus the function can be given with correct indices by the user
    twisted_morphism_func := function( i )
      
      return morphism_func(-i);
      
    end;
    
    z_functor_morphism := ZFunctorMorphism( UnderlyingZFunctorCell( source ), twisted_morphism_func, UnderlyingZFunctorCell( range ) );
    
    return FILTERED_MORPHISM( source, z_functor_morphism, range, TheTypeOfDescendingFilteredMorphisms, CategoryOfDescendingFilteredObjects );
    
end );

#################################################
##
## Functors
##
#################################################

##
InstallMethodWithCache( DescendingToAscendingFilteredObjectFunctor,
                        [ IsCapCategory ],
                                  
  function( category )
    local descending_filtered_object_category, ascending_filtered_object_category, functor;
    
    descending_filtered_object_category := CategoryOfDescendingFilteredObjects( category );
    
    ascending_filtered_object_category := CategoryOfAscendingFilteredObjects( category );
    
    functor := CapFunctor( Concatenation( "Descending to ascending filtered objects functor of ", Name( category ) ),
                           descending_filtered_object_category,
                           ascending_filtered_object_category );
    
    AddObjectFunction( functor,
      
      function( descending_filtered_object )
        local object_func, differential_func, z_functor_object;
        
        object_func := function( i )
          
          return descending_filtered_object[-i];
          
        end;
        
        differential_func := function( i )
          
          return Embedding( descending_filtered_object, -i );
          
        end;
        
        z_functor_object := ZFunctorObject( object_func, differential_func, category );
        
        return AsAscendingFilteredObject( z_functor_object );
        
    end );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local func;
        
        func := function( i )
          
          return morphism[-i];
          
        end;
        
        return AscendingFilteredMorphism( new_source, func, new_range );
        
    end );
    
    return functor;
    
end );

##
InstallMethodWithCache( AscendingToDescendingFilteredObjectFunctor,
                        [ IsCapCategory ],
                                  
  function( category )
    local ascending_filtered_object_category, descending_filtered_object_category, functor;
    
    ascending_filtered_object_category := CategoryOfAscendingFilteredObjects( category );
    
    descending_filtered_object_category := CategoryOfDescendingFilteredObjects( category );
    
    functor := CapFunctor( Concatenation( "Ascending to descending filtered object functor of ", Name( category ) ),
                           ascending_filtered_object_category,
                           descending_filtered_object_category );
    
    AddObjectFunction( functor,
      
      function( ascending_filtered_object )
        local object_func, differential_func, z_functor_object;
        
        object_func := function( i )
          
          return ascending_filtered_object[i];
          
        end;
        
        differential_func := function( i )
          
          return Embedding( ascending_filtered_object, i );
          
        end;
        
        z_functor_object := ZFunctorObject( object_func, differential_func, category );
        
        #note that the interpretation of this z_functor_object as a complex will automatically
        #change the signs
        return AsDescendingFilteredObject( z_functor_object );
        
    end );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local func;
        
        func := function( i )
          
          return morphism[-i];
          
        end;
        
        #here the signs have to be changed manually for this constructor
        #expects a function whose indices are compatible with new_source and new_range
        return DescendingFilteredMorphism( new_source, func, new_range );
        
    end );
    
    return functor;
    
end );

