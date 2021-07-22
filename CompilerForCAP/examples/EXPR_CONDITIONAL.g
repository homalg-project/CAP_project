#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

func1 := function( x )
    if x = 1 then return 1; else return 2; fi; end;;

tree1 := ENHANCED_SYNTAX_TREE( func1 );;
tree1.stats.statements[1].obj.type = "EXPR_CONDITIONAL";
#! true

coded_func1 := ENHANCED_SYNTAX_TREE_CODE( tree1 );;
String( func1 ) = ReplacedString( String( coded_func1 ), "_1", "" );
#! true

func2 := function( x )
  local y; if x = 1 then y := 1; else y := 2; fi; return y; end;;

tree2 := ENHANCED_SYNTAX_TREE( func2 );;
tree2.stats.statements[1].rhs.type = "EXPR_CONDITIONAL";
#! true

coded_func2 := ENHANCED_SYNTAX_TREE_CODE( tree2 );;
String( func2 ) = ReplacedString( String( coded_func2 ), "_1", "" );
#! true

tree3 := rec(
    type := "EXPR_FUNC",
    id := 1,
    nams := [ ],
    narg := 0,
    nloc := 0,
    variadic := false,
    stats := rec(
        type := "STAT_SEQ_STAT",
        statements := [
            rec(
                type := "STAT_RETURN_OBJ",
                obj := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "IdFunc",
                    ),
                    args := [
                        rec(
                            type := "EXPR_CONDITIONAL",
                            condition := rec(
                                type := "EXPR_FALSE",
                            ),
                            expr_if_true := rec(
                                type := "EXPR_INT",
                                value := 1,
                            ),
                            expr_if_false := rec(
                                type := "EXPR_INT",
                                value := 2,
                            ),
                        ),
                    ],
                ),
            ),
        ],
    ),
);;

coded_func3 := ENHANCED_SYNTAX_TREE_CODE( tree3 );;
Display( coded_func3 );
#! function (  )
#!     return IdFunc( function (  )
#!               if false then
#!                   return 1;
#!               else
#!                   return 2;
#!               fi;
#!               return;
#!           end(  ) );
#! end

coded_func3();
#! 2

func4 := function( x )
  local y; if x then y := 1; else y := 2; fi; return IdFunc( y ); end;;

compiled_func4 := CapJitCompiledFunction( func4, [ true ] );;
Display( compiled_func4 );
#! function ( x_1 )
#!     if x_1 then
#!         return ID_FUNC( 1 );
#!     else
#!         return ID_FUNC( 2 );
#!     fi;
#!     return;
#! end

func5 := function( x )
  local y; if x then return 1; else return 1; fi; end;;

compiled_func5 := CapJitCompiledFunction( func5, [ true ] );;
Display( compiled_func5 );
#! function ( x_1 )
#!     return 1;
#! end

#! @EndExample
