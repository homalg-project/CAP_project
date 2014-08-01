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
## ToDo-Lists
##
####################################

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_GENERALIZED_MORPHISM_CATEGORY,

  function( category )
    local technical_implications, implication, entry, objects;
    
    technical_implications := [
      [
        [
          [ category, "CanComputeEqualityOfSubobjects", true ],
          [ category, "CanComputeEqualityOfFactorobjects", true ],
          [ category, "CanComputeMonoAsKernelLift", true ],
          [ category, "CanComputeEpiAsCokernelColift", true ],
          [ category, "CanComputeEqualityOfMorphisms", true ],
          [ category, "CanComputePreCompose", true ],
        ],
        "CanComputeEqualityOfMorphisms"
      ]
    ];
    
    for implication in technical_implications do
      
      entry := ToDoListEntry( Concatenation( implication[1], [ [ category, "GeneralizedMorphismCategory" ] ] ) , 
                              [ GeneralizedMorphismCategory, category ], 
                              implication[2], 
                              true 
                            );
      
      AddToToDoList( entry );
      
    od;
    
end );


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
    
    name := Name( category );
    
    name := Concatenation( "Generalized morphism category of ", name );
    
    generalized_morphism_category := CreateHomalgCategory( name );
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY( generalized_morphism_category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_GENERALIZED_MORPHISM_CATEGORY( category );
    
    return generalized_morphism_category;
    
end );

##
InstallMethod( GeneralizedMorphismObject,
               [ IsHomalgCategoryObject ],
               
  function( object )
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    return gen_object;
    
end );

