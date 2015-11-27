#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

## GAP-Hack in order to avoid the pre-installed GAP-method Domain
BindGlobal( "CAP_INTERNAL_DOMAIN_SAVE", Domain );

MakeReadWriteGlobal( "Domain" );

Domain := function( arg )
  
  if Length( arg ) = 1 and IsGeneralizedMorphism( arg[1] ) then
      
      return DomainOfGeneralizedMorphism( arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DOMAIN_SAVE, arg );
  
end;

InstallMethod( DomainOfGeneralizedMorphism,
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
