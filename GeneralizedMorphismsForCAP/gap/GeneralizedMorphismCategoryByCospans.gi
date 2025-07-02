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
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS,
                       
  function( category )
    local entry, underlying_honest_category;
    
    underlying_honest_category := UnderlyingHonestCategory( category );
    
    AddIsEqualForObjects( category,
      
      function( cat, object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestCategory( cat ), UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( cat, morphism1, morphism2 )
        local honest_category, arrow_tuple, pullback_diagram1, pullback_diagram2, subobject1, subobject2;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        arrow_tuple := [ Arrow( morphism1 ), ReversedArrow( morphism1 ) ];
        
        pullback_diagram1 := [ ProjectionInFactorOfFiberProduct( honest_category, arrow_tuple, 1 ),
                               ProjectionInFactorOfFiberProduct( honest_category, arrow_tuple, 2 ) ];
        
        arrow_tuple := [ Arrow( morphism2 ), ReversedArrow( morphism2 ) ];
        
        pullback_diagram2 := [ ProjectionInFactorOfFiberProduct( honest_category, arrow_tuple, 1 ),
                               ProjectionInFactorOfFiberProduct( honest_category, arrow_tuple, 2 ) ];
        
        subobject1 := UniversalMorphismIntoDirectSum( honest_category, pullback_diagram1 );
        
        subobject2 := UniversalMorphismIntoDirectSum( honest_category, pullback_diagram2 );
        
        ## TODO: added more logic to make the following line obsolete
        Assert( 4, IsMonomorphism( subobject1 ) );
        SetIsMonomorphism( subobject1, true );
        
        Assert( 4, IsMonomorphism( subobject2 ) );
        SetIsMonomorphism( subobject2, true );
        
        return IsEqualAsSubobjects( honest_category, subobject1, subobject2 );
        
    end );
    
    
    ## PreCompose
    
    AddPreCompose( category,
                   
      function( cat, morphism1, morphism2 )
        local honest_category, pushout_diagram, injection_left, injection_right;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        pushout_diagram := [ ReversedArrow( morphism1 ), Arrow( morphism2 ) ];
        
        injection_left := InjectionOfCofactorOfPushout( honest_category, pushout_diagram, 1 );
        
        injection_right := InjectionOfCofactorOfPushout( honest_category, pushout_diagram, 2 );
        
        return GeneralizedMorphismByCospan( PreCompose( honest_category, Arrow( morphism1 ), injection_left ),
                                            PreCompose( honest_category, ReversedArrow( morphism2 ), injection_right ) );
        
    end );
    
    # the following optimizations probably do not fulfill the specification "equal input gives equal output", see https://github.com/homalg-project/CAP_project/issues/1669
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsReversedArrow, MorphismFilter( category ) and HasIdentityAsReversedArrow ],
                        
      function( cat, morphism1, morphism2 )
          local honest_category, arrow, reversed_arrow;

          honest_category := UnderlyingHonestCategory( cat );

          arrow := PreCompose( honest_category, Arrow( morphism1 ), Arrow( morphism2 ) );

          return AsGeneralizedMorphismByCospan( arrow );

    end );
    
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsReversedArrow, MorphismFilter( category ) ],
                        
      function( cat, morphism1, morphism2 )
          local honest_category, arrow;

          honest_category := UnderlyingHonestCategory( cat );

          arrow := PreCompose( honest_category, Arrow( morphism1 ), Arrow( morphism2 ) );

          return GeneralizedMorphismByCospan( arrow, ReversedArrow( morphism2 ) );

    end );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category,
                             
      function( cat, morphism1, morphism2 )
        local honest_category, pushout_diagram, pushout_left, pushout_right, arrow, reversed_arrow;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        pushout_diagram := [ ReversedArrow( morphism1 ), ReversedArrow( morphism2 ) ];
        
        pushout_left := InjectionOfCofactorOfPushout( honest_category, pushout_diagram, 1 );
        
        pushout_right := InjectionOfCofactorOfPushout( honest_category, pushout_diagram, 2 );
        
        arrow := AdditionForMorphisms( honest_category,
                                       PreCompose( honest_category, Arrow( morphism1 ), pushout_left ),
                                       PreCompose( honest_category, Arrow( morphism2 ), pushout_right ) );
        
        reversed_arrow := PreCompose( honest_category, pushout_diagram[ 1 ], pushout_left );
        
        return GeneralizedMorphismByCospan( arrow, reversed_arrow );
        
    end );
      
    AddAdditiveInverseForMorphisms( category,
                                    
      function( cat, morphism )
        
        return GeneralizedMorphismByCospan( AdditiveInverseForMorphisms( UnderlyingHonestCategory( cat ), Arrow( morphism ) ),
                                            ReversedArrow( morphism ) );
        
    end );
    
    AddZeroMorphism( category,
      
      function( cat, obj1, obj2 )
        local honest_category, morphism;
         
        honest_category := UnderlyingHonestCategory( cat );
          
        morphism := ZeroMorphism( honest_category, UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
        return AsGeneralizedMorphismByCospan( morphism );
        
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( cat, generalized_object )
        local honest_category, identity_morphism;
         
        honest_category := UnderlyingHonestCategory( cat );
          
        identity_morphism := IdentityMorphism( honest_category, UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismByCospan( identity_morphism );
        
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
    
    return;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( GeneralizedMorphismCategoryByCospans,
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
    
    name := Concatenation( "Generalized morphism category of ", name, " by cospan" );
    
    generalized_morphism_category := CreateCapCategoryWithDataTypes(
                                             name,
                                             IsGeneralizedMorphismCategoryByCospans,
                                             IsGeneralizedMorphismCategoryByCospansObject,
                                             IsGeneralizedMorphismByCospan and HasArrow and HasReversedArrow,
                                             IsCapCategoryTwoCell,
                                             fail,
                                             fail,
                                             fail );
    
    generalized_morphism_category!.predicate_logic := category!.predicate_logic;
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryByCospans );

    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS( generalized_morphism_category );
    
    AddPredicateImplicationFileToCategory( generalized_morphism_category,
      Filename(
        DirectoriesPackageLibrary( "GeneralizedMorphismsForCAP", "LogicForGeneralizedMorphismCategory" ),
        "PredicateImplicationsForGeneralizedMorphismCategory.tex" )
    );
    
    Finalize( generalized_morphism_category );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismByCospansObject,
               [ IsCapCategoryObject ],
                                       
  function( object )
    local generalized_category;
    
    generalized_category := GeneralizedMorphismCategoryByCospans( CapCategory( object ) );
    
    return CreateCapCategoryObjectWithAttributes( generalized_category,
                                                  UnderlyingHonestObject, object );
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismByCospan,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( arrow, reversed_arrow )
    local generalized_category;
    
    if not IsEqualForObjects( Range( arrow ), Range( reversed_arrow ) ) then
        
        Error( "Ranges of morphisms must coincide" );
        
    fi;
    
    generalized_category := GeneralizedMorphismCategoryByCospans( CapCategory( arrow ) );
    
    return CreateCapCategoryMorphismWithAttributes( generalized_category,
                                                    GeneralizedMorphismByCospansObject( Source( arrow ) ),
                                                    GeneralizedMorphismByCospansObject( Source( reversed_arrow ) ),
                                                    Arrow, arrow,
                                                    ReversedArrow, reversed_arrow );
    
end );

##
InstallMethod( AsGeneralizedMorphismByCospan,
               [ IsCapCategoryMorphism ],
               
  function( arrow )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphismByCospan( arrow, IdentityMorphism( Range( arrow ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    SetHasIdentityAsReversedArrow( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

####################################
##
## Constructors of lifts of exact functors
##
####################################

##
InstallMethod( AsGeneralizedMorphismByCospan,
        [ IsCapFunctor, IsString ],

  function( F, name )
    local A, B, gmcF;
    
    A := GeneralizedMorphismCategoryByCospans( SourceOfFunctor( F ) : FinalizeCategory := true );
    B := GeneralizedMorphismCategoryByCospans( RangeOfFunctor( F ) : FinalizeCategory := true );
    
    gmcF := CapFunctor( name, A, B );
    
    AddObjectFunction( gmcF,
            function( obj )
              return GeneralizedMorphismByCospansObject( ApplyFunctor( F, UnderlyingHonestObject( obj ) ) );
            end );
    
    AddMorphismFunction( gmcF,
            function( new_source, mor, new_range )
              return GeneralizedMorphismByCospan( ApplyFunctor( F, Arrow( mor ) ), ApplyFunctor( F, ReversedArrow( mor ) ) );
            end );
    
    return gmcF;
    
end );

##
InstallMethod( AsGeneralizedMorphismByCospan,
        [ IsCapFunctor ],

  function( F )
    local name;

    name := "GeneralizedMorphismByCospan version of ";
    name := Concatenation( name, Name( F ) );
    
    return AsGeneralizedMorphismByCospan( F, name );
    
end );

#################################
##
## Additional methods
##
#################################

InstallMethod( HasIdentityAsReversedArrow,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    local reversed_arrow;
    
    reversed_arrow := ReversedArrow( morphism );
    
    if not IsEqualForObjects( Source( reversed_arrow ), Range( reversed_arrow ) ) then
        
        return false;
        
    fi;
    
    return IsCongruentForMorphisms( reversed_arrow, IdentityMorphism( Source( reversed_arrow ) ) );
    
end );

InstallMethod( NormalizedCospanTuple,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    local arrow_tuple, pullback_diagram;
    
    arrow_tuple := [ Arrow( morphism ), ReversedArrow( morphism ) ];
    
    pullback_diagram := [ ProjectionInFactorOfFiberProduct( arrow_tuple, 1 ), ProjectionInFactorOfFiberProduct( arrow_tuple, 2 ) ];
    
    return [ InjectionOfCofactorOfPushout( pullback_diagram, 1 ), InjectionOfCofactorOfPushout( pullback_diagram, 2 ) ];
    
end );

InstallMethod( NormalizedCospan,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    
    return CallFuncList( GeneralizedMorphismByCospan, NormalizedCospanTuple( morphism ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    
    return GeneralizedMorphismByCospan( ReversedArrow( morphism ), Arrow( morphism ) );
    
end );

InstallMethod( GeneralizedInverseByCospan,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return GeneralizedMorphismByCospan( IdentityMorphism( Range( morphism ) ), morphism );
    
end );

InstallMethod( HonestRepresentative,
               [ IsGeneralizedMorphismByCospan ],
               
  function( generalized_morphism )
    local normalization;
    
    normalization := NormalizedCospanTuple( generalized_morphism );
    
    return PreCompose( normalization[ 1 ], Inverse( normalization[ 2 ] ) );
    
end );

##
InstallMethod( HasFullCodomain,
               [ IsGeneralizedMorphismByCospan ],
               
  function( generalized_morphism )
    
    return IsMonomorphism( ReversedArrow( generalized_morphism ) );
    
end );

##
InstallMethod( HasFullDomain,
               [ IsGeneralizedMorphismByCospan ],
               
  function( generalized_morphism )
    local cokernel_projection;
    
    cokernel_projection := CokernelProjection( ReversedArrow( generalized_morphism ) );
    
    return IsZeroForMorphisms( PreCompose( Arrow( generalized_morphism ), cokernel_projection ) );
    
end );

InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobjectByCospan,
                              [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                
  function( factor, subobject )
    local pushout_diagram;
    
    factor := AsGeneralizedMorphismByCospan( factor );
    
    subobject := AsGeneralizedMorphismByCospan( subobject );
    
    return PreCompose( PseudoInverse( factor ), PseudoInverse( subobject ) );
    
end );

InstallMethod( IdempotentDefinedBySubobjectByCospan,
              [ IsCapCategoryMorphism ],
              
  function( subobject )
    local generalized;
    
    generalized := AsGeneralizedMorphismByCospan( subobject );
    
    return PreCompose( PseudoInverse( generalized ), generalized );
    
end );

InstallMethod( IdempotentDefinedByFactorobjectByCospan,
              [ IsCapCategoryMorphism ],
              
  function( factorobject )
    
    return GeneralizedMorphismByCospan( factorobject, factorobject );
    
end );

InstallMethod( GeneralizedInverseByCospan,
              [ IsCapCategoryMorphism ],
              
  function( morphism )
    
    return PseudoInverse( AsGeneralizedMorphismByCospan( morphism ) );
    
end );

##
InstallMethodWithCacheFromObject( CommonCoastrictionOp,
                                  [ IsList, IsGeneralizedMorphismByCospan ],
               
  function( morphism_list, method_selection_object )
    local arrow_list, reversedarrow_list, i, j, current_pushout_left, current_pushout_right, test_source;
    
    if not ForAll( morphism_list, IsGeneralizedMorphismByCospan ) then
        TryNextMethod();
    fi;
    
    if Length( morphism_list ) = 1 then
        return morphism_list;
    fi;
    
    test_source := Range( morphism_list[ 1 ] );
    
    if not ForAll( [ 2 .. Length( morphism_list ) ], i -> IsEqualForObjects( test_source, Range( morphism_list[ i ] ) ) ) then
        Error( "not all ranges are equal" );
    fi;
    
    arrow_list := List( morphism_list, Arrow );
    reversedarrow_list := List( morphism_list, ReversedArrow );
    
    for i in [ 2  .. Length( morphism_list ) ] do
        current_pushout_left := InjectionOfCofactorOfPushout( [ reversedarrow_list[ i - 1 ], reversedarrow_list[ i ] ], 1 );
        current_pushout_right := InjectionOfCofactorOfPushout( [ reversedarrow_list[ i - 1 ], reversedarrow_list[ i ] ], 2 );
        
        for j in [ 1 .. i - 1 ] do
            
            arrow_list[ j ] := PreCompose( arrow_list[ j ], current_pushout_left );
            reversedarrow_list[ j ] := PreCompose( reversedarrow_list[ j ], current_pushout_left );
            
        od;
        
        arrow_list[ i ] := PreCompose( arrow_list[ i ], current_pushout_right );
        reversedarrow_list[ i ] := PreCompose( reversedarrow_list[ i ], current_pushout_right );
        
    od;
    
    return List( [ 1 .. Length( morphism_list ) ], i -> GeneralizedMorphismByCospan( arrow_list[ i ], reversedarrow_list[ i ] ) );
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ConcatenationProductOp,
                                  [ IsList, IsGeneralizedMorphismByCospan ],
               
  function( generalized_morphism_list, method_selection_object )
    
    return GeneralizedMorphismByCospan( DirectSumFunctorial( List( generalized_morphism_list, Arrow ) ),
                                        DirectSumFunctorial( List( generalized_morphism_list, ReversedArrow ) ) );
    
end : ArgumentNumber := 2 );

######################################
##
## Compatibility
##
######################################

InstallMethod( GeneralizedMorphismByCospan,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( source_aid, morphism_aid, range_aid )
    local morphism1, morphism2;
    
    morphism1 := PseudoInverse( AsGeneralizedMorphismByCospan( source_aid ) );
    
    morphism2 := GeneralizedMorphismByCospan( morphism_aid, range_aid );
    
    return PreCompose( morphism1, morphism2 );
    
end );

InstallMethodWithCacheFromObject( DomainAssociatedMorphismCodomainTriple,
                                  [ IsGeneralizedMorphismByCospan ],
                                  
  function( morphism )
    local three_arrow;
    
    three_arrow := GeneralizedMorphismByThreeArrowsWithRangeAid( Arrow( morphism ), ReversedArrow( morphism ) );
    
    return DomainAssociatedMorphismCodomainTriple( three_arrow );
    
end );

InstallMethod( GeneralizedMorphismByCospanWithSourceAid,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( source_aid, morphism_aid )
    local morphism1, morphism2;
    
    morphism1 := GeneralizedInverseByCospan( source_aid );
    
    morphism2 := AsGeneralizedMorphismByCospan( morphism_aid );
    
    return PreCompose( morphism1, morphism2 );
    
end );
    