##
InstallMethodWithToDoForIsWellDefined( GeneralizedMorphism,
##               [ IsHomalgCategoryMorphism, IsSubobject, IsFactorobject ], we wont check this for performance reasons.
                                       [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ],
                                       
  function( source_aid, associated_morphism, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsIdenticalObj( Source( source_aid ), Source( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    elif not IsIdenticalObj( Range( range_aid ), Range( associated_morphism ) ) then
        
        Error( "range of range aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphism,
                             Source, GeneralizedMorphismObject( Range( source_aid ) ),
                             Range, GeneralizedMorphismObject( Source( range_aid ) ),
                             SourceAid, source_aid,
                             RangeAid, range_aid,
                             AssociatedMorphism, associated_morphism );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( associated_morphism ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end : InstallMethod := InstallMethodWithToDoForIsWellDefined );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithSourceAid,
                                  [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
  function( source_aid, associated_morphism )
    local generalized_morphism;
    
    if not IsIdenticalObj( Source( source_aid ), Source( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphism( source_aid, associated_morphism, IdentityMorphism( Range( associated_morphism ) ) );
    
    SetHasHonestRange( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithRangeAid,
                                  [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
  function( associated_morphism, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsIdenticalObj( Range( range_aid ), Range( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( associated_morphism ) ), associated_morphism, range_aid );
    
    SetHasHonestSource( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethod( AsGeneralizedMorphism,
               [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism ],
               
  function( associated_morphism )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( associated_morphism ) ), associated_morphism, IdentityMorphism( Range( associated_morphism ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsGeneralizedMorphism 
                                         and HasHonestRange
                                         and CanComputePreComposeInUnderlyingHonestCategory,
                                         IsGeneralizedMorphism and HasHonestSource ],
                                       
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return GeneralizedMorphism( SourceAid( mor1 ), PreCompose( AssociatedMorphism( mor1 ), AssociatedMorphism( mor2 ) ), RangeAid( mor2 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsGeneralizedMorphism 
                                         and HasHonestRange
                                         and CanComputePreComposeInUnderlyingHonestCategory
                                         and CanComputePullbackInUnderlyingHonestCategory,
                                         IsGeneralizedMorphism and HasHonestRange ],
                                       
  function( mor1, mor2 )
    local category, pullback, new_source_aid, new_associated_morphism;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    pullback := FiberProduct( AssociatedMorphism( mor1 ), SourceAid( mor2 ) );
    
    new_source_aid := PreCompose( ProjectionInFactor( pullback, 1 ), SourceAid( mor1 ) );
    
    new_associated_morphism := PreCompose( ProjectionInFactor( pullback, 2 ), AssociatedMorphism( mor2 ) );
    
    return GeneralizedMorphismWithSourceAid( new_source_aid, new_associated_morphism );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsGeneralizedMorphism
                                         and HasHonestSource
                                         and CanComputePreComposeInUnderlyingHonestCategory
                                         and CanComputePushoutInUnderlyingHonestCategory,
                                       IsGeneralizedMorphism and HasHonestSource ],
                                       
  function( mor1, mor2 )
    local category, pushout, new_associated_morphism, new_range_aid;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    pushout := Pushout( RangeAid( mor1 ), AssociatedMorphism( mor2 ) );
    
    new_associated_morphism := PreCompose( AssociatedMorphism( mor1 ), InjectionOfCofactor( pushout, 1 ) );
    
    new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactor( pushout, 2 ) );
    
    return GeneralizedMorphismWithRangeAid( new_associated_morphism, new_range_aid );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsGeneralizedMorphism
                                         and IsHonest
                                         and CanComputePreComposeInUnderlyingHonestCategory,
                                       IsGeneralizedMorphism and IsHonest ],
                                       
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return AsGeneralizedMorphism( PreCompose( AssociatedMorphism( mor1 ), AssociatedMorphism( mor2 ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallTrueMethod( CanComputeGeneralizedMorphismFromFactorToSubobject, 
                   CanComputeKernelEmb and
                   CanComputeUniversalMorphismFromCoproduct and
                   CanComputeImageEmbedding and
                   CanComputeMonoAsKernelLift and
                   CanComputeCokernelProj and
                   CanComputeCokernelColift and
                   CanComputePreCompose and
                   CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( GeneralizedMorphismFromFactorToSubobject,
                                       [ IsHomalgCategoryMorphism and
                                         CanComputeKernelEmb and
                                         CanComputeUniversalMorphismFromCoproduct and
                                         CanComputeImageEmbedding and
                                         CanComputeMonoAsKernelLift and
                                         CanComputeCokernelProj and
                                         CanComputeCokernelColift and
                                         CanComputePreCompose and
                                         CanComputeIdentityMorphism,
                                         IsHomalgCategoryMorphism ],
                                         
  function( factor, subobject )
    local A_into_B, B_onto_BmodC, C_into_B, AoplusC_to_B, AplusC_into_B, C_into_AplusC, AplusC_onto_M, M, M_into_BmodC, A_into_AplusC, A_onto_M;
    
    # Notation:
    # subobject: A -> B, factor: B -> B/C
    # we want to construct: M := (A + C)/C and a generalized morphism: B/C - - - > A
    
    A_into_B := subobject;
    
    B_onto_BmodC := factor;
    
    C_into_B := KernelEmb( B_onto_BmodC );
    
    AoplusC_to_B := UniversalMorphismFromCoproduct( A_into_B, C_into_B );
    
    AplusC_into_B := ImageEmbedding( AoplusC_to_B );
    
    C_into_AplusC := MonoAsKernelLift( AplusC_into_B, C_into_B );
    
    AplusC_onto_M := CokernelProj( C_into_AplusC );
    
    M := Range( AplusC_onto_M );
    
    M_into_BmodC := CokernelColift( M, PreCompose( AplusC_into_B, B_onto_BmodC ) );
    
    A_into_AplusC := MonoAsKernelLift( AplusC_into_B, A_into_B );
    
    A_onto_M := PreCompose( A_into_AplusC, AplusC_onto_M );
    
    return GeneralizedMorphism( M_into_BmodC, IdentityMorphism( M ), A_onto_M );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsGeneralizedMorphism 
                                         and CanComputeGeneralizedMorphismFromFactorToSubobjectInUnderlyingHonestCategory
                                         and CanComputePullbackInUnderlyingHonestCategory
                                         and CanComputePushoutInUnderlyingHonestCategory
                                         and CanComputePreComposeInUnderlyingHonestCategory,
                                         IsGeneralizedMorphism ],
                                       
  function( mor1, mor2 )
    local generalized_mor_factor_sub, pullback, pushout, new_associated, new_source_aid, new_range_aid;
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    generalized_mor_factor_sub := GeneralizedMorphismFromFactorToSubobject( RangeAid( mor1 ), SourceAid( mor2 ) );
    
    pullback := FiberProduct( AssociatedMorphism( mor1 ), SourceAid( generalized_mor_factor_sub ) );
    
    pushout := Pushout( RangeAid( generalized_mor_factor_sub ), AssociatedMorphism( mor2 ) );
    
    new_source_aid := PreCompose( ProjectionInFactor( pullback, 1 ), SourceAid( mor1 ) );
    
    new_associated := PreCompose( ProjectionInFactor( pullback, 2 ), InjectionOfCofactor( pushout, 1 ) );
    
    new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactor( pushout, 2 ) );
    
    return GeneralizedMorphism( new_source_aid, new_associated, new_range_aid );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

## CanCompute management in ToDoList of category
InstallMethodWithCacheFromObject( EqualityOfMorphisms,
                                  [ IsGeneralizedMorphism, IsGeneralizedMorphism ],
                                  
  function( generalized_morphism1, generalized_morphism2 )
    local subobject1, subobject2, factorobject1, factorobject2, isomorphism_of_subobjects, isomorphism_of_factorobjects;
    
    subobject1 := SourceAid( generalized_morphism1 );
    
    subobject2 := SourceAid( generalized_morphism2 );
    
    factorobject1 := RangeAid( generalized_morphism1 );
    
    factorobject2 := RangeAid( generalized_morphism2 );
    
    if not IsEqualAsSubobject( subobject1, subobject2 ) or
       not IsEqualAsFactorobject( factorobject1, factorobject2 ) then
      
      return false;
      
    fi;
    
    isomorphism_of_subobjects := MonoAsKernelLift( subobject2, subobject1 );
    
    isomorphism_of_factorobjects := EpiAsCokernelColift( factorobject2, factorobject1 );
    
    return EqualityOfMorphisms( AssociatedMorphism( generalized_morphism1 ), PreCompose( PreCompose( isomorphism_of_subobjects, AssociatedMorphism( generalized_morphism2 ) ), isomorphism_of_factorobjects ) );
    
end );