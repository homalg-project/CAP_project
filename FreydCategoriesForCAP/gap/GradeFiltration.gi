# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

##
InstallMethod( GradeFiltrationNthNaturalTransformationOp,
               [ IsCapCategory, IsInt ],
               
  function( underlying_category, n ) 
    local nat_trans;
    
    if n <= 1 then
        
        return CounitOfSatelliteAdjunctionOfAdelmanCategory( underlying_category );
        
    fi;
    
    nat_trans := GradeFiltrationNthNaturalTransformation( underlying_category, n - 1 );
    
    nat_trans := 
        HorizontalPreComposeNaturalTransformationWithFunctor( nat_trans, RightSatelliteAsEndofunctorOfAdelmanCategory( underlying_category ) );
    
    nat_trans := 
        HorizontalPreComposeFunctorWithNaturalTransformation( LeftSatelliteAsEndofunctorOfAdelmanCategory( underlying_category ), nat_trans );
    
    return nat_trans;
    
end );

##
InstallMethod( GradeFiltrationNthNaturalTransformationComponentOp,
               [ IsAdelmanCategoryObject, IsInt ],
               
  function( adel_obj, n )
    local underlying_category;
    
    underlying_category := UnderlyingCategory( CapCategory( adel_obj ) );
    
    return ApplyNaturalTransformation(
            GradeFiltrationNthNaturalTransformation( underlying_category, n ),
            adel_obj
    );
    
end );

##
InstallMethod( GradeFiltrationNthMonomorphismOp,
               [ IsFreydCategoryObject, IsInt ],
                
  function( freyd_obj, n )
    local underlying_category, nat, emb, adel_obj, adel_mor;
    
    underlying_category := UnderlyingCategory( CapCategory( freyd_obj ) );
    
    adel_obj := ApplyFunctor( EmbeddingFunctorOfFreydCategoryIntoAdelmanCategory( underlying_category ), freyd_obj );
    
    adel_mor := GradeFiltrationNthNaturalTransformationComponent( adel_obj, n );
    
    return ApplyFunctor( ProjectionFunctorAdelmanCategoryToFreydCategory( underlying_category ), adel_mor );
    
end );
