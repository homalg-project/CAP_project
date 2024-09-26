# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

####################################
##
## Installer
##
####################################

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_SPANS,
                       
  function( category )
    local entry, underlying_honest_category;
    
    underlying_honest_category := UnderlyingHonestCategory( category );
    
    AddIsEqualForObjects( category,
      
      function( cat, object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestCategory( cat ), UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( cat, morphism1, morphism2 )
        local honest_category, arrow_tuple, pushout_diagram1, pushout_diagram2, factorobject1, factorobject2;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        arrow_tuple := [ Arrow( morphism1 ), ReversedArrow( morphism1 ) ];
        
        pushout_diagram1 := [ InjectionOfCofactorOfPushout( honest_category, arrow_tuple, 1 ),
                              InjectionOfCofactorOfPushout( honest_category, arrow_tuple, 2 ) ];
        
        arrow_tuple := [ Arrow( morphism2 ), ReversedArrow( morphism2 ) ];
        
        pushout_diagram2 := [ InjectionOfCofactorOfPushout( honest_category, arrow_tuple, 1 ),
                              InjectionOfCofactorOfPushout( honest_category, arrow_tuple, 2 ) ];
        
        factorobject1 := UniversalMorphismFromDirectSum( honest_category, pushout_diagram1 );
        
        factorobject2 := UniversalMorphismFromDirectSum( honest_category, pushout_diagram2 );
        
        return IsEqualAsFactorobjects( honest_category, factorobject1, factorobject2 );
        
    end );
    
    ## PreCompose
    
    
    AddPreCompose( category,
                   
      function( cat, morphism1, morphism2 )
        local honest_category, pullback_diagram, projection_left, projection_right;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        pullback_diagram := [ Arrow( morphism1 ), ReversedArrow( morphism2 ) ];
        
        projection_left := ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 1 );
        
        projection_right := ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 2 );
        
        return GeneralizedMorphismBySpan( PreCompose( honest_category, projection_left, ReversedArrow( morphism1 ) ),
                                          PreCompose( projection_right, Arrow( morphism2 ) ) );
        
    end );
    
    # the following optimizations probably do not fulfill the specification "equal input gives equal output", see https://github.com/homalg-project/CAP_project/issues/1669
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsReversedArrow, MorphismFilter( category ) and HasIdentityAsReversedArrow ],
                        
      function( cat, morphism1, morphism2 )
          local honest_category, arrow;

          honest_category := UnderlyingHonestCategory( cat );

          arrow := PreCompose( honest_category, Arrow( morphism1 ), Arrow( morphism2 ) );

          return AsGeneralizedMorphismBySpan( arrow );

    end );
    
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ), MorphismFilter( category ) and HasIdentityAsReversedArrow ],
                        
      function( cat, morphism1, morphism2 )
          local honest_category, arrow;

          honest_category := UnderlyingHonestCategory( cat );

          arrow := PreCompose( honest_category, Arrow( morphism1 ), Arrow( morphism2 ) );

          return GeneralizedMorphismBySpan( ReversedArrow( morphism1 ), arrow );

    end );
    

    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category,
                             
      function( cat, morphism1, morphism2 )
        local honest_category, pullback_diagram, pullback_left, pullback_right, arrow, reversed_arrow;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        pullback_diagram := [ ReversedArrow( morphism1 ), ReversedArrow( morphism2 ) ];
        
        pullback_left := ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 1 );
        
        pullback_right := ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 2 );
        
        arrow := AdditionForMorphisms( honest_category,
                                       PreCompose( honest_category, pullback_left, Arrow( morphism1 ) ),
                                       PreCompose( honest_category, pullback_right, Arrow( morphism2 ) ) );
        
        reversed_arrow := PreCompose( honest_category, pullback_left, pullback_diagram[ 1 ] );
        
        return GeneralizedMorphismBySpan( reversed_arrow, arrow );
        
    end );
      
    AddAdditiveInverseForMorphisms( category,
                                    
      function( cat, morphism )
        
        return GeneralizedMorphismBySpan( ReversedArrow( morphism ),
                                          AdditiveInverseForMorphisms( UnderlyingHonestCategory( cat ), Arrow( morphism ) ) );
        
    end );
    
    AddZeroMorphism( category,
      
      function( cat, obj1, obj2 )
        local honest_category, morphism;
        
        honest_category := UnderlyingHonestCategory( cat );
          
        morphism := ZeroMorphism( honest_category, UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
        return AsGeneralizedMorphismBySpan( morphism );
        
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( cat, generalized_object )
        local honest_category, identity_morphism;
        
        honest_category := UnderlyingHonestCategory( cat );
          
        identity_morphism := IdentityMorphism( honest_category, UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismBySpan( identity_morphism );
        
    end );
    
    if CanCompute( underlying_honest_category, "IsWellDefinedForObjects" ) then
        
        AddIsWellDefinedForObjects( category,
          
          function( cat, object )
              
              return IsWellDefinedForObjects( UnderlyingHonestCategory( cat ), UnderlyingHonestObject( object ) );
              
          end );
          
    fi;
    
    if CanCompute( underlying_honest_category, "IsWellDefinedForMorphisms" ) then
        
        AddIsWellDefinedForMorphisms( category,
                                      
          function( cat, generalized_morphism )
            local honest_category;
            
            honest_category := UnderlyingHonestCategory( cat );
          
            if not ForAll( [ Arrow( generalized_morphism ), ReversedArrow( generalized_morphism ) ],
                        x -> IsIdenticalObj( CapCategory( x ), honest_category ) ) then
              
              return false;
              
            fi;
            
            if not ( ForAll( [ Arrow( generalized_morphism ), ReversedArrow( generalized_morphism ) ],
                    IsWellDefinedForMorphisms ) ) then
              
              return false;
              
            fi;
            
            return true;
            
        end );
        
    fi;
    
    
    ## Additional method for a category, when generalized morphism category is present.
    
    return;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( GeneralizedMorphismCategoryBySpans,
               [ IsCapCategory ],
               
  function( category )
    local name, generalized_morphism_category, i, preconditions;
    
    if not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        
        return;
        
    elif not ( HasIsAbelianCategory( category ) and IsAbelianCategory( category ) ) then
        
        Error( "the category must be abelian" );
        
        return;
      
    fi;
    
    preconditions := [ "IsEqualAsSubobjects",
                       "IsEqualAsFactorobjects",
                       "LiftAlongMonomorphism",
                       "ColiftAlongEpimorphism",
                       "PreCompose",
                       "IdentityMorphism",
                       "FiberProduct",
                       "Pushout",
                       "ProjectionInFactorOfFiberProduct",
                       "InjectionOfCofactorOfPushout",
                       "AdditionForMorphisms",
                       "CoastrictionToImage",
                       "ImageEmbedding" ];
    
    for i in preconditions do
        
        if not CanCompute( category, i ) then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "Generalized morphism category of ", name, " by span" );
    
    generalized_morphism_category := CreateCapCategoryWithDataTypes(
                                             name,
                                             IsGeneralizedMorphismCategoryBySpans,
                                             IsGeneralizedMorphismCategoryBySpansObject,
                                             IsGeneralizedMorphismBySpan and HasArrow and HasReversedArrow,
                                             IsCapCategoryTwoCell,
                                             fail,
                                             fail,
                                             fail );
    
    generalized_morphism_category!.predicate_logic := category!.predicate_logic;
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryBySpans );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_SPANS( generalized_morphism_category );
    
    AddPredicateImplicationFileToCategory( generalized_morphism_category,
      Filename(
        DirectoriesPackageLibrary( "GeneralizedMorphismsForCAP", "LogicForGeneralizedMorphismCategory" ),
        "PredicateImplicationsForGeneralizedMorphismCategory.tex" )
    );
    
    Finalize( generalized_morphism_category );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismBySpansObject,
               [ IsCapCategoryObject ],
                                       
  function( object )
    local generalized_category;
    
    generalized_category := GeneralizedMorphismCategoryBySpans( CapCategory( object ) );
    
    return CreateCapCategoryObjectWithAttributes( generalized_category,
                                                  UnderlyingHonestObject, object );
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismBySpan,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( reversed_arrow, arrow )
    local generalized_category;
    
    if not IsEqualForObjects( Source( arrow ), Source( reversed_arrow ) ) then
        
        Error( "Sources of morphisms must coincide" );
        
    fi;
    
    generalized_category := GeneralizedMorphismCategoryBySpans( CapCategory( arrow ) );
    
    return CreateCapCategoryMorphismWithAttributes( generalized_category,
                                                    GeneralizedMorphismBySpansObject( Range( reversed_arrow ) ),
                                                    GeneralizedMorphismBySpansObject( Range( arrow ) ),
                                                    Arrow, arrow,
                                                    ReversedArrow, reversed_arrow );
    
end );

