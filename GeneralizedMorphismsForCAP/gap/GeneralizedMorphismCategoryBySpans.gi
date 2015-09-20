#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGeneralizedMorphismCategoryBySpansObjectRep",
                       IsCapCategoryObjectRep and IsGeneralizedMorphismCategoryBySpansObject,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismCategoryBySpansObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsGeneralizedMorphismCategoryBySpansObjectRep ) );

DeclareRepresentation( "IsGeneralizedMorphismBySpanRep",
                       IsCapCategoryMorphismRep and IsGeneralizedMorphismBySpan,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismBySpan",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsGeneralizedMorphismBySpanRep ) );

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
      
      function( object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( morphism1, morphism2 )
        local arrow_tuple, pushout_diagram1, pushout_diagram2, factorobject1, factorobject2;
        
        arrow_tuple := [ Arrow( morphism1 ), ReversedArrow( morphism1 ) ];
        
        pushout_diagram1 := [ InjectionOfCofactorOfPushout( arrow_tuple, 1 ), InjectionOfCofactorOfPushout( arrow_tuple, 2 ) ];
        
        arrow_tuple := [ Arrow( morphism2 ), ReversedArrow( morphism2 ) ];
        
        pushout_diagram2 := [ InjectionOfCofactorOfPushout( arrow_tuple, 1 ), InjectionOfCofactorOfPushout( arrow_tuple, 2 ) ];
        
        factorobject1 := UniversalMorphismFromDirectSum( pushout_diagram1 );
        
        factorobject2 := UniversalMorphismFromDirectSum( pushout_diagram2 );
        
        return IsEqualAsFactorobjects( factorobject1, factorobject2 );
        
    end );
    
    ## PreCompose
    
    
    AddPreCompose( category, [
      
      [ function( morphism1, morphism2 )
          local pullback_diagram, projection_left, projection_right;
          
          pullback_diagram := [ Arrow( morphism1 ), ReversedArrow( morphism2 ) ];
          
          projection_left := ProjectionInFactorOfFiberProduct( pullback_diagram, 1 );
          
          projection_right := ProjectionInFactorOfFiberProduct( pullback_diagram, 2 );
          
          return GeneralizedMorphismBySpan( PreCompose( projection_left, ReversedArrow( morphism1 ) ), PreCompose( projection_right, Arrow( morphism2 ) ) );
          
      end, [ ] ],
      
      [ function( morphism1, morphism2 )
          local arrow;
          
          arrow := PreCompose( Arrow( morphism1 ), Arrow( morphism2 ) );
          
          return AsGeneralizedMorphismBySpan( arrow );
          
      end, [ HasIdentityAsReversedArrow, HasIdentityAsReversedArrow ] ],
      
      [ function( morphism1, morphism2 )
          local arrow;
          
          arrow := PreCompose( Arrow( morphism1 ), Arrow( morphism2 ) );
          
          return GeneralizedMorphismBySpan( ReversedArrow( morphism1 ), arrow );
          
      end, [ , HasIdentityAsReversedArrow ] ] ] );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category, [
                             
      [ function( morphism1, morphism2 )
          local pullback_diagram, pullback_left, pullback_right, arrow, reversed_arrow;
          
          pullback_diagram := [ ReversedArrow( morphism1 ), ReversedArrow( morphism2 ) ];
          
          pullback_left := ProjectionInFactorOfFiberProduct( pullback_diagram, 1 );
          
          pullback_right := ProjectionInFactorOfFiberProduct( pullback_diagram, 2 );
          
          arrow := PreCompose( pullback_left, Arrow( morphism1 ) ) + PreCompose( pullback_right, Arrow( morphism2 ) );
          
          reversed_arrow := PreCompose( pullback_left, pullback_diagram[ 1 ] );
          
          return GeneralizedMorphismBySpan( arrow, reversed_arrow );
          
      end, [ ] ],
      
      [ function( morphism1, morphism2 )
          
          return AsGeneralizedMorphismBySpan( Arrow( morphism1 ) + Arrow( morphism2 ) );
          
      end, [ HasIdentityAsReversedArrow, HasIdentityAsReversedArrow ] ] ] );
      
    AddAdditiveInverseForMorphisms( category, [
                                    
      [ function( morphism )
           
         return GeneralizedMorphismBySpan( - Arrow( morphism ), ReversedArrow( morphism ) );
         
      end, [ ] ],
      
      [ function( morphism )
          
          return AsGeneralizedMorphismBySpan( - Arrow( morphism ) );
          
      end, [ HasIdentityAsReversedArrow ] ] ] );
    
    AddZeroMorphism( category,
      
      function( obj1, obj2 )
        local morphism;
        
        morphism := ZeroMorphism( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
        return AsGeneralizedMorphismBySpan( morphism );
        
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( generalized_object )
        local identity_morphism;
        
        identity_morphism := IdentityMorphism( UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismBySpan( identity_morphism );
        
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
    
    
    ## Additional method for a category, when generalized morphism category is present.
    
    InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobjectBySpan,
                                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ),
                                    IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                                    
      function( factor, subobject )
        local pushout_diagram;
        
        factor := AsGeneralizedMorphismBySpan( factor );
        
        subobject := AsGeneralizedMorphismBySpan( subobject );
        
        return PreCompose( PseudoInverse( factor ), PseudoInverse( subobject ) );
        
    end );
    
    InstallMethod( IdempotentDefinedBySubobjectBySpan,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( subobject )
        
        return GeneralizedMorphismBySpan( subobject, subobject );
        
    end );
    
    InstallMethod( IdempotentDefinedByFactorobjectBySpan,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( factorobject )
        local generalized;
        
        generalized := AsGeneralizedMorphismBySpan( factorobject );
        
        return PreCompose( PseudoInverse( factorobject ), factorobject );
        
    end );
    
    InstallMethod( GeneralizedInverseBySpan,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( morphism )
        
        return PseudoInverse( AsGeneralizedMorphismBySpan( morphism ) );
        
    end );
    
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
    local name, generalized_morphism_category, category_weight_list, i, preconditions;
    
    if not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        
        return;
        
    elif not IsAbelianCategory( category ) then
        
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
    
    name := Concatenation( "Generalized morphism category of ", name, " by span" );
    
    generalized_morphism_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_SPANS( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryBySpans );
    
    Finalize( generalized_morphism_category );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismBySpansObject,
               [ IsCapCategoryObject ],
                                       
  function( object )
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryBySpansObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategoryBySpans( CapCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( gen_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return gen_object;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismBySpan,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( reversed_arrow, arrow )
    local generalized_morphism, generalized_category;
    
    if not IsEqualForObjects( Source( arrow ), Source( reversed_arrow ) ) then
        
        Error( "Sources of morphisms must coincide" );
        
    fi;

    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphismBySpan,
                             Source, GeneralizedMorphismBySpansObject( Range( reversed_arrow ) ),
                             Range, GeneralizedMorphismBySpansObject( Range( arrow ) ) );
    
    SetArrow( generalized_morphism, arrow );
    
    SetReversedArrow( generalized_morphism, reversed_arrow );
    
    generalized_category := GeneralizedMorphismCategoryBySpans( CapCategory( arrow ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end );

##
InstallMethod( AsGeneralizedMorphismBySpan,
               [ IsCapCategoryMorphism ],
               
  function( arrow )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphismBySpan( IdentityMorphism( Source( arrow ) ), arrow );
    
    SetIsHonest( generalized_morphism, true );
    
    SetFilterObj( generalized_morphism, HasIdentityAsReversedArrow );
    
    SetHonestRepresentative( generalized_morphism, arrow );
    
    return generalized_morphism;
    
end );

#################################
##
## Additional methods
##
#################################

InstallMethod( IsHonest,
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

InstallMethod( IsHonest,
               [ IsGeneralizedMorphismBySpan ],
               
  function( morphism )
    
    return IsIsomorphism( NormalizedSpanTuple( morphism )[ 1 ] );
    
end );

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
    