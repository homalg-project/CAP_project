#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

MY_ID_FUNC := x -> x;;

func1 := function( x )
    if x = 1 then return 1; else return 2; fi; end;;

tree1 := ENHANCED_SYNTAX_TREE( func1 );;
tree1.bindings.BINDING_RETURN_VALUE.type = "EXPR_CASE";
#! true

coded_func1 := ENHANCED_SYNTAX_TREE_CODE( tree1 );;
String( func1 ) = ReplacedString( String( coded_func1 ), "_1", "" );
#! true



tree2 := rec(
    type := "EXPR_DECLARATIVE_FUNC",
    id := 1,
    nams := [ "RETURN_VALUE" ],
    narg := 0,
    nloc := 1,
    variadic := false,
    bindings := rec(
        type := "FVAR_BINDING_SEQ",
        length := 1,
        names := [ "RETURN_VALUE" ],
        BINDING_RETURN_VALUE := rec(
            type := "EXPR_FUNCCALL",
            funcref := rec(
                type := "EXPR_REF_GVAR",
                gvar := "MY_ID_FUNC",
            ),
            args := AsSyntaxTreeList( [
                rec(
                    type := "EXPR_CASE",
                    branches := AsSyntaxTreeList( [
                        rec(
                            type := "CASE_BRANCH",
                            condition := rec(
                                type := "EXPR_FALSE",
                            ),
                            value := rec(
                                type := "EXPR_INT",
                                value := 1,
                            ),
                        ),
                        rec(
                            type := "CASE_BRANCH",
                            condition := rec(
                                type := "EXPR_TRUE",
                            ),
                            value := rec(
                                type := "EXPR_INT",
                                value := 2,
                            ),
                        ),
                    ] ),
                ),
            ] ),
        ),
    ),
);;

coded_func2 := ENHANCED_SYNTAX_TREE_CODE( tree2 );;
Display( coded_func2 );
#! function (  )
#!     return MY_ID_FUNC( function (  )
#!               if false then
#!                   return 1;
#!               else
#!                   return 2;
#!               fi;
#!               return;
#!           end(  ) );
#! end

coded_func2();
#! 2



func3 := function( x )
  local y; if x then return 1; else return 1; fi; end;;

compiled_func3 := CapJitCompiledFunction( func3 );;
Display( compiled_func3 );
#! function ( x_1 )
#!     return 1;
#! end

#! @EndExample
