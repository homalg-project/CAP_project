# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( CapJitAppliedCompilerHints, function ( tree, category )
    
    tree := CapJitReplacedGlobalVariablesByCategoryAttributes( tree, category );
    
    return tree;
    
end );

InstallGlobalFunction( CapJitReplacedGlobalVariablesByCategoryAttributes, function ( tree, category )
  local categories_in_tower, categories_in_tower_getters, category_attribute_values, category_attribute_values_getters, i, cat, cat_getter, attribute_names, value, pre_func, name;
    
    categories_in_tower := [ category ];
    categories_in_tower_getters := [
        rec(
            type := "EXPR_REF_FVAR",
            func_id := tree.id,
            pos := 1,
            initial_name := tree.nams[1],
        )
    ];
    
    category_attribute_values := [ ];
    category_attribute_values_getters := [ ];
    
    i := 1;
    
    while i <= Length( categories_in_tower ) do
        
        cat := categories_in_tower[i];
        cat_getter := categories_in_tower_getters[i];
        
        if IsBound( cat!.compiler_hints ) and IsBound( cat!.compiler_hints.category_attribute_names ) then
            
            attribute_names := cat!.compiler_hints.category_attribute_names;
            
        else
            
            attribute_names := [ ];
            
        fi;
        
        # add some attributes by default
        
        if HasObjectType( category ) then
            
            Add( attribute_names, "ObjectType" );
            
        fi;
        
        if HasMorphismType( category ) then
            
            Add( attribute_names, "MorphismType" );
            
        fi;
        
        if HasRangeCategoryOfHomomorphismStructure( category ) then
            
            Add( attribute_names, "RangeCategoryOfHomomorphismStructure" );
            
        fi;
        
        for name in attribute_names do
            
            value := ValueGlobal( name )( cat );
            
            if IsCapCategory( value ) and not ForAny( categories_in_tower, c -> IsIdenticalObj( c, value ) ) then
                
                Add( categories_in_tower, value );
                Add( categories_in_tower_getters,
                    rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := name,
                        ),
                        args := [
                            cat_getter
                        ],
                    )
                );
                
            else
                
                Add( category_attribute_values, value );
                Add( category_attribute_values_getters,
                    rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := name,
                        ),
                        args := [
                            cat_getter
                        ],
                    )
                );
                
            fi;
            
        od;
        
        i := i + 1;
        
    od;
    
    pre_func := function ( tree, additional_arguments )
      local pos;
        
        if IsRecord( tree ) and tree.type = "EXPR_REF_GVAR" then
            
            # try to find the value of the global variable in categories_in_tower
            pos := PositionProperty( categories_in_tower, c -> IsIdenticalObj( c, ValueGlobal( tree.gvar ) ) );
            
            if pos <> fail then
                
                return categories_in_tower_getters[pos];
                
            fi;
            
            # try to find the value of the global variable in category_attribute_values
            pos := PositionProperty( category_attribute_values, v -> IsIdenticalObj( v, ValueGlobal( tree.gvar ) ) );
            
            if pos <> fail then
                
                return category_attribute_values_getters[pos];
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
