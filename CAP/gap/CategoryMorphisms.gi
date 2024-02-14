# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

######################################
##
## Reps, types, stuff.
##
######################################

# backwards compatibility
BindGlobal( "IsCapCategoryMorphismRep", IsCapCategoryMorphism );

######################################
##
## Properties logic
##
######################################
# 
# InstallTrueMethod( IsSplitMonomorphism and IsSplitEpimorphism, IsCapCategoryMorphism and IsIsomorphism );
# 
# InstallTrueMethod( IsAutomorphism, IsCapCategoryMorphism and IsOne );
# 
# InstallTrueMethod( IsIsomorphism and IsEndomorphism, IsCapCategoryMorphism and IsAutomorphism );
# 
# InstallTrueMethod( IsMonomorphism, IsCapCategoryMorphism and IsSplitMonomorphism );
# 
# InstallTrueMethod( IsEpimorphism, IsCapCategoryMorphism and IsSplitEpimorphism );
# 
# InstallTrueMethod( IsIsomorphism, IsMonomorphism and IsEpimorphism and IsAbelianCategory );#TODO: weaker?

#######################################
##
## Technical implications
##
#######################################

InstallValue( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS,
              [  
                 "IsMonomorphism",
                 "IsEpimorphism",
                 "IsIsomorphism",
                 "IsEndomorphism",
                 "IsAutomorphism",
                 "IsSplitMonomorphism",
                 "IsSplitEpimorphism",
                 "IsOne",
                 "IsIdempotent",
                 "IsZero",
                 # ..
              ] );

######################################
##
## Operations
##
######################################

InstallMethod( Target,
               [ IsCapCategoryMorphism ],
               
  Range );

InstallMethod( Add,
               [ IsCapCategory, IsCapCategoryMorphism ],
               
  function( category, morphism )
    local filter;
    
    filter := MorphismFilter( category );
    
    if not filter( morphism ) then
        
        SetFilterObj( morphism, filter );
        
    fi;
    
    AddObject( category, Source( morphism ) );
    
    AddObject( category, Range( morphism ) );
    
    if category!.predicate_logic then
        
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ morphism ], Source( morphism ), category );
        
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ morphism ], Range( morphism ), category );
      
    fi;
    
    if HasCapCategory( morphism ) then
        
        if IsIdenticalObj( CapCategory( morphism ), category ) then
            
            return;
            
        else
            
            Error(
                Concatenation(
                    "a morphism that lies in the CAP-category with the name\n",
                    Name( CapCategory( morphism ) ),
                    "\n",
                    "was tried to be added to a different CAP-category with the name\n",
                    Name( category ), ".\n",
                    "(Please note that it is possible for different CAP-categories to have the same name)"
                )
            );
            
        fi;
        
    fi;
    
    SetCapCategory( morphism, category );
    
end );

InstallMethod( AddMorphism,
               [ IsCapCategory, IsCapCategoryMorphism ],
               
  function( category, morphism )
    
    Add( category, morphism );
    
end );

InstallMethod( AddMorphism,
               [ IsCapCategory, IsAttributeStoringRep ],
               
  function( category, morphism )
    
    SetFilterObj( morphism, IsCapCategoryMorphism );
    
    Add( category, morphism );
    
end );

##
InstallMethod( IsZero,
               [ IsCapCategoryMorphism ],
                  
IsZeroForMorphisms );

##
InstallMethod( \+,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
AdditionForMorphisms );

##
InstallMethod( \-,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
SubtractionForMorphisms );

##
InstallMethod( AdditiveInverse,
                  [ IsCapCategoryMorphism ],
                  
AdditiveInverseForMorphisms );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    AdditiveInverse := [ [ "AdditiveInverseForMorphisms", 1 ] ],
    AdditiveInverseImmutable := [ [ "AdditiveInverseForMorphisms", 1 ] ],
  )
 );

