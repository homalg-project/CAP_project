#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGeneralizedMorphismCategoryObjectRep",
                       IsCapCategoryObjectRep and IsGeneralizedMorphismCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsGeneralizedMorphismCategoryObjectRep ) );

DeclareRepresentation( "IsGeneralizedMorphismRep",
                       IsCapCategoryMorphismRep and IsGeneralizedMorphism,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsGeneralizedMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY,
                       
  function( category )
    local entry, underlying_honest_category;
    
    underlying_honest_category := UnderlyingHonestCategory( category );
    
    AddIsEqualForObjects( category,
      
      function( object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( generalized_morphism1, generalized_morphism2 )
        local subobject1, subobject2, factorobject1, factorobject2, isomorphism_of_subobjects, isomorphism_of_factorobjects;
        
        subobject1 := Domain( generalized_morphism1 );
        
        subobject2 := Domain( generalized_morphism2 );
        
        if not IsEqualAsSubobjects( subobject1, subobject2 ) then
          
          return false;
          
        fi;
        
        factorobject1 := Codomain( generalized_morphism1 );
        
        factorobject2 := Codomain( generalized_morphism2 );
        
        if not IsEqualAsFactorobjects( factorobject1, factorobject2 ) then
        
          return false;
        
        fi;
        
        isomorphism_of_subobjects := MonoAsKernelLift( subobject2, subobject1 );
        
        isomorphism_of_factorobjects := EpiAsCokernelColift( factorobject2, factorobject1 );
        
        return IsCongruentForMorphisms( AssociatedMorphism( generalized_morphism1 ), 
                                  PreCompose( PreCompose( isomorphism_of_subobjects, AssociatedMorphism( generalized_morphism2 ) ), isomorphism_of_factorobjects ) 
                                  );
  
    end );
    
    ## PreCompose
    
    
    AddPreCompose( category, [
      
      [ function( mor1, mor2 )
          
          return GeneralizedMorphism( SourceAid( mor1 ), PreCompose( MorphismAid( mor1 ), MorphismAid( mor2 ) ), RangeAid( mor2 ) );
          
      end, [ HasHonestRange, HasHonestSource ] ],
      
      
      [ function( mor1, mor2 )
          local category, pullback_diagram, new_source_aid, new_morphism_aid;
          
          pullback_diagram := [ MorphismAid( mor1 ), SourceAid( mor2 ) ];
          
          new_source_aid := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 1 ), SourceAid( mor1 ) );
          
          new_morphism_aid := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 2 ), MorphismAid( mor2 ) );
          
          return GeneralizedMorphismWithSourceAid( new_source_aid, new_morphism_aid );
          
      end, [ HasHonestRange, HasHonestRange ] ],
      
      
      [ function( mor1, mor2 )
          local category, diagram, injection_of_cofactor1, injection_of_cofactor2, new_morphism_aid, new_range_aid;
          
          diagram := [ RangeAid( mor1 ), MorphismAid( mor2 ) ];
          
          injection_of_cofactor1 :=
            InjectionOfCofactorOfPushout( diagram, 1 );
          
          injection_of_cofactor2 :=
            InjectionOfCofactorOfPushout( diagram, 2 );
          
          new_morphism_aid := PreCompose( MorphismAid( mor1 ), injection_of_cofactor1 );
          
          new_range_aid := PreCompose( RangeAid( mor2 ), injection_of_cofactor2 );
          
          return GeneralizedMorphismWithRangeAid( new_morphism_aid, new_range_aid );
          
      end, [ HasHonestSource, HasHonestSource ] ],
      
      
      [ function( mor1, mor2 )
          local category;
          
          return AsGeneralizedMorphism( PreCompose( MorphismAid( mor1 ), MorphismAid( mor2 ) ) );
          
      end, [ IsHonest, IsHonest ] ],
      
      
      [ function( mor1, mor2 )
          local generalized_mor_factor_sub, pullback_diagram, pushout_diagram, new_associated, new_source_aid, new_range_aid;
          
          generalized_mor_factor_sub := GeneralizedMorphismFromFactorToSubobject( RangeAid( mor1 ), SourceAid( mor2 ) );
          
          pullback_diagram := [ MorphismAid( mor1 ), SourceAid( generalized_mor_factor_sub ) ];
          
          pushout_diagram := [ RangeAid( generalized_mor_factor_sub ), MorphismAid( mor2 ) ];
          
          new_source_aid := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 1 ), SourceAid( mor1 ) );
          
          new_associated := PreCompose( ProjectionInFactorOfFiberProduct( pullback_diagram, 2 ), InjectionOfCofactorOfPushout( pushout_diagram, 1 ) );
          
          new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactorOfPushout( pushout_diagram, 2 ) );
          
          return GeneralizedMorphism( new_source_aid, new_associated, new_range_aid );
          
      end, [ ] ] ] );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category,
                             
      function( mor1, mor2 )
        local return_value, pullback_of_sourceaids_diagram, pushout_of_rangeaids_diagram, restricted_mor1, restricted_mor2;
        
        pullback_of_sourceaids_diagram := [ SourceAid( mor1 ), SourceAid( mor2 ) ];
        
        pushout_of_rangeaids_diagram := [ RangeAid( mor1 ), RangeAid( mor2 ) ];
        
        restricted_mor1 := PreCompose( ProjectionInFactorOfFiberProduct( pullback_of_sourceaids_diagram, 1 ), MorphismAid( mor1 ) );
        
        restricted_mor1 := PreCompose( restricted_mor1, InjectionOfCofactorOfPushout( pushout_of_rangeaids_diagram, 1 ) );
        
        restricted_mor2 := PreCompose( ProjectionInFactorOfFiberProduct( pullback_of_sourceaids_diagram, 2 ), MorphismAid( mor2 ) );
        
        restricted_mor2 := PreCompose( restricted_mor2, InjectionOfCofactorOfPushout( pushout_of_rangeaids_diagram, 2 ) );
        
        return_value := GeneralizedMorphism( 
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
        
        return AsGeneralizedMorphism( identity_morphism );
        
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
            
            if not ForAll( [ MorphismAid( generalized_morphism ), RangeAid( generalized_morphism ) ],
                        x -> IsIdenticalObj( CapCategory( x ), category ) ) then
              
              return false;
              
            fi;
            
            if not ( ForAll( [ SourceAid( generalized_morphism ), MorphismAid( generalized_morphism ), RangeAid( generalized_morphism ) ],
                    IsWellDefined ) ) then
              
              return false;
              
            fi;
            
            return true;
            
        end );
        
    fi;
    
    
    ## Additional method for a category, when generalized morphism category is present.
    
    InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobject,
                                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ),
                                    IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                                    
      function( factor, subobject )
        local composition, image_embedding, coastriction_to_image;
        
        composition := PreCompose( subobject, factor );
        
        coastriction_to_image := CoastrictionToImage( composition );
        
        image_embedding := ImageEmbedding( composition );
        
        return GeneralizedMorphism( image_embedding, IdentityMorphism( Range( coastriction_to_image ) ), coastriction_to_image );
        
    end );
    
    InstallMethod( IdempotentDefinedBySubobject,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( subobject )
        
        return GeneralizedMorphismWithSourceAid( subobject, subobject );
        
    end );
    
    InstallMethod( IdempotentDefinedByFactorobject,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( factorobject )
        
        return GeneralizedMorphismWithRangeAid( factorobject, factorobject );
        
    end );
    
    InstallMethod( GeneralizedInverse,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( morphism )
        
        return PseudoInverse( AsGeneralizedMorphism( morphism ) );
        
    end );
    
    return;
    
