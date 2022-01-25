# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitPrettyPrintSyntaxTree, function ( tree )
  local result_func;
    
    result_func := function ( tree, result, keys, additional_arguments )
      local record, recnames, index, key, recname;
        
        # special case: syntax tree lists
        if tree.type = "SYNTAX_TREE_LIST" then
            
            # the list starts from 1, so we have do cheat to get type and length at the top
            record := rec(
                0__type := tree.type,
                0_length := tree.length,
            );
            
            for key in keys do
                
                record.(key) := result.(key);
                
            od;
            
            return record;
            
        fi;
        
        recnames := Set( RecNames( tree ) );
        
        RemoveSet( recnames, "type" );
        RemoveSet( recnames, "data_type" );
        
        recnames := Difference( recnames, keys );
        
        record := rec(
            0_type := tree.type,
        );
        
        index := 1;
        
        if StartsWith( tree.type, "EXPR_" ) and IsBound( tree.data_type ) then
            
            record.1_data_type := tree.data_type;
            index := 2;
            
        fi;
        
        for recname in recnames do
            
            record.(Concatenation( String( index ), "_", recname )) := tree.(recname);
            
            index := index + 1;
            
        od;
        
        for key in keys do
            
            record.(Concatenation( String( index ), "_", key )) := result.(key);
            
            index := index + 1;
            
        od;
        
        return record;
        
    end;
    
    Display( CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true ) );
    
end );
