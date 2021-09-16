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
Display( compiled_func );
#! function ( cat_1, mor_1, test_mor_1 )
#!     local cap_jit_morphism_attribute_1;
#!     cap_jit_morphism_attribute_1 
#!      := RightDivide( UnderlyingMatrix( test_mor_1 ), 
#!        SyzygiesOfRows( UnderlyingMatrix( mor_1 ) ) );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, Source( test_mor_1 ), 
#!        ObjectifyObjectForCAPWithAttributes( rec(
#!              ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ) )
#!         , UnderlyingMatrix, cap_jit_morphism_attribute_1 );
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
