#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

applied_logic_template_to_func :=
    { func, template, type_signature } ->
        ENHANCED_SYNTAX_TREE_CODE(
            CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATE(
                CapJitInferredDataTypes(
                    ENHANCED_SYNTAX_TREE(
                        func :
                        type_signature := type_signature
                    )
                ),
                template
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

Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( a_1 )
#!     return function ( b_2 )
#!           return b_2 + (2 * b_2 + a_1) + 0;
#!       end;
#! end

# general example not returning a value
# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
template := EvalString( ReplacedString( """rec(
    variable_names := [ "variable" ],
    src_template := "return x -> x + variable + x - x@",
    dst_template := "return x -> x + variable + 0@",
    returns_value := false,
)""", "@", ";" ) );;

Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( a_1 )
#!     return function ( b_2 )
#!           return b_2 + (2 * b_2 + a_1) + 0;
#!       end;
#! end

# example testing needed_packages
template := rec(
    variable_names := [ "name" ],
    variable_filters := [ "THIS_SHOULD_NOT_BE_PARSED" ],
    src_template := "THIS_SHOULD_NOT_BE_PARSED_TOO",
    dst_template := "THIS_SHOULD_NOT_BE_PARSED_EITHER",
    returns_value := true,
    needed_packages := [ [ "NON_EXISTING_PACKAGE", ">= 9999" ] ],
);;

Display( applied_logic_template_to_func( x -> x, template, fail ) );
#! function ( x_1 )
#!     return x_1;
#! end

# check that functions in variables can match
# and test variable_filters (strings and filters)
template := rec(
    variable_names := [ "L1", "L2", "func" ],
    variable_filters := [ "IsList", IsList, IsFunction ],
    src_template := "Concatenation( [ List( L1, func ), List( L2, func ) ] )",
    dst_template := "List( Concatenation( [ L1, L2 ] ), func )",
    returns_value := true,
);;

func := { L1, L2 } ->
    Concatenation( [ List( L1, x -> x ), List( L2, x -> x ) ] );;

Display( applied_logic_template_to_func(
    func,
    template,
    [
        [
            rec( filter := IsList, element_type := rec( filter := IsInt ) ),
            rec( filter := IsList, element_type := rec( filter := IsInt ) ),
        ],
        fail,
    ]
) );
#! function ( L1_1, L2_1 )
#!     return List( Concatenation( [ L1_1, L2_1 ] ), function ( x_2 )
#!             return x_2;
#!         end );
#! end

# check that template is not executed if data types cannot be determined
Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( L1_1, L2_1 )
#!     return Concatenation( [ List( L1_1, function ( x_2 )
#!               return x_2;
#!           end ), List( L2_1, function ( x_2 )
#!               return x_2;
#!           end ) ] );
#! end

# check that template is only applied if filters match
template := rec(
    variable_names := [ "value" ],
    variable_filters := [ IsInt ],
    src_template := "Sum( [ value ] )",
    dst_template := "value",
    returns_value := true,
);;

func := { x } -> Sum( [ x ] );;

Display( applied_logic_template_to_func(
    func,
    template,
    [
        [
            rec( filter := IsInt ),
        ],
        fail,
    ]
) );
#! function ( x_1 )
#!     return x_1;
#! end

Display( applied_logic_template_to_func(
    func,
    template,
    [
        [
            rec( filter := IsFloat ),
        ],
        fail,
    ]
) );
#! function ( x_1 )
#!     return Sum( [ x_1 ] );
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

Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( list_1 )
#!     return Sum( list_1, function ( x_2 )
#!               return x_2;
#!           end ) + Sum( list_1, function ( x_2 )
#!               return x_2;
#!           end );
#! end

func := function ( list )
    return List( list, x -> (y -> y) ); end;;

Display( applied_logic_template_to_func( func, template, fail ) );
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

Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( x_1 )
#!     return List( [ 1 ], function ( y_2 )
#!             local r_2;
#!             r_2 := x_1;
#!             return r_2;
#!         end );
#! end

# check that values are pulled out iff
# they are independent of local variables
template := rec(
    variable_names := [ "list", "value" ],
    src_template := "List( list, l -> value * l )",
    dst_template := "value * List( list, l -> l )",
    returns_value := true,
);;

func := L -> List( L, l -> l * l );;
Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( L_1 )
#!     return List( L_1, function ( l_2 )
#!             return l_2 * l_2;
#!         end );
#! end

func := L -> List( L, l -> 2 * l );;
Display( applied_logic_template_to_func( func, template, fail ) );
#! function ( L_1 )
#!     return 2 * List( L_1, function ( l_2 )
#!               return l_2;
#!           end );
#! end

#! @EndExample
