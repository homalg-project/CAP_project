#! @Chapter Examples and tests

#! @Section Examples

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function( x )
  local a, b, c, d, e@
    
    a := 1@
    
    if x < 0 then
        
        b := 2@
        
        c := 3@
        
    elif x = 1 then
        
        c := b@
        
    else
        
        d := a@
        
        c := a@
        
    fi@
    
    e := c@
    
    if x < 0 then
        
        return a@
        
    elif x = 1 then
        
        return c@
        
    else
        
        return d@
        
    fi@
    
end""", "@", ";" ) );;

tree := ENHANCED_SYNTAX_TREE( func );;
CapJitPrettyPrintSyntaxTree( tree );
#! rec(
#!   0_type := "EXPR_DECLARATIVE_FUNC",
#!   1_id := 1,
#!   2_nams := [ "x", "a", "b", "c", "d", "e", "RETURN_VALUE" ],
#!   3_narg := 1,
#!   4_variadic := false,
#!   5_bindings := rec(
#!       0_type := "FVAR_BINDING_SEQ",
#!       1_names := [ "RETURN_VALUE", "a", "b", "c", "d", "e" ],
#!       2_bindings := [ rec(
#!               name := "RETURN_VALUE",
#!               value := rec(
#!                   0_type := "EXPR_CASE",
#!                   1_branches := [ rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_LT",
#!                               1_left := rec(
#!                                   0_type := "EXPR_REF_FVAR",
#!                                   1_func_id := 1,
#!                                   2_name := "x" ),
#!                               2_right := rec(
#!                                   0_type := "EXPR_INT",
#!                                   1_value := 0 ) ),
#!                           2_value := rec(
#!                               0_type := "EXPR_REF_FVAR",
#!                               1_func_id := 1,
#!                               2_name := "a" ) ), rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_EQ",
#!                               1_left := rec(
#!                                   0_type := "EXPR_REF_FVAR",
#!                                   1_func_id := 1,
#!                                   2_name := "x" ),
#!                               2_right := rec(
#!                                   0_type := "EXPR_INT",
#!                                   1_value := 1 ) ),
#!                           2_value := rec(
#!                               0_type := "EXPR_REF_FVAR",
#!                               1_func_id := 1,
#!                               2_name := "c" ) ), rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_TRUE" ),
#!                           2_value := rec(
#!                               0_type := "EXPR_REF_FVAR",
#!                               1_func_id := 1,
#!                               2_name := "d" ) ) ] ) ), rec(
#!               name := "a",
#!               value := rec(
#!                   0_type := "EXPR_INT",
#!                   1_value := 1 ) ), rec(
#!               name := "b",
#!               value := rec(
#!                   0_type := "EXPR_INT",
#!                   1_value := 2 ) ), rec(
#!               name := "c",
#!               value := rec(
#!                   0_type := "EXPR_CASE",
#!                   1_branches := [ rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_LT",
#!                               1_left := rec(
#!                                   0_type := "EXPR_REF_FVAR",
#!                                   1_func_id := 1,
#!                                   2_name := "x" ),
#!                               2_right := rec(
#!                                   0_type := "EXPR_INT",
#!                                   1_value := 0 ) ),
#!                           2_value := rec(
#!                               0_type := "EXPR_INT",
#!                               1_value := 3 ) ), rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_EQ",
#!                               1_left := rec(
#!                                   0_type := "EXPR_REF_FVAR",
#!                                   1_func_id := 1,
#!                                   2_name := "x" ),
#!                               2_right := rec(
#!                                   0_type := "EXPR_INT",
#!                                   1_value := 1 ) ),
#!                           2_value := rec(
#!                               0_type := "EXPR_REF_FVAR",
#!                               1_func_id := 1,
#!                               2_name := "b" ) ), rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_TRUE" ),
#!                           2_value := rec(
#!                               0_type := "EXPR_REF_FVAR",
#!                               1_func_id := 1,
#!                               2_name := "a" ) ) ] ) ), rec(
#!               name := "d",
#!               value := rec(
#!                   0_type := "EXPR_REF_FVAR",
#!                   1_func_id := 1,
#!                   2_name := "a" ) ), rec(
#!               name := "e",
#!               value := rec(
#!                   0_type := "EXPR_REF_FVAR",
#!                   1_func_id := 1,
#!                   2_name := "c" ) ) ] ) )

func := EvalString( ReplacedString( """function( x )
  local y@
    
    if x < 0 then
        
        Error( "error" )@
        
    fi@
    
    if x = 1 then
        
        return true@
        
    fi@
    
    y := 2@
    
    return false@
    
end""", "@", ";" ) );;

tree := ENHANCED_SYNTAX_TREE( func );;
CapJitPrettyPrintSyntaxTree( tree );
#! rec(
#!   0_type := "EXPR_DECLARATIVE_FUNC",
#!   1_id := 2,
#!   2_nams := [ "x", "y", "RETURN_VALUE" ],
#!   3_narg := 1,
#!   4_variadic := false,
#!   5_bindings := rec(
#!       0_type := "FVAR_BINDING_SEQ",
#!       1_names := [ "RETURN_VALUE", "y" ],
#!       2_bindings := [ rec(
#!               name := "RETURN_VALUE",
#!               value := rec(
#!                   0_type := "EXPR_CASE",
#!                   1_branches := [ rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_EQ",
#!                               1_left := rec(
#!                                   0_type := "EXPR_REF_FVAR",
#!                                   1_func_id := 2,
#!                                   2_name := "x" ),
#!                               2_right := rec(
#!                                   0_type := "EXPR_INT",
#!                                   1_value := 1 ) ),
#!                           2_value := rec(
#!                               0_type := "EXPR_TRUE" ) ), rec(
#!                           0_type := "CASE_BRANCH",
#!                           1_condition := rec(
#!                               0_type := "EXPR_TRUE" ),
#!                           2_value := rec(
#!                               0_type := "EXPR_FALSE" ) ) ] ) ), rec(
#!               name := "y",
#!               value := rec(
#!                   0_type := "EXPR_INT",
#!                   1_value := 2 ) ) ] ) )

#! @EndExample
