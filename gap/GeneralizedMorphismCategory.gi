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
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY,
                       
  function( category )
    
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
                                       [ IsGeneralizedMorphism and HasHonestRange, IsGeneralizedMorphism and SetHasHonestSource ],
                                       
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not CanComputePreCompose( UnderlyingHonestCategory( category ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if not IsIdenticalObj( category, HomalgCategory( mor2 ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return GeneralizedMorphism( SourceAid( mor1 ), PreCompose( AssociatedMorphism( mor1 ), AssociatedMorphism( mor2 ) ), RangeAid( mor2 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsGeneralizedMorphism and HasHonestRange, IsGeneralizedMorphism and HasHonestRange ],
                                       
  function( mor1, mor2 )
    local category, pullback, new_source_aid, new_associated_morphism;
    
    category := HomalgCategory( mor1 );
    
    if not CanComputePreCompose( UnderlyingHonestCategory( category ) ) or not CanComputePullback( UnderlyingHonestCategory( category ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if not IsIdenticalObj( category, HomalgCategory( mor2 ) ) then
        
        TryNextMethod( );
        
    fi;
    
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
                                       [ IsGeneralizedMorphism and HasHonestSource, IsGeneralizedMorphism and HasHonestSource ],
                                       
  function( mor1, mor2 )
    local category, pushout, new_associated_morphism, new_range_aid;
    
    category := HomalgCategory( mor1 );
    
    if not CanComputePreCompose( UnderlyingHonestCategory( category ) ) or not CanComputePushout( UnderlyingHonestCategory( category ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if not IsIdenticalObj( category, HomalgCategory( mor2 ) ) then
        
        TryNextMethod( );
        
    fi;
    
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
                                       [ IsGeneralizedMorphism and IsHonest, IsGeneralizedMorphism and IsHonest ],
                                       
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not CanComputePreCompose( UnderlyingHonestCategory( category ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if not IsIdenticalObj( category, HomalgCategory( mor2 ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return AsGeneralizedMorphism( PreCompose( AssociatedMorphism( mor1 ), AssociatedMorphism( mor2 ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );


    


