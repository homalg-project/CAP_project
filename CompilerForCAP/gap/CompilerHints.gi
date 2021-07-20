# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( CapJitAppliedCompilerHints, function ( tree, category )
    
    tree := CapJitReplacedGlobalVariablesByCategoryAttributes( tree, category );
    
    tree := CapJitReplacedSourceAndRangeAttributes( tree, category );
    
    return tree;
    
end );

InstallGlobalFunction( CapJitReplacedGlobalVariablesByCategoryAttributes, function ( tree, category )
  local categories_in_tower, categories_in_tower_getters, category_attribute_values, category_attribute_values_getters, i, cat, cat_getter, attribute_names, value, pre_func, name;
    
    categories_in_tower := [ category ];
    categories_in_tower_getters := [
        rec(
            type := "EXPR_REF_FVAR",
            func_id := tree.id,
            name := tree.nams[1],
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
            
            attribute_names := ShallowCopy( cat!.compiler_hints.category_attribute_names );
            
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

InstallGlobalFunction( CapJitReplacedSourceAndRangeAttributes, function ( tree, category )
  local object_attribute_name, morphism_attribute_name, source_attribute_getter_name, range_attribute_getter_name, args, morphism_attribute_position, morphism_attribute_value, source_args, source_attribute_position, range_args, range_attribute_position;
    
    if not (IsBound( category!.compiler_hints ) and IsBound( category!.compiler_hints.source_and_range_attributes_from_morphism_attribute )) then
        
        return tree;
        
    fi;
    
    object_attribute_name := category!.compiler_hints.source_and_range_attributes_from_morphism_attribute.object_attribute_name;
    morphism_attribute_name := category!.compiler_hints.source_and_range_attributes_from_morphism_attribute.morphism_attribute_name;
    source_attribute_getter_name := category!.compiler_hints.source_and_range_attributes_from_morphism_attribute.source_attribute_getter_name;
    range_attribute_getter_name := category!.compiler_hints.source_and_range_attributes_from_morphism_attribute.range_attribute_getter_name;
    
    if Length( tree.stats.statements ) = 1 and tree.stats.statements[1].type = "STAT_RETURN_OBJ" and CapJitIsCallToGlobalFunction( tree.stats.statements[1].obj, "ObjectifyWithAttributes" ) then
        
        args := tree.stats.statements[1].obj.args;
        
        if Length( args ) > 7 and
            # check if 2nd argument is "MorphismType( cat )"
            CapJitIsCallToGlobalFunction( args[2], "MorphismType" ) and Length( args[2].args ) = 1 and args[2].args[1].type = "EXPR_REF_FVAR" and args[2].args[1].func_id = tree.id and args[2].args[1].name = tree.nams[1] and
            # check if 5th argument is "Source"
            args[5].type = "EXPR_REF_GVAR" and args[5].gvar = "Source" and
            # check if 7th argument is "Range"
            args[7].type = "EXPR_REF_GVAR" and args[7].gvar = "Range" then
            
            # check if either Source or Range are constructed inplace
            if CapJitIsCallToGlobalFunction( args[6], "ObjectifyWithAttributes" ) or CapJitIsCallToGlobalFunction( args[8], "ObjectifyWithAttributes" ) then
                
                morphism_attribute_position := PositionProperty( args, x -> x.type = "EXPR_REF_GVAR" and x.gvar = morphism_attribute_name );
                
                if morphism_attribute_position = fail then
                    
                    Error( "cannot find morphism attribute" );
                    
                fi;
                
                Assert( 0, morphism_attribute_position < Length( args ) );
                
                morphism_attribute_value := args[morphism_attribute_position + 1];
                
                Assert( 0, not "cap_jit_morphism_attribute" in tree.nams );
                
                tree.nams := Concatenation( tree.nams, [ "cap_jit_morphism_attribute" ] );
                tree.nloc := tree.nloc + 1;
                
                tree.stats.statements := Concatenation(
                    [
                        rec(
                            type := "STAT_ASS_FVAR",
                            func_id := tree.id,
                            name := "cap_jit_morphism_attribute",
                            initial_name := "cap_jit_morphism_attribute",
                            rhs := morphism_attribute_value,
                        )
                    ],
                    tree.stats.statements
                );
                
                args[morphism_attribute_position + 1] := rec(
                    type := "EXPR_REF_FVAR",
                    func_id := tree.id,
                    name := "cap_jit_morphism_attribute",
                    initial_name := "cap_jit_morphism_attribute",
                );
                
                if CapJitIsCallToGlobalFunction( args[6], "ObjectifyWithAttributes" ) then
                    
                    source_args := args[6].args;
                    
                    source_attribute_position := PositionProperty( source_args, x -> x.type = "EXPR_REF_GVAR" and x.gvar = object_attribute_name );
                    
                    if source_attribute_position = fail then
                        
                        Error( "cannot find source attribute" );
                        
                    fi;
                    
                    Assert( 0, source_attribute_position < Length( source_args ) );
                    
                    # ignore simple expression, e.g. integers
                    if not source_args[source_attribute_position + 1].type in [ "EXPR_INT", "EXPR_STRING", , "EXPR_CHAR", "EXPR_TRUE", "EXPR_FALSE", "EXPR_REF_GVAR", "EXPR_RANGE" ] then
                        
                        source_args[source_attribute_position + 1] := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := source_attribute_getter_name,
                            ),
                            args := [
                                rec(
                                    type := "EXPR_REF_FVAR",
                                    func_id := tree.id,
                                    name := "cap_jit_morphism_attribute",
                                    initial_name := "cap_jit_morphism_attribute",
                                ),
                            ],
                        );
                        
                    fi;
                    
                fi;
                        
                if CapJitIsCallToGlobalFunction( args[8], "ObjectifyWithAttributes" ) then
                    
                    range_args := args[8].args;
                    
                    range_attribute_position := PositionProperty( range_args, x -> x.type = "EXPR_REF_GVAR" and x.gvar = object_attribute_name );
                    
                    if range_attribute_position = fail then
                        
                        Error( "cannot find range attribute" );
                        
                    fi;
                    
                    Assert( 0, range_attribute_position < Length( range_args ) );
                    
                    # ignore simple expression, e.g. integers
                    if not range_args[range_attribute_position + 1].type in [ "EXPR_INT", "EXPR_STRING", , "EXPR_CHAR", "EXPR_TRUE", "EXPR_FALSE", "EXPR_REF_GVAR", "EXPR_RANGE" ] then
                        
                        range_args[range_attribute_position + 1] := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := range_attribute_getter_name,
                            ),
                            args := [
                                rec(
                                    type := "EXPR_REF_FVAR",
                                    func_id := tree.id,
                                    name := "cap_jit_morphism_attribute",
                                    initial_name := "cap_jit_morphism_attribute",
                                ),
                            ],
                        );
                        
                    fi;
                    
                fi;
                
            fi;
            
        fi;
        
    fi;
    
    return tree;
    
end );