##
InstallOtherMethod( Inverse,
                  [ IsCapCategoryMorphism ],
                  
InverseForMorphisms );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    Inverse := [ [ "InverseForMorphisms", 1 ] ],
    InverseImmutable := [ [ "InverseForMorphisms", 1 ] ],
  )
 );

##
InstallMethod( \*,
               [ IsRingElement, IsCapCategoryMorphism ],
               
MultiplyWithElementOfCommutativeRingForMorphisms );

##
InstallMethod( \*,
               [ IsCapCategoryMorphism, IsRingElement ],
               
  function( mor, r )
    
    return MultiplyWithElementOfCommutativeRingForMorphisms( r, mor );
    
end );

##
InstallMethod( \*,
               [ IsRat, IsCapCategoryMorphism ],
               
function( q, mor )
    local cat, ring, r;
    
    cat := CapCategory( mor );
    
    ring := CommutativeRingOfLinearCategory( cat );
    
    if IsIdenticalObj( ring, Integers ) or IsIdenticalObj( ring, Rationals ) then
        
        r := q;
        
    else
        
        if IsBound( ring!.interpret_rationals_func ) then
            
            r := ring!.interpret_rationals_func( q );
            
            if r = fail then
                
                Error( "cannot interpret ", String( q ), " as an element of the commutative ring of ", Name( cat ) );
                
            fi;
            
        else
            
            Error( "The commutative ring of ", Name( cat ), "doesn't know how to interpret rationals" );
            
        fi;
        
    fi;
    
    return MultiplyWithElementOfCommutativeRingForMorphisms( r, mor );
    
end );

##
InstallMethod( IsEqualForCache,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  { mor1, mor2 } -> IsEqualForCacheForMorphisms( CapCategory( mor1 ), mor1, mor2 ) );

##
# generic fallback to IsIdenticalObj
InstallOtherMethod( IsEqualForCacheForMorphisms,
               [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  { cat, mor1, mor2 } -> IsIdenticalObj( mor1, mor2 ) );

##
InstallMethod( AddMorphismRepresentation,
               [ IsCapCategory, IsObject ],
               
  function( category, representation )
    
    Print( "WARNING: AddMorphismRepresentation is deprecated and will not be supported after 2024.08.21. Please use CreateCapCategory with four arguments instead.\n" );
    
    if not IsSpecializationOfFilter( IsCapCategoryMorphism, representation ) then
        
        Error( "the morphism representation must imply IsCapCategoryMorphism" );
        
    fi;
    
    if IsBound( category!.initially_known_categorical_properties ) then
        
        Error( "calling AddMorphismRepresentation after adding functions to the category is not supported" );
        
    fi;
    
    InstallTrueMethod( representation, MorphismFilter( category ) );
    
end );

InstallMethod( RandomMorphismWithFixedSourceAndRange,
    [ IsCapCategoryObject, IsCapCategoryObject, IsInt ], RandomMorphismWithFixedSourceAndRangeByInteger );

InstallMethod( RandomMorphismWithFixedSourceAndRange,
    [ IsCapCategoryObject, IsCapCategoryObject, IsList ], RandomMorphismWithFixedSourceAndRangeByList );

InstallMethod( RandomMorphismWithFixedSource,
    [ IsCapCategoryObject, IsInt ], RandomMorphismWithFixedSourceByInteger );

InstallMethod( RandomMorphismWithFixedSource,
    [ IsCapCategoryObject, IsList ], RandomMorphismWithFixedSourceByList );

InstallMethod( RandomMorphismWithFixedRange,
    [ IsCapCategoryObject, IsInt ], RandomMorphismWithFixedRangeByInteger );

InstallMethod( RandomMorphismWithFixedRange,
    [ IsCapCategoryObject, IsList ], RandomMorphismWithFixedRangeByList );

InstallMethod( RandomMorphism,
    [ IsCapCategory, IsInt ], RandomMorphismByInteger );

InstallMethod( RandomMorphism,
    [ IsCapCategory, IsList ], RandomMorphismByList );

InstallMethod( RandomMorphism,
    [ IsCapCategoryObject, IsCapCategoryObject, IsList ], RandomMorphismWithFixedSourceAndRangeByList );

InstallMethod( RandomMorphism,
    [ IsCapCategoryObject, IsCapCategoryObject, IsInt ], RandomMorphismWithFixedSourceAndRangeByInteger );

##
InstallGlobalFunction( ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes,
                       
  function( morphism, category, source, range, additional_arguments_list... )
    local arg_list, objectified_morphism;
    
    Print( "WARNING: ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes is deprecated and will not be supported after 2024.08.29. Please use CreateCapCategoryMorphismWithAttributes instead.\n" );
    
    arg_list := Concatenation(
        [ morphism, category!.morphism_type, CapCategory, category, Source, source, Range, range ], additional_arguments_list
    );
    
    objectified_morphism := CallFuncList( ObjectifyWithAttributes, arg_list );
    
    if category!.predicate_logic then
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ objectified_morphism ], source, category );
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ objectified_morphism ], range, category );
    fi;
    
    #= comment for Julia
    # This can be removed once AddMorphismRepresentation is removed.
    # work around https://github.com/gap-system/gap/issues/3642:
    # New implications of `MorphismFilter( category )` (e.g. installed via `AddMorphismRepresentation`)
    # are not automatically set in `category!.morphism_type`.
    SetFilterObj( objectified_morphism, MorphismFilter( category ) );
    # =#
    
    return objectified_morphism;
    
