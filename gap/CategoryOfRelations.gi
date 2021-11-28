# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

## A morphism in the category of relations is given by a span:
##
##   R
##  / \
## v   v
## S   T

##
InstallOtherMethod( PseudoInverse,
        "for a morphism in any CAP category",
        [ IsCapCategoryMorphism ],
        
  function( morphism )
    
    return PseudoInverse( AsMorphismInCategoryOfRelations( morphism ) );
    
end );

##
InstallMethod( PseudoInverse,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],
        
  function( relation )
    
    ## switch the source leg and the range leg
    return MorphismConstructor( Range( relation ), Reversed( MorphismDatum( relation ) ), Source( relation ) );
    
end );

##
InstallMethod( EmbeddingOfRelationInDirectProduct,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    local span;
    
    span := MorphismDatum( relation ); ## [ I → S, I → T ]
    
    return ImageEmbedding( ## the mono R ↪ S × T of the epi-mono factorization of I → S × T
                   UniversalMorphismIntoDirectProduct( ## I → S × T
                           List( span, Range ),
                           Source( span[1] ), span ) );
    
end );

##
InstallMethod( SourceProjection,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    local emb, ST;
    
    emb := EmbeddingOfRelationInDirectProduct( relation ); ## R ↪ S × T
    
    ## [ S, T ]
    ST := List( [ Source( relation ), Range( relation ) ], ObjectDatum );
    
    ## R ↪ S × T → S
    return PreCompose( emb, ProjectionInFactorOfDirectProduct( ST, 1 ) );
    
end );

##
InstallMethod( RangeProjection,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    local emb, ST;
    
    emb := EmbeddingOfRelationInDirectProduct( relation ); ## R ↪ S × T
    
    ## [ S, T ]
    ST := List( [ Source( relation ), Range( relation ) ], ObjectDatum );
    
    ## R ↪ S × T → T
    return PreCompose( emb, ProjectionInFactorOfDirectProduct( ST, 2 ) );
    
end );

##
InstallMethod( StandardizedSpan,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    
    return [ SourceProjection( relation ), RangeProjection( relation ) ];
    
end );

##
InstallMethod( MorphismByStandardizedSpan,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    
    return MorphismConstructor( Source( relation ), StandardizedSpan( relation ), Range( relation ) );
    
end );

## a morphism in RelC comes from a morphism A -f-> B in C if the span defining the morhism
## is congruent in the sense of IsCongruentForMorphisms below to the span [ 1_A, f ],
## this is equivalent to saying that the domain of the morphism
## (=source leg of the standardized span) is an isomorphism in C
##
InstallMethod( IsHonest,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    
    return IsIsomorphism( SourceProjection( relation ) );
    
end );

##
InstallMethod( HonestRepresentative,
        "for a morphism in the category of relations",
        [ IsMorphismInCategoryOfRelations ],

  function( relation )
    
    return PreCompose( Inverse( SourceProjection( relation ) ), RangeProjection( relation ) );
    
end );

