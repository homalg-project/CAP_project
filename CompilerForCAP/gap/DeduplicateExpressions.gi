# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( CapJitDeduplicatedExpressions, function ( tree )
  local expressions_by_level_and_type, result_func, additional_arguments_func, ignored_paths, path_replacements, bound_levels, expressions_by_type, expressions, info, expr, positions, equal_expressions, length, common_path, pos, func_path, func, id, new_variable_name, info2, level, key, path_replacement, i;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_by_level_and_type := [ ];
    
    result_func := function ( tree, result, keys, info )
      local level;
        
        if IsEmpty( keys ) then
            
            level := 1;
            
        else
            
            level := Maximum( List( keys, name -> result.(name) ) ) + 1;
            
        fi;
        
        if StartsWith( tree.type, "EXPR_" ) and not tree.type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_DECLARATIVE_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] then
            
            if not IsBound( expressions_by_level_and_type[level] ) then
                
                expressions_by_level_and_type[level] := rec( );
                
            fi;
            
            if not IsBound( expressions_by_level_and_type[level].(tree.type) ) then
                
                expressions_by_level_and_type[level].(tree.type) := [ ];
                
            fi;
            
            Add( expressions_by_level_and_type[level].(tree.type), info );
            
        fi;
        
        return level;
        
    end;
    
    additional_arguments_func := function ( tree, key, info )
        
        # the child should get tree as a parent
        return rec( parent := tree, key := key, path := Concatenation( info.path, [ key ] ) );
        
    end;
    
    # populate `expressions_by_level_and_type`
    CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, rec( path := [ ] ) );
    
    # now actually deduplicate expressions
    ignored_paths := [ ];
    path_replacements := [ ];
    
    bound_levels := PositionsBound( expressions_by_level_and_type );
    for level in Reversed( bound_levels ) do
        
        expressions_by_type := expressions_by_level_and_type[level];
        
        for key in SortedList( RecNames( expressions_by_type ) ) do
            
            expressions := expressions_by_type.(key);
            
            # honor path replacements
            for info in expressions do
                
                for path_replacement in path_replacements do
                    
                    if StartsWith( info.path, path_replacement.from ) then
                        
                        info.path := Concatenation( path_replacement.to, info.path{[ Length( path_replacement.from ) + 1 .. Length( info.path ) ]} );
                        
                    fi;
                    
                od;
                
            od;
            
            # drop ignored expressions
            # this has to happen after applying the replacements because replaced paths might be ignored
            expressions := Filtered( expressions, info -> not ForAny( ignored_paths, path -> StartsWith( info.path, path ) ) );
            
            while not IsEmpty( expressions ) do
                
                info := expressions[1];
                
                expr := info.parent.(info.key);
                
                positions := PositionsProperty( expressions, e -> CapJitIsEqualForEnhancedSyntaxTrees( e.parent.(e.key), expr ) );
                
                Assert( 0, 1 in positions );
                
                equal_expressions := expressions{positions};
                
                expressions := expressions{Difference( [ 1 .. Length( expressions ) ], positions )};
                
                if Length( equal_expressions ) > 1 then
                    
                    # find common prefix of paths
                    length := 1;
                    while ForAll( equal_expressions, e -> Length( e.path ) >= length and e.path[length] = info.path[length] ) do
                        length := length + 1;
                    od;
                    
                    # we have gone one level to far
                    length := length - 1;
                    
                    common_path := info.path{[ 1 .. length ]};
                    
                    # find common function
                    pos := Last( Positions( common_path, "bindings" ) );
                    
                    func_path := common_path{[ 1 .. pos - 1 ]};
                    
                    func := CapJitGetNodeByPath( tree, func_path );
                    
                    Assert( 0, func.type = "EXPR_DECLARATIVE_FUNC" );
                    
                    id := CapJitGetNextUnusedVariableID( func );
                    
                    new_variable_name := Concatenation( "deduped_", String( id ) );
                    
                    func.nams := Concatenation( func.nams, [ new_variable_name ] );
                    
                    CapJitAddBinding( func.bindings, new_variable_name, expr );
                    
                    for i in [ 1 .. Length( equal_expressions ) ] do
                        
                        info2 := equal_expressions[i];
                        
                        info2.parent.(info2.key) := rec(
                            type := "EXPR_REF_FVAR",
                            func_id := func.id,
                            name := new_variable_name,
                        );
                        
                        if i > 1 then
                            
                            Add( ignored_paths, info2.path );
                            
                        fi;
                        
                    od;
                    
                    Add( path_replacements, rec( from := info.path, to := Concatenation( func_path, [ "bindings", Concatenation( "BINDING_", new_variable_name ) ] ) ) );
                    
                fi;
                
            od;
            
        od;
        
    od;
    
    return tree;
    
end );
