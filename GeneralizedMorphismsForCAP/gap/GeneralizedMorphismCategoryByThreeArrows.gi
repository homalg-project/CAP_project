#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGeneralizedMorphismCategoryByThreeArrowsObjectRep",
                       IsCapCategoryObjectRep and IsGeneralizedMorphismCategoryByThreeArrowsObject,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismCategoryByThreeArrowsObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsGeneralizedMorphismCategoryByThreeArrowsObjectRep ) );

DeclareRepresentation( "IsGeneralizedMorphismByThreeArrowsRep",
                       IsCapCategoryMorphismRep and IsGeneralizedMorphismByThreeArrows,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismByThreeArrows",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsGeneralizedMorphismByThreeArrowsRep ) );

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
    
    ##
    AddIsEqualForCacheForObjects( category, IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category, IsIdenticalObj );
    
    AddIsEqualForObjects( category,
      
      function( object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( generalized_morphism1, generalized_morphism2 )
        local subobject1, subobject2, factorobject1, factorobject2, isomorphism_of_subobjects, isomorphism_of_factorobjects;
        
        subobject1 := DomainOfGeneralizedMorphism( generalized_morphism1 );
        
        subobject2 := DomainOfGeneralizedMorphism( generalized_morphism2 );
        
        if not IsEqualAsSubobjects( subobject1, subobject2 ) then
          
          return false;
          
        fi;
        
        factorobject1 := Codomain( generalized_morphism1 );
        
        factorobject2 := Codomain( generalized_morphism2 );
        
        if not IsEqualAsFactorobjects( factorobject1, factorobject2 ) then
        
          return false;
        
        fi;
        
        isomorphism_of_subobjects := LiftAlongMonomorphism( subobject2, subobject1 );
        
        isomorphism_of_factorobjects := ColiftAlongEpimorphism( factorobject2, factorobject1 );
        
        return IsCongruentForMorphisms( AssociatedMorphism( generalized_morphism1 ), 
                                  PreCompose( PreCompose( isomorphism_of_subobjects, AssociatedMorphism( generalized_morphism2 ) ), isomorphism_of_factorobjects ) 
                                  );
  
    end );
    
    ## PreCompose
    
    
    AddPreCompose( category, [
      
      [ function( mor1, mor2 )
          
          return GeneralizedMorphismByThreeArrows( SourceAid( mor1 ), PreCompose( Arrow( mor1 ), Arrow( mor2 ) ), RangeAid( mor2 ) );
          
      end, [ HasIdentityAsRangeAid, HasIdentityAsSourceAid ] ],
      
      
      [ function( mor1, mor2 )
          local category, pullback_diagram, new_source_aid, new_morphism_aid;
          
          pullback_diagram := [ Arrow( mor1 ), SourceAid( mor2 ) ];
          
          new_source_aid := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 1 ), SourceAid( mor1 ) );
          
          new_morphism_aid := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 2 ), Arrow( mor2 ) );
          
          return GeneralizedMorphismByThreeArrowsWithSourceAid( new_source_aid, new_morphism_aid );
          
      end, [ HasIdentityAsRangeAid, HasIdentityAsRangeAid ] ],
      
      
      [ function( mor1, mor2 )
          local category, diagram, injection_of_cofactor1, injection_of_cofactor2, new_morphism_aid, new_range_aid;
          
          diagram := [ RangeAid( mor1 ), Arrow( mor2 ) ];
          
          injection_of_cofactor1 :=
            InjectionOfCofactorOfPushout( diagram, 1 );
          
          injection_of_cofactor2 :=
            InjectionOfCofactorOfPushout( diagram, 2 );
          
          new_morphism_aid := PreCompose( Arrow( mor1 ), injection_of_cofactor1 );
          
          new_range_aid := PreCompose( RangeAid( mor2 ), injection_of_cofactor2 );
          
          return GeneralizedMorphismByThreeArrowsWithRangeAid( new_morphism_aid, new_range_aid );
          
      end, [ HasIdentityAsSourceAid, HasIdentityAsSourceAid ] ],
      
      
      [ function( mor1, mor2 )
          local category;
          
          return AsGeneralizedMorphismByThreeArrows( PreCompose( Arrow( mor1 ), Arrow( mor2 ) ) );
          
      end, [ HasIdentityAsRangeAid and HasIdentityAsSourceAid, HasIdentityAsRangeAid and HasIdentityAsSourceAid ] ],
      
      
      [ function( mor1, mor2 )
          local generalized_mor_factor_sub, pullback_diagram, pushout_diagram, new_associated, new_source_aid, new_range_aid;
          
          generalized_mor_factor_sub := GeneralizedMorphismFromFactorToSubobjectByThreeArrows( RangeAid( mor1 ), SourceAid( mor2 ) );
          
          pullback_diagram := [ Arrow( mor1 ), SourceAid( generalized_mor_factor_sub ) ];
          
          pushout_diagram := [ RangeAid( generalized_mor_factor_sub ), Arrow( mor2 ) ];
          
          new_source_aid := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 1 ), SourceAid( mor1 ) );
          
          new_associated := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 2 ), InjectionOfCofactorOfPushout( pushout_diagram, 1 ) );
          
          new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactorOfPushout( pushout_diagram, 2 ) );
          
          return GeneralizedMorphismByThreeArrows( new_source_aid, new_associated, new_range_aid );
          
      end, [ ] ] ] );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category,
                             
      function( mor1, mor2 )
        local return_value, pullback_of_sourceaids_diagram, pushout_of_rangeaids_diagram, restricted_mor1, restricted_mor2;
        
        pullback_of_sourceaids_diagram := [ SourceAid( mor1 ), SourceAid( mor2 ) ];
        
        pushout_of_rangeaids_diagram := [ RangeAid( mor1 ), RangeAid( mor2 ) ];
        
        restricted_mor1 := PreCompose( ProjectionInFactorOfFiberProduct( pullback_of_sourceaids_diagram, 1 ), Arrow( mor1 ) );
        
        restricted_mor1 := PreCompose( restricted_mor1, InjectionOfCofactorOfPushout( pushout_of_rangeaids_diagram, 1 ) );
        
        restricted_mor2 := PreCompose( ProjectionInFactorOfFiberProduct( pullback_of_sourceaids_diagram, 2 ), Arrow( mor2 ) );
        
        restricted_mor2 := PreCompose( restricted_mor2, InjectionOfCofactorOfPushout( pushout_of_rangeaids_diagram, 2 ) );
        
        return_value := GeneralizedMorphismByThreeArrows(
                          PreCompose( ProjectionInFactorOfFiberProduct( pullback_of_sourceaids_diagram, 1 ), SourceAid( mor1 ) ),
                          restricted_mor1 + restricted_mor2,
                          PreCompose( RangeAid( mor1 ), InjectionOfCofactorOfPushout( pushout_of_rangeaids_diagram, 1 ) )
                        );
        
        return return_value;
      
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( generalized_object )
        local identity_morphism;
        
        identity_morphism := IdentityMorphism( UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismByThreeArrows( identity_morphism );
        
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
            
            category := CapCategory( SourceAid( generalized_morphism ) );
            
            if not ForAll( [ Arrow( generalized_morphism ), RangeAid( generalized_morphism ) ],
                        x -> IsIdenticalObj( CapCategory( x ), category ) ) then
              
              return false;
              
            fi;
            
            if not ( ForAll( [ SourceAid( generalized_morphism ), Arrow( generalized_morphism ), RangeAid( generalized_morphism ) ],
                    IsWellDefined ) ) then
              
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
    
    name := Concatenation( "Generalized morphism category of ", name );
    
    generalized_morphism_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_BY_THREE_ARROWS_CATEGORY( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryByThreeArrows );
    
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
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryByThreeArrowsObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategoryByThreeArrows( CapCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( gen_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return gen_object;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismByThreeArrows,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( source_aid, morphism_aid, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsEqualForObjects( Source( source_aid ), Source( morphism_aid ) ) then
        
        Error( "source of source aid and associated morphism must be equal objects" );
        
    elif not IsEqualForObjects( Range( range_aid ), Range( morphism_aid ) ) then
        
        Error( "range of range aid and associated morphism must be equal objects" );
        
    fi;

    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphismByThreeArrows,
                             Source, GeneralizedMorphismByThreeArrowsObject( Range( source_aid ) ),
                             Range, GeneralizedMorphismByThreeArrowsObject( Source( range_aid ) ) );
    
    SetSourceAid( generalized_morphism, source_aid );
    
    SetRangeAid( generalized_morphism, range_aid );
    
    SetArrow( generalized_morphism, morphism_aid );
    
    generalized_category := GeneralizedMorphismCategoryByThreeArrows( CapCategory( morphism_aid ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
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
             PreCompose( Inverse( DomainOfGeneralizedMorphism( generalized_morphism ) ), AssociatedMorphism( generalized_morphism ) ), 
             Inverse( Codomain( generalized_morphism ) ) 
           );
    
end );

##
InstallMethod( HasFullCodomain,
               [ IsGeneralizedMorphismByThreeArrows ],
               
  function( generalized_morphism )
    
    return IsIsomorphism( Codomain( generalized_morphism ) );
    
end );

##
InstallMethod( HasFullDomain,
               [ IsGeneralizedMorphismByThreeArrows ],
               
  function( generalized_morphism )
    
    return IsIsomorphism( Domain( generalized_morphism ) );
    
end );

###########################
##
## DomainOfGeneralizedMorphism, Associated Morphism, Codomain
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
    
    source_aid_list := List( morphism_list, DomainOfGeneralizedMorphism );
    
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
    
    codomain_list := List( morphism_list, Codomain );
    
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