end );

##
InstallGlobalFunction( CreateCapCategoryMorphismWithAttributes,
                       
  function( category, source, range, additional_arguments_list... )
    local arg_list, objectified_morphism;
    
    arg_list := Concatenation(
        [ rec( ), category!.morphism_type, CapCategory, category, Source, source, Range, range ], additional_arguments_list
    );
    
    objectified_morphism := CallFuncList( ObjectifyWithAttributes, arg_list );
    
    if category!.predicate_logic then
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ objectified_morphism ], source, category );
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ objectified_morphism ], range, category );
    fi;
    
    #= comment for Julia
    # This can be removed once AddMorphismRepresentation is removed.
    # work around https://github.com/gap-system/gap/issues/3642:
    # New implications of `MorphismFilter( category )` (e.g. installed via `AddMorphismRepresentation`)
    # are not automatically set in `category!.morphism_type`.
    SetFilterObj( objectified_morphism, MorphismFilter( category ) );
    # =#
    
    return objectified_morphism;
    
end );

##
InstallGlobalFunction( AsCapCategoryMorphism,
                       
  function( category, source, morphism_datum, range )
    local morphism_datum_type, mor;
    
    morphism_datum_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "morphism_datum", category );
    
    if morphism_datum_type <> fail then
        
        CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( morphism_datum_type, [ "the third argument of `AsCapCategoryMorphism`" ] )( morphism_datum );
        
    fi;
    
    mor := ObjectifyWithAttributes( rec( ), category!.morphism_type, CapCategory, category, Source, source, Range, range, category!.morphism_attribute, morphism_datum );
    
    if not IsIdenticalObj( category!.morphism_attribute( mor ), morphism_datum ) then
        
        Print( "WARNING: <morphism_datum> is not identical to `", category!.morphism_attribute_name, "( <mor> )`. You might want to make <morphism_datum> immutable.\n" );
        
    fi;
    
    if category!.predicate_logic then
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ mor ], source, category );
        INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ mor ], range, category );
    fi;
    
    return mor;
    
end );

##
InstallMethod( Simplify,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    local phi;
    
    phi := PreCompose( [ SimplifyObject_IsoToInputObject( Source( morphism ), infinity ),
                         morphism,
                         SimplifyObject_IsoFromInputObject( Range( morphism ), infinity ) ] );
    
    return SimplifyMorphism( phi, infinity );
    
end );

