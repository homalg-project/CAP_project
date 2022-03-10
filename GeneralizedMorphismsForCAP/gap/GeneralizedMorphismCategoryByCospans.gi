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
    
    ##
    AddIsEqualForCacheForObjects( category, IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category, IsIdenticalObj );
    
    AddIsEqualForObjects( category,
      
      function( object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( morphism1, morphism2 )
        local arrow_tuple, pullback_diagram1, pullback_diagram2, subobject1, subobject2;
        
        arrow_tuple := [ Arrow( morphism1 ), ReversedArrow( morphism1 ) ];
        
        pullback_diagram1 := [ ProjectionInFactorOfFiberProduct( arrow_tuple, 1 ), ProjectionInFactorOfFiberProduct( arrow_tuple, 2 ) ];
        
        arrow_tuple := [ Arrow( morphism2 ), ReversedArrow( morphism2 ) ];
        
        pullback_diagram2 := [ ProjectionInFactorOfFiberProduct( arrow_tuple, 1 ), ProjectionInFactorOfFiberProduct( arrow_tuple, 2 ) ];
        
        subobject1 := UniversalMorphismIntoDirectSum( pullback_diagram1 );
        
        subobject2 := UniversalMorphismIntoDirectSum( pullback_diagram2 );
        
        ## TODO: added more logic to make the following line obsolete
        Assert( 4, IsMonomorphism( subobject1 ) );
        SetIsMonomorphism( subobject1, true );
        
        Assert( 4, IsMonomorphism( subobject2 ) );
        SetIsMonomorphism( subobject2, true );
        
        return IsEqualAsSubobjects( subobject1, subobject2 );
        
    end );
    
    ## PreCompose
    
    
    AddPreCompose( category, [
      
      [ function( morphism1, morphism2 )
          local pushout_diagram, injection_left, injection_right;
          
          pushout_diagram := [ ReversedArrow( morphism1 ), Arrow( morphism2 ) ];
          
          injection_left := InjectionOfCofactorOfPushout( pushout_diagram, 1 );
          
          injection_right := InjectionOfCofactorOfPushout( pushout_diagram, 2 );
          
          return GeneralizedMorphismByCospan( PreCompose( Arrow( morphism1 ), injection_left ), PreCompose( ReversedArrow( morphism2 ), injection_right ) );
          
      end, [ ] ],
      
      [ function( morphism1, morphism2 )
          local arrow, reversed_arrow;
          
          arrow := PreCompose( Arrow( morphism1 ), Arrow( morphism2 ) );
          
          return AsGeneralizedMorphismByCospan( arrow );
          
      end, [ HasIdentityAsReversedArrow, HasIdentityAsReversedArrow ] ],
      
      [ function( morphism1, morphism2 )
          local arrow;
          
          arrow := PreCompose( Arrow( morphism1 ), Arrow( morphism2 ) );
          
          return GeneralizedMorphismByCospan( arrow, ReversedArrow( morphism2 ) );
          
      end, [ HasIdentityAsReversedArrow, ] ] ] );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category, [
                             
      [ function( morphism1, morphism2 )
          local pushout_diagram, pushout_left, pushout_right, arrow, reversed_arrow;
          
          pushout_diagram := [ ReversedArrow( morphism1 ), ReversedArrow( morphism2 ) ];
          
          pushout_left := InjectionOfCofactorOfPushout( pushout_diagram, 1 );
          
          pushout_right := InjectionOfCofactorOfPushout( pushout_diagram, 2 );
          
          arrow := AdditionForMorphisms( PreCompose( Arrow( morphism1 ), pushout_left ), PreCompose( Arrow( morphism2 ), pushout_right ) );
          
          reversed_arrow := PreCompose( pushout_diagram[ 1 ], pushout_left );
          
          return GeneralizedMorphismByCospan( arrow, reversed_arrow );
          
      end, [ ] ],
      
      [ function( morphism1, morphism2 )
          
          return AsGeneralizedMorphismByCospan( AdditionForMorphisms( Arrow( morphism1 ),  Arrow( morphism2 ) ) );
          
      end, [ HasIdentityAsReversedArrow, HasIdentityAsReversedArrow ] ] ] );
      
    AddAdditiveInverseForMorphisms( category, [
                                    
      [ function( morphism )
           
         return GeneralizedMorphismByCospan( AdditiveInverseForMorphisms( Arrow( morphism ) ), ReversedArrow( morphism ) );
         
      end, [ ] ],
      
      [ function( morphism )
          
          return AsGeneralizedMorphismByCospan( AdditiveInverseForMorphisms( Arrow( morphism ) ) );
          
      end, [ HasIdentityAsReversedArrow ] ] ] );
    
    AddZeroMorphism( category,
      
      function( obj1, obj2 )
        local morphism;
        
        morphism := ZeroMorphism( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
        return AsGeneralizedMorphismByCospan( morphism );
        
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( generalized_object )
        local identity_morphism;
        
        identity_morphism := IdentityMorphism( UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismByCospan( identity_morphism );
        
    end );
    
    if CurrentOperationWeight( underlying_honest_category!.derivations_weight_list, "IsWellDefinedForObjects" ) < infinity then
        
        AddIsWellDefinedForObjects( category,
          
          function( object )
              
              return IsWellDefined( UnderlyingHonestObject( object ) );
              
          end );
          
    fi;
    
    if CurrentOperationWeight( underlying_honest_category!.derivations_weight_list, "IsWellDefinedForMorphisms" ) < infinity then
        
        AddIsWellDefinedForMorphisms( category,
                                      
          function( generalized_morphism )
            local category;
            
            category := CapCategory( Arrow( generalized_morphism ) );
            
            if not ForAll( [ Arrow( generalized_morphism ), ReversedArrow( generalized_morphism ) ],
                        x -> IsIdenticalObj( CapCategory( x ), category ) ) then
              
              return false;
              
            fi;
            
            if not ( ForAll( [ Arrow( generalized_morphism ), ReversedArrow( generalized_morphism ) ],
                    IsWellDefined ) ) then
              
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
    local name, generalized_morphism_category, category_weight_list, i, preconditions;
    
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
    
    category_weight_list := category!.derivations_weight_list;
    
    for i in preconditions do
        
        if CurrentOperationWeight( category_weight_list, i ) = infinity then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "Generalized morphism category of ", name, " by cospan" );
    
    generalized_morphism_category := CreateCapCategory( name );
    
    AddObjectRepresentation( generalized_morphism_category, IsGeneralizedMorphismCategoryByCospansObject );
    
    AddMorphismRepresentation( generalized_morphism_category, IsGeneralizedMorphismByCospan and HasArrow and HasReversedArrow );
    
    generalized_morphism_category!.predicate_logic := category!.predicate_logic;
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryByCospans );
    
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
    
    return ObjectifyObjectForCAPWithAttributes( rec( ), generalized_category,
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
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), generalized_category,
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
    
    A := GeneralizedMorphismCategoryByCospans( AsCapCategory( Source( F ) ) : FinalizeCategory := true );
    B := GeneralizedMorphismCategoryByCospans( AsCapCategory( Range( F ) ) : FinalizeCategory := true );
    
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
    
