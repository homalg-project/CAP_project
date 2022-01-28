#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true

Q := HomalgFieldOfRationals();;
rows := MatrixCategory( Q );;

MyKernelLift := function( cat, mor, test_mor )
    #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
    return LiftOrFail( cat, test_mor, KernelEmbedding( cat, mor ) ); end;;

V := VectorSpaceObject( 2, Q );;
compiled_func := CapJitCompiledFunction(
    MyKernelLift,
    [ rows, ZeroMorphism( V, V ), IdentityMorphism( V ) ]
);;
#! WARNING: Compiling CAP operation LiftOrFail with return_type morphism_or_fail.\
#!  Operations returning fail usually do not fulfill the requirements that all br\
#! anches of an if statement can be executed even if the corresponding condition \
#! does not hold. This might cause errors.
Display( compiled_func );
#! function ( cat_1, mor_1, test_mor_1 )
#!     local morphism_attr_1_1;
#!     morphism_attr_1_1 := RightDivide( UnderlyingMatrix( test_mor_1 ), 
#!        SyzygiesOfRows( UnderlyingMatrix( mor_1 ) ) );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, Source( test_mor_1 ), 
#!        ObjectifyObjectForCAPWithAttributes( rec(
#!              ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), 
#!        UnderlyingMatrix, morphism_attr_1_1 );
#! end

func1 := function( x )
    #% CAP_JIT_RESOLVE_FUNCTION
    if x = 1 then return fail; fi; return 1; end;;

func2 := function( x )
    #% CAP_JIT_RESOLVE_FUNCTION
    if x = 1 then return fail; else return 1; fi; end;;

call_func1 := function( x )
    #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
    return func1( x ); end;;

call_func2 := function( x )
    #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
    return func2( x ); end;;

Display( CapJitCompiledFunction( call_func1, [ 2 ] ) );
#! function ( x_1 )
#!     return 1;
#! end
Display( CapJitCompiledFunction( call_func2, [ 2 ] ) );
#! function ( x_1 )
#!     return 1;
#! end

#! @EndExample
