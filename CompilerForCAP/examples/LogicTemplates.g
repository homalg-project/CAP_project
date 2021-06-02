#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

GUARD_STRING := "\"THIS_STRING_SHOULD_NEVER_APPEAR_IN_PRODUCTION_CODE\"";;

# add a nonsense template
logic_template := rec(
    variable_names := [ "variable" ],
    src_template := "x -> x + variable + x - x",
    dst_template := Concatenation( "x -> x + variable + ", GUARD_STRING ),
    returns_value := true,
);;

CapJitAddLogicTemplate( logic_template );

func := function ( a )
    return b -> b + ( 2 * b + a ) + b - b; end;;

Display( CapJitCompiledFunction( func, [ ] ) );
#! function ( a )
#!     return function ( b )
#!           return b + (2 * b + a) 
#!             + "THIS_STRING_SHOULD_NEVER_APPEAR_IN_PRODUCTION_CODE";
#!       end;
#! end

# remove the last template again and make sure it is
# the one we have added above
MakeReadWriteGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
Remove( CAP_JIT_LOGIC_TEMPLATES ) = logic_template;
#! true
MakeReadOnlyGlobal( "CAP_JIT_LOGIC_TEMPLATES" );

#! @EndExample
