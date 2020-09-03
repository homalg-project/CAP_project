#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION, function( cond1, cond2 )
    
    # check if cond1 implies cond2, i.e. if ( cond1 = true => cond2 = true )
    if cond1 = cond2 then
        
        return true;

    elif cond1.type = "EXPR_OR" then
        
        if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1.left, cond2 ) = true and CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1.right, cond2 ) = true then
            
            return true;
            
        fi;
        
    elif cond2.type = "EXPR_OR" then
        
        if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1, cond2.left ) = true then
            
            return true;
            
        fi;
        
        if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1, cond2.right ) = true then
            
            return true;
            
        fi;
        
    fi;
    
    return fail;
    
end );

InstallGlobalFunction( CapJitDroppedHandledEdgeCases, function( tree )
  local handled_edge_cases, pre_func, result_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Drop handled edge cases." );
    
    handled_edge_cases := [];

    pre_func := function( tree, path )
      local statements, statement, branches, branch, if_path, i, j;
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            statements := tree.stats.statements;
            
            for i in [ 1 .. Length( statements ) ] do
                
                statement := statements[i];
                
                if StartsWith( statement.type, "STAT_IF" ) then
                    
                    branches := statement.branches;
                    
                    for j in [ 1 .. Length( branches ) ] do
                        
                        branch := branches[j];
                        
                        if Last( branch.body.statements ).type = "STAT_RETURN_OBJ" then
                            
                            # we are in the main sequence of statements of a function => we are not inside of a loop
                            # and this branch ends with a return statement
                            # => we can only reach the remaining branches if the condition of this branch does not match
                            if_path := Concatenation( path, [ "stats", "statements", i ] );
                            Add( handled_edge_cases, rec( if_path := if_path, key := j, condition := branch.condition ) );
                            
                        fi;
                        
                    od;
                    
                fi;
                
            od;
            
        fi;
            
        return tree;
        
    end;
    
    result_func := function( tree, result, path )
      local statements, i, statement, positions, key;
        
        if IsList( result ) then
            
            return result;
            
        elif IsRecord( result ) then
            
            tree := ShallowCopy( tree );

            for key in RecNames( result ) do
                
                tree.(key) := result.(key);

            od;

            if tree.type = "STAT_SEQ_STAT" then
                
                tree.statements := Filtered( tree.statements, s -> s.type <> "STAT_EMPTY" );

                statements := tree.statements;
                
                i := 1;
                
                while i <= Length( statements ) do
                    
                    statement := statements[i];
                    
                    if statement.type = "STAT_SEQ_STAT" then
                        
                        statements := Concatenation( statements{[ 1 .. i-1 ]}, statement.statements, statements{[ i+1 .. Length( statements ) ]} );
                        
                    else
                        
                        i := i + 1;
                        
                    fi;
                    
                od;
                
                tree.statements := statements;
            
            elif StartsWith( tree.type, "STAT_IF" ) then
                
                positions := Filtered( [ 1 .. Length( tree.branches ) ], function( j )
                  local branch, key, handled_edge_case;
                    
                    branch := tree.branches[j];
                    
                    for handled_edge_case in handled_edge_cases do
                        
                        if PositionSublist( path, handled_edge_case.if_path ) = 1 then
                            
                            if Length( path ) > Length( handled_edge_case.if_path ) then
                                
                                # next entry of path is "branches", then the key
                                key := path[ Length( handled_edge_case.if_path ) + 2];

                            else
                                
                                key := j;
                                
                            fi;
                            
                            Assert( 0, IsInt( key ) );
                            
                            if key > handled_edge_case.key and CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( branch.condition, handled_edge_case.condition ) = true then

                                Info( InfoCapJit, 1, "####" );
                                Info( InfoCapJit, 1, "Dropped edge case." );
    
                                return false;
                                
                            fi;
                            
                        fi;
                        
                    od;
                    
                    return true;
                    
                end );
                
                if Length( positions ) = 0 then
                    
                    return rec( type := "STAT_EMPTY" );
                    
                else
                    
                    tree.branches := tree.branches{positions};
                    
                fi;

                if Length( tree.branches ) = 1 and tree.branches[1].condition.type = "EXPR_TRUE" then
                    
                    return tree.branches[1].body;
                    
                fi;

            fi;
            
            return tree;

        else
            
            Error( "this should never happen" );
            
        fi;
        
    end;

    additional_arguments_func := function( tree, key, path )
        
        return Concatenation( path, [ key ] );
        
    end;
  
    return CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [] );

end );
