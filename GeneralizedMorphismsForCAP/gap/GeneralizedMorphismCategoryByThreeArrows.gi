# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_BY_THREE_ARROWS_CATEGORY,
                       
  function( category )
    local entry, underlying_honest_category;
    
    underlying_honest_category := UnderlyingHonestCategory( category );
    
    AddIsEqualForObjects( category,
      
      function( cat, object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestCategory( cat ), UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( cat, generalized_morphism1, generalized_morphism2 )
        local honest_category, subobject1, subobject2, factorobject1, factorobject2, isomorphism_of_subobjects, isomorphism_of_factorobjects;
        
        honest_category := UnderlyingHonestCategory( cat );

        subobject1 := DomainEmbedding( generalized_morphism1 );
        
        subobject2 := DomainEmbedding( generalized_morphism2 );
        
        if not IsEqualAsSubobjects( honest_category, subobject1, subobject2 ) then
          
          return false;
          
        fi;
        
        factorobject1 := CodomainProjection( generalized_morphism1 );
        
        factorobject2 := CodomainProjection( generalized_morphism2 );
        
        if not IsEqualAsFactorobjects( honest_category, factorobject1, factorobject2 ) then
        
          return false;
        
        fi;
        
        isomorphism_of_subobjects := LiftAlongMonomorphism( honest_category, subobject2, subobject1 );
        
        isomorphism_of_factorobjects := ColiftAlongEpimorphism( honest_category, factorobject2, factorobject1 );
        
        return IsCongruentForMorphisms( honest_category,
                                        AssociatedMorphism( generalized_morphism1 ),
                                        PreCompose( honest_category,
                                                    PreCompose( honest_category, isomorphism_of_subobjects, AssociatedMorphism( generalized_morphism2 ) ),
                                                    isomorphism_of_factorobjects ) );
  
    end );
    
    
    ## PreCompose
    
    AddPreCompose( category,
                   
      function( cat, mor1, mor2 )
        local honest_category, generalized_mor_factor_sub, pullback_diagram, pushout_diagram, new_associated, new_source_aid, new_range_aid;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        generalized_mor_factor_sub := GeneralizedMorphismFromFactorToSubobjectByThreeArrows( RangeAid( mor1 ), SourceAid( mor2 ) );
        
        pullback_diagram := [ Arrow( mor1 ), SourceAid( generalized_mor_factor_sub ) ];
        
        pushout_diagram := [ RangeAid( generalized_mor_factor_sub ), Arrow( mor2 ) ];
        
        new_source_aid := PreCompose( honest_category,
                                      ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 1 ),
                                      SourceAid( mor1 ) );
        
        new_associated := PreCompose( honest_category,
                                      ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 2 ),
                                      InjectionOfCofactorOfPushout( honest_category, pushout_diagram, 1 ) );
        
        new_range_aid := PreCompose( honest_category,
                                     RangeAid( mor2 ),
                                     InjectionOfCofactorOfPushout( honest_category, pushout_diagram, 2 ) );
        
        return GeneralizedMorphismByThreeArrows( new_source_aid, new_associated, new_range_aid );
        
    end );
    
    # the following optimizations probably do not fulfill the specification "equal input gives equal output", see https://github.com/homalg-project/CAP_project/issues/1669
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsRangeAid, MorphismFilter( category ) and HasIdentityAsSourceAid ],
                        
      function( cat, mor1, mor2 )
        
        return GeneralizedMorphismByThreeArrows( SourceAid( mor1 ),
                                                 PreCompose( UnderlyingHonestCategory( cat ), Arrow( mor1 ), Arrow( mor2 ) ),
                                                 RangeAid( mor2 ) );
        
    end );
    
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsRangeAid, MorphismFilter( category ) and HasIdentityAsRangeAid ],
                        
      function( cat, mor1, mor2 )
          local honest_category, category, pullback_diagram, new_source_aid, new_morphism_aid;

          honest_category := UnderlyingHonestCategory( cat );

          pullback_diagram := [ Arrow( mor1 ), SourceAid( mor2 ) ];

          new_source_aid := PreCompose( honest_category,
                                        ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 1 ),
                                        SourceAid( mor1 ) );

          new_morphism_aid := PreCompose( honest_category,
                                          ProjectionInFactorOfFiberProduct( honest_category, pullback_diagram, 2 ),
                                          Arrow( mor2 ) );

          return GeneralizedMorphismByThreeArrowsWithSourceAid( new_source_aid, new_morphism_aid );

    end );
    
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsSourceAid, MorphismFilter( category ) and HasIdentityAsSourceAid ],
                        
      function( cat, mor1, mor2 )
          local honest_category, category, diagram, injection_of_cofactor1, injection_of_cofactor2, new_morphism_aid, new_range_aid;

          honest_category := UnderlyingHonestCategory( cat );

          diagram := [ RangeAid( mor1 ), Arrow( mor2 ) ];

          injection_of_cofactor1 := InjectionOfCofactorOfPushout( honest_category, diagram, 1 );

          injection_of_cofactor2 := InjectionOfCofactorOfPushout( honest_category, diagram, 2 );

          new_morphism_aid := PreCompose( honest_category, Arrow( mor1 ), injection_of_cofactor1 );

          new_range_aid := PreCompose( honest_category, RangeAid( mor2 ), injection_of_cofactor2 );

          return GeneralizedMorphismByThreeArrowsWithRangeAid( new_morphism_aid, new_range_aid );

    end );
    
    InstallOtherMethod( PreCompose,
                        [ CategoryFilter( category ), MorphismFilter( category ) and HasIdentityAsRangeAid and HasIdentityAsSourceAid, MorphismFilter( category ) and HasIdentityAsRangeAid and HasIdentityAsSourceAid ],
                        
      function( cat, mor1, mor2 )
          local honest_category, category;

          honest_category := UnderlyingHonestCategory( cat );

          return AsGeneralizedMorphismByThreeArrows( PreCompose( honest_category, Arrow( mor1 ), Arrow( mor2 ) ) );

    end );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category,
                             
      function( cat, mor1, mor2 )
        local honest_category, return_value, pullback_of_sourceaids_diagram, pushout_of_rangeaids_diagram, restricted_mor1, restricted_mor2;
        
        honest_category := UnderlyingHonestCategory( cat );

        pullback_of_sourceaids_diagram := [ SourceAid( mor1 ), SourceAid( mor2 ) ];
        
        pushout_of_rangeaids_diagram := [ RangeAid( mor1 ), RangeAid( mor2 ) ];
        
        restricted_mor1 := PreCompose( honest_category,
                                       ProjectionInFactorOfFiberProduct( honest_category, pullback_of_sourceaids_diagram, 1 ),
                                       Arrow( mor1 ) );
        
        restricted_mor1 := PreCompose( honest_category,
                                       restricted_mor1,
                                       InjectionOfCofactorOfPushout( honest_category, pushout_of_rangeaids_diagram, 1 ) );
        
        restricted_mor2 := PreCompose( honest_category,
                                       ProjectionInFactorOfFiberProduct( honest_category, pullback_of_sourceaids_diagram, 2 ),
                                       Arrow( mor2 ) );
        
        restricted_mor2 := PreCompose( honest_category,
                                       restricted_mor2,
                                       InjectionOfCofactorOfPushout( honest_category, pushout_of_rangeaids_diagram, 2 ) );
        
        return_value := GeneralizedMorphismByThreeArrows( PreCompose( honest_category,
                                                                      ProjectionInFactorOfFiberProduct( honest_category, pullback_of_sourceaids_diagram, 1 ),
                                                                      SourceAid( mor1 ) ),
                                                          AdditionForMorphisms( honest_category, restricted_mor1, restricted_mor2 ),
                                                          PreCompose( honest_category,
                                                                      RangeAid( mor1 ),
                                                                      InjectionOfCofactorOfPushout( honest_category, pushout_of_rangeaids_diagram, 1 ) ) );
        
        return return_value;
      
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( cat, generalized_object )
        local honest_category, identity_morphism;
        
        honest_category := UnderlyingHonestCategory( cat );

        identity_morphism := IdentityMorphism( honest_category, UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismByThreeArrows( identity_morphism );
        
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
            
            if not ForAll( [ Arrow( generalized_morphism ), RangeAid( generalized_morphism ) ],
                        x -> IsIdenticalObj( CapCategory( x ), honest_category ) ) then
              
              return false;
              
            fi;
            
            if not ( ForAll( [ SourceAid( generalized_morphism ), Arrow( generalized_morphism ), RangeAid( generalized_morphism ) ],
                    IsWellDefinedForMorphisms ) ) then
              
              return false;
              
            fi;
            
            return true;
            
        end );
        
    fi;
    
    
    ## Additional method for a category, when generalized morphism category is present.
    
    return;
    
