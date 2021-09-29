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

# check that functions in variables can match
CapJitAddLogicTemplate( rec(
    variable_names := [ "L1", "L2", "func" ],
    src_template := "Concatenation( List( L1, func ), List( L2, func ) )",
    dst_template := "List( Concatenation( L1, L2 ), func )",
    returns_value := true,
) );;

func := function ( L1, L2 )
    return Concatenation( List( L1, x -> x ), List( L2, x -> x ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogicTemplates( tree, [ ] );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( L1_1, L2_1 )
#!     return List( Concatenation( L1_1, L2_1 ), function ( x_2 )
#!             return x_2;
#!         end );
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
    return List( list, x -> x ); end;;

Display( CapJitCompiledFunction( func, [ ] ) );;
#! function ( list_1 )
#!     return Sum( list_1, function ( x_2 )
#!               return x_2;
#!           end ) + Sum( list_1, function ( x_2 )
#!               return x_2;
#!           end );
#! end

func := function ( list )
    return List( list, x -> (y -> y) ); end;;
Display( CapJitCompiledFunction( func, [ ] ) );;
#! function ( list_1 )
#!     return Sum( list_1, function ( x_2 )
#!               return function ( y_3 )
#!                     return y_3;
#!                 end;
#!           end ) + Sum( list_1, function ( x_2 )
#!               return function ( y_3 )
#!                     return y_3;
#!                 end;
#!           end );
#! end

# check that functions with assignments to local variables do not match
# logic templates without assignments to local variables
CapJitAddLogicTemplate( rec(
    variable_names := [ "value" ],
    src_template := "List( [ 1 ], l -> value )",
    dst_template := "(l -> value)(1)",
    returns_value := true,
) );;

func := function ( x )
    return List( [ 1 ], function ( y )
        local r; r := x; return r; end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogicTemplates( tree, [ ] );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( x_1 )
#!     return List( [ 1 ], function ( y_2 )
#!             local r_2;
#!             r_2 := x_1;
#!             return r_2;
#!         end );
#! end

# reset CAP_JIT_LOGIC_TEMPLATES
MakeReadWriteGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
CAP_JIT_LOGIC_TEMPLATES  := logic_templates_orig;;
MakeReadOnlyGlobal( "CAP_JIT_LOGIC_TEMPLATES" );

#! @EndExample
