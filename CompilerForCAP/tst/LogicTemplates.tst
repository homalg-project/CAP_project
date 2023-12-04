gap> START_TEST( "LogicTemplates" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# example testing needed_packages
gap> template1 := rec(
>     variable_names := [ "name" ],
>     variable_filters := [ "THIS_SHOULD_NOT_BE_PARSED" ],
>     src_template := "THIS_SHOULD_NOT_BE_PARSED_TOO",
>     dst_template := "THIS_SHOULD_NOT_BE_PARSED_EITHER",
>     needed_packages := [ [ "NON_EXISTING_PACKAGE", ">= 9999" ] ],
> );;
gap> template2 := rec(
>     variable_names := [ ],
>     src_template := "1 + 1",
>     dst_template := "2",
> );;

#
gap> Add( CAP_JIT_LOGIC_TEMPLATES, template1 );
gap> Add( CAP_JIT_LOGIC_TEMPLATES, template2 );

#
gap> Display( CapJitCompiledFunction( x -> x ) );
function ( x_1 )
    return x_1;
end

#
gap> IsIdenticalObj( Remove( CAP_JIT_LOGIC_TEMPLATES ), template2 );
true
gap> IsIdenticalObj( Remove( CAP_JIT_LOGIC_TEMPLATES ), template1 );
true

#
gap> applied_logic_template_to_func :=
>     { func, template, type_signature } ->
>         ENHANCED_SYNTAX_TREE_CODE(
>             CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATES(
>                 CapJitInferredDataTypes(
>                     ENHANCED_SYNTAX_TREE(
>                         func :
>                         type_signature := type_signature
>                     )
>                 ),
>                 [ template ]
>             )
>         );;

# some general example
gap> template := rec(
>     variable_names := [ "variable" ],
>     src_template := "x -> x + variable + x - x",
>     dst_template := "x -> x + variable + 0",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := function ( a )
>     return b -> b + ( 2 * b + a ) + b - b; end;;

#
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( a_1 )
    return function ( b_2 )
          return b_2 + (2 * b_2 + a_1) + 0;
      end;
end

# example using EXPR_CASE
gap> template := rec(
>     variable_names := [ "val1", "val2" ],
>     src_template := "CAP_JIT_INTERNAL_EXPR_CASE( 1 <> 1, val1, true, val2 )",
>     dst_template := "val2",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := function ( )
>     if 1 <> 1 then return 1; else return 2; fi; end;;

#
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function (  )
    return 2;
end

# check that functions in variables can match
# and test variable_filters (strings and filters)
gap> template := rec(
>     variable_names := [ "L1", "L2", "func" ],
>     variable_filters := [ "IsList", IsList, IsFunction ],
>     src_template := "Concatenation( [ List( L1, func ), List( L2, func ) ] )",
>     dst_template := "List( Concatenation( [ L1, L2 ] ), func )",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := { L1, L2 } ->
>     Concatenation( [ List( L1, x -> x ), List( L2, x -> x ) ] );;

#
gap> Display( applied_logic_template_to_func(
>     func,
>     template,
>     [
>         [
>             CapJitDataTypeOfListOf( IsInt ),
>             CapJitDataTypeOfListOf( IsInt ),
>         ],
>         fail,
>     ]
> ) );
function ( L1_1, L2_1 )
    return List( Concatenation( [ L1_1, L2_1 ] ), function ( x_2 )
            return x_2;
        end );
end

# check that template is not executed if data types cannot be determined
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( L1_1, L2_1 )
    return Concatenation( [ List( L1_1, function ( x_2 )
                  return x_2;
              end ), List( L2_1, function ( x_2 )
                  return x_2;
              end ) ] );
end

# check that template is only applied if filters match
gap> template := rec(
>     variable_names := [ "value" ],
>     variable_filters := [ IsInt ],
>     src_template := "Sum( [ value ] )",
>     dst_template := "value",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := { x } -> Sum( [ x ] );;

#
gap> Display( applied_logic_template_to_func(
>     func,
>     template,
>     [
>         [
>             rec( filter := IsInt ),
>         ],
>         fail,
>     ]
> ) );
function ( x_1 )
    return x_1;
end

#
gap> Display( applied_logic_template_to_func(
>     func,
>     template,
>     [
>         [
>             rec( filter := IsFloat ),
>         ],
>         fail,
>     ]
> ) );
function ( x_1 )
    return Sum( [ x_1 ] );
end

# check that functions can be used multiple times in dst_template
# add a nonsense template
gap> template := rec(
>     variable_names := [ "list", "value" ],
>     src_template := "List( list, l -> value )",
>     dst_template := "Sum( list, l -> value ) + Sum( list, l -> value )",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := function ( list )
>     return List( list, x -> x ); end;;

#
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( list_1 )
    return Sum( list_1, function ( x_2 )
              return x_2;
          end ) + Sum( list_1, function ( x_2 )
              return x_2;
          end );
end

#
gap> func := function ( list )
>     return List( list, x -> (y -> y) ); end;;

#
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( list_1 )
    return Sum( list_1, function ( x_2 )
              return function ( y_3 )
                    return y_3;
                end;
          end ) + Sum( list_1, function ( x_2 )
              return function ( y_3 )
                    return y_3;
                end;
          end );
end

# check that functions with assignments to local variables do not match
# logic templates without assignments to local variables
gap> template := rec(
>     variable_names := [ "value" ],
>     src_template := "List( [ 1 ], l -> value )",
>     dst_template := "(l -> value)(1)",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := function ( x )
>     return List( [ 1 ], function ( y )
>         local r; r := x; return r; end ); end;;

#
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( x_1 )
    return List( [ 1 ], function ( y_2 )
            local r_2;
            r_2 := x_1;
            return r_2;
        end );
end

# check that values are pulled out iff
# they are independent of local variables
gap> template := rec(
>     variable_names := [ "list", "value" ],
>     src_template := "List( list, l -> value * l )",
>     dst_template := "value * List( list, l -> l )",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );

#
gap> func := L -> List( L, l -> l * l );;
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( L_1 )
    return List( L_1, function ( l_2 )
            return l_2 * l_2;
        end );
end

#
gap> func := L -> List( L, l -> 2 * l );;
gap> Display( applied_logic_template_to_func( func, template, fail ) );
function ( L_1 )
    return 2 * List( L_1, function ( l_2 )
              return l_2;
          end );
end

# check that the outermost function is not turned into a non-literal function
gap> template1 := rec(
>     variable_names := [ ],
>     src_template := "x -> x + 1 - 1",
>     dst_template := "IdFunc",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template1 );
gap> template2 := rec(
>     variable_names := [ ],
>     src_template := "x -> x + 1 - 1",
>     dst_template := "x -> x",
> );;
gap> CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template2 );

#
gap> func1 := y -> (x -> x + 1 - 1);;
gap> func2 := x -> x + 1 - 1;;

#
gap> Display( applied_logic_template_to_func( func1, template1, fail ) );
function ( y_1 )
    return IdFunc;
end
gap> Display( applied_logic_template_to_func( func1, template2, fail ) );
function ( y_1 )
    return function ( x_2 )
          return x_2;
      end;
end
gap> Display( applied_logic_template_to_func( func2, template1, fail ) );
function ( x_1 )
    return x_1 + 1 - 1;
end
gap> Display( applied_logic_template_to_func( func2, template2, fail ) );
function ( x_1 )
    return x_1;
end

#
gap> STOP_TEST( "LogicTemplates" );
