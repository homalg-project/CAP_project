# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_STORED_VALUES", [ ] );
BindGlobal( "CAP_JIT_INTERNAL_STORED_VALUES_COUNTER", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_STORED_VALUES_COUNTER" );

BindGlobal( "CAP_JIT_INTERNAL_STORE_ARGUMENTS", function ( counter, func, args... )
  local result;
    
    CAP_JIT_INTERNAL_STORED_VALUES[counter] := args;
    
    result := CallFuncListWrap( func, args );
    
    if Length( result ) > 0 then
        
        return result[1];
        
    else
    
        return;
    
    fi;

end );

BindGlobal( "CAP_JIT_INTERNAL_STORE_VALUE", function ( counter, value )
  
    CAP_JIT_INTERNAL_STORED_VALUES[counter] := value;
    
    return value;

end );

InstallGlobalFunction( CapJitGetFunctionCallArgumentsFromJitArgs, function ( tree, path, jit_args )
  local jit_tree, jit_record, counter, jit_func;
    
    jit_tree := StructuralCopy( tree );
    
    jit_record := CapJitGetNodeByPath( jit_tree, path );
    
    Assert( 0, jit_record.type = "EXPR_FUNCCALL" and jit_record.funcref.type = "EXPR_REF_GVAR" );
    
    counter := CAP_JIT_INTERNAL_STORED_VALUES_COUNTER;
    CAP_JIT_INTERNAL_STORED_VALUES_COUNTER := CAP_JIT_INTERNAL_STORED_VALUES_COUNTER + 1;
    
    jit_record.args := ConcatenationForSyntaxTreeLists( AsSyntaxTreeList( [ rec( type := "EXPR_INT", value := counter ), jit_record.funcref ] ), jit_record.args );
    
    jit_record.funcref := rec(
        type := "EXPR_REF_GVAR",
        gvar := "CAP_JIT_INTERNAL_STORE_ARGUMENTS",
    );
    
    jit_func := ENHANCED_SYNTAX_TREE_CODE( jit_tree );
    
    CallFuncList( jit_func, jit_args );
    
    if IsBound( CAP_JIT_INTERNAL_STORED_VALUES[counter] ) then
        
        return [ true, CAP_JIT_INTERNAL_STORED_VALUES[counter] ];
        
    else
        
        return [ false ];
        
    fi;
    
end );

InstallGlobalFunction( CapJitGetExpressionValueFromJitArgs, function ( tree, path, jit_args )
  local jit_tree, jit_record, parent, counter, new_record, args, jit_func;
    
    jit_tree := StructuralCopy( tree );
    
    jit_record := CapJitGetNodeByPath( jit_tree, path );
    
    Assert( 0, StartsWith( jit_record.type, "EXPR_" ) );
    Assert( 0, Length( path ) >= 1 );
    
    parent := CapJitGetNodeByPath( jit_tree, path{[ 1 .. Length( path ) - 1 ]} );
    
    counter := CAP_JIT_INTERNAL_STORED_VALUES_COUNTER;
    CAP_JIT_INTERNAL_STORED_VALUES_COUNTER := CAP_JIT_INTERNAL_STORED_VALUES_COUNTER + 1;
    
    new_record := rec(
        type := "EXPR_FUNCCALL",
        funcref := rec(
            type := "EXPR_REF_GVAR",
            gvar := "CAP_JIT_INTERNAL_STORE_VALUE",
        ),
        args := AsSyntaxTreeList( [
            rec(
                type := "EXPR_INT",
                value := counter,
            ),
            jit_record,
        ] ),
    );
    
    parent.(Last( path )) := new_record;
    
    jit_func := ENHANCED_SYNTAX_TREE_CODE( jit_tree );
    
    CallFuncList( jit_func, jit_args );
    
    if IsBound( CAP_JIT_INTERNAL_STORED_VALUES[counter] ) then
        
        return [ true, CAP_JIT_INTERNAL_STORED_VALUES[counter] ];
        
    else
        
        return [ false ];
        
    fi;
    
end );
