#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGeneralizedMorphismCategoryObjectRep",
                       IsHomalgCategoryObjectRep and IsGeneralizedMorphismCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismCategoryObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsGeneralizedMorphismCategoryObjectRep ) );

DeclareRepresentation( "IsGeneralizedMorphismRep",
                       IsHomalgCategoryMorphismRep and IsGeneralizedMorphism,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsGeneralizedMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( CREATE_PROPAGATION_LISTS_FOR_GENERALIZED_MORPHISM_CATEGORY,
                       
  function( )
    local prop_list_pairs, prop_list_solo, i, concat_string, i_concat;
    
    prop_list_pairs := [ ];
    
    prop_list_solo := [ ];
    
    concat_string := "InUnderlyingHonestCategory";
    
    for i in CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST do
        
        i_concat := Concatenation( i, concat_string );
        
        ## FIXME: This syntax needs to be fixed.
        Add( prop_list_pairs, [ i, [ i, i_concat ] ] );
        
        Add( prop_list_solo, i_concat );
        
        DeclareProperty( i_concat, IsHomalgCategory );
        
        DeclareProperty( i_concat, IsHomalgCategoryCell );
        
    od;
    
    InstallValue( GENERALIZED_MORPHISM_CATEGORY_PROPAGATION_LIST, prop_list_pairs );
    
    InstallValue( GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST, prop_list_solo );
    
end );

CREATE_PROPAGATION_LISTS_FOR_GENERALIZED_MORPHISM_CATEGORY( );

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY,
                       
  function( category )
    local entry;
    
    ## Entries between honest and generalized morphism category
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "UnderlyingHonestCategory" ] ],
                                                         [ [ UnderlyingHonestCategory, category ], category ],
                                                         GENERALIZED_MORPHISM_CATEGORY_PROPAGATION_LIST
                                                       );
    
    AddToToDoList( entry );
    
    category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_OBJECTS := GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST;
    
    category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_MORPHISM := GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST;
    
    return;
    
end );

##
InstallMethod( GeneralizedMorphismCategory,
               [ IsHomalgCategory ],
               
  function( category )
    local name, generalized_morphism_category;
    
    if not IsAbelianCategory( category ) then
      
      Error( "the category must be abelian" );
      
    fi;
    
    name := Name( category );
    
    name := Concatenation( "Generalized morphism category of ", name );
    
    generalized_morphism_category := CreateHomalgCategory( name );
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategory );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismObject,
               [ IsHomalgCategoryObject ],
                                       
  function( object )
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( gen_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return gen_object;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphism,
                                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ],
                                  
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
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( morphism_aid ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithSourceAid,
                                  [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
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
                                  [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
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
               [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism ],
               
  function( morphism_aid )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( morphism_aid ) ), morphism_aid, IdentityMorphism( Range( morphism_aid ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

####################################
##
## PreCompose
##
####################################

##
InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism 
                                    and HasHonestRange
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                    IsGeneralizedMorphism and HasHonestSource ],
                                    
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return GeneralizedMorphism( SourceAid( mor1 ), PreCompose( MorphismAid( mor1 ), MorphismAid( mor2 ) ), RangeAid( mor2 ) );
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                       [ IsGeneralizedMorphism 
                                         and HasHonestRange
                                         and CanComputePreComposeInUnderlyingHonestCategory
                                         and CanComputePullbackInUnderlyingHonestCategory,
                                         IsGeneralizedMorphism and HasHonestRange ],
                                       
  function( mor1, mor2 )
    local category, pullback, new_source_aid, new_morphism_aid;
    
    category := HomalgCategory( mor1 );
    
    if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    pullback := FiberProduct( MorphismAid( mor1 ), SourceAid( mor2 ) );
    
    new_source_aid := PreCompose( ProjectionInFactor( pullback, 1 ), SourceAid( mor1 ) );
    
    new_morphism_aid := PreCompose( ProjectionInFactor( pullback, 2 ), MorphismAid( mor2 ) );
    
    return GeneralizedMorphismWithSourceAid( new_source_aid, new_morphism_aid );
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism
                                    and HasHonestSource
                                    and CanComputePreComposeInUnderlyingHonestCategory
                                    and CanComputePushoutInUnderlyingHonestCategory,
                                  IsGeneralizedMorphism and HasHonestSource ],
                                  
  function( mor1, mor2 )
    local category, pushout, new_morphism_aid, new_range_aid;
    
    category := HomalgCategory( mor1 );
    
    if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    pushout := Pushout( RangeAid( mor1 ), MorphismAid( mor2 ) );
    
    new_morphism_aid := PreCompose( MorphismAid( mor1 ), InjectionOfCofactor( pushout, 1 ) );
    
    new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactor( pushout, 2 ) );
    
    return GeneralizedMorphismWithRangeAid( new_morphism_aid, new_range_aid );
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism
                                    and IsHonest
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                  IsGeneralizedMorphism and IsHonest ],
                                  
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return AsGeneralizedMorphism( PreCompose( MorphismAid( mor1 ), MorphismAid( mor2 ) ) );
    
