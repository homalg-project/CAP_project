#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

Q := HomalgFieldOfRationals();;
vec := MATRIX_CATEGORY( Q : enable_compilation := true );;

func := function ( cat, x )
    #% CAP_JIT_RESOLVE_FUNCTION
    return ZeroObject( cat ); end;;

# make sure that ZeroObject( cat ) is not resolved to a global variable
Display( CapJitCompiledFunction( { cat, x } -> func( cat, x ), [ vec ] ) );
#! function ( cat, x )
#!     return ObjectifyWithAttributes( rec(
#!            ), ObjectType( cat ), CapCategory, cat, Dimension, 0, 
#!        UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
#! end

#! @EndExample
