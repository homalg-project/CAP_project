#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

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
#! function ( cat, mor, test_mor )
#!     local cap_jit_morphism_attribute;
#!     cap_jit_morphism_attribute 
#!      := RightDivide( UnderlyingMatrix( test_mor ), 
#!        SyzygiesOfRows( UnderlyingMatrix( mor ) ) );
#!     return ObjectifyWithAttributes( rec(
#!            ), MorphismType( cat ), CapCategory, cat, Source, 
#!        Source( test_mor ), Range, ObjectifyWithAttributes( rec(
#!              ), ObjectType( cat ), CapCategory, cat, Dimension, 
#!          NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, 
#!          UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, 
#!        UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
#! end

func1 := function( x )
    #% CAP_JIT_RESOLVE_FUNCTION
    if x = 1 then return fail; fi; return 1; end;;

func2 := function( x )
    #% CAP_JIT_RESOLVE_FUNCTION
    if x = 1 then return fail; else return 1; fi; end;;

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func3 := EvalString( ReplacedString( """function( x )
    local y@
    #% CAP_JIT_RESOLVE_FUNCTION
    if x = 1 then
        y := fail@
    else
        y := 1@
    fi@
    return y@
end""", "@", ";" ) );;

call_func1 := function( x )
    #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
    return func1( x ); end;;

call_func2 := function( x )
    #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
    return func2( x ); end;;

call_func3 := function( x )
    #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
    return func3( x ); end;;

Display( CapJitCompiledFunction( call_func1, [ 2 ] ) );
#! function ( x )
#!     return 1;
#! end
Display( CapJitCompiledFunction( call_func2, [ 2 ] ) );
#! function ( x )
#!     return 1;
#! end
Display( CapJitCompiledFunction( call_func3, [ 2 ] ) );
#! function ( x )
#!     return 1;
#! end

#! @EndExample