######################################
##
## Morphism equality functions
##
######################################

# This method should usually not be selected when the two morphisms belong to the same category and the category can compute IsEqualForMorphisms.
InstallOtherMethod( IsEqualForMorphisms,
                    [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( cat, morphism_1, morphism_2 )
    
    if not HasCapCategory( morphism_1 ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_1 ), "\" has no CAP category" ) );
        
    fi;
    
    if not HasCapCategory( morphism_2 ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_2 ), "\" has no CAP category" ) );
        
    fi;
    
    if not IsIdenticalObj( CapCategory( morphism_1 ), cat ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_1 ), "\" does not belong to the CAP category <cat>" ) );
        
    elif not IsIdenticalObj( CapCategory( morphism_2 ), cat ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_2 ), "\" does not belong to the CAP category <cat>" ) );
        
    else
        
        # convenience: as long as the morphisms are identical, everything "just works"
        if IsIdenticalObj( morphism_1, morphism_2 ) then
            
            return true;
            
        else
            
            Error( "Cannot decide whether the morphism \"", String( morphism_1 ), "\" and the morphism \"", String( morphism_2 ), "\" are equal. You can fix this error by installing `IsEqualForMorphisms` in <cat> or possibly avoid it by enabling strict caching." );
            
        fi;
        
    fi;
    
end );

# This method should usually not be selected when the two morphisms belong to the same category and the category can compute IsCongruentForMorphisms.
InstallOtherMethod( IsCongruentForMorphisms,
                    [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( cat, morphism_1, morphism_2 )
    
    if not HasCapCategory( morphism_1 ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_1 ), "\" has no CAP category" ) );
        
    fi;
    
    if not HasCapCategory( morphism_2 ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_2 ), "\" has no CAP category" ) );
        
    fi;
    
    if not IsIdenticalObj( CapCategory( morphism_1 ), cat ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_1 ), "\" does not belong to the CAP category <cat>" ) );
        
    elif not IsIdenticalObj( CapCategory( morphism_2 ), cat ) then
        
        Error( Concatenation( "the morphism \"", String( morphism_2 ), "\" does not belong to the CAP category <cat>" ) );
        
    else
        
        if CapCategory( morphism_1 )!.is_computable then
            
            # convenience: as long as the morphisms are identical, everything "just works"
            if IsIdenticalObj( morphism_1, morphism_2 ) then
                
                return true;
                
            else
                
                Error( "Cannot decide whether the morphism \"", String( morphism_1 ), "\" and the morphism \"", String( morphism_2 ), "\" are congruent. You can fix this error by installing `IsCongruentForMorphisms` in <cat>." );
                
            fi;
            
        else
            
            Error( "cannot decide congruence of morphisms in a non-computable category" );
            
        fi;
        
    fi;
    
end );

##
InstallMethod( \=,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    if CapCategory( morphism_1 )!.input_sanity_check_level > 0 or CapCategory( morphism_2 )!.input_sanity_check_level > 0  then
        if not IsIdenticalObj( CapCategory( morphism_1 ), CapCategory( morphism_2 ) ) then
            Error( Concatenation( "the morphism \"", String( morphism_1 ), "\" and the morphism \"", String( morphism_2 ), "\" do not belong to the same CAP category" ) );
        fi;
    fi;
    if not IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) ) or not IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) ) then
        
        return false;
        
    fi;
    
    return IsCongruentForMorphisms( morphism_1, morphism_2 );
    
end );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS,
                       
  function( morphism_1, morphism_2 )
    local category, i, entry;
    
    category := CapCategory( morphism_1 );
    
    for i in PROPAGATION_LIST_FOR_EQUAL_MORPHISMS do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( morphism_1, i, morphism_2, i ) );
        
    od;
    
    if IsBound( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS ) then
        
        for i in category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS do
            
            AddToToDoList( ToDoListEntryForEqualAttributes( morphism_1, i, morphism_2, i ) );
            
        od;
        
    fi;
    
