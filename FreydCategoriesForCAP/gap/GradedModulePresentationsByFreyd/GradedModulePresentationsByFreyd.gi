##############################################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
## The CAP category of graded module presentations for CAP by use of Freyd categories
##
##############################################################################################


######################################
##
## Section CAP categories
##
######################################

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodLeft,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    local cat;
  
    # set name of category
    cat := FreydCategory( CAPCategoryOfGradedRows( graded_ring ) );
    cat!.Name := Concatenation( "Category of graded left module presentations over ", RingName( graded_ring ) );

    # return category
    return cat;

end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodRight,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    local cat;

    # set name of category
    cat := FreydCategory( CAPCategoryOfGradedColumns( graded_ring ) );
    cat!.Name := Concatenation( "Category of graded right module presentations over ", RingName( graded_ring ) );

    # return category
    return cat;

end );



######################################################################
##
##  Section The GAP Categories for graded module presentations for CAP
##
######################################################################

##
DeclareRepresentation( "IsGradedLeftOrRightModulePresentationForCAPRep",
                       IsGradedLeftOrRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftOrRightModulePresentationsForCAP,
                     IsGradedLeftOrRightModulePresentationForCAPRep ) );

##
DeclareRepresentation( "IsGradedLeftModulePresentationForCAPRep",
                       IsGradedLeftModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationsForCAP,
                     IsGradedLeftModulePresentationForCAPRep ) );

##
DeclareRepresentation( "IsGradedRightModulePresentationForCAPRep",
                       IsGradedRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationsForCAP,
                     IsGradedRightModulePresentationForCAPRep ) );




#######################################################################
##
##  Section The GAP Categories for graded module presentation morphisms
##
#######################################################################

##
DeclareRepresentation( "IsGradedLeftOrRightModulePresentationMorphismForCAPRep",
                       IsGradedLeftOrRightModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP,
                     IsGradedLeftOrRightModulePresentationMorphismForCAPRep ) );

##
DeclareRepresentation( "IsGradedLeftModulePresentationMorphismForCAPRep",
                       IsGradedLeftModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationMorphismsForCAP,
                     IsGradedLeftModulePresentationMorphismForCAPRep ) );

##
DeclareRepresentation( "IsGradedRightModulePresentationMorphismForCAPRep",
                       IsGradedRightModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationMorphismsForCAP,
                     IsGradedRightModulePresentationMorphismForCAPRep ) );



######################################
##
## Section Specialised constructors
##
######################################

##
InstallMethod( FreydCategoryObject,
               [ IsCapCategoryMorphism and IsGradedRowOrColumnMorphism ],
  function( relation_morphism )
    local category, object, type;

    # identify category and type
    if IsGradedRowMorphism( relation_morphism ) then
      category := SfpgrmodLeft( UnderlyingHomalgGradedRing( relation_morphism ) );
      type := TheTypeOfGradedLeftModulePresentationForCAP;      
    else
      category := SfpgrmodRight( UnderlyingHomalgGradedRing( relation_morphism ) );
      type := TheTypeOfGradedRightModulePresentationForCAP;
    fi;

    # objectify
    object := rec( );
    ObjectifyWithAttributes( object, type,
                             RelationMorphism, relation_morphism );

    # add it to the freyd category
    Add( category, object );

    # and return it
    return object;    

end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsFreydCategoryObject and IsGradedLeftOrRightModulePresentationForCAP,
                 IsCapCategoryMorphism and IsGradedRowOrColumnMorphism,
                 IsFreydCategoryObject and IsGradedLeftOrRightModulePresentationForCAP ],
  function( source, morphism_datum, range )
    local underlying_category, morphism, category, type;

    # extract the underlying projecitve category
    underlying_category := UnderlyingCategory( CapCategory( source ) );

    # check if the input data is valid
    if not IsIdenticalObj( CapCategory( RelationMorphism( source ) ), CapCategory( morphism_datum ) ) then

      Error( "The morphism and the source do not belong to the same category" );
      return;

    elif not IsIdenticalObj( CapCategory( RelationMorphism( range ) ), CapCategory( morphism_datum ) ) then

      Error( "The morphism and the range do not belong to the same category" );
      return;

    elif not IsEqualForObjects( Range( RelationMorphism( source ) ), Source( morphism_datum ) ) then

      Error( "The source of the morphism and the range of the presentation morphism of the source do not match" );
      return;

    elif not IsEqualForObjects( Range( RelationMorphism( range ) ), Range( morphism_datum ) ) then

      Error( "The range of the morphism and the range of the presentation morphism of the range do not match" );
      return;

    fi;

    # we found that the input is valid - although we have not yet checked that it is well-defined as well, i.e.
    # that there is a morphism of the sources that makes the following diagram commute
    # source: A --> B
    #               ^
    # mapping:      morphism
    #               |
    # range:  C --> D

    # this is to be checked in the IsWellDefined methods, but will not be performed here (performance)

    # set the type
    if IsGradedRowMorphism( morphism_datum ) then
      type := TheTypeOfGradedLeftModulePresentationMorphismForCAP;
    else
      type := TheTypeOfGradedRightModulePresentationMorphismForCAP;
    fi;

    # objectify the morphism_datum
    morphism := rec( );
    ObjectifyWithAttributes( morphism, type,
                             Source, source,
                             Range, range,
                             MorphismDatum, morphism_datum );

    # then add it to the corresponding category
    Add( CapCategory( source ), morphism );

    # and return the object
    return morphism;

end );


##############################################
##
## HOM-Embedding for convenience
##
##############################################

InstallGlobalFunction( INTERNAL_HOM_FOR_GRADED_MODULE_PRESENTATIONS_VIA_FREYD,
  function( a,b )

      local mor, range, source, map, emb_matrix, emb_map, kernel_relations, kernel;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). 
      # Then we have to compute the kernel embedding of the following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # (1) compute source
      mor := TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( Range( RelationMorphism( a ) ) ) ),
                                       RelationMorphism( b ) );
      source := FreydCategoryObject( mor ); 
      
      # (2) compute range
      mor := TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( Source( RelationMorphism( a ) ) ) ),
                                       RelationMorphism( b ) );
      range := FreydCategoryObject( mor );

      # (3) compute morphism
      mor := TensorProductOnMorphisms( DualOnMorphisms( RelationMorphism( a ) ),
                                       IdentityMorphism( Range( RelationMorphism( b ) ) ) );
                                       
      # (4) construct map, reduce it if possible and return the kernel embedding
      map := FreydCategoryMorphism( source, mor, range );
      # map := ByASmallerPresentation( map ); #### FIXME

      return KernelEmbedding( map );

end );

InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING,
                           [ IsGradedLeftModulePresentationForCAP, IsGradedLeftModulePresentationForCAP ],
    function( a, b )

        return INTERNAL_HOM_FOR_GRADED_MODULE_PRESENTATIONS_VIA_FREYD( a,b );

end );


InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING,
                           [ IsGradedRightModulePresentationForCAP, IsGradedRightModulePresentationForCAP ],
    function( a, b )

        return INTERNAL_HOM_FOR_GRADED_MODULE_PRESENTATIONS_VIA_FREYD( a,b );

end );
