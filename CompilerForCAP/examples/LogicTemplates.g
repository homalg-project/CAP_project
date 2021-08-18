#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

logic_templates_orig := ShallowCopy( CAP_JIT_LOGIC_TEMPLATES );;

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
#! function ( a_1 )
#!     return function ( b_2 )
#!           return b_2 + (2 * b_2 + a_1) 
#!             + "THIS_STRING_SHOULD_NEVER_APPEAR_IN_PRODUCTION_CODE";
#!       end;
#! end

# check that functions can be used multiple times in dst_template
# add a nonsense template
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "value" ],
        src_template := "List( list, l -> value )",
        dst_template := "Sum( list, l -> value ) + Sum( list, l -> value )",
        returns_value := true,
    )
);

func := function ( list )
    return List( list, l -> l ); end;;

# we are not interested in the output, but only that this does not throw
# an error due to some function id being used multiple times
CapJitCompiledFunction( func, [ ] );;

func := function ( list )
    return List( list, l -> (x -> x) ); end;;

# we are not interested in the output, but only that this does not throw
# an error due to some function id being used multiple times
CapJitCompiledFunction( func, [ ] );;

# reset CAP_JIT_LOGIC_TEMPLATES
MakeReadWriteGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
CAP_JIT_LOGIC_TEMPLATES  := logic_templates_orig;;
MakeReadOnlyGlobal( "CAP_JIT_LOGIC_TEMPLATES" );

#! @EndExample