end );

##
InstallMethod( GeneralizedMorphismCategory,
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
                       "MonoAsKernelLift",
                       "EpiAsCokernelColift",
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
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategory );
    
    Finalize( generalized_morphism_category );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismObject,
               [ IsCapCategoryObject ],
                                       
  function( object )
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategory( CapCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( gen_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return gen_object;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphism,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( source_aid, morphism_aid, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsEqualForObjects( Source( source_aid ), Source( morphism_aid ) ) then
        
        Error( "source of source aid and associated morphism must be equal objects" );
        
    elif not IsEqualForObjects( Range( range_aid ), Range( morphism_aid ) ) then
        
        Error( "range of range aid and associated morphism must be equal objects" );
        
    fi;

    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphism,
                             Source, GeneralizedMorphismObject( Range( source_aid ) ),
                             Range, GeneralizedMorphismObject( Source( range_aid ) ) );
    
    SetSourceAid( generalized_morphism, source_aid );
    
    SetRangeAid( generalized_morphism, range_aid );
    
    SetMorphismAid( generalized_morphism, morphism_aid );
    
    generalized_category := GeneralizedMorphismCategory( CapCategory( morphism_aid ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithSourceAid,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( source_aid, morphism_aid )
    local generalized_morphism;
    
    if not IsEqualForObjects( Source( source_aid ), Source( morphism_aid ) ) then
        
        Error( "source of source aid and associated morphism must be equal objects" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphism( source_aid, morphism_aid, IdentityMorphism( Range( morphism_aid ) ) );
    
    SetHasHonestRange( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithRangeAid,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_aid, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsEqualForObjects( Range( range_aid ), Range( morphism_aid ) ) then
        
        Error( "range of source aid and associated morphism must be equal objects" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( morphism_aid ) ), morphism_aid, range_aid );
    
    SetHasHonestSource( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethod( AsGeneralizedMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism_aid )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( morphism_aid ) ), morphism_aid, IdentityMorphism( Range( morphism_aid ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    return generalized_morphism;
    
end );


####################################
##
## Methods for GeneralizedMorphismCategory
##
####################################

InstallMethod( HonestRepresentative,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return PreCompose(
             PreCompose( Inverse( SourceAid( generalized_morphism ) ), MorphismAid( generalized_morphism ) ), 
             Inverse( RangeAid( generalized_morphism ) ) 
           );
    
end );

###########################
##
## Domain, Associated Morphism, Codomain
##
###########################

InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphism ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, pushout_diagram, composition, codomain, pullback_diagram, domain, associated_morphism;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := MorphismAid( generalized_morphism );
    
    range_aid := RangeAid( generalized_morphism );
    
    if HasIsSubobject( source_aid ) 
       and IsSubobject( source_aid )
       and HasIsFactorobject( range_aid )
       and IsFactorobject( range_aid ) then
       
       return [ source_aid, morphism_aid, range_aid ];
    
    fi;
    
    #non-trivial SourceAid and non-trivial RangeAid
    
    pushout_diagram := [ SourceAid( generalized_morphism ), MorphismAid( generalized_morphism ) ];
    
    composition := PreCompose( RangeAid( generalized_morphism ), InjectionOfCofactorOfPushout( pushout_diagram, 2 ) );
    
    codomain := CoastrictionToImage( composition );
    
    pullback_diagram := [ InjectionOfCofactorOfPushout( pushout_diagram, 1 ), ImageEmbedding( composition ) ];
    
    domain := ProjectionInFactorOfFiberProduct( pullback_diagram, 1 );
    
    associated_morphism := ProjectionInFactorOfFiberProduct( pullback_diagram, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphism and HasHonestRange ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, domain, pushout_diagram, associated_morphism, codomain;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := MorphismAid( generalized_morphism );
    
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
               [ IsGeneralizedMorphism and HasHonestSource ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, codomain, pullback_diagram, domain, associated_morphism;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := MorphismAid( generalized_morphism );
    
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
               [ IsGeneralizedMorphism
                 and HasHonestSource
                 and HasHonestRange ],
                 
  function( generalized_morphism )
    
    return [ SourceAid( generalized_morphism ), MorphismAid( generalized_morphism ), RangeAid( generalized_morphism ) ];
    
end );

## GAP-Hack in order to avoid the pre-installed GAP-method Domain
BindGlobal( "CAP_INTERNAL_DOMAIN_SAVE", Domain );

MakeReadWriteGlobal( "Domain" );

Domain := function( arg )
  
  if Length( arg ) = 1 and IsGeneralizedMorphism( arg[1] ) then
      
      return DomainOp( arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DOMAIN_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "Domain" );

InstallMethod( DomainOp,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    local domain;
    
    domain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[1];
    
    SetIsMonomorphism( domain, true );
    
    return domain;
    
end );

InstallMethod( AssociatedMorphism,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return DomainAssociatedMorphismCodomainTriple( generalized_morphism )[2];
    
end );

InstallMethod( Codomain,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    local codomain;
    
    codomain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[3];
    
    SetIsEpimorphism( codomain, true );
    
    return codomain;
    
end );

InstallMethodWithCacheFromObject( CommonRestriction,
                                  [ IsList ],
                                  
  function( morphism_list )
    local test_source, source_aid_list, associated_compose_list
          current_pullback_left, current_pullback_right, i, j;
    
    if not ForAll( morphism_list, IsGeneralizedMorphism ) then
        
        TryNextMethod();
        
    fi;
    
    if Length( morphism_list ) = 1 then
        
        return morphism_list;
        
    fi;
    
    test_source := Source( morphism_list[ 1 ] );
    
    if not ForAll( [ 2 .. Length( morphism_list ) ], i -> IsEqualForObjects( Source( morphism_list[ i ] ), test_source ) = true ) then
        
        Error( "no common restriction" );
        
    fi;
    
    source_aid_list := List( morphism_list, Domain );
    
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
    
    for i in [ 1 .. Length( morphism_list ) ] do
        
        morphism_list[ i ][ 1 ] := source_aid_list[ i ];
        
        morphism_list[ i ][ 2 ] := PreCompose( associated_compose_list[ i ], morphism_list[ i ][ 2 ] );
        
    od;
    
    return List( morphism_list, i -> CallFuncList( GeneralizedMorphism, i ) );
    
end );

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
               [ IsGeneralizedMorphism
                 and HasHonestRange ],
                 
  function( generalized_morphism )
    
    return GeneralizedMorphismWithSourceAid( MorphismAid( generalized_morphism ),
                                             SourceAid( generalized_morphism ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphism ],
                 
  function( generalized_morphism )
    local source_aid, factor1, factor2;
    
    source_aid := SourceAid( generalized_morphism );
    
    factor1 := GeneralizedMorphismWithSourceAid( source_aid, 
                                                IdentityMorphism( Source( source_aid ) ) );
    
    factor2 := GeneralizedMorphismWithRangeAid( MorphismAid( generalized_morphism ),
                                                RangeAid( generalized_morphism ) );
    
    return PreCompose( PseudoInverse( factor2 ), PseudoInverse( factor1 ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphism
                 and HasHonestSource ],
               
  function( generalized_morphism )
    
    return GeneralizedMorphismWithRangeAid( RangeAid( generalized_morphism ),
                                            MorphismAid( generalized_morphism ) );
    
end );