end );

##
InstallTrueMethod( CanComputePreCompose,
                   CanComputeGeneralizedMorphismFromFactorToSubobjectInUnderlyingHonestCategory
                   and CanComputePullbackInUnderlyingHonestCategory
                   and CanComputePushoutInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory );

InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism 
                                    and CanComputeGeneralizedMorphismFromFactorToSubobjectInUnderlyingHonestCategory
                                    and CanComputePullbackInUnderlyingHonestCategory
                                    and CanComputePushoutInUnderlyingHonestCategory
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                    IsGeneralizedMorphism ],
                                    
  function( mor1, mor2 )
    local generalized_mor_factor_sub, pullback, pushout, new_associated, new_source_aid, new_range_aid;
    
    if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    generalized_mor_factor_sub := GeneralizedMorphismFromFactorToSubobject( RangeAid( mor1 ), SourceAid( mor2 ) );
    
    pullback := FiberProduct( MorphismAid( mor1 ), SourceAid( generalized_mor_factor_sub ) );
    
    pushout := Pushout( RangeAid( generalized_mor_factor_sub ), MorphismAid( mor2 ) );
    
    new_source_aid := PreCompose( ProjectionInFactor( pullback, 1 ), SourceAid( mor1 ) );
    
    new_associated := PreCompose( ProjectionInFactor( pullback, 2 ), InjectionOfCofactor( pushout, 1 ) );
    
    new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactor( pushout, 2 ) );
    
    return GeneralizedMorphism( new_source_aid, new_associated, new_range_aid );
    
end );

####################################
##
## Methods for GeneralizedMorphismCategory
##
####################################

##
InstallTrueMethod( CanComputeGeneralizedMorphismFromFactorToSubobject,
                   CanComputePreCompose
                   and CanComputeImageEmbedding
                   and CanComputeCoastrictionToImage
                   and CanComputeIdentityMorphism );

InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobject,
                                  [ IsHomalgCategoryMorphism
                                    and CanComputePreCompose
                                    and CanComputeImageEmbedding
                                    and CanComputeCoastrictionToImage
                                    and CanComputeIdentityMorphism,
                                    IsHomalgCategoryMorphism ],
                                    
  function( factor, subobject )
    local composition, image_embedding, coastriction_to_image;
    
    composition := PreCompose( subobject, factor );
    
    coastriction_to_image := CoastrictionToImage( composition );
    
    image_embedding := ImageEmbedding( composition );
    
    return GeneralizedMorphism( image_embedding, IdentityMorphism( Range( coastriction_to_image ) ), coastriction_to_image );
    
end );

##
InstallTrueMethod( CanComputeIsEqualForMorphisms,
                   CanComputeEqualityOfSubobjectsInUnderlyingHonestCategory
                   and CanComputeEqualityOfFactorobjectsInUnderlyingHonestCategory
                   and CanComputeMonoAsKernelLiftInUnderlyingHonestCategory
                   and CanComputeEpiAsCokernelColiftInUnderlyingHonestCategory
                   and CanComputeIsEqualForMorphismsInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory
                   and CanComputeDomainAssociatedMorphismCodomainTriple );

