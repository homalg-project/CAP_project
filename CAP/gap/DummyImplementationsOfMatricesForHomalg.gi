# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

## dummy homalg rings

BindGlobal( "TheFamilyOfDummyHomalgRings",
        NewFamily( "TheFamilyOfDummyHomalgRings" ) );

CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER := 1;

InstallGlobalFunction( DummyHomalgRing, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter := NewFilter( "DummyHomalgSemiringFilter", IsDummyHomalgRing );
    ring_element_filter := NewFilter( "DummyHomalgSemiringElementFilter", IsDummyHomalgRingElement );
    
    name := Concatenation( "Dummy homalg ring ", String( CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER ) );
    CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER := CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER + 1;
    
    ring := CreateGapObjectWithAttributes( NewType( TheFamilyOfDummyHomalgRings, IsAttributeStoringRep and ring_filter ),
        Name, name,
        String, name,
        SemiringFilter, ring_filter,
        SemiringElementFilter, ring_element_filter
    );
    
    return ring;
    
end );

## dummy commutative homalg rings

BindGlobal( "TheFamilyOfDummyCommutativeHomalgRings",
        NewFamily( "TheFamilyOfDummyCommutativeHomalgRings" ) );

CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER := 1;

InstallGlobalFunction( DummyCommutativeHomalgRing, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter := NewFilter( "DummyCommutativeHomalgSemiringFilter", IsDummyCommutativeHomalgRing );
    ring_element_filter := NewFilter( "DummyCommutativeHomalgSemiringElementFilter", IsDummyCommutativeHomalgRingElement );
    
    name := Concatenation( "Dummy commutative homalg ring ", String( CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER ) );
    CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER := CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER + 1;
    
    ring := CreateGapObjectWithAttributes( NewType( TheFamilyOfDummyCommutativeHomalgRings, IsAttributeStoringRep and ring_filter ),
        Name, name,
        String, name,
        SemiringFilter, ring_filter,
        SemiringElementFilter, ring_element_filter,
        IsCommutative, true
    );
    
    return ring;
    
end );

## dummy homalg fields

BindGlobal( "TheFamilyOfDummyHomalgFields",
        NewFamily( "TheFamilyOfDummyHomalgFields" ) );

CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER := 1;

InstallGlobalFunction( DummyHomalgField, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter := NewFilter( "DummyHomalgFieldFilter", IsDummyHomalgField );
    ring_element_filter := NewFilter( "DummyHomalgFieldElementFilter", IsDummyHomalgFieldElement );
    
    name := Concatenation( "Dummy homalg field ", String( CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER ) );
    CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER := CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER + 1;
    
    ring := CreateGapObjectWithAttributes( NewType( TheFamilyOfDummyHomalgFields, IsAttributeStoringRep and ring_filter ),
        Name, name,
        String, name,
        SemiringFilter, ring_filter,
        SemiringElementFilter, ring_element_filter,
        IsField, true,
        IsFieldForHomalg, true
    );
    
    return ring;
    
end );
