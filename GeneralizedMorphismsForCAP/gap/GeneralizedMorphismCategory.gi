# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

## GAP-Hack in order to avoid the pre-installed GAP-method Domain
BindGlobal( "CAP_INTERNAL_DOMAIN_SAVE", Domain );

MakeReadWriteGlobal( "Domain" );

Domain := function( arg )
  
  if Length( arg ) = 1 and IsGeneralizedMorphism( arg[1] ) then
      
      return DomainEmbedding( arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DOMAIN_SAVE, arg );
  
end;

InstallMethod( DomainEmbedding,
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
    local associated_morphism;
    
    associated_morphism := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[2];
    
    if CapCategory( generalized_morphism )!.predicate_logic then
        
        INSTALL_TODO_LIST_FROM_GENERALIZED_TO_ASSOCIATED_MORPHISM( generalized_morphism, associated_morphism );
        
    fi;
    
    return associated_morphism;
    
end );

InstallMethod( CodomainProjection,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    local codomain;
    
    codomain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[3];
    
    SetIsEpimorphism( codomain, true );
    
    return codomain;
    
end );

InstallMethod( CommonRestriction,
               [ IsList ],
               
  function( morphism_list )
    
    if morphism_list = [ ] then
        
        return morphism_list;
        
    fi;
    
    return CommonRestrictionOp( morphism_list, morphism_list[ 1 ] );
    
end );

##
InstallMethod( IsHonest,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return HasFullDomain( generalized_morphism ) and HasFullCodomain( generalized_morphism );
    
end );

##
InstallMethod( ConcatenationProduct,
               [ IsList ],
               
  function( generalized_morphism_list )
    
    return ConcatenationProductOp( generalized_morphism_list, generalized_morphism_list[1] );
    
end );

##
InstallImmediateMethod( IsSingleValued,
                        IsGeneralizedMorphism and HasHasFullCodomain,
                        0,
                        HasFullCodomain );

##
InstallImmediateMethod( HasFullCodomain,
                        IsGeneralizedMorphism and HasIsSingleValued,
                        0,
                        IsSingleValued );

##
InstallImmediateMethod( IsTotal,
                        IsGeneralizedMorphism and HasHasFullDomain,
                        0,
                        HasFullDomain );

##
InstallImmediateMethod( HasFullDomain,
                        IsGeneralizedMorphism and HasIsTotal,
                        0,
                        IsTotal );

##
InstallMethod( IsSingleValued, 
               [ IsGeneralizedMorphism ],
               HasFullCodomain );

##
InstallMethod( IsTotal,
               [ IsGeneralizedMorphism ],
               HasFullDomain );

##
InstallMethod( GeneralizedImageEmbedding,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    local triple;
    
    triple := DomainAssociatedMorphismCodomainTriple( generalized_morphism );
    
    return ProjectionInFactorOfFiberProduct( [ ImageEmbedding( triple[ 2 ] ), triple[ 3 ] ], 2 );
    
end );

##
InstallMethod( DefectEmbedding,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return KernelEmbedding( CodomainProjection( generalized_morphism ) );
    
end );

##
InstallMethod( GeneralizedKernelEmbedding,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return DefectEmbedding( PseudoInverse( generalized_morphism ) );
    
end );

##
InstallMethod( GeneralizedCokernelProjection,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return CokernelProjection( GeneralizedImageEmbedding( generalized_morphism ) );
    
end );

##
InstallMethod( GeneralizedCoimageProjection,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return CokernelProjection( GeneralizedKernelEmbedding( generalized_morphism ) );
    
end );

##
InstallMethod( CodefectProjection,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return CokernelProjection( DomainEmbedding( generalized_morphism ) );
    
end );

##
InstallValue( PROPAGATION_LIST_FROM_GENERALIZED_TO_ASSOCIATED_MORPHISM,
        [
         "IsMonomorphism",
         "IsEpimorphism",
         "IsIsomorphism",
         #"IsSplitMonomorphism", propagating this would be wrong
         #"IsSplitEpimorphism",  propagating this would be wrong
         #"IsZero", the category of generalized morphisms has no zero objects
         # ..
         ]
        );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FROM_GENERALIZED_TO_ASSOCIATED_MORPHISM,
  function( hull, mor )
    local i;
    
    for i in PROPAGATION_LIST_FROM_GENERALIZED_TO_ASSOCIATED_MORPHISM do
        
        AddToToDoList( ToDoListEntryWithContraposition( hull, i, true, mor, i, true ) );
        
    od;
    
end );