InstallMethodWithCacheFromObject( IsEqualForMorphisms,
                                  [ IsGeneralizedMorphism
                                    and CanComputeEqualityOfSubobjectsInUnderlyingHonestCategory
                                    and CanComputeEqualityOfFactorobjectsInUnderlyingHonestCategory
                                    and CanComputeMonoAsKernelLiftInUnderlyingHonestCategory
                                    and CanComputeEpiAsCokernelColiftInUnderlyingHonestCategory
                                    and CanComputeIsEqualForMorphismsInUnderlyingHonestCategory
                                    and CanComputePreComposeInUnderlyingHonestCategory
                                    and CanComputeDomainAssociatedMorphismCodomainTriple,
                                    IsGeneralizedMorphism ],
                                  
  function( generalized_morphism1, generalized_morphism2 )
    local subobject1, subobject2, factorobject1, factorobject2, isomorphism_of_subobjects, isomorphism_of_factorobjects;
    
    if IsIdenticalObj( generalized_morphism1, generalized_morphism2 ) then
    
      return true;
      
    fi;
    
    subobject1 := Domain( generalized_morphism1 );
    
    subobject2 := Domain( generalized_morphism2 );
    
    if not IsEqualAsSubobject( subobject1, subobject2 ) then
      
      return false;
      
    fi;
    
    factorobject1 := Codomain( generalized_morphism1 );
    
    factorobject2 := Codomain( generalized_morphism2 );
    
    if not IsEqualAsFactorobject( factorobject1, factorobject2 ) then
      
      return false;
      
    fi;
    
    isomorphism_of_subobjects := MonoAsKernelLift( subobject2, subobject1 );
    
    isomorphism_of_factorobjects := EpiAsCokernelColift( factorobject2, factorobject1 );
    
    return IsEqualForMorphisms( AssociatedMorphism( generalized_morphism1 ), 
                                PreCompose( PreCompose( isomorphism_of_subobjects, AssociatedMorphism( generalized_morphism2 ) ), isomorphism_of_factorobjects ) 
                              );
    
end );

##
InstallTrueMethod( CanComputeHonestRepresentative,
                   CanComputePreComposeInUnderlyingHonestCategory
                   and CanComputeInverseInUnderlyingHonestCategory );

InstallMethod( HonestRepresentative,
               [ IsGeneralizedMorphism
                 and CanComputePreComposeInUnderlyingHonestCategory
                 and CanComputeInverseInUnderlyingHonestCategory ],
               
  function( generalized_morphism )
    
    return PreCompose(
             PreCompose( Inverse( SourceAid( generalized_morphism ) ), MorphismAid( generalized_morphism ) ), 
             Inverse( RangeAid( generalized_morphism ) ) 
           );
    
end );

##
InstallTrueMethod( CanComputeAdditionForMorphisms,
                   CanComputePullbackInUnderlyingHonestCategory
                   and CanComputeProjectionInFactorOfPullbackInUnderlyingHonestCategory
                   and CanComputePushoutInUnderlyingHonestCategory
                   and CanComputeInjectionOfCofactorOfPushoutInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory
                   and CanComputeAdditionForMorphismsInUnderlyingHonestCategory );

InstallMethodWithCacheFromObject( \+,
                                 [ IsGeneralizedMorphism
                                   and CanComputePullbackInUnderlyingHonestCategory
                                   and CanComputeProjectionInFactorOfPullbackInUnderlyingHonestCategory
                                   and CanComputePushoutInUnderlyingHonestCategory
                                   and CanComputeInjectionOfCofactorOfPushoutInUnderlyingHonestCategory
                                   and CanComputePreComposeInUnderlyingHonestCategory
                                   and CanComputeAdditionForMorphismsInUnderlyingHonestCategory, 
                                   IsGeneralizedMorphism ],
                                 
  function( mor1, mor2 )
    local return_value, pullback_of_sourceaids, pushout_of_rangeaids, restricted_mor1, restricted_mor2;
    
    if not IsEqualForObjects( Source( mor1 ), Source( mor2 ) ) or not IsEqualForObjects( Range( mor1 ), Range( mor2 ) ) then
        
        Error( "morphisms are not addable" );
        
    fi;
    
    pullback_of_sourceaids := FiberProduct( SourceAid( mor1 ), SourceAid( mor2 ) );
    
    pushout_of_rangeaids := Pushout( RangeAid( mor1 ), RangeAid( mor2 ) );
    
    restricted_mor1 := PreCompose( ProjectionInFactor( pullback_of_sourceaids, 1 ), MorphismAid( mor1 ) );
    
    restricted_mor1 := PreCompose( restricted_mor1, InjectionOfCofactor( pushout_of_rangeaids, 1 ) );
    
    restricted_mor2 := PreCompose( ProjectionInFactor( pullback_of_sourceaids, 2 ), MorphismAid( mor2 ) );
    
    restricted_mor2 := PreCompose( restricted_mor2, InjectionOfCofactor( pushout_of_rangeaids, 2 ) );
    
    return_value := GeneralizedMorphism( 
                      PreCompose( ProjectionInFactor( pullback_of_sourceaids, 1 ), SourceAid( mor1 ) ),
                      restricted_mor1 + restricted_mor2,
                      PreCompose( RangeAid( mor1 ), InjectionOfCofactor( pushout_of_rangeaids, 1 ) )
                    );
    
    return return_value;
    
end );

