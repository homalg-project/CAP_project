# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

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

Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsMonomorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsEpimorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsIsomorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsEndomorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsAutomorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsSplitMonomorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsSplitEpimorphism" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsOne" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsIdempotent" );
Add( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, "IsZero" );

######################################
##
## Operations
##
######################################

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
    if IsEqualForMorphisms( morphism_1, morphism_2 ) then
        
        return true;
        
    fi;
    
    return IsCongruentForMorphisms( morphism_1, morphism_2 );
    
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
InstallMethod( SetOfMorphisms,
        [ IsCapCategory ],
        
  function( cat )
    
    return SetOfMorphismsOfFiniteCategory( cat );
    
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
InstallMethod( ExtendRangeOfHomomorphismStructureByFullEmbedding,
               [ IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsFunction, IsFunction ],
  function ( C, E, object_function, morphism_function, object_function_inverse, morphism_function_inverse )
    
    # C has a D-homomorphism structure
    # object_function and morphism_function defined a full embedding ι: D → E
    # object_function_inverse and morphism_function_inverse define the inverse of ι on its image
    
    InstallMethodForCompilerForCAP( DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ) ],
      function ( C, E )
        
        return object_function( C, E, DistinguishedObjectOfHomomorphismStructure( C ) );
        
    end );
    
    InstallMethodForCompilerForCAP( HomomorphismStructureOnObjectsExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ), ObjectFilter( C ), ObjectFilter( C ) ],
      function ( C, E, a, b )
        
        return object_function( C, E, HomomorphismStructureOnObjects( C, a, b ) );
        
    end );
    
    InstallMethodForCompilerForCAP( HomomorphismStructureOnMorphismsExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ), MorphismFilter( C ), MorphismFilter( C ) ],
      function ( C, E, alpha, beta )
        local mor;
        
        mor := HomomorphismStructureOnMorphisms( C, alpha,  beta );
        
        return morphism_function( C, E, object_function( C, E, Source( mor ) ), mor, object_function( C, E, Range( mor ) ) );
        
    end );
    
    InstallMethodForCompilerForCAP( HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ), ObjectFilter( E ), MorphismFilter( C ), MorphismFilter( C ), ObjectFilter( E ) ],
      function ( C, E, s, alpha, beta, r )
        local mor;
        
        mor := HomomorphismStructureOnMorphismsWithGivenObjects( C, object_function_inverse( C, E, s ), alpha, beta, object_function_inverse( C, E, r ) );
        
        return morphism_function( C, E, s, mor, r );
        
    end );
    
    InstallMethodForCompilerForCAP( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ), MorphismFilter( C ) ],
      function ( C, E, alpha )
        local mor;
        
        mor := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( C, alpha );
        
        return morphism_function( C, E, object_function( C, E, Source( mor ) ), mor, object_function( C, E, Range( mor ) ) );
        
    end );
    
    InstallMethodForCompilerForCAP( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ), ObjectFilter( E ), MorphismFilter( C ), ObjectFilter( E ) ],
      function ( C, E, distinguished_object, alpha, r )
        local mor;
        
        mor := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( C, object_function_inverse( C, E, distinguished_object ), alpha, object_function_inverse( C, E, r ) );
        
        return morphism_function( C, E, distinguished_object, mor, r );
        
    end );
    
    InstallMethodForCompilerForCAP( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding,
                                    [ CategoryFilter( C ), CategoryFilter( E ), ObjectFilter( C ), ObjectFilter( C ), MorphismFilter( E ) ],
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

###################################
##
## Lift/Colift/SolveLinearSystemInAbCategory
##
###################################

##
InstallMethod( LiftOrFail,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function ( alpha, beta )
    
    return LiftOrFail( CapCategory( alpha ), alpha, beta );
    
end );

##
InstallOtherMethodForCompilerForCAP( LiftOrFail,
                                     [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                     
  function( cat, alpha, beta )
    
    if IsLiftable( cat, alpha, beta ) then
        
        return Lift( cat, alpha, beta );
        
    else
        
        return fail;
        
    fi;
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
    rec(
        LiftOrFail := [ [ "IsLiftable", 1 ], [ "Lift", 1 ] ],
    )
);

##
InstallMethod( ColiftOrFail,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function ( alpha, beta )
    
    return ColiftOrFail( CapCategory( alpha ), alpha, beta );
    
end );

##
InstallOtherMethodForCompilerForCAP( ColiftOrFail,
                                     [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                     
  function( cat, alpha, beta )
    
    if IsColiftable( cat, alpha, beta ) then
        
        return Colift( cat, alpha, beta );
        
    else
        
        return fail;
        
    fi;
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
    rec(
        ColiftOrFail := [ [ "IsColiftable", 1 ], [ "Colift", 1 ] ],
    )
);

##
InstallMethod( SolveLinearSystemInAbCategoryOrFail,
               [ IsList, IsList, IsList ],
               
  function ( left_coefficients, right_coefficients, right_side )
    
    return SolveLinearSystemInAbCategoryOrFail( CapCategory( right_side[1] ), left_coefficients, right_coefficients, right_side );
    
end );

##
InstallOtherMethodForCompilerForCAP( SolveLinearSystemInAbCategoryOrFail,
                                     [ IsCapCategory, IsList, IsList, IsList ],
                                     
  function( cat, left_coefficients, right_coefficients, right_side )
    
    if MereExistenceOfSolutionOfLinearSystemInAbCategory( cat, left_coefficients, right_coefficients, right_side ) then
        
        return SolveLinearSystemInAbCategory( cat, left_coefficients, right_coefficients, right_side );
        
    else
        
        return fail;
        
    fi;
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
    rec(
        SolveLinearSystemInAbCategoryOrFail := [ [ "MereExistenceOfSolutionOfLinearSystemInAbCategory", 1 ], [ "SolveLinearSystemInAbCategory", 1 ] ],
    )
);

##
InstallMethod( MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory,
        "for two lists",
        [ IsList, IsList ],
        
  function( left_coeffs, right_coeffs )
    
    return MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory( CapCategory( right_coeffs[1,1] ), left_coeffs, right_coeffs );
    
end );

##
InstallMethod( BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory,
        "for two lists",
        [ IsList, IsList ],
        
  function( left_coeffs, right_coeffs )
    
    return BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( CapCategory( right_coeffs[1, 1] ), left_coeffs, right_coeffs );
    
end );

##
InstallMethod( BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory,
        "for four lists",
        [ IsList, IsList, IsList, IsList ],
        
  function( alpha, beta, gamma, delta )
    
    return BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory(
                    CapCategory( delta[1, 1] ), alpha, beta, gamma, delta );
    
end );

##
InstallMethod( BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory,
        "for two lists",
        [ IsList, IsList ],

  function( alpha, delta )
    local cat, beta, gamma, i;
    
    cat := CapCategory( alpha[1][1] );
    
    beta := List( [ 1 .. Length( alpha ) ],
                i ->  List( [ 1 .. Length( delta[i] ) ],
                      function ( j )
                        local alpha_ij, delta_ij;

                        alpha_ij := alpha[i][j];
                        delta_ij := delta[i][j];

                        if IsEndomorphism( cat, delta_ij ) and not IsEqualToZeroMorphism( cat, alpha_ij ) then
                            return IdentityMorphism( cat, Source( delta_ij ) );
                        else
                            return ZeroMorphism( cat, Source( delta_ij ), Target( delta_ij ) );
                        fi;

                      end ) );
    
    gamma := List( [ 1 .. Length( alpha ) ],
                i ->  List( [ 1 .. Length( alpha[i] ) ],
                      function ( j )
                        local alpha_ij, delta_ij;

                        alpha_ij := alpha[i][j];
                        delta_ij := delta[i][j];

                        if IsEndomorphism( cat, alpha_ij ) and not IsEqualToZeroMorphism( cat, delta_ij ) then
                            return IdentityMorphism( cat, Source( alpha_ij ) );
                        else
                            return ZeroMorphism( cat, Source( alpha_ij ), Target( alpha_ij ) );
                        fi;

                      end ) );
    
    return BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory( cat, alpha, beta, gamma, delta );
    
end );
