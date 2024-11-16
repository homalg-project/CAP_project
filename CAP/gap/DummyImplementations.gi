# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

## dummy rings

BindGlobal( "TheFamilyOfDummyRings",
        NewFamily( "TheFamilyOfDummyRings" ) );

CAP_INTERNAL_DUMMY_RING_COUNTER := 1;

InstallGlobalFunction( DummyRing, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter := NewFilter( "DummyRingFilter", IsDummyRing );
    ring_element_filter := NewFilter( "DummyRingElementFilter", IsDummyRingElement );
    
    name := Concatenation( "Dummy ring ", String( CAP_INTERNAL_DUMMY_RING_COUNTER ) );
    CAP_INTERNAL_DUMMY_RING_COUNTER := CAP_INTERNAL_DUMMY_RING_COUNTER + 1;
    
    ring := CreateGapObjectWithAttributes( NewType( TheFamilyOfDummyRings, IsAttributeStoringRep and ring_filter ),
        Name, name,
        String, name,
        RingFilter, ring_filter,
        RingElementFilter, ring_element_filter
    );
    
    CapJitAddTypeSignature( "+", [ ring_element_filter, ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "ZeroImmutable", [ ring_filter ], ring_element_filter );
    CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "*", [ ring_element_filter, ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "OneImmutable", [ ring_filter ], ring_element_filter );
    
    return ring;
    
end );

## dummy commutative rings

BindGlobal( "TheFamilyOfDummyCommutativeRings",
        NewFamily( "TheFamilyOfDummyCommutativeRings" ) );

CAP_INTERNAL_DUMMY_COMMUTATIVE_RING_COUNTER := 1;

InstallGlobalFunction( DummyCommutativeRing, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter := NewFilter( "DummyCommutativeRingFilter", IsDummyCommutativeRing );
    ring_element_filter := NewFilter( "DummyCommutativeRingElementFilter", IsDummyCommutativeRingElement );
    
    name := Concatenation( "Dummy commutative ring ", String( CAP_INTERNAL_DUMMY_COMMUTATIVE_RING_COUNTER ) );
    CAP_INTERNAL_DUMMY_COMMUTATIVE_RING_COUNTER := CAP_INTERNAL_DUMMY_COMMUTATIVE_RING_COUNTER + 1;
    
    ring := CreateGapObjectWithAttributes( NewType( TheFamilyOfDummyCommutativeRings, IsAttributeStoringRep and ring_filter ),
        Name, name,
        String, name,
        RingFilter, ring_filter,
        RingElementFilter, ring_element_filter,
        IsCommutative, true
    );
    
    CapJitAddTypeSignature( "+", [ ring_element_filter, ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "ZeroImmutable", [ ring_filter ], ring_element_filter );
    CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "*", [ ring_element_filter, ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "OneImmutable", [ ring_filter ], ring_element_filter );
    
    return ring;
    
end );

## dummy fields

BindGlobal( "TheFamilyOfDummyFields",
        NewFamily( "TheFamilyOfDummyFields" ) );

CAP_INTERNAL_DUMMY_FIELD_COUNTER := 1;

InstallGlobalFunction( DummyField, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter := NewFilter( "DummyFieldFilter", IsDummyField );
    ring_element_filter := NewFilter( "DummyFieldElementFilter", IsDummyFieldElement );
    
    name := Concatenation( "Dummy field ", String( CAP_INTERNAL_DUMMY_FIELD_COUNTER ) );
    CAP_INTERNAL_DUMMY_FIELD_COUNTER := CAP_INTERNAL_DUMMY_FIELD_COUNTER + 1;
    
    ring := CreateGapObjectWithAttributes( NewType( TheFamilyOfDummyFields, IsAttributeStoringRep and ring_filter ),
        Name, name,
        String, name,
        RingFilter, ring_filter,
        RingElementFilter, ring_element_filter,
        IsField, true
    );
    
    CapJitAddTypeSignature( "+", [ ring_element_filter, ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "ZeroImmutable", [ ring_filter ], ring_element_filter );
    CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "*", [ ring_element_filter, ring_element_filter ], ring_element_filter );
    CapJitAddTypeSignature( "OneImmutable", [ ring_filter ], ring_element_filter );
    
    return ring;
    
end );

## dummy categories

##
InstallMethod( DummyCategory,
        "for a record of options",
        [ IsRecord ],
        
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, options )
    local category_constructor_options, dummy_function, C, operation_name;
    
    category_constructor_options := ShallowCopy( options );
    category_constructor_options.category_filter := IsDummyCategory;
    category_constructor_options.category_object_filter := IsDummyCategoryObject;
    category_constructor_options.category_morphism_filter := IsDummyCategoryMorphism;
    category_constructor_options.is_computable := "IsCongruentForMorphisms" in options.list_of_operations_to_install;
    category_constructor_options.supports_empty_limits := true;
    
    if "ObjectConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.object_constructor := function ( cat, object_datum )
            
            Error( "this is a dummy category without actual implementation" );
            
        end;
        
    fi;
    
    if "MorphismConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.morphism_constructor := function ( cat, source, morphism_datum, range )
            
            Error( "this is a dummy category without actual implementation" );
            
        end;
        
    fi;
    
    if "ObjectDatum" in options.list_of_operations_to_install then
        
        category_constructor_options.object_datum := function ( cat, object )
            
            Error( "this is a dummy category without actual implementation" );
            
        end;
        
    fi;
    
    if "MorphismDatum" in options.list_of_operations_to_install then
        
        category_constructor_options.morphism_datum := function ( cat, morphism )
            
            Error( "this is a dummy category without actual implementation" );
            
        end;
        
    fi;
    
    dummy_function := { operation_name, dummy } -> Pair( """
        function ( input_arguments... )
            
            Error( "this is a dummy category without actual implementation" );
            
        end
    """, 1 );
    
    category_constructor_options.create_func_bool := dummy_function;
    category_constructor_options.create_func_object := dummy_function;
    category_constructor_options.create_func_morphism := dummy_function;
    category_constructor_options.create_func_list_of_objects := dummy_function;
    
    C := CategoryConstructor( category_constructor_options );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( C );
        
    fi;
    
    for operation_name in options.list_of_operations_to_install do
        
        if not CanCompute( C, operation_name ) then
            
            Print( "WARNING: The dummy category cannot compute ", operation_name, ", probably because the operation is not supported by CategoryConstructor yet.\n" );
            
        fi;
        
    od;
    
    return C;
    
end ) );
