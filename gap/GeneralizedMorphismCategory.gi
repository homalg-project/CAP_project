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

DeclareRepresentation( "IsGeneralizedMorphismWithSourceAidRep",
                       IsHomalgCategoryMorphismRep and IsGeneralizedMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismWithSourceAid",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsGeneralizedMorphismWithSourceAidRep ) );

DeclareRepresentation( "IsGeneralizedMorphismWithRangeAidRep",
                       IsHomalgCategoryMorphismRep and IsGeneralizedMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismWithRangeAid",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsGeneralizedMorphismWithRangeAidRep ) );

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
                                       
  function( associated_morphism, source_aid, range_aid )
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
InstallMethodWithToDoForIsWellDefined( GeneralizedMorphismWithSourceAid,
                                       [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
  function( associated_morphism, source_aid )
    local generalized_morphism, generalized_category;
    
    if not IsIdenticalObj( Source( source_aid ), Source( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphismWithSourceAid,
                             Source, GeneralizedMorphismObject( Range( source_aid ) ),
                             Range, GeneralizedMorphismObject( Range( associated_morphism ) ),
                             SourceAid, source_aid,
                             RangeAid, IdentityMorphism( Range( associated_morphism ) ),
                             AssociatedMorphism, associated_morphism );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( associated_morphism ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallMethodWithToDoForIsWellDefined( GeneralizedMorphismWithRangeAid,
                                       [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
  function( associated_morphism, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsIdenticalObj( Range( range_aid ), Range( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphismWithRangeAid,
                             Source, GeneralizedMorphismObject( Source( associated_morphism ) ),
                             Range, GeneralizedMorphismObject( Source( range_aid ) ),
                             SourceAid, IdentityMorphism( Source( associated_morphism ) ),
                             RangeAid, range_aid,
                             AssociatedMorphism, associated_morphism );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( associated_morphism ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end : InstallMethod := InstallMethodWithToDoForIsWellDefined );

##
InstallMethodWithToDoForIsWellDefined( AsGeneralizedMorphism,
                                       [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism ],
               
  function( associated_morphism )
    local generalized_morphism, generalized_category;
    
    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphismWithRangeAid,
                             Source, GeneralizedMorphismObject( Source( associated_morphism ) ),
                             Range, GeneralizedMorphismObject( Range( associated_morphism ) ),
                             SourceAid, IdentityMorphism( Source( associated_morphism ) ),
                             RangeAid, IdentityMorphism( Range( associated_morphism ) ),
                             AssociatedMorphism, associated_morphism );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( associated_morphism ) );
    
    Add( generalized_category, generalized_morphism );
    
    SetIsHonest( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

