# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

## prepare functions for (co)products

##
BindGlobal( "CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT",
  function( binary_direct_product_func, category )
    return function( cat, diagram )
      local direct_product, i;
        
        # Direct product diagrams are supposed to have at least length 1
        direct_product := diagram[ 1 ];
        
        for i in [ 2 .. Length( diagram ) ] do
            direct_product := binary_direct_product_func( cat, direct_product, diagram[ i ] );
        od;
        
        return direct_product;
    end;
end );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT,
                       "BinaryDirectSumToDirectSum",
                       "turns a binary direct sum function into a n-ary direct sum function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT,
                       "BinaryDirectProductToDirectProduct",
                       "turns a binary direct product function into a n-ary direct product function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT,
                       "BinaryCoproductToCoproduct",
                       "turns a binary coproduct function into a n-ary coproduct function" );

##
BindGlobal( "GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT",
  function( direct_product_method, limit_or_colimit )
    return function( projection_in_factor_of_binary_direct_product_func, category )
        return function( cat, diagram, projection_number )
          local projection, left_hand_side_diagram, left_hand_side_direct_product, i, current_factor, current_projection;
            
            if projection_number = 1 then
                projection := IdentityMorphism( diagram[ 1 ] );
            else
                left_hand_side_diagram := diagram{ [ 1 .. ( projection_number - 1 ) ] };
                left_hand_side_direct_product := direct_product_method( left_hand_side_diagram );
                
                projection := projection_in_factor_of_binary_direct_product_func( cat, left_hand_side_direct_product, diagram[ projection_number ], 2 );
            fi;
            
            for i in [ ( projection_number + 1 ) .. Length( diagram ) ] do
                if limit_or_colimit = "limit" then
                    current_factor := Source( projection );
                else
                    current_factor := Range( projection );
                fi;
                
                current_projection := projection_in_factor_of_binary_direct_product_func( cat, current_factor, diagram[ i ], 1 );

                if limit_or_colimit = "limit" then
                    projection := PreCompose( current_projection, projection );
                else
                    projection := PreCompose( projection, current_projection );
                fi;
            od;
            
            return projection;
    end;
  end;
end );

CAPAddPrepareFunction( GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT( DirectSum, "limit" ),
                       "ProjectionInFactorOfBinaryDirectSumToProjectionInFactorOfDirectSum",
                       "turns a projection in factor of binary direct sum function into a projection in factor of n-ary direct sum function",
                       [ "DirectSum" ] );

CAPAddPrepareFunction( GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT( DirectProduct, "limit" ),
                       "ProjectionInFactorOfBinaryDirectProductToProjectionInFactorOfDirectProduct",
                       "turns a projection in factor of binary direct product function into a projection in factor of n-ary direct product function",
                       [ "DirectProduct" ] );

CAPAddPrepareFunction( GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT( Coproduct, "colimit" ),
                       "InjectionOfCofactorOfBinaryCoproductToInjectionOfCofactorOfCoproduct",
                       "turns an injection of cofactor of binary coproduct function into an injection of cofactor of n-ary coproduct function",
                       [ "Coproduct" ] );

##
BindGlobal( "CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT",
  function( universal_morphism_into_binary_direct_product_func, category )
    return function( cat, diagram, test_object, tau )
      local universal_morphism, i;
        
        # Direct product diagrams are supposed to have at least length 1
        universal_morphism := tau[ 1 ];
        
        for i in [ 2 .. Length( diagram ) ] do
            universal_morphism := universal_morphism_into_binary_direct_product_func( cat, universal_morphism, tau[ i ] );
        od;
        
        return universal_morphism;
    end;
end );

CAPAddPrepareFunction( CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT,
                       "UniversalMorphismIntoBinaryDirectSumToUniversalMorphismIntoDirectSum",
                       "turns a universal morphism into binary direct sum function into a universal morphism into n-ary direct sum function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT,
                       "UniversalMorphismIntoBinaryDirectProductToUniversalMorphismIntoDirectProduct",
                       "turns a universal morphism into binary direct product function into a universal morphism into n-ary direct product function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT,
                       "UniversalMorphismFromBinaryCoproductToUniversalMorphismFromCoproduct",
                       "turns a universal morphism from binary coproduct function into a universal morphism from n-ary coproduct function" );
