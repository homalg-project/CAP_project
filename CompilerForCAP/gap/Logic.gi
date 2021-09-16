# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_LOGIC_FUNCTIONS", [ ] );

InstallGlobalFunction( CapJitAddLogicFunction, function ( func )
    
    if not IsFunction( func ) then
        
        Error( "a logic function must be a function" );
        
    fi;
    
    if not NumberArgumentsFunction( func ) in [ -2, -1, 2 ] then
        
        Error( "a logic function must be callable with two arguments" );
        
    fi;
    
    Add( CAP_JIT_LOGIC_FUNCTIONS, func );
    
end );

InstallGlobalFunction( CapJitAppliedLogic, function ( tree, jit_args )
  local logic_function;
    
    for logic_function in CAP_JIT_LOGIC_FUNCTIONS do
        
        tree := logic_function( tree, jit_args );
        
    od;
    
    tree := CapJitAppliedLogicTemplates( tree, jit_args );
    
    return tree;
    
end );

# Concatenation( [ a, b, ... ], [ c, d, ... ], ... ) => [ a, b, ..., c, d, ... ]
CapJitAddLogicFunction( function ( tree, jit_args )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for concatenation of lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "Concatenation" ) then
            
            args := tree.args;
            
            if ForAll( args, a -> a.type = "EXPR_LIST" ) then
                
                return rec(
                    type := "EXPR_LIST",
                    list := ConcatenationForSyntaxTreeLists( List( args, a -> a.list ) ),
                );
                
            fi;

        fi;
            
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# CallFuncList( func, [ a, b, ... ] ) => func( a, b, ... )
CapJitAddLogicFunction( function ( tree, jit_args )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for CallFuncList." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "CallFuncList" ) then
            
            args := tree.args;
            
            if args.2.type = "EXPR_LIST" then
                
                return rec(
                    type := "EXPR_FUNCCALL",
                    funcref := args.1,
                    args := args.2.list,
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# AttributeGetter( ObjectifyObject/MorphismForCAPWithAttributes( ..., Attribute, value, ... ) ) => value
CapJitAddLogicFunction( function ( tree, jit_args )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for attribute getters." );
    
    pre_func := function ( tree, additional_arguments )
      local attribute_name, args, object, list, pos;
        
        # attribute getters can also be applied to more than one argument, but we are not interested in that case
        if CapJitIsCallToGlobalFunction( tree, gvar -> IsAttribute( ValueGlobal( gvar ) ) ) and tree.args.length = 1 then
            
            attribute_name := tree.funcref.gvar;
            
            args := tree.args;
            
            object := args.1;
            
            list := fail;
            
            if CapJitIsCallToGlobalFunction( object, "ObjectifyObjectForCAPWithAttributes" ) then
                
                # special case
                if attribute_name = "CapCategory" then
                    
                    return object.args.2;
                    
                fi;
                
                list := Sublist( object.args, [ 3 .. object.args.length ] );
                
            fi;
            
            if CapJitIsCallToGlobalFunction( object, "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ) then
                
                # special cases
                if attribute_name = "CapCategory" then
                    
                    return object.args.2;
                    
                elif attribute_name = "Source" then
                    
                    return object.args.3;
                    
                elif attribute_name = "Range" then
                    
                    return object.args.4;
                    
                fi;
                
                list := Sublist( object.args, [ 5 .. object.args.length ] );
                
            fi;
            
            if list <> fail then
                
                pos := PositionProperty( list, a -> a.type = "EXPR_REF_GVAR" and a.gvar = tree.funcref.gvar );
                
                if pos <> fail and IsOddInt( pos ) then
                    
                    Assert( 0, IsBound( list.(pos + 1) ) );
                    
                    return list.(pos + 1);
                    
                fi;
                
            fi;
            
        fi;
            
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# EXPR_CASE with all branches having the same value
CapJitAddLogicFunction( function ( tree, jit_args )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for EXPR_CASE with all branches having the same value." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_CASE" and tree.branches.length > 0 and ForAll( tree.branches, branch -> CapJitIsEqualForEnhancedSyntaxTrees( branch.value, tree.branches.1.value ) ) then
            
            return tree.branches.1.value;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# func( EXPR_CASE )
CapJitAddLogicFunction( function ( tree, jit_args )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for func( EXPR_CASE )." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_FUNCCALL" and tree.args.length = 1 and tree.args.1.type = "EXPR_CASE" then
            
            return rec(
                type := "EXPR_CASE",
                branches := List( tree.args.1.branches, branch -> rec(
                    type := "CASE_BRANCH",
                    condition := branch.condition,
                    value := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := tree.funcref,
                        args := AsSyntaxTreeList( [
                            branch.value
                        ] ),
                    ),
                ) ),
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