##
InstallMethod( CategoryOfRelations,
        "for a CAP category which is cartesian",
        [ IsCapCategory and IsCartesianCategory ],
        
  function( C )
    local RelC, finalize;

    ##
    RelC := CreateCapCategory( Concatenation( "CategoryOfRelations( ", Name( C ), " )" ) );

    ## In order to have composition in RelC we need C to have fiber products
    ## In order to replace the span with a single morphism in C we need C to have products
    ## In order to replace this single morphism in C by a monomorphism in C we need C to have images
    
    ##
    SetUnderlyingCategory( RelC, C );
    
    ##
    SetFilterObj( RelC, IsCategoryOfRelations );

    ##
    RelC!.category_as_first_argument := true;
    
    ##
    AddObjectRepresentation( RelC, IsObjectInCategoryOfRelations );
    AddMorphismRepresentation( RelC, IsMorphismInCategoryOfRelations );

    ## "the objects of RelC are the objects of C"
    ## here: object is an object in C
    AddObjectConstructor( RelC,
      function( RelC, object )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), RelC,
                       ObjectDatum, object );
        
    end );
    
    ##
    AddObjectDatum( RelC,
      function( RelC, object )
        
        return ObjectDatum( object );
        
    end );
    
    ## "a morphism in RelC is a span in C"
    ## here: morphisms is a pair of morphisms from some object in C to ObjectDatum( S ) and ObjectDatum( T )
    AddMorphismConstructor( RelC,
      function( RelC, S, morphisms, T )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), RelC,
                       S,
                       T,
                       MorphismDatum, morphisms );
        
    end );
    
    ##
    AddMorphismDatum( RelC,
      function( RelC, relation )
        
        return MorphismDatum( relation );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( RelC,
      function( RelC, object )

        if not IsIdenticalObj( CapCategory( ObjectDatum( object ) ), UnderlyingCategory( RelC ) ) then
            ## the underlying object does not belong to the underlying category
            return false;
        elif not IsWellDefinedForObjects( ObjectDatum( object ) ) then
            ## the underlying object well-defined as an object in the underlying category
            return false;
        fi;
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( RelC,
      function( RelC, relation )
        
        if not ForAll( MorphismDatum( relation ), m -> IsIdenticalObj( CapCategory( m ), UnderlyingCategory( RelC ) ) ) then
            ## at least one of two defining morphisms do not belong to the underlying category
            return false;
        elif not ForAll( MorphismDatum( relation ), IsWellDefinedForMorphisms ) then
            ## at least one of the two defining morphisms is not well-defined as a morphism in the underlying category
            return false;
        fi;
        
        return true;
        
    end );
    
    ##
    AddIsEqualForObjects( RelC,
      function( RelC, object1, object2 )
        
        return IsEqualForObjects( UnderlyingCategory( RelC ), ObjectDatum( object1 ), ObjectDatum( object2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( RelC,
      function( RelC, relation1, relation2 )
        local span1, span2;
        
        span1 := MorphismDatum( relation1 );
        span2 := MorphismDatum( relation2 );
        
        return IsEqualForMorphisms( UnderlyingCategory( RelC ), span1[1], span2[1] ) and
               IsEqualForMorphisms( UnderlyingCategory( RelC ), span1[2], span2[2] );
        
    end );

    ##
    AddIsCongruentForMorphisms( RelC,
      function( RelC, relation1, relation2 )
        local emb1, emb2;

        ## the embeddings in the underlying category of the direct product
        ## of the underlying objects of the common source and common target
        emb1 := EmbeddingOfRelationInDirectProduct( relation1 );
        emb2 := EmbeddingOfRelationInDirectProduct( relation2 );
        
        ## do the embeddings emb1 and emb2 define the same subobject of the direct product
        return IsEqualAsSubobjects( UnderlyingCategory( RelC ), emb1, emb2 );
        
    end );
    
    ## Composition here means taking the pullback of the adjacent legs of the spans
    ##
    ##      K
    ##     / \
    ##    v   v
    ##    I   J
    ##   / \ / \
    ##  v   v   v
    ## S    U   T
    ##
    AddPreCompose( RelC,
      function( RelC, pre_relation, post_relation )
        local C, diagram, K;
        
        C := UnderlyingCategory( RelC );
        
        diagram := [ MorphismDatum( pre_relation )[2], MorphismDatum( post_relation )[1] ];
        
        K := FiberProduct( C, diagram );
        
        return MorphismConstructor(
                       Source( pre_relation ),
                       [ PreCompose(
                               C,
                               ProjectionInFactorOfFiberProductWithGivenFiberProduct( C, diagram, 1, K ),
                               MorphismDatum( pre_relation )[1] ),
                         PreCompose(
                                 ProjectionInFactorOfFiberProductWithGivenFiberProduct( C, diagram, 2, K ),
                                 MorphismDatum( post_relation )[2] ) ],
                       Range( post_relation ) );
        
    end );

    ##    A
    ##   / \
    ##  v   v
    ##  A   A
    ##
    AddIdentityMorphism( RelC,
      function( RelC, object )
        local id;
        
        id := IdentityMorphism( UnderlyingCategory( RelC ), ObjectDatum( object ) );
        
        return MorphismConstructor(
                       object,
                       [ id, id ],
                       object );
        
    end );

    if CanCompute( C, "SubobjectClassifier" ) and
       CanCompute( C, "HomomorphismStructureOnObjects" ) and
       CanCompute( C, "DirectProduct" ) and
       HasRangeCategoryOfHomomorphismStructure( C ) then
       ##IsCategoryOfFinSets( RangeCategoryOfHomomorphismStructure( C ) ) then

        ##
        AddHomomorphismStructureOnObjects( RelC,
          function( RelC, object1, object2 )
            local C;
            
            C := UnderlyingCategory( RelC );
            
            return HomomorphismStructureOnObjects(
                           C,
                           DirectProduct( C, ObjectDatum( object1 ), ObjectDatum( object2 ) ),
                           SubobjectClassifier( C ) );
            
        end );
        
    fi;
    
    Finalize( RelC );
    
    return RelC;
    
end );

##
InstallOtherMethod( \/,
        [ IsCapCategoryObject, IsCategoryOfRelations ],
        
  function( M, Rel )
    
    return ObjectConstructor( Rel, M );
    
end );

##
InstallMethod( UnitObjectInCategoryOfRelations,
        [ IsCategoryOfRelations ],
        
  function( Rel )
    
    return TerminalObject( UnderlyingCategory( Rel ) ) / Rel;
    
end );

##
InstallMethod( AsMorphismInCategoryOfRelations,
        [ IsCapCategoryMorphism ],
        
  function( morphism )
    local C, Rel, S, T, rel;
    
    C := CapCategory( morphism );
    
    Rel := CategoryOfRelations( C );
    
    S := Source( morphism );
    
    T := Range( morphism );
    
    rel := MorphismConstructor( S / Rel, [ IdentityMorphism( S ), morphism ], T / Rel );
    
    SetIsHonest( rel, true );
    
    return rel;
    
end );

##
InstallMethod( MaximalRelationIntoTerminalObject,
        [ IsObjectInCategoryOfRelations ],
        
  function( object )
    return MorphismConstructor(
                   object,
                   [ IdentityMorphism( ObjectDatum( object ) ),
                     UniversalMorphismIntoTerminalObject( ObjectDatum( object ) ) ],
                   UnitObjectInCategoryOfRelations( CapCategory( object ) ) );
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( ViewObj,
        [ IsObjectInCategoryOfRelations ],
        
  function( a )
    
    Print( "An object in the category of relations given by: " );
    
    ViewObj( ObjectDatum( a ) );
    
end );

##
InstallMethod( Display,
        [ IsObjectInCategoryOfRelations ],
        
  function( a )
    
    Display( ObjectDatum( a ) );
    
    Display( "\nAn object in the category of relations given by the above data" );
    
end );
