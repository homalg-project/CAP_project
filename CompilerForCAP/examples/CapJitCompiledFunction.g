#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

Q := HomalgFieldOfRationals();;
vec := MATRIX_CATEGORY( Q );;

# test CapJitCompiledFunction with explicit type signature
Display(
    CapJitCompiledFunction(
        cat -> ZeroObject( cat ),
        [
            [
                rec(
                    filter := IsCapCategory,
                    category := vec
                )
            ],
            fail,
        ]
    )
);
#! function ( cat_1 )
#!     return ObjectifyObjectForCAPWithAttributes( rec(
#!            ), cat_1, Dimension, 0 );
#! end

#! @EndExample
