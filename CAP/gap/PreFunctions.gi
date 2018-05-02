#############################################################################
##
##                                               CAP package
##
##  Copyright 2017, Sebastian Gutsche, Siegen University
##                  Sebastian Posur,   Siegen University
##
#! @Chapter Prepare functions
##
#############################################################################

BindGlobal( "CAP_PREFUNCTION_BINARY_PRODUCT_TO_PRODUCT",
  function( binary_product_func, category )
    return function( diagram )
      local product, i;
        
        # Direct sum diagrams are supposed to have at least length 1
        product := diagram[ 1 ];
        
        for i in [ 2 .. Length( diagram ) ] do
            product := binary_product_func( product, diagram[ i ] );
        od;
        
        return product;
    end;
end );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_PRODUCT_TO_PRODUCT,
                       "BinaryDirectSumToDirectSum",
                       "turns a binary direct sum function into a n-ary direct sum" );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_PRODUCT_TO_PRODUCT,
                       "BinaryDirectProductToDirectProduct",
                       "turns a binary direct product function into a n-ary direct product" );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_PRODUCT_TO_PRODUCT,
                       "BinaryCoproductToCoproduct",
                       "turns a binary coproduct function into a n-ary coproduct" );