end );

##
InstallMethod( GeneralizedMorphismCategoryByThreeArrows,
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
    
    name := Concatenation( "Generalized morphism category of ", name );
    
    generalized_morphism_category := CreateCapCategoryWithDataTypes(
                                             name,
                                             IsGeneralizedMorphismCategoryByThreeArrows,
                                             IsGeneralizedMorphismCategoryByThreeArrowsObject,
                                             IsGeneralizedMorphismByThreeArrows and HasSourceAid and HasRangeAid and HasArrow,
                                             IsCapCategoryTwoCell,
                                             fail,
                                             fail,
                                             fail );
    
    generalized_morphism_category!.predicate_logic := category!.predicate_logic;
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryByThreeArrows );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_BY_THREE_ARROWS_CATEGORY( generalized_morphism_category );
    
    AddPredicateImplicationFileToCategory( generalized_morphism_category,
      Filename(
        DirectoriesPackageLibrary( "GeneralizedMorphismsForCAP", "LogicForGeneralizedMorphismCategory" ),
        "PredicateImplicationsForGeneralizedMorphismCategory.tex" )
    );
    
    Finalize( generalized_morphism_category );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismByThreeArrowsObject,
               [ IsCapCategoryObject ],
                                       
  function( object )
    local generalized_category;
    
    generalized_category := GeneralizedMorphismCategoryByThreeArrows( CapCategory( object ) );
    
    return CreateCapCategoryObjectWithAttributes( generalized_category,
                                                  UnderlyingHonestObject, object );
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismByThreeArrows,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( source_aid, morphism_aid, range_aid )
    local generalized_category;
    
    if not IsEqualForObjects( Source( source_aid ), Source( morphism_aid ) ) then
        
        Error( "source of source aid and associated morphism must be equal objects" );
        
    elif not IsEqualForObjects( Range( range_aid ), Range( morphism_aid ) ) then
        
        Error( "range of range aid and associated morphism must be equal objects" );
        
    fi;
    
    generalized_category := GeneralizedMorphismCategoryByThreeArrows( CapCategory( morphism_aid ) );
    
    return CreateCapCategoryMorphismWithAttributes( generalized_category,
                                                    GeneralizedMorphismByThreeArrowsObject( Range( source_aid ) ),
                                                    GeneralizedMorphismByThreeArrowsObject( Source( range_aid ) ),
                                                    SourceAid, source_aid,
                                                    RangeAid, range_aid,
                                                    Arrow, morphism_aid );
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismByThreeArrowsWithSourceAid,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( source_aid, morphism_aid )
    local generalized_morphism;
    
    if not IsEqualForObjects( Source( source_aid ), Source( morphism_aid ) ) then
        
        Error( "source of source aid and associated morphism must be equal objects" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphismByThreeArrows( source_aid, morphism_aid, IdentityMorphism( Range( morphism_aid ) ) );
    
    SetHasIdentityAsRangeAid( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismByThreeArrowsWithRangeAid,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_aid, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsEqualForObjects( Range( range_aid ), Range( morphism_aid ) ) then
        
        Error( "range of source aid and associated morphism must be equal objects" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphismByThreeArrows( IdentityMorphism( Source( morphism_aid ) ), morphism_aid, range_aid );
    
    SetHasIdentityAsSourceAid( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethod( AsGeneralizedMorphismByThreeArrows,
               [ IsCapCategoryMorphism ],
               
  function( morphism_aid )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphismByThreeArrows( IdentityMorphism( Source( morphism_aid ) ), morphism_aid, IdentityMorphism( Range( morphism_aid ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    SetHasIdentitiesAsReversedArrows( generalized_morphism, true );
    
    SetHonestRepresentative( generalized_morphism, morphism_aid );
    
    return generalized_morphism;
    
end );


####################################
##
## Methods for GeneralizedMorphismCategoryByThreeArrows
##
####################################

##
InstallMethod( HonestRepresentative,
               [ IsGeneralizedMorphismByThreeArrows ],
               
  function( generalized_morphism )
    
    return PreCompose(
             PreCompose( Inverse( DomainEmbedding( generalized_morphism ) ), AssociatedMorphism( generalized_morphism ) ), 
             Inverse( CodomainProjection( generalized_morphism ) ) 
           );
    
end );

##
InstallMethod( HasFullCodomain,
               [ IsGeneralizedMorphismByThreeArrows ],
               
  function( generalized_morphism )
    
    return IsIsomorphism( CodomainProjection( generalized_morphism ) );
    
end );

##
InstallMethod( HasFullDomain,
               [ IsGeneralizedMorphismByThreeArrows ],
               
  function( generalized_morphism )
    
    return IsIsomorphism( Domain( generalized_morphism ) );
    
end );

###########################
##
## DomainEmbedding, Associated Morphism, CodomainProjection
##
###########################

InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphismByThreeArrows ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, pushout_diagram, composition, codomain, pullback_diagram, domain, associated_morphism;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := Arrow( generalized_morphism );
    
    range_aid := RangeAid( generalized_morphism );
    
    if HasIsSubobject( source_aid ) 
       and IsSubobject( source_aid )
       and HasIsFactorobject( range_aid )
       and IsFactorobject( range_aid ) then
       
       return [ source_aid, morphism_aid, range_aid ];
    
    fi;
    
    #non-trivial SourceAid and non-trivial RangeAid
    
    pushout_diagram := [ SourceAid( generalized_morphism ), Arrow( generalized_morphism ) ];
    
    composition := PreCompose( RangeAid( generalized_morphism ), InjectionOfCofactorOfPushout( pushout_diagram, 2 ) );
    
    codomain := CoastrictionToImage( composition );
    
    pullback_diagram := [ InjectionOfCofactorOfPushout( pushout_diagram, 1 ), ImageEmbedding( composition ) ];
    
    domain := ProjectionInFactorOfFiberProduct( pullback_diagram, 1 );
    
    associated_morphism := ProjectionInFactorOfFiberProduct( pullback_diagram, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphismByThreeArrows and HasIdentityAsRangeAid ],
               
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, domain, pushout_diagram, associated_morphism, codomain;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := Arrow( generalized_morphism );
    
    range_aid := RangeAid( generalized_morphism );
    
    if HasIsSubobject( source_aid )
       and IsSubobject( source_aid ) then
       
       return [ source_aid, morphism_aid, range_aid ];
    
    fi;
    #trivial RangeAid
    
    domain := ImageEmbedding( source_aid );
    
    pushout_diagram := [ CoastrictionToImage( source_aid ), morphism_aid ];
    
    associated_morphism := InjectionOfCofactorOfPushout( pushout_diagram, 1 );
    
    codomain := InjectionOfCofactorOfPushout( pushout_diagram, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphismByThreeArrows and HasIdentityAsSourceAid ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, codomain, pullback_diagram, domain, associated_morphism;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := Arrow( generalized_morphism );
    
    range_aid := RangeAid( generalized_morphism );
    
    if HasIsFactorobject( range_aid )
       and IsFactorobject( range_aid ) then
       
       return [ source_aid, morphism_aid, range_aid ];
    
    fi;
    #trivial SourceAid
    
    codomain := CoastrictionToImage( range_aid );
    
    pullback_diagram := [ morphism_aid, ImageEmbedding( range_aid ) ];
    
    domain := ProjectionInFactorOfFiberProduct( pullback_diagram, 1 );
    
    associated_morphism := ProjectionInFactorOfFiberProduct( pullback_diagram, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphismByThreeArrows
                 and HasIdentityAsSourceAid
                 and HasIdentityAsRangeAid ],
                 
  function( generalized_morphism )
    
    return [ SourceAid( generalized_morphism ), Arrow( generalized_morphism ), RangeAid( generalized_morphism ) ];
    
end );

InstallMethodWithCacheFromObject( CommonRestrictionOp,
                                  [ IsList, IsGeneralizedMorphismByThreeArrows ],
                                  
  function( morphism_list, cacher )
    local test_source, source_aid_list, associated_compose_list,
          current_pullback_left, current_pullback_right, i, j;
    
    if not ForAll( morphism_list, IsGeneralizedMorphismByThreeArrows ) then
        
        TryNextMethod();
        
    fi;
    
    if Length( morphism_list ) = 1 then
        
        return morphism_list;
        
    fi;
    
    test_source := Source( morphism_list[ 1 ] );
    
    if not ForAll( [ 2 .. Length( morphism_list ) ], i -> IsEqualForObjects( Source( morphism_list[ i ] ), test_source ) = true ) then
        
        Error( "no common restriction" );
        
    fi;
    
    source_aid_list := List( morphism_list, DomainEmbedding );
    
    associated_compose_list := [ ];
    
    for i in [ 2 .. Length( morphism_list ) ] do
        
        current_pullback_left := ProjectionInFactorOfFiberProduct( [ source_aid_list[ i - 1 ], source_aid_list[ i ] ], 1 );
        
        current_pullback_right := ProjectionInFactorOfFiberProduct( [ source_aid_list[ i - 1 ], source_aid_list[ i ] ], 2 );
        
        for j in [ 1 .. i - 1 ] do
            
            source_aid_list[ j ] := PreCompose( current_pullback_left, source_aid_list[ j ] );
            
            if not IsBound( associated_compose_list[ j ] ) then
                associated_compose_list[ j ] := current_pullback_left;
            else
                associated_compose_list[ j ] := PreCompose( current_pullback_left, associated_compose_list[ j ] );
            fi;
            
        od;
        
        source_aid_list[ i ] := PreCompose( current_pullback_right, source_aid_list[ i ] );
        
        associated_compose_list[ i ] := current_pullback_right;
        
    od;
    
    morphism_list := List( morphism_list, DomainAssociatedMorphismCodomainTriple );
    
    morphism_list := List( morphism_list, ShallowCopy );
    
    for i in [ 1 .. Length( morphism_list ) ] do
        
        morphism_list[ i ][ 1 ] := source_aid_list[ i ];
        
        morphism_list[ i ][ 2 ] := PreCompose( associated_compose_list[ i ], morphism_list[ i ][ 2 ] );
        
    od;
    
    return List( morphism_list, i -> CallFuncList( GeneralizedMorphismByThreeArrows, i ) );
    
end : ArgumentNumber := 2 );

InstallMethod( CommonCoastriction,
               [ IsList ],
               
  function( morphism_list )
    
    if morphism_list = [ ] then
        
        return morphism_list;
        
    fi;
    
    return CommonCoastrictionOp( morphism_list, morphism_list[ 1 ] );
    
end );

InstallMethodWithCacheFromObject( CommonCoastrictionOp,
                                  [ IsList, IsGeneralizedMorphismByThreeArrows ],
                                  
  function( morphism_list, cacher )
    local test_range, codomain_list, associated_compose_list,
          current_pushout_left, current_pushout_right, i, j;
    
    if not ForAll( morphism_list, IsGeneralizedMorphismByThreeArrows ) then
        
        TryNextMethod();
        
    fi;
    
    if Length( morphism_list ) = 1 then
        
        return morphism_list;
        
    fi;
    
    test_range := Range( morphism_list[ 1 ] );
    
    if not ForAll( [ 2 .. Length( morphism_list ) ], i -> IsEqualForObjects( Range( morphism_list[ i ] ), test_range ) = true ) then
        
        Error( "no common coastriction" );
        
    fi;
    
    codomain_list := List( morphism_list, CodomainProjection );
    
    associated_compose_list := [ ];
    
    for i in [ 2 .. Length( morphism_list ) ] do
        
        current_pushout_left := InjectionOfCofactorOfPushout( [ codomain_list[ i - 1 ], codomain_list[ i ] ], 1 );
        
        current_pushout_right := InjectionOfCofactorOfPushout( [ codomain_list[ i - 1 ], codomain_list[ i ] ], 2 );
        
        for j in [ 1 .. i - 1 ] do
            
            codomain_list[ j ] := PreCompose( codomain_list[ j ], current_pushout_left );
            
            if not IsBound( associated_compose_list[ j ] ) then
                associated_compose_list[ j ] := current_pushout_left;
            else
                associated_compose_list[ j ] := PreCompose( associated_compose_list[ j ], current_pushout_left );
            fi;
            
        od;
        
        codomain_list[ i ] := PreCompose( codomain_list[ i ], current_pushout_right );
        
        associated_compose_list[ i ] := current_pushout_right;
        
    od;
    
    morphism_list := List( morphism_list, DomainAssociatedMorphismCodomainTriple );
    
    morphism_list := List( morphism_list, ShallowCopy );
    
    for i in [ 1 .. Length( morphism_list ) ] do
        
        morphism_list[ i ][ 3 ] := codomain_list[ i ];
        
        morphism_list[ i ][ 2 ] := PreCompose( morphism_list[ i ][ 2 ], associated_compose_list[ i ] );
        
    od;
    
    return List( morphism_list, i -> CallFuncList( GeneralizedMorphismByThreeArrows, i ) );
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ConcatenationProductOp,
                                  [ IsList, IsGeneralizedMorphismByThreeArrows ],
               
  function( generalized_morphism_list, method_selection_object )
    
    return GeneralizedMorphismByThreeArrows( DirectSumFunctorial( List( generalized_morphism_list, SourceAid ) ),
                                             DirectSumFunctorial( List( generalized_morphism_list, Arrow ) ),
                                             DirectSumFunctorial( List( generalized_morphism_list, RangeAid ) ) );
    
end : ArgumentNumber := 2 );

###########################
##
## Pseudo-Inverse
##
###########################

## convention: we prefer a 2-arrow calculus with honest source,
## because in the module category, pushouts are easier to compute
## than pullbacks.
##
InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphismByThreeArrows
                 and HasIdentityAsRangeAid ],
                 
  function( generalized_morphism )
    
    return GeneralizedMorphismByThreeArrowsWithSourceAid( Arrow( generalized_morphism ),
                                             SourceAid( generalized_morphism ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphismByThreeArrows ],
                 
  function( generalized_morphism )
    local source_aid, factor1, factor2;
    
    source_aid := SourceAid( generalized_morphism );
    
    factor1 := GeneralizedMorphismByThreeArrowsWithSourceAid( source_aid, 
                                                IdentityMorphism( Source( source_aid ) ) );
    
    factor2 := GeneralizedMorphismByThreeArrowsWithRangeAid( Arrow( generalized_morphism ),
                                                RangeAid( generalized_morphism ) );
    
    return PreCompose( PseudoInverse( factor2 ), PseudoInverse( factor1 ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphismByThreeArrows
                 and HasIdentityAsSourceAid ],
               
  function( generalized_morphism )
    
    return GeneralizedMorphismByThreeArrowsWithRangeAid( RangeAid( generalized_morphism ),
                                            Arrow( generalized_morphism ) );
    
end );

InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobjectByThreeArrows,
                              [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                
  function( factor, subobject )
    local composition, image_embedding, coastriction_to_image;
    
    composition := PreCompose( subobject, factor );
    
    coastriction_to_image := CoastrictionToImage( composition );
    
    image_embedding := ImageEmbedding( composition );
    
    return GeneralizedMorphismByThreeArrows( image_embedding, IdentityMorphism( Range( coastriction_to_image ) ), coastriction_to_image );
    
end );

InstallMethod( IdempotentDefinedBySubobjectByThreeArrows,
              [ IsCapCategoryMorphism ],
              
  function( subobject )
    
    return GeneralizedMorphismByThreeArrowsWithSourceAid( subobject, subobject );
    
end );

InstallMethod( IdempotentDefinedByFactorobjectByThreeArrows,
              [ IsCapCategoryMorphism ],
              
  function( factorobject )
    
    return GeneralizedMorphismByThreeArrowsWithRangeAid( factorobject, factorobject );
    
end );

InstallMethod( GeneralizedInverseByThreeArrows,
              [ IsCapCategoryMorphism ],
              
  function( morphism )
    
    return PseudoInverse( AsGeneralizedMorphismByThreeArrows( morphism ) );
    
end );

###########################
##
## Compatibility
##
###########################

InstallMethod( GeneralizedMorphismByThreeArrows,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  GeneralizedMorphismByThreeArrowsWithRangeAid );