##
InstallMethod( AsGeneralizedMorphismBySpan,
               [ IsCapCategoryMorphism ],
               
  function( arrow )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphismBySpan( IdentityMorphism( Source( arrow ) ), arrow );
    
    SetIsHonest( generalized_morphism, true );
    
    SetHasIdentityAsReversedArrow( generalized_morphism, true );
    
    SetHonestRepresentative( generalized_morphism, arrow );
    
    return generalized_morphism;
    
end );

#################################
##
## Additional methods
##
#################################

InstallMethod( HasIdentityAsReversedArrow,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    local reversed_arrow;
    
    reversed_arrow := ReversedArrow( morphism );
    
    if not IsEqualForObjects( Source( reversed_arrow ), Range( reversed_arrow ) ) then
        
        return false;
        
    fi;
    
    return IsCongruentForMorphisms( reversed_arrow, IdentityMorphism( Source( reversed_arrow ) ) );
    
end );

InstallMethod( NormalizedSpanTuple,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    local arrow_tuple, pushout_diagram;
    
    arrow_tuple := [ ReversedArrow( morphism ), Arrow( morphism ) ];
    
    pushout_diagram := [ InjectionOfCofactorOfPushout( arrow_tuple, 1 ), InjectionOfCofactorOfPushout( arrow_tuple, 2 ) ];
    
    return [ ProjectionInFactorOfFiberProduct( pushout_diagram, 1 ), ProjectionInFactorOfFiberProduct( pushout_diagram, 2 ) ];
    
end );

InstallMethod( NormalizedSpan,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    
    return CallFuncList( GeneralizedMorphismBySpan, NormalizedSpanTuple( morphism ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    
    return GeneralizedMorphismBySpan( Arrow( morphism ), ReversedArrow( morphism ) );
    
end );

InstallMethod( GeneralizedInverseBySpan,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return GeneralizedMorphismBySpan( morphism, IdentityMorphism( Source( morphism ) ) );
    
end );

InstallMethod( HonestRepresentative,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    local normalization;
    
    normalization := NormalizedSpanTuple( morphism );
    
    return PreCompose( Inverse( normalization[ 1 ] ), normalization[ 2 ] );
    
end );

##
InstallMethod( HasFullDomain,
               [ IsGeneralizedMorphismBySpan ],
               
  function( generalized_morphism )
    
    return IsEpimorphism( ReversedArrow( generalized_morphism ) );
    
end );

##
InstallMethod( HasFullCodomain,
               [ IsGeneralizedMorphismBySpan ],
               
  function( generalized_morphism )
    local kernel_embedding;
    
    kernel_embedding := KernelEmbedding( ReversedArrow( generalized_morphism ) );
    
    return IsZeroForMorphisms( PreCompose( kernel_embedding, Arrow( generalized_morphism ) ) );
    
end );

InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobjectBySpan,
                              [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                
  function( factor, subobject )
    local pushout_diagram;
    
    factor := AsGeneralizedMorphismBySpan( factor );
    
    subobject := AsGeneralizedMorphismBySpan( subobject );
    
    return PreCompose( PseudoInverse( factor ), PseudoInverse( subobject ) );
    
end );

InstallMethod( IdempotentDefinedBySubobjectBySpan,
              [ IsCapCategoryMorphism ],
              
  function( subobject )
    
    return GeneralizedMorphismBySpan( subobject, subobject );
    
end );

InstallMethod( IdempotentDefinedByFactorobjectBySpan,
              [ IsCapCategoryMorphism ],
              
  function( factorobject )
    local generalized;
    
    generalized := AsGeneralizedMorphismBySpan( factorobject );
    
    return PreCompose( generalized, PseudoInverse( generalized ) );
    
end );

InstallMethod( GeneralizedInverseBySpan,
              [ IsCapCategoryMorphism ],
              
  function( morphism )
    
    return PseudoInverse( AsGeneralizedMorphismBySpan( morphism ) );
    
end );

##
InstallMethodWithCacheFromObject( CommonRestrictionOp,
                                  [ IsList, IsGeneralizedMorphismBySpan ],
               
  function( morphism_list, method_selection_object )
    local arrow_list, reversedarrow_list, i, j, current_pullback_left, current_pullback_right, test_source;
    
    if not ForAll( morphism_list, IsGeneralizedMorphismBySpan ) then
        TryNextMethod();
    fi;
    
    if Length( morphism_list ) = 1 then
        return morphism_list;
    fi;
    
    test_source := Source( morphism_list[ 1 ] );
    
    if not ForAll( [ 2 .. Length( morphism_list ) ], i -> IsEqualForObjects( test_source, Source( morphism_list[ i ] ) ) ) then
        Error( "not all sources are equal" );
    fi;
    
    arrow_list := List( morphism_list, Arrow );
    reversedarrow_list := List( morphism_list, ReversedArrow );
    
    for i in [ 2  .. Length( morphism_list ) ] do
        current_pullback_left := ProjectionInFactorOfFiberProduct( [ reversedarrow_list[ i - 1 ], reversedarrow_list[ i ] ], 1 );
        current_pullback_right := ProjectionInFactorOfFiberProduct( [ reversedarrow_list[ i - 1 ], reversedarrow_list[ i ] ], 2 );
        
        for j in [ 1 .. i - 1 ] do
            
            arrow_list[ j ] := PreCompose( current_pullback_left, arrow_list[ j ] );
            reversedarrow_list[ j ] := PreCompose( current_pullback_left, reversedarrow_list[ j ] );
            
        od;
        
        arrow_list[ i ] := PreCompose( current_pullback_right, arrow_list[ i ] );
        reversedarrow_list[ i ] := PreCompose( current_pullback_right, reversedarrow_list[ i ] );
        
    od;
    
    return List( [ 1 .. Length( morphism_list ) ], i -> GeneralizedMorphismBySpan( reversedarrow_list[ i ], arrow_list[ i ] ) );
    
end : ArgumentNumber := 2 );

##
InstallMethod( GeneralizedImageEmbedding,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    
    return ImageEmbedding( Arrow( morphism ) );
    
end );

##
InstallMethodWithCacheFromObject( ConcatenationProductOp,
                                  [ IsList, IsGeneralizedMorphismBySpan ],
               
  function( generalized_morphism_list, method_selection_object )
    
    return GeneralizedMorphismBySpan( DirectSumFunctorial( List( generalized_morphism_list, ReversedArrow ) ),
                                      DirectSumFunctorial( List( generalized_morphism_list, Arrow ) ) );
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ConcatenationProductOp,
                                  [ IsList, IsGeneralizedMorphismBySpan ],
               
  function( generalized_morphism_list, method_selection_object )
    
    return GeneralizedMorphismBySpan( DirectSumFunctorial( List( generalized_morphism_list, ReversedArrow ) ),
                                      DirectSumFunctorial( List( generalized_morphism_list, Arrow ) ) );
    
end : ArgumentNumber := 2 );

######################################
##
## Compatibility
##
######################################

InstallMethod( GeneralizedMorphismBySpan,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( source_aid, morphism_aid, range_aid )
    local morphism1, morphism2;
    
    morphism1 := PseudoInverse( AsGeneralizedMorphismBySpan( range_aid ) );
    
    morphism2 := GeneralizedMorphismBySpan( source_aid, morphism_aid );
    
    return PreCompose( morphism1, morphism2 );
    
end );

InstallMethodWithCacheFromObject( DomainAssociatedMorphismCodomainTriple,
                                  [ IsGeneralizedMorphismBySpan ],
                                  
  function( morphism )
    local three_arrow;
    
    three_arrow := GeneralizedMorphismByThreeArrowsWithSourceAid( ReversedArrow( morphism ), Arrow( morphism ) );
    
    return DomainAssociatedMorphismCodomainTriple( three_arrow );
    
end );

InstallMethod( GeneralizedMorphismBySpanWithRangeAid,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_aid, range_aid )
    local morphism1, morphism2;
    
    morphism1 := GeneralizedInverseBySpan( range_aid );
    
    morphism2 := AsGeneralizedMorphismBySpan( morphism_aid );
    
    return PreCompose( morphism2, morphism1 );
    
end );
    