###########################
##
## Domain, Associated Morphism, Codomain
##
###########################

##
InstallTrueMethod( CanComputeDomainAssociatedMorphismCodomainTriple,
                   CanComputePushoutInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory
                   and CanComputeInjectionOfCofactorOfPushoutInUnderlyingHonestCategory
                   and CanComputeCoastrictionToImageInUnderlyingHonestCategory
                   and CanComputePullbackInUnderlyingHonestCategory
                   and CanComputeImageEmbeddingInUnderlyingHonestCategory
                   and CanComputeProjectionInFactorOfPullbackInUnderlyingHonestCategory );

InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphism
                 and CanComputePushoutInUnderlyingHonestCategory
                 and CanComputePreComposeInUnderlyingHonestCategory
                 and CanComputeInjectionOfCofactorOfPushoutInUnderlyingHonestCategory
                 and CanComputeCoastrictionToImageInUnderlyingHonestCategory
                 and CanComputePullbackInUnderlyingHonestCategory
                 and CanComputeImageEmbeddingInUnderlyingHonestCategory
                 and CanComputeProjectionInFactorOfPullbackInUnderlyingHonestCategory ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, pushout, composition, codomain, pullback, domain, associated_morphism;
    
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
    
    pushout := Pushout( SourceAid( generalized_morphism ), MorphismAid( generalized_morphism ) );
    
    composition := PreCompose( RangeAid( generalized_morphism ), InjectionOfCofactor( pushout, 2 ) );
    
    codomain := CoastrictionToImage( composition );
    
    pullback := FiberProduct( InjectionOfCofactor( pushout, 1 ), ImageEmbedding( composition ) );
    
    domain := ProjectionInFactor( pullback, 1 );
    
    associated_morphism := ProjectionInFactor( pullback, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphism
                 and CanComputeImageEmbeddingInUnderlyingHonestCategory
                 and CanComputePushoutInUnderlyingHonestCategory
                 and CanComputeCoastrictionToImageInUnderlyingHonestCategory
                 and CanComputeInjectionOfCofactorOfPushoutInUnderlyingHonestCategory
                 and HasHonestRange ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, domain, pushout, associated_morphism, codomain;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := MorphismAid( generalized_morphism );
    
    range_aid := RangeAid( generalized_morphism );
    
    if HasIsSubobject( source_aid )
       and IsSubobject( source_aid ) then
       
       return [ source_aid, morphism_aid, range_aid ];
    
    fi;
    #trivial RangeAid
    
    domain := ImageEmbedding( source_aid );
    
    pushout := Pushout( CoastrictionToImage( source_aid ), morphism_aid );
    
    associated_morphism := InjectionOfCofactor( pushout, 1 );
    
    codomain := InjectionOfCofactor( pushout, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphism
                 and CanComputeCoastrictionToImageInUnderlyingHonestCategory
                 and CanComputePullbackInUnderlyingHonestCategory
                 and CanComputeImageEmbeddingInUnderlyingHonestCategory
                 and CanComputeProjectionInFactorOfPullbackInUnderlyingHonestCategory
                 and HasHonestSource ],
                 
  function( generalized_morphism )
    local source_aid, morphism_aid, range_aid, codomain, pullback, domain, associated_morphism;
    
    source_aid := SourceAid( generalized_morphism );
    
    morphism_aid := MorphismAid( generalized_morphism );
    
    range_aid := RangeAid( generalized_morphism );
    
    if HasIsFactorobject( range_aid )
       and IsFactorobject( range_aid ) then
       
       return [ source_aid, morphism_aid, range_aid ];
    
    fi;
    #trivial SourceAid
    
    codomain := CoastrictionToImage( range_aid );
    
    pullback := FiberProduct( morphism_aid, ImageEmbedding( range_aid ) );
    
    domain := ProjectionInFactor( pullback, 1 );
    
    associated_morphism := ProjectionInFactor( pullback, 2 );
    
    return [ domain, associated_morphism, codomain ];
    
end );

