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

# if <condition> then <body>; return <value>; fi; <more statements>
# =>
# if <condition> then <body>; return <value>; else <more statements>; fi
CapJitAddLogicFunction( function ( tree, jit_args )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for ifs." );
    
    pre_func := function ( tree, additional_arguments )
      local statements, i, statement, new_branch;
        
        if tree.type = "EXPR_FUNC" then
            
            statements := tree.stats.statements;

            # find if ... then ...; return ...; elif ...; return ...; fi; (excluding the last statement)
            i := 1;
            while i <= statements.length - 1 do
                
                statement := statements.(i);
                
                if StartsWith( statement.type, "STAT_IF" ) and ForAll( statement.branches, b -> b.body.statements.length > 0 and Last( b.body.statements ).type = "STAT_RETURN_OBJ" ) then
                    # we are in the main sequence of statements of a function => we are not inside of a loop
                    # and all branches end with a return statement
                    # => we reach the remaining statements iff none of the conditions of the branches match
                    
                    if Last( statement.branches ).condition.type = "EXPR_TRUE" then
                        
                        Error( "found unreachable code, this is not yet handled" );
                        
                    else
                        
                        Assert( 0, not EndsWith( statement.type, "_ELSE" ) );
                        
                        # put remaining statements into an else branch
                        statement.type := Concatenation( statement.type, "_ELSE" );
                        
                        new_branch := rec(
                            type := "BRANCH_IF",
                            condition := rec(
                                type := "EXPR_TRUE",
                            ),
                            body := rec(
                                type := "STAT_SEQ_STAT",
                                statements := Sublist( statements, [ i + 1 .. statements.length ] ),
                            ),
                        );
                        
                        # GAP does not allow to implement Add for records :(
                        statement.branches.(statement.branches.length + 1) := new_branch;
                        statement.branches.length := statement.branches.length + 1;
                        
                        statements := Sublist( statements, [ 1 .. i ] );

                        tree := ShallowCopy( tree );
                        tree.stats := ShallowCopy( tree.stats );
                        tree.stats.statements := statements;
                        
                    fi;
                    
                fi;
                
                i := i + 1;
                
            od;
            
        fi;
            
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
