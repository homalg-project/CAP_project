#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

applied_non_enhanced_logic_template_to_func :=
    { func, template, jit_args } ->
        ENHANCED_SYNTAX_TREE_CODE(
            CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATE(
                ENHANCED_SYNTAX_TREE( func ),
                CAP_JIT_INTERNAL_ENHANCED_LOGIC_TEMPLATE( template ),
                jit_args
            )
        );;

# some general example
template := rec(
    variable_names := [ "variable" ],
    src_template := "x -> x + variable + x - x",
    dst_template := "x -> x + variable + 0",
    returns_value := true,
);;

func := function ( a )
    return b -> b + ( 2 * b + a ) + b - b; end;;

Display(
    applied_non_enhanced_logic_template_to_func( func, template, [ ] ) );
#! function ( a_1 )
#!     return function ( b_2 )
#!           return b_2 + (2 * b_2 + a_1) + 0;
#!       end;
#! end

# check that functions in variables can match
template := rec(
    variable_names := [ "L1", "L2", "func" ],
    src_template := "Concatenation( List( L1, func ), List( L2, func ) )",
    dst_template := "List( Concatenation( L1, L2 ), func )",
    returns_value := true,
);;

func := function ( L1, L2 )
    return Concatenation( List( L1, x -> x ), List( L2, x -> x ) ); end;;

Display(
    applied_non_enhanced_logic_template_to_func( func, template, [ ] ) );
#! function ( L1_1, L2_1 )
#!     return List( Concatenation( L1_1, L2_1 ), function ( x_2 )
#!             return x_2;
#!         end );
#! end

# check that functions can be used multiple times in dst_template
# add a nonsense template
template := rec(
    variable_names := [ "list", "value" ],
    src_template := "List( list, l -> value )",
    dst_template := "Sum( list, l -> value ) + Sum( list, l -> value )",
    returns_value := true,
);;

func := function ( list )
    return List( list, x -> x ); end;;

Display(
    applied_non_enhanced_logic_template_to_func( func, template, [ ] ) );
#! function ( list_1 )
#!     return Sum( list_1, function ( x_2 )
#!               return x_2;
#!           end ) + Sum( list_1, function ( x_2 )
#!               return x_2;
#!           end );
#! end

func := function ( list )
    return List( list, x -> (y -> y) ); end;;

Display(
    applied_non_enhanced_logic_template_to_func( func, template, [ ] ) );
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
template := rec(
    variable_names := [ "value" ],
    src_template := "List( [ 1 ], l -> value )",
    dst_template := "(l -> value)(1)",
    returns_value := true,
);;

func := function ( x )
    return List( [ 1 ], function ( y )
        local r; r := x; return r; end ); end;;

Display(
    applied_non_enhanced_logic_template_to_func( func, template, [ ] ) );
#! function ( x_1 )
#!     return List( [ 1 ], function ( y_2 )
#!             local r_2;
#!             r_2 := x_1;
#!             return r_2;
#!         end );
#! end

#! @EndExample
