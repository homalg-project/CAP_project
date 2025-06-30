# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

InstallMethod( LiftCovariantEndoFunctorToSerreQuotientCategory,
               [ IsCapCategory, IsCapFunctor ],
               
  function( serre_category, functor )
    local new_functor, object_func;
    
    new_functor := CapFunctor( Concatenation( "Lifted ", Name( functor ) ), serre_category, serre_category );
    
    object_func := function( object )
        local underlying_honest, new_honest;
        
        underlying_honest := UnderlyingHonestObject( object );
        
        new_honest := ApplyFunctor( functor, underlying_honest );
        
        return AsSerreQuotientCategoryObject( serre_category, new_honest );
        
    end;
    
    AddObjectFunction( new_functor, object_func );
    
    return new_functor;
    
end );

InstallMethod( LiftNaturalIsoFromIdToSomeToSerreQuotientCategory,
               [ IsCapCategory, IsCapNaturalTransformation ],
               
  function( serre_category, nat_trans )
    local new_nat_trans, new_source, new_range, nat_trans_func;
    
    new_source := IdentityMorphism( AsCatObject( serre_category ) );
    
    new_range := LiftCovariantEndoFunctorToSerreQuotientCategory( serre_category, Range( nat_trans ) );
    
    new_nat_trans := NaturalTransformation( Concatenation( "Lifted ", Name( nat_trans ) ), new_source, new_range );
    
    nat_trans_func := function( new_source, obj, new_range )
        local new_mor;
        
        new_mor := ApplyNaturalTransformation( nat_trans, UnderlyingHonestObject( obj ) );
        
        return AsSerreQuotientCategoryMorphism( serre_category, new_mor );
        
    end;
    
    AddNaturalTransformationFunction( new_nat_trans, nat_trans_func );
    
    return new_nat_trans;
    
end );

InstallGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );

    AddIsWellDefinedForObjects( category,
      
      function( cat, object )

        return IsWellDefined( UnderlyingHonestCategory( cat ), UnderlyingHonestObject( object ) );
        
    end );
    
    AddIsWellDefinedForMorphisms( category,
      
      function( cat, morphism )
        local generalized_morphism;
        
        generalized_morphism := UnderlyingGeneralizedMorphism( morphism );
        
        return
          membership_function( Range( CodefectProjection( generalized_morphism ) ) ) and
          membership_function( Source( DefectEmbedding( generalized_morphism ) ) );
        
    end );
    
end );

####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
               [ IsCapCategoryObject, IsSerreQuotientCategory ],
               
  function( obj, serre_category )
    
    return AsSerreQuotientCategoryObject( serre_category, obj );
    
end );