end );

##
InstallMethod( AddPropertyToMatchAtIsCongruentForMorphisms,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    
    if not IsBound( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS ) then
        
        category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS := [ ];
        
    fi;
    
    if Position( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, name ) = fail then
        
        Add( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, name );
        
    fi;
    
end );

######################################
##
## Convenience method
##
######################################

## FIXME: This might be dangerous
##
# InstallMethod( Zero,
#                [ IsCapCategoryMorphism ],
#                
#   function( mor )
#     
#     return ZeroMorphism( Source( mor ), Range( mor ) );
#     
# end );

##
InstallOtherMethod( PreComposeList,
               [ IsCapCategory, IsList ],
               
  function( cat, morphism_list )
    
    if IsEmpty( morphism_list ) then
        Error( "the given list of morphisms is empty\n" );
    fi;
    
    return PreComposeList( cat, Source( First( morphism_list ) ), morphism_list, Range( Last( morphism_list ) ) );
    
end );

##
InstallOtherMethod( PostComposeList,
               [ IsCapCategory, IsList ],
               
  function( cat, morphism_list )
    
    if IsEmpty( morphism_list ) then
        Error( "the given list of morphisms is empty\n" );
    fi;
    
    return PostComposeList( cat, Source( Last( morphism_list ) ), morphism_list, Range( First( morphism_list ) ) );
    
end );

##
InstallOtherMethod( PreComposeList,
               [ IsList ],
               
  function( morphism_list )
    
    if IsEmpty( morphism_list ) then
        Error( "the given list of morphisms is empty\n" );
    fi;
    
    return PreComposeList( CapCategory( morphism_list[1] ), morphism_list );
    
end );

##
InstallOtherMethod( PostComposeList,
               [ IsList ],
               
  function( morphism_list )
    
    if IsEmpty( morphism_list ) then
        Error( "the given list of morphisms is empty\n" );
    fi;
    
    return PostComposeList( CapCategory( morphism_list[1] ), morphism_list );
    
end );

##
InstallMethod( PreCompose,
               [ IsList ],
               
  function( morphism_list )
    
    return PreComposeList( morphism_list );
    
end );

##
InstallMethod( PostCompose,
               [ IsList ],
               
  function( morphism_list )
    
    return PostComposeList( morphism_list );
    
end );

##
InstallMethod( HomStructure,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( alpha, beta )
    
    return HomomorphismStructureOnMorphisms( alpha, beta );
    
end );

##
InstallMethod( HomStructure,
               [ IsCapCategoryObject, IsCapCategoryMorphism ],
               
  function( a, beta )
    
    return HomomorphismStructureOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( HomStructure,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( alpha, b )
    
    return HomomorphismStructureOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );

##
InstallMethod( HomStructure,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( a, b )
    
    return HomomorphismStructureOnObjects( a, b );
    
end );

##
InstallMethod( HomStructure,
               [ IsCapCategoryMorphism ],
    InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure
);

##
InstallMethod( HomStructure,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ],
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
);

##
InstallMethod( HomStructure,
               [ IsCapCategory ],
    DistinguishedObjectOfHomomorphismStructure
);

##

# usually the type signatures should be part of the gd file, but `CapJitAddTypeSignature` is not available there

