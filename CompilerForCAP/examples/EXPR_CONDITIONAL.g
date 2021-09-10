#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

MY_ID_FUNC := x -> x;;

func1 := function( x )
    if x = 1 then return 1; else return 2; fi; end;;

tree1 := ENHANCED_SYNTAX_TREE( func1 );;
tree1 := CapJitDetectedTernaryConditionalExpressions( tree1 );;
tree1.stats.statements[1].obj.type = "EXPR_CONDITIONAL";
#! true

coded_func1 := ENHANCED_SYNTAX_TREE_CODE( tree1 );;
String( func1 ) = ReplacedString( String( coded_func1 ), "_1", "" );
#! true



tree2 := rec(
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
                        gvar := "MY_ID_FUNC",
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



# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func3 := EvalString( ReplacedString( """function( x )
  local inner_func@
    
    inner_func := function( )
      local y@
        if x then
            return 1@
        else
            y := 2@
            return y@
        fi@
    end@
    
    return MY_ID_FUNC( inner_func( ) )@
    
end""", "@", ";" ) );;

compiled_func3 := CapJitCompiledFunction( func3, [ true ] );;
Display( compiled_func3 );
#! function ( x_1 )
#!     if x_1 then
#!         return MY_ID_FUNC( 1 );
#!     else
#!         return MY_ID_FUNC( 2 );
#!     fi;
#!     return;
#! end



func4 := function( x )
  local y; if x then return 1; else return 1; fi; end;;

compiled_func4 := CapJitCompiledFunction( func4, [ true ] );;
Display( compiled_func4 );
#! function ( x_1 )
#!     return 1;
#! end

#! @EndExample