##
InstallMethod( DomainAssociatedMorphismCodomainTriple,
               [ IsGeneralizedMorphism
                 and HasHonestSource
                 and HasHonestRange ],
                 9999,
                 
  function( generalized_morphism )
    
    return [ SourceAid( generalized_morphism ), MorphismAid( generalized_morphism ), RangeAid( generalized_morphism ) ];
    
end );

## GAP-Hack in order to avoid the pre-installed GAP-method Domain
BindGlobal( "HOMALG_CATEGORIES_DOMAIN_SAVE", Domain );

MakeReadWriteGlobal( "Domain" );

Domain := function( arg )
  
  if Length( arg ) = 1 and IsGeneralizedMorphism( arg[1] ) then
      
      return DomainOp( arg[ 1 ] );
      
  fi;
  
  return CallFuncList( HOMALG_CATEGORIES_DOMAIN_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "Domain" );

##
InstallTrueMethod( CanComputeDomain, CanComputeDomainAssociatedMorphismCodomainTriple );

InstallMethod( DomainOp,
               [ IsGeneralizedMorphism and CanComputeDomainAssociatedMorphismCodomainTriple ],
               
  function( generalized_morphism )
    local domain;
    
    domain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[1];
    
    SetIsMonomorphism( domain, true );
    
    return domain;
    
end );

##
InstallTrueMethod( CanComputeAssociatedMorphism, CanComputeDomainAssociatedMorphismCodomainTriple );

InstallMethod( AssociatedMorphism,
               [ IsGeneralizedMorphism and CanComputeDomainAssociatedMorphismCodomainTriple ],
               
  function( generalized_morphism )
    
    return DomainAssociatedMorphismCodomainTriple( generalized_morphism )[2];
    
end );

##
InstallTrueMethod( CanComputeCodomain, CanComputeDomainAssociatedMorphismCodomainTriple );

InstallMethod( Codomain,
               [ IsGeneralizedMorphism and CanComputeDomainAssociatedMorphismCodomainTriple ],
               
  function( generalized_morphism )
    local codomain;
    
    codomain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[3];
    
    SetIsEpimorphism( codomain, true );
    
    return codomain;
    
end );

##
InstallTrueMethod( CanComputeIdentityMorphism, CanComputeIdentityMorphismInUnderlyingHonestCategory );

InstallMethodWithCacheFromObject( IdentityMorphism,
                                  [ IsGeneralizedMorphismCategoryObjectRep
                                    and CanComputeIdentityMorphismInUnderlyingHonestCategory ],
                                  
  function( generalized_object )
    local identity_morphism;
    
    identity_morphism := IdentityMorphism( UnderlyingHonestObject( generalized_object ) );
    
    return AsGeneralizedMorphism( identity_morphism );
    
end );

###########################
##
## Pseudo-Inverse
##
###########################

## convention: we prefer a 2-arrow calculus with honest source,
## because in the module category, pushouts are easier too compute
## than pullbacks.
##
InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphism
                 and HasHonestSource ],
               9999,
               
  function( generalized_morphism )
    
    return GeneralizedMorphismWithRangeAid( RangeAid( generalized_morphism ),
                                            MorphismAid( generalized_morphism ) );
    
end );

##
InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphism
                 and HasHonestRange ],
                 
  function( generalized_morphism )
    
    return GeneralizedMorphismWithSourceAid( MorphismAid( generalized_morphism ),
                                             SourceAid( generalized_morphism ) );
    
end );

##
InstallTrueMethod( CanComputePseudoInverse,
                   CanComputePreCompose ); 

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

###########################
##
## IsWellDefined
##
###########################

##
InstallTrueMethod( CanComputeIsWellDefinedForObjects, CanComputeIsWellDefinedForObjectsInUnderlyingHonestCategory );

InstallMethod( IsWellDefined,
               [ IsGeneralizedMorphismCategoryObjectRep
                 and CanComputeIsWellDefinedForObjectsInUnderlyingHonestCategory ],
               
  function( object )
    
    return IsWellDefined( UnderlyingHonestObject( object ) );
    
end );