CapJitAddTypeSignature( "HomomorphismStructureOnObjectsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "HomomorphismStructureOnMorphismsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

InstallMethod( ExtendRangeOfHomomorphismStructureByFullEmbedding,
               [ IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsFunction, IsFunction ],
  function ( C, E, object_function, morphism_function, object_function_inverse, morphism_function_inverse )
    
    # C has a D-homomorphism structure
    # object_function and morphism_function defined a full embedding ι: D → E
    # object_function_inverse and morphism_function_inverse define the inverse of ι on its image
    
    InstallMethodForCompilerForCAP( DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ) ],
      function ( C, E )
        
        return object_function( C, E, DistinguishedObjectOfHomomorphismStructure( C ) );
        
    end );
    
    InstallMethodForCompilerForCAP( HomomorphismStructureOnObjectsExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ), IsCapCategoryObject and ObjectFilter( C ), IsCapCategoryObject and ObjectFilter( C ) ],
      function ( C, E, a, b )
        
        return object_function( C, E, HomomorphismStructureOnObjects( C, a, b ) );
        
    end );
    
    InstallMethodForCompilerForCAP( HomomorphismStructureOnMorphismsExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ), IsCapCategoryMorphism and MorphismFilter( C ), IsCapCategoryMorphism and MorphismFilter( C ) ],
      function ( C, E, alpha, beta )
        local mor;
        
        mor := HomomorphismStructureOnMorphisms( C, alpha,  beta );
        
        return morphism_function( C, E, object_function( C, E, Source( mor ) ), mor, object_function( C, E, Range( mor ) ) );
        
    end );
    
    InstallMethodForCompilerForCAP( HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ), IsCapCategoryObject and ObjectFilter( E ), IsCapCategoryMorphism and MorphismFilter( C ), IsCapCategoryMorphism and MorphismFilter( C ), IsCapCategoryObject and ObjectFilter( E ) ],
      function ( C, E, s, alpha, beta, r )
        local mor;
        
        mor := HomomorphismStructureOnMorphismsWithGivenObjects( C, object_function_inverse( C, E, s ), alpha, beta, object_function_inverse( C, E, r ) );
        
        return morphism_function( C, E, s, mor, r );
        
    end );
    
    InstallMethodForCompilerForCAP( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ), IsCapCategoryMorphism and MorphismFilter( C ) ],
      function ( C, E, alpha )
        local mor;
        
        mor := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( C, alpha );
        
        return morphism_function( C, E, object_function( C, E, Source( mor ) ), mor, object_function( C, E, Range( mor ) ) );
        
    end );
    
    InstallMethodForCompilerForCAP( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ), IsCapCategoryObject and ObjectFilter( E ), IsCapCategoryMorphism and MorphismFilter( C ), IsCapCategoryObject and ObjectFilter( E ) ],
      function ( C, E, distinguished_object, alpha, r )
        local mor;
        
        mor := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( C, object_function_inverse( C, E, distinguished_object ), alpha, object_function_inverse( C, E, r ) );
        
        return morphism_function( C, E, distinguished_object, mor, r );
        
    end );
    
    InstallMethodForCompilerForCAP( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding,
                                    [ IsCapCategory and CategoryFilter( C ), IsCapCategory and CategoryFilter( E ), IsCapCategoryObject and ObjectFilter( C ), IsCapCategoryObject and ObjectFilter( C ), IsCapCategoryMorphism and MorphismFilter( E ) ],
      function ( C, E, a, b, iota )
        
        return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C, a, b, morphism_function_inverse( C, E, object_function_inverse( C, E, Source( iota ) ), iota, object_function_inverse( C, E, Range( iota ) ) ) );
        
    end );
    
end );

##
InstallMethod( ExtendRangeOfHomomorphismStructureByIdentityAsFullEmbedding,
               [ IsCapCategory ],
  function ( C )
    local object_function, morphism_function, object_function_inverse, morphism_function_inverse;
    
    if IsBound( C!.range_category_of_hom_structure_already_extended_by_identity ) then
        ## the range of the hom-structure has already been extended by identity
        return;
    fi;
    
    object_function := function ( category, range_category, object )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return object;
        
    end;
    
    morphism_function := function ( category, range_category, source, morphism, range )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return morphism;
        
    end;
    
    object_function_inverse := function ( category, range_category, object )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return object;
        
    end;
    
    morphism_function_inverse := function ( category, range_category, source, morphism, range )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return morphism;
        
    end;
    
    ExtendRangeOfHomomorphismStructureByFullEmbedding( C, RangeCategoryOfHomomorphismStructure( C ), object_function, morphism_function, object_function_inverse, morphism_function_inverse );
    
    C!.range_category_of_hom_structure_already_extended_by_identity := true;
    
end );

######################################
##
## Morphism transport
##
######################################

## mor: x -> y
## equality_source: x -> x'
## equality_range: y -> y'
## TransportHom( mor, equality_source, equality_range ): x' -> y'
##
InstallMethodWithCacheFromObject( TransportHom,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( mor, equality_source, equality_range )
    
    return PreCompose(
             Inverse( equality_source ),
             PreCompose( mor, equality_range )
           );
    
end );

###########################
##
## IsWellDefined
##
###########################

##
InstallMethod( IsWellDefined,
               [ IsCapCategoryMorphism ],
               
  IsWellDefinedForMorphisms
);

###########################
##
## Print
##
###########################

InstallMethod( String,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return Concatenation( "A morphism in ", Name( CapCategory( morphism ) ) );
    
end );

# fallback methods for Julia
InstallMethod( ViewString,
               [ IsCapCategoryMorphism ],
               
  function ( morphism )
    
    # do not reuse `String` because morphisms might use `String` as the attribute storing the morphism datum
    return Concatenation( "<A morphism in ", Name( CapCategory( morphism ) ), ">" );
    
end );

InstallMethod( DisplayString,
               [ IsCapCategoryMorphism ],
               
  function ( morphism )
    
    # do not reuse `String` because morphisms might use `String` as the attribute storing the morphism datum
    return Concatenation( "A morphism in ", Name( CapCategory( morphism ) ), ".\n" );
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_CREATE_MORPHISM_PRINT,
                       
  function( )
    local print_graph, morphism_function;
    
    morphism_function := function( object )
      local string;
        
        string := "morphism in ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategoryMorphism and HasCapCategory, morphism_function );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ rec( Conditions := "IsIsomorphism",
                                              PrintString := "iso",
                                              Adjective := true,
                                              NoSepString := true ) ],
                             Range := [ rec( Conditions := "IsSplitMonomorphism",
                                             PrintString := "split mono",
                                             TypeOfView := "ViewObj",
                                             ComputeLevel := "AllWithCompute",
                                             Adjective := true,
                                              NoSepString := true ),
                                        rec( Conditions := "IsSplitEpimorphism",
                                             PrintString := "split epi",
                                             Adjective := true,
                                              NoSepString := true ) ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ rec( Conditions := "IsOne",
                                              PrintString := "identity",
                                              Adjective := true ) ],
                             Range := [ rec( Conditions := "IsAutomorphism",
                                             PrintString := "auto",
                                             Adjective := true,
                                             NoSepString := true ),
                                        "IsIsomorphism" ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ "IsAutomorphism" ],
                             Range := [ "IsIsomorphism",
                                        rec( Conditions := "IsEndomorphism",
                                             PrintString := "endo",
                                             Adjective := true,
                                             NoSepString := true) ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ "IsSplitMonomorphism" ],
                             Range := [ rec( Conditions := "IsMonomorphism",
                                             PrintString := "mono",
                                             Adjective := true,
                                             NoSepString := true ) ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ "IsSplitEpimorphism" ],
                             Range := [ rec( Conditions := "IsEpimorphism",
                                             PrintString := "epi",
                                             Adjective := true,
                                             NoSepString := true ) ] ) );
    
    AddNodeToGraph( print_graph,
                    rec( Conditions := "IsZeroForMorphisms",
                         PrintString := "zero",
                         Adjective := true ) );
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph, -1 );
    
end );

#= comment for Julia
CAP_INTERNAL_CREATE_MORPHISM_PRINT( );
# =#