##
InstallTrueMethod( CanComputeIsWellDefinedForMorphisms, CanComputeIsWellDefinedForMorphismsInUnderlyingHonestCategory );

InstallMethod( IsWellDefined,
               [ IsGeneralizedMorphismRep
                 and CanComputeIsWellDefinedForMorphismsInUnderlyingHonestCategory ],
               
  function( generalized_morphism )
    local category;
    
    category := HomalgCategory( SourceAid( generalized_morphism ) );
    
    if not ForAll( [ MorphismAid( generalized_morphism ), RangeAid( generalized_morphism ) ],
                 x -> IsIdenticalObj( HomalgCategory( x ), category ) ) then
      
      return false;
      
    fi;
    
    if not ( ForAll( [ SourceAid( generalized_morphism ), MorphismAid( generalized_morphism ), RangeAid( generalized_morphism ) ],
             IsWellDefined ) ) then
      
      return false;
      
    fi;
    
    return true;
    
end );

###########################
##
## Snake-Lemma
##
###########################

##
InstallMethodWithCacheFromObject( SnakeLemmaConnectingHomomorphism,
                                  [ IsHomalgCategoryMorphism,
                                    IsHomalgCategoryMorphism,
                                    IsHomalgCategoryMorphism,
                                    IsHomalgCategoryMorphism,
                                    IsHomalgCategoryMorphism ],
                                    
  function( morphism_up_right,
            morphism_middle_left,
            morphism_middle_middle,
            morphism_middle_right,
            morphism_down_left )
      local generalized_morphism1, generalized_morphism2, cokernel_proj, composition,
            domain, inverse_domain, associated_morphism, codomain, inverse_codomain;
            
#     composition := GeneralizedMorphism( morphism_up_right,
#                                         morphism_middle_middle,
#                                         morphism_down_left );
#     
#     associated_morphism := AssociatedMorphism( composition );
#     
#     return associated_morphism;

###################

    generalized_morphism1 := GeneralizedMorphismWithRangeAid( KernelEmb( morphism_middle_right ), morphism_up_right );
    
    generalized_morphism2 := GeneralizedMorphismWithRangeAid( morphism_middle_middle, morphism_down_left );
    
    cokernel_proj := AsGeneralizedMorphism( CokernelProj( morphism_middle_left ) );
    
    composition := PreCompose( generalized_morphism1, generalized_morphism2 );
    
    composition := PreCompose( composition, cokernel_proj );
    
    associated_morphism := AssociatedMorphism( composition );
    
    return associated_morphism;
    
end );

## Alternative implementation:

#     generalized_morphism1 := GeneralizedMorphismWithRangeAid( KernelEmb( morphism_middle_right ), morphism_up_right );
#     
#     generalized_morphism2 := GeneralizedMorphismWithRangeAid( morphism_middle_middle, morphism_down_left );
#     
#     cokernel_proj := AsGeneralizedMorphism( CokernelProj( morphism_middle_left ) );
#     
#     composition := PreCompose( generalized_morphism1, generalized_morphism2 );
#     
#     composition := PreCompose( composition, cokernel_proj );
    
#     domain := Domain( composition );
#     
#     inverse_domain := Inverse( domain );
    
    
#     
#     codomain := Codomain( composition );
#     
#     inverse_codomain := Inverse( codomain );
#     
#     return PreCompose( PreCompose( inverse_domain, associated_morphism ), inverse_codomain );

InstallMethodWithCacheFromObject( SnakeLemmaConnectingHomomorphismWithKernelAndCokernel,
                                  [ IsHomalgCategoryMorphism,
                                    IsHomalgCategoryMorphism,
                                    IsHomalgCategoryMorphism ],
                                    
  function( morphism_up_right,
            morphism_middle_middle,
            morphism_down_left )
      local generalized_morphism1, generalized_morphism2, cokernel_proj, composition,
            domain, inverse_domain, associated_morphism, codomain, inverse_codomain;
            
    composition := GeneralizedMorphism( morphism_up_right,
                                        morphism_middle_middle,
                                        morphism_down_left );
    
    associated_morphism := AssociatedMorphism( composition );
    
    return associated_morphism;
    
end );
