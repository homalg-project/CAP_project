# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := false;

InstallGlobalFunction( CapJitEnableProofAssistantMode, function ( )
    
    CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := true;
    
end );

InstallGlobalFunction( CapJitDisableProofAssistantMode, function ( )
    
    CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := false;
    
end );

# various logic templates which usually only appear in proofs

# literal booleans together with `and` and `or`
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "true and value",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value and true",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "false and value",
        dst_template := "false",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value and false",
        dst_template := "false",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "true or value",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value or true",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "false or value",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value or false",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

# not true => false
# Note: GAP simplifies `not true` to `false` during parsing, so we have to specify src_template_tree directly
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "not true",
        src_template_tree := rec(
            type := "EXPR_NOT",
            op := rec(
                type := "EXPR_TRUE",
            ),
        ),
        dst_template := "false",
        apply_in_proof_assistant_mode := "only",
    )
);

# not false => true
# Note: GAP simplifies `not false` to `true` during parsing, so we have to specify src_template_tree directly
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "not false",
        src_template_tree := rec(
            type := "EXPR_NOT",
            op := rec(
                type := "EXPR_FALSE",
            ),
        ),
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# ForAll( list, l -> true ) => true
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list" ],
        src_template := "ForAll( list, l -> true )",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# ForAll( [ ], func ) => true
# Note: the empty list can be of arbitrary type, so to avoid the warning about empty lists without types, we have to provide src_template_tree directly
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "func" ],
        src_template := "ForAll( [ ], func )",
        src_template_tree := rec(
            type := "EXPR_FUNCCALL",
            funcref := rec(
                type := "EXPR_REF_GVAR",
                gvar := "ForAll",
            ),
            args := AsSyntaxTreeList( [
                rec(
                    type := "EXPR_LIST",
                    list := AsSyntaxTreeList( [ ] ),
                ),
                rec(
                    type := "SYNTAX_TREE_VARIABLE",
                    id := 1,
                ),
            ] ),
        ),
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# IsEqualForObjects( expr, expr ) => true
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "expr" ],
        src_template := "IsEqualForObjects( cat, expr, expr )",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# IsCongruentForMorphisms( expr, expr ) => true
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "mor" ],
        src_template := "IsCongruentForMorphisms( cat, mor, mor )",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# take Source and Range of CAP operations
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    if not CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED then
        
        return tree;
        
    fi;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Source and Range of CAP operations." );
    
    pre_func := function ( tree, additional_arguments )
      local operation_name, getter;
        
        if CapJitIsCallToGlobalFunction( tree, gvar -> gvar = "Source" or gvar = "Range" or gvar = "Target" ) and tree.args.length = 1 and CapJitIsCallToGlobalFunction( tree.args.1, gvar -> gvar in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) ) then
            
            operation_name := tree.args.1.funcref.gvar;
            
            if tree.funcref.gvar = "Source" and IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).output_source_getter ) then
                
                getter := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).output_source_getter;
                
            elif tree.funcref.gvar in [ "Range", "Target" ] and IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).output_range_getter ) then
                
                getter := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).output_range_getter;
                
            else
                
                return tree;
                
            fi;
            
            return rec(
                type := "EXPR_FUNCCALL",
                funcref := ENHANCED_SYNTAX_TREE( getter ),
                args := tree.args.1.args,
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# apply local replacements
CapJitAddLogicFunction( function ( tree )
  local local_templates, template;
    
    if not CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED then
        
        return tree;
        
    fi;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA = fail then
        
        return tree;
        
    fi;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.func_id <> tree.id then
        
        return tree;
        
    fi;
    
    if IsEmpty( CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.local_replacements ) then
        
        return tree;
        
    fi;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply local replacements." );
    
    local_templates := List( CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.local_replacements, x -> rec(
        variable_names := [ ],
        variable_filters := [ ],
        src_template := Concatenation( x.src_template, " (local replacement)" ),
        src_template_tree := x.src_template_tree,
        dst_template := Concatenation( x.dst_template, " (local replacement)" ),
        dst_template_tree := x.dst_template_tree,
    ) );
    
    for template in local_templates do
        
        CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );
        
    od;
    
    tree := CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATES( tree, local_templates );
    
    # local replacements might introduce new CAP operations
    tree := CapJitResolvedOperations( tree );
    tree := CapJitResolvedGlobalVariables( tree );
    
    return tree;
    
end );
CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA := fail;

InstallMethod( StateLemma,
               [ IsString, IsFunction, IsCapCategory, IsList, IsList ],
               
  function ( description, func, cat, input_filters, preconditions )
    local tree, arguments_data_types, tmp_tree, src_template_tree, dst_template_tree, text, names, handled_input_filters, parts, local_replacements, filter, positions, plural, numerals, numeral, part, morphisms, name, source, range, to_remove, replacement, function_string, i, j;
    
    if not CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "please enable proof assistant mode with `CapJitEnableProofAssistantMode` before using `StateLemma`; if you 'return;', proof assistant mode will be now be enabled automatically" );
        CapJitEnableProofAssistantMode( );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    Assert( 0, CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED );
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA <> fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there already is an active lemma; if you 'return;' it will be overwritten" );
        
    fi;
    
    if IsEmpty( input_filters ) or input_filters[1] <> "category" or Length( input_filters ) <> NumberArgumentsFunction( func ) then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "input filters must not be empty, the first filter must be \"category\", and the number of filters must match the number of function arguments" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA := rec(
        claim := func,
        category := cat,
        input_filters := input_filters,
        local_replacements := [ ],
    );
    
    Add( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK, func );
    
    tree := ENHANCED_SYNTAX_TREE( func : given_arguments := [ cat ] );
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.func_id := tree.id;
    
    arguments_data_types := CAP_INTERNAL_GET_DATA_TYPES_FROM_STRINGS( input_filters, cat );
    
    Assert( 0, not fail in arguments_data_types );
    
    tree.data_type := rec(
        filter := IsFunction,
        signature := Pair(
            arguments_data_types,
            rec( filter := IsBool )
        ),
    );
    
    for replacement in preconditions do
        
        # src_template
        Assert( 0, input_filters[1] = "category" );
        
        tmp_tree := ENHANCED_SYNTAX_TREE( EvalStringStrict( Concatenation( "{ ", JoinStringsWithSeparator( tree.nams{[ 1 .. tree.narg ]}, ", " ), " } -> ", replacement.src_template ) ) : given_arguments := [ cat ] );
        
        tmp_tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tmp_tree, tree.id, tmp_tree.nams );
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        src_template_tree := CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" );
        
        # dst_template
        Assert( 0, input_filters[1] = "category" );
        
        tmp_tree := ENHANCED_SYNTAX_TREE( EvalStringStrict( Concatenation( "{ ", JoinStringsWithSeparator( tree.nams{[ 1 .. tree.narg ]}, ", " ), " } -> ", replacement.dst_template ) ) : given_arguments := [ cat ] );
        
        tmp_tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tmp_tree, tree.id, tmp_tree.nams );
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        dst_template_tree := CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" );
        
        #
        Add( CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.local_replacements, rec(
            src_template := replacement.src_template,
            src_template_tree := src_template_tree,
            dst_template := replacement.dst_template,
            dst_template_tree := dst_template_tree,
        ) );
        
    od;
    
    text := Concatenation( "In ", Name( cat ), ", ", description, ":\n" );
    
    Assert( 0, input_filters[1] = "category" );
    
    if Length( input_filters ) = 1 then
        
        Assert( 0, IsEmpty( CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.local_replacements ) );
        
        text := Concatenation( text, "We have" );
        
    elif Length( input_filters ) > 1 then
        
        text := Concatenation( text, "For" );
        
        names := tree.nams;
        
        Assert( 0, Length( names ) >= Length( input_filters ) );
        
        handled_input_filters := [ ];
        
        parts := [ ];
        
        local_replacements := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.local_replacements;
        
        for i in [ 2 .. Length( input_filters ) ] do
            
            filter := input_filters[i];
            
            if filter in handled_input_filters then
                
                continue;
                
            fi;
            
            positions := Positions( input_filters, filter );
            
            Assert( 0, i in positions );
            
            if Length( positions ) = 1 then
                
                plural := "";
                
            else
                
                plural := "s";
                
            fi;
            
            numerals := [ "a", "two", "three", "four", "five", "six", "seven", "eight", "nine" ];
            
            if Length( positions ) <= Length( numerals ) then
                
                numeral := numerals[Length( positions )];
                
            else
                
                numeral := String( Length( positions ) );
                
            fi;
            
            if filter = "element_of_commutative_ring_of_linear_structure" then
                
                part := Concatenation( numeral, " element", plural, " ", ConcatenationOfStringsAsEnumerationWithAnd( names{positions} ), " of the commutative ring of the linear structure" );
                
                part := ReplacedString( part, "a element ", "an element " );
                
            elif filter = "object" then
                
                part := Concatenation( numeral, " object", plural, " ", ConcatenationOfStringsAsEnumerationWithAnd( names{positions} ) );
                
                part := ReplacedString( part, "a object ", "an object " );
            
            elif filter = "morphism" or filter = "morphism_in_range_category_of_homomorphism_structure" then
                
                morphisms := [ ];
                
                for i in positions do
                    
                    name := names[i];
                    
                    source := fail;
                    range := fail;
                    
                    to_remove := [ ];
                    
                    for j in [ 1 .. Length( local_replacements ) ] do
                        
                        replacement := local_replacements[j];
                        
                        if CapJitIsCallToGlobalFunction( replacement.src_template_tree, "Source" ) and replacement.src_template_tree.args.length = 1 and
                           replacement.src_template_tree.args.1.type = "EXPR_REF_FVAR" and replacement.src_template_tree.args.1.func_id = tree.id and replacement.src_template_tree.args.1.name = name then
                            
                            Assert( 0, source = fail );
                            
                            source := replacement.dst_template;
                            
                            Add( to_remove, j );
                            
                        elif CapJitIsCallToGlobalFunction( replacement.src_template_tree, gvar -> gvar in [ "Range", "Target" ] ) and replacement.src_template_tree.args.length = 1 and
                           replacement.src_template_tree.args.1.type = "EXPR_REF_FVAR" and replacement.src_template_tree.args.1.func_id = tree.id and replacement.src_template_tree.args.1.name = name then
                            
                            Assert( 0, range = fail );
                            
                            range := replacement.dst_template;
                            
                            Add( to_remove, j );
                            
                        fi;
                        
                    od;
                    
                    if source = fail or range = fail then
                        
                        # COVERAGE_IGNORE_BLOCK_START
                        Error( "could not determine source or range of ", name );
                        return;
                        # COVERAGE_IGNORE_BLOCK_END
                        
                    fi;
                    
                    local_replacements := local_replacements{Difference( [ 1 .. Length( local_replacements ) ], to_remove )};
                    
                    Add( morphisms, Concatenation( name, " : ", source, " → ", range ) );
                    
                od;
                
                if filter = "morphism" then
                    
                    part := Concatenation( numeral, " morphism", plural, " ", ConcatenationOfStringsAsEnumerationWithAnd( morphisms ) );
                    
                elif filter = "morphism_in_range_category_of_homomorphism_structure" then
                    
                    part := Concatenation( numeral, " morphism", plural, " ", ConcatenationOfStringsAsEnumerationWithAnd( morphisms ), " in the range category of the homomorphism structure" );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "this should never happen" );
                    
                fi;
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "not yet handled" );
                
            fi;
            
            Add( parts, part );
            
            Add( handled_input_filters, filter );
            
        od;
        
        text := Concatenation( text, " ", ConcatenationOfStringsAsEnumerationWithAnd( parts ), " " );
        
        if not IsEmpty( local_replacements ) then
            
            text := Concatenation( text, "such that\n" );
            
            for replacement in local_replacements do
                
                text := Concatenation( text, "• ", replacement.src_template, " = ", replacement.dst_template, ",\n" );
                
            od;
            
        fi;
        
        text := Concatenation( text, "we have" );
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "this should never happen" );
        
    fi;
    
    Print( text, "\n" );
    Print( func, "\n" );
    
    tree := CAP_JIT_INTERNAL_COMPILED_ENHANCED_SYNTAX_TREE( tree, "with_post_processing", cat );
    
    function_string := CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Could not get rid of all global variables, see <function_string>. You should use compiler_hints.category_attribute_names." );
        
    fi;
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree := tree;
    
    if tree.bindings.names = [ "RETURN_VALUE" ] and tree.bindings.BINDING_RETURN_VALUE.type = "EXPR_TRUE" then
        
        Print( "This is immediate from the construction.\n" );
        
        CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA := fail;
        
        Remove( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
        
    fi;
    
end );

InstallMethod( PrintLemma,
               [ ],
               
  function ( )
    local tree, func;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA = fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "no active lemma, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    tree := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree;
    
    func := ENHANCED_SYNTAX_TREE_CODE( tree );
    
    Print( "We have to show\n" );
    Print( func, "\n" );
    
end );

InstallMethod( AttestValidInputs,
               [ ],
               
  function ( )
    local tree, cat, pre_func, old_tree, function_string;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA = fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "no active lemma, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    tree := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree;
    cat := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.category;
    
    # assert that the tree is well-typed
    Assert( 0, IsBound( tree.bindings.BINDING_RETURN_VALUE.data_type ) );
    
    pre_func := function ( tree, additional_arguments )
      local category, source, morphism, range, attribute, ring;
        
        # properties like IsZeroForMorphisms can be applied to two arguments, a category and a morphism
        if CapJitIsCallToGlobalFunction( tree, x -> IsFilter( ValueGlobal( x ) ) ) and tree.args.length = 1 then
            
            if IsSpecializationOfFilter( ValueGlobal( tree.funcref.gvar ), tree.args.1.data_type.filter ) then
                
                return rec( type := "EXPR_TRUE" );
                
            fi;
            
            # We do not want to return `false` in the `else` case, for example because `IsList( Pair( 1, 2 ) )` is `true` but `IsNTuple` does not imply `IsList`.
            
        fi;
        
        if CapJitIsCallToGlobalFunction( tree, "IsWellDefinedForObjects" ) and tree.args.length = 2 then
            
            Assert( 0, IsSpecializationOfFilter( "category", tree.args.1.data_type.filter ) );
            Assert( 0, IsSpecializationOfFilter( ObjectFilter( tree.args.1.data_type.category ), tree.args.2.data_type.filter ) );
            Assert( 0, IsIdenticalObj( tree.args.1.data_type.category, tree.args.2.data_type.category ) );
            
            return rec( type := "EXPR_TRUE" );
            
        fi;
        
        if CapJitIsCallToGlobalFunction( tree, "IsWellDefinedForMorphismsWithGivenSourceAndRange" ) and tree.args.length = 4 then
            
            category := tree.args.1;
            source := tree.args.2;
            morphism := tree.args.3;
            range := tree.args.4;
            
            Assert( 0, IsSpecializationOfFilter( "category", category.data_type.filter ) );
            
            Assert( 0, IsSpecializationOfFilter( ObjectFilter( category.data_type.category ), source.data_type.filter ) );
            Assert( 0, IsIdenticalObj( category.data_type.category, source.data_type.category ) );
            
            Assert( 0, IsSpecializationOfFilter( MorphismFilter( category.data_type.category ), morphism.data_type.filter ) );
            Assert( 0, IsIdenticalObj( category.data_type.category, morphism.data_type.category ) );
            
            Assert( 0, IsSpecializationOfFilter( ObjectFilter( category.data_type.category ), range.data_type.filter ) );
            Assert( 0, IsIdenticalObj( category.data_type.category, range.data_type.category ) );
            
            # IsEqualForObjects( category, Source( morphism ), source ) and IsEqualForObjects( category, Range( morphism ), range )
            return rec(
                type := "EXPR_AND",
                left := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "IsEqualForObjects",
                    ),
                    args := AsSyntaxTreeList( [
                        CapJitCopyWithNewFunctionIDs( category ),
                        rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "Source",
                            ),
                            args := AsSyntaxTreeList( [
                                CapJitCopyWithNewFunctionIDs( morphism ),
                            ] ),
                        ),
                        source,
                    ] ),
                ),
                right := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "IsEqualForObjects",
                    ),
                    args := AsSyntaxTreeList( [
                        CapJitCopyWithNewFunctionIDs( category ),
                        rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "Range",
                            ),
                            args := AsSyntaxTreeList( [
                                CapJitCopyWithNewFunctionIDs( morphism ),
                            ] ),
                        ),
                        range,
                    ] ),
                ),
            );
            
        fi;
        
        # `in` for rings corresponds to `IsWellDefined` for categories
        if tree.type = "EXPR_IN" and IsSpecializationOfFilter( IsRingElement, tree.left.data_type.filter ) and IsSpecializationOfFilter( IsRing, tree.right.data_type.filter ) then
            
            # In the future, the ring should be part of the data type.
            # For now, we can only consider attributes of categories.
            if CapJitIsCallToGlobalFunction( tree.right, gvar -> true ) and tree.right.args.length = 1 and IsSpecializationOfFilter( "category", tree.right.args.1.data_type.filter ) then
                
                category := tree.right.args.1.data_type.category;
                
                attribute := ValueGlobal( tree.right.funcref.gvar );
                
                ring := attribute( category );
                
                Assert( 0, IsRing( ring ) );
                
                if HasRingElementFilter( ring ) and IsSpecializationOfFilter( RingElementFilter( ring ), tree.left.data_type.filter ) then
                    
                    return rec( type := "EXPR_TRUE" );
                    
                fi;
                
                # we are conservative and do not return `false` for now if the filter does not match
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    old_tree := StructuralCopy( tree );
    
    tree := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
    if CapJitIsEqualForEnhancedSyntaxTrees( old_tree, tree ) then
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
        
        Error( "attesting valid inputs did not change the tree, you can 'return;' to continue anyway" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    tree := CAP_JIT_INTERNAL_COMPILED_ENHANCED_SYNTAX_TREE( tree, "with_post_processing", cat );
    
    function_string := CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Could not get rid of all global variables, see <function_string>. You should use compiler_hints.category_attribute_names." );
        
    fi;
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree := tree;
    
    Print( "We let CompilerForCAP assume that all inputs are valid.\n" );
    
end );

InstallMethod( ApplyLogicTemplate,
               [ IsRecord ],
               
  function ( logic_template )
    local tree, cat, old_tree, new_tree, function_string;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA = fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "no active lemma, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    tree := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree;
    cat := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.category;
    
    logic_template := ShallowCopy( logic_template );
    
    if not IsBound( logic_template.number_of_applications ) then
        
        logic_template.number_of_applications := 1;
        
    fi;
    
    if logic_template.number_of_applications = infinity then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Calling ApplyLogicTemplate with a logic template with an infinite number of applications is not supported. Please use CapJitAddLogicTemplate instead." );
        
    fi;
    
    CapJitAddLogicTemplate( logic_template );
    
    old_tree := StructuralCopy( tree );
    
    new_tree := CAP_JIT_INTERNAL_COMPILED_ENHANCED_SYNTAX_TREE( tree, "with_post_processing", cat );
    
    function_string := CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( new_tree ) );
    
    if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Could not get rid of all global variables, see <function_string>. You should use compiler_hints.category_attribute_names." );
        
    fi;
    
    if CapJitIsEqualForEnhancedSyntaxTrees( old_tree, new_tree ) then
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( ENHANCED_SYNTAX_TREE_CODE( new_tree ) );
        
        Error( "applying the logic template did not change the tree; you can 'return;' to continue anyway" );
        # COVERAGE_IGNORE_BLOCK_END
        
    elif ForAny( CAP_JIT_LOGIC_TEMPLATES, t -> IsBound( t.is_fully_enhanced ) and t.is_fully_enhanced = true and t.number_of_applications <> infinity ) then
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( ENHANCED_SYNTAX_TREE_CODE( new_tree ) );
        
        Perform( CAP_JIT_LOGIC_TEMPLATES, function ( t ) if IsBound( t.is_fully_enhanced ) and t.is_fully_enhanced = true and t.number_of_applications <> infinity then Display( t.number_of_applications ); fi; end );
        
        Error( "there are logic templates with the non-zero number of remaining applications displayed above; you can 'return;' to remove the logic templates and continue" );
        
        MakeReadWriteGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
        
        CAP_JIT_LOGIC_TEMPLATES := Filtered( CAP_JIT_LOGIC_TEMPLATES, function ( t )
            
            if not (IsBound( t.is_fully_enhanced ) and t.is_fully_enhanced = true) then
                
                return true;
                
            else
                
                return t.number_of_applications = infinity;
                
            fi;
            
        end );
        
        MakeReadOnlyGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree := new_tree;
    
end );

InstallMethod( ApplyLogicTemplateNTimes,
               [ IsPosInt, IsRecord ],
               
  function ( n, logic_template )
    local i;
    
    Assert( 0, not IsBound( logic_template.number_of_applications ) );
    
    for i in [ 1 .. n ] do
        
        ApplyLogicTemplate( logic_template );
        
    od;
    
end );

InstallMethod( AssertLemma,
               [ ],
               
  function ( )
    local tree;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA = fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "no active lemma, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    tree := CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.tree;
    
    # check that the function id has not changed (otherwise local replacements have no change to match)
    Assert( 0, tree.id = CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA.func_id );
    
    if tree.bindings.names = [ "RETURN_VALUE" ] and tree.bindings.BINDING_RETURN_VALUE.type = "EXPR_TRUE" then
        
        CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA := fail;
        
        Remove( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
        
        Print( "With this, the claim follows. ∎\n" );
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
        
        Error( "function is not reduced to `{...} -> true`, not clearing lemma; you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
end );

BindGlobal( "CAP_JIT_INTERNAL_PROOF_ASSISTANT_LEMMATA", rec(
    PreCompose := rec(
        lemmata := [
            rec(
                description := "the composite of two morphisms defines a morphism",
                input_types := [ "category", "object", "object", "object", "morphism", "morphism" ],
                func := function ( cat, A, B, C, alpha, beta )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, PreCompose( cat, alpha, beta ), C );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "B" ),
                    rec( src_template := "Range( beta )", dst_template := "C" ),
                ],
            ),
            rec(
                description := "composition is associative",
                input_types := [ "category", "object", "object", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, D, alpha, beta, gamma )
                    
                    return IsCongruentForMorphisms( cat, PreCompose( cat, PreCompose( cat, alpha, beta ), gamma ), PreCompose( cat, alpha, PreCompose( cat, beta, gamma ) ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "B" ),
                    rec( src_template := "Range( beta )", dst_template := "C" ),
                    rec( src_template := "Source( gamma )", dst_template := "C" ),
                    rec( src_template := "Range( gamma )", dst_template := "D" ),
                ],
            ),
        ],
    ),
    IdentityMorphism := rec(
        lemmata := [
            rec(
                description := "the identity on an object defines a morphism",
                input_types := [ "category", "object" ],
                func := function ( cat, A )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, IdentityMorphism( cat, A ), A );
                    
                end,
                preconditions := [ ],
            ),
            rec(
                description := "identity morphisms are left neutral",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, PreCompose( cat, IdentityMorphism( cat, A ), alpha ), alpha );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "identity morphisms are right neutral",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, PreCompose( cat, alpha, IdentityMorphism( cat, B ) ), alpha );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
        ],
    ),
    AdditionForMorphisms := rec(
        lemmata := [
            rec(
                description := "the addition of morphisms defines a morphism",
                input_types := [ "category", "object", "object", "morphism", "morphism" ],
                func := function ( cat, A, B, alpha, beta )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, AdditionForMorphisms( cat, alpha, beta ), B );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "A" ),
                    rec( src_template := "Range( beta )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "addition of morphisms is associative",
                input_types := [ "category", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, alpha, beta, gamma )
                    
                    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), gamma ), AdditionForMorphisms( cat, alpha, AdditionForMorphisms( cat, beta, gamma ) ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "A" ),
                    rec( src_template := "Range( beta )", dst_template := "B" ),
                    rec( src_template := "Source( gamma )", dst_template := "A" ),
                    rec( src_template := "Range( gamma )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "addition of morphisms is commutative",
                input_types := [ "category", "object", "object", "morphism", "morphism" ],
                func := function ( cat, A, B, alpha, beta )
                    
                    return IsCongruentForMorphisms( cat,
                        AdditionForMorphisms( cat, alpha, beta ),
                        AdditionForMorphisms( cat, beta, alpha )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "A" ),
                    rec( src_template := "Range( beta )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "composition is additive in the first component",
                input_types := [ "category", "object", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, alpha, beta, phi )
                    
                    return IsCongruentForMorphisms( cat,
                        PreCompose( cat, AdditionForMorphisms( cat, alpha, beta ), phi ),
                        AdditionForMorphisms( cat, PreCompose( cat, alpha, phi ), PreCompose( cat, beta, phi ) )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "A" ),
                    rec( src_template := "Range( beta )", dst_template := "B" ),
                    
                    rec( src_template := "Source( phi )", dst_template := "B" ),
                    rec( src_template := "Range( phi )", dst_template := "C" ),
                ],
            ),
            rec(
                description := "composition is additive in the second component",
                input_types := [ "category", "object", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, alpha, beta, phi )
                    
                    return IsCongruentForMorphisms( cat,
                        PreCompose( cat, phi, AdditionForMorphisms( cat, alpha, beta ) ),
                        AdditionForMorphisms( cat, PreCompose( cat, phi, alpha ), PreCompose( cat, phi, beta ) )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( phi )", dst_template := "A" ),
                    rec( src_template := "Range( phi )", dst_template := "B" ),
                    
                    rec( src_template := "Source( alpha )", dst_template := "B" ),
                    rec( src_template := "Range( alpha )", dst_template := "C" ),
                    rec( src_template := "Source( beta )", dst_template := "B" ),
                    rec( src_template := "Range( beta )", dst_template := "C" ),
                ],
            ),
        ],
    ),
    ZeroMorphism := rec(
        lemmata := [
            rec(
                description := "the zero morphism between two objects is a morphism",
                input_types := [ "category", "object", "object" ],
                func := function ( cat, A, B )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, ZeroMorphism( cat, A, B ), B );
                    
                end,
                preconditions := [ ],
            ),
            rec(
                description := "zero morphisms are left neutral",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, ZeroMorphism( cat, A, B ), alpha ), alpha );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "zero morphisms are right neutral",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, ZeroMorphism( cat, A, B ) ), alpha );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
        ],
    ),
    AdditiveInverseForMorphisms := rec(
        lemmata := [
            rec(
                description := "the additive inverse of a morphism defines a morphism",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, AdditiveInverseForMorphisms( cat, alpha ), B );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "additive inverses are left inverse",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, AdditiveInverseForMorphisms( cat, alpha ), alpha ), ZeroMorphism( cat, A, B ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "additive inverses are right inverse",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, AdditiveInverseForMorphisms( cat, alpha ) ), ZeroMorphism( cat, A, B ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
        ],
    ),
    MultiplyWithElementOfCommutativeRingForMorphisms := rec(
        lemmata := [
            rec(
                description := "multiplying a morphism by a ring element defines a morphism",
                input_types := [ "category", "object", "object", "element_of_commutative_ring_of_linear_structure", "morphism" ],
                func := function ( cat, A, B, r, alpha )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), B );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "multiplication with ring elements is associative",
                input_types := [ "category", "object", "object", "element_of_commutative_ring_of_linear_structure", "element_of_commutative_ring_of_linear_structure", "morphism" ],
                func := function ( cat, A, B, r, s, alpha )
                    
                    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, MultiplyWithElementOfCommutativeRingForMorphisms( s, alpha ) ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r * s, alpha ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "composition distributes over the addition of ring elements",
                input_types := [ "category", "object", "object", "element_of_commutative_ring_of_linear_structure", "element_of_commutative_ring_of_linear_structure", "morphism" ],
                func := function ( cat, A, B, r, s, alpha )
                    
                    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r + s, alpha ), AdditionForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, s, alpha ) ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "ring multiplication distributes over the addition of morphisms",
                input_types := [ "category", "object", "object", "element_of_commutative_ring_of_linear_structure", "morphism", "morphism" ],
                func := function ( cat, A, B, r, alpha, beta )
                    
                    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, AdditionForMorphisms( cat, alpha, beta ) ), AdditionForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, beta ) ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "A" ),
                    rec( src_template := "Range( beta )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "multiplication with ring elements has a neutral element",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, One( CommutativeRingOfLinearCategory( cat ) ), alpha ), alpha );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                description := "composition is linear in the first component",
                input_types := [ "category", "object", "object", "object", "element_of_commutative_ring_of_linear_structure", "morphism", "morphism" ],
                func := function ( cat, A, B, C, r, alpha, beta )
                    
                    return IsCongruentForMorphisms( cat, PreCompose( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), beta ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, PreCompose( cat, alpha, beta ) ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "B" ),
                    rec( src_template := "Range( beta )", dst_template := "C" ),
                ],
            ),
            rec(
                description := "composition is linear in the second component",
                input_types := [ "category", "object", "object", "object", "element_of_commutative_ring_of_linear_structure", "morphism", "morphism" ],
                func := function ( cat, A, B, C, r, alpha, beta )
                    
                    return IsCongruentForMorphisms( cat, PreCompose( cat, alpha, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, beta ) ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, PreCompose( cat, alpha, beta ) ) );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "B" ),
                    rec( src_template := "Range( beta )", dst_template := "C" ),
                ],
            ),
        ],
    ),
    ZeroObject := rec(
        lemmata := [
            rec(
                description := "the zero object is an object",
                input_types := [ "category" ],
                func := function ( cat )
                    
                    return IsWellDefinedForObjects( cat, ZeroObject( cat ) );
                    
                end,
                preconditions := [ ],
            ),
        ],
    ),
    UniversalMorphismIntoZeroObject := rec(
        lemmata := [
            rec(
                description := "the universal morphism into the zero objects defines a morphism",
                input_types := [ "category", "object" ],
                func := function ( cat, A )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, UniversalMorphismIntoZeroObject( cat, A ), ZeroObject( cat ) );
                    
                end,
                preconditions := [ ],
            ),
            rec(
                description := "the universal morphism into the zero object is unique",
                input_types := [ "category", "object", "morphism" ],
                func := function ( cat, A, u )
                    
                    return IsCongruentForMorphisms( cat,
                        UniversalMorphismIntoZeroObject( cat, A ),
                        u
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( u )", dst_template := "A" ),
                    rec( src_template := "Range( u )", dst_template := "ZeroObject( cat )" ),
                ],
            ),
        ],
    ),
    UniversalMorphismFromZeroObject := rec(
        lemmata := [
            rec(
                description := "the universal morphism from the zero objects defines a morphism",
                input_types := [ "category", "object" ],
                func := function ( cat, B )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, ZeroObject( cat ), UniversalMorphismFromZeroObject( cat, B ), B );
                    
                end,
                preconditions := [ ],
            ),
            rec(
                description := "the universal morphism from the zero object is unique",
                input_types := [ "category", "object", "morphism" ],
                func := function ( cat, B, u )
                    
                    return IsCongruentForMorphisms( cat,
                        UniversalMorphismFromZeroObject( cat, B ),
                        u
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( u )", dst_template := "ZeroObject( cat )" ),
                    rec( src_template := "Range( u )", dst_template := "B" ),
                ],
            ),
        ],
    ),
    DistinguishedObjectOfHomomorphismStructure := rec(
        lemmata := [
            rec(
                description := "the distinguished object is an object in the range category of the homomorphism structure",
                input_types := [ "category" ],
                func := function ( cat )
                    
                    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ) );
                    
                end,
                preconditions := [ ],
            ),
        ],
    ),
    HomomorphismStructureOnObjects := rec(
        lemmata := [
            rec(
                description := "the homomorphism structure on objects defines an object in the range category of the homomorphism structure",
                input_types := [ "category", "object", "object" ],
                func := function ( cat, A, B )
                    
                    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) );
                    
                end,
                preconditions := [ ],
            ),
        ],
    ),
    HomomorphismStructureOnMorphisms := rec(
        lemmata := [
            rec(
                description := "the homomorphism structure on morphisms defines a morphism in the range category of the homomorphism structure",
                input_types := [ "category", "object", "object", "object", "object", "morphism", "morphism" ],
                func := function ( cat, A, B, C, D, alpha, beta )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat ),
                        HomomorphismStructureOnObjects( cat, B, C ),
                        HomomorphismStructureOnMorphisms( cat, alpha, beta ),
                        HomomorphismStructureOnObjects( cat, A, D )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( beta )", dst_template := "C" ),
                    rec( src_template := "Range( beta )", dst_template := "D" ),
                ],
            ),
            # H( id, id ) = id
            rec(
                description := "the homomorphism structure preserves identities",
                input_types := [ "category", "object", "object" ],
                func := function ( cat, A, B )
                    
                    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
                        HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) ),
                        IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) )
                    );
                    
                end,
                preconditions := [ ],
            ),
            # H( α₁, β₁ ) ⋅ H( α₂, β₂ ) = H( α₂ ⋅ α₁, β₁ ⋅ β₂ )
            rec(
                description := "the homomorphism structure is compatible with composition",
                input_types := [ "category", "object", "object", "object", "object", "object", "object", "morphism", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, D, E, F, alpha_1, alpha_2, beta_1, beta_2 )
                    
                    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
                        PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta_2 ) ),
                        HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha_2, alpha_1 ), PreCompose( cat, beta_1, beta_2 ) )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha_2 )", dst_template := "A" ),
                    rec( src_template := "Range( alpha_2 )", dst_template := "B" ),
                    rec( src_template := "Source( alpha_1 )", dst_template := "B" ),
                    rec( src_template := "Range( alpha_1 )", dst_template := "C" ),
                    
                    rec( src_template := "Source( beta_1 )", dst_template := "D" ),
                    rec( src_template := "Range( beta_1 )", dst_template := "E" ),
                    rec( src_template := "Source( beta_2 )", dst_template := "E" ),
                    rec( src_template := "Range( beta_2 )", dst_template := "F" ),
                ],
            ),
            # H( α₁, β ) + H( α₂, β ) = H( α₁ + α₂, β )
            rec(
                description := "the homomorphism structue is additive in the first component",
                input_types := [ "category", "object", "object", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, D, alpha_1, alpha_2, beta )
                    
                    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
                        AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta ) ),
                        HomomorphismStructureOnMorphisms( cat, AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha_1 )", dst_template := "A" ),
                    rec( src_template := "Range( alpha_1 )", dst_template := "B" ),
                    rec( src_template := "Source( alpha_2 )", dst_template := "A" ),
                    rec( src_template := "Range( alpha_2 )", dst_template := "B" ),
                    
                    rec( src_template := "Source( beta )", dst_template := "C" ),
                    rec( src_template := "Range( beta )", dst_template := "D" ),
                ],
                category_filter := IsAbCategory,
            ),
            # H( α, β₁ ) + H( α, β₂ ) = H( α, β₁ + β₂ )
            rec(
                description := "the homomorphism structure is additive in the second component",
                input_types := [ "category", "object", "object", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, D, alpha, beta_1, beta_2 )
                    
                    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
                        AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha, beta_2 ) ),
                        HomomorphismStructureOnMorphisms( cat, alpha, AdditionForMorphisms( cat, beta_1, beta_2 ) )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    
                    rec( src_template := "Source( beta_1 )", dst_template := "C" ),
                    rec( src_template := "Range( beta_1 )", dst_template := "D" ),
                    rec( src_template := "Source( beta_2 )", dst_template := "C" ),
                    rec( src_template := "Range( beta_2 )", dst_template := "D" ),
                ],
                category_filter := IsAbCategory,
            ),
        ],
    ),
    InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure := rec(
        lemmata := [
            rec(
                description := "interpreting a morphism as a morphism from the distinguished object defines a morphism in the range category of the homomorphism structure",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat ),
                        DistinguishedObjectOfHomomorphismStructure( cat ),
                        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ),
                        HomomorphismStructureOnObjects( cat, A, B )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            # for more, see InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
        ],
    ),
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism := rec(
        lemmata := [
            rec(
                description := "reinterpreting a morphism from the distinguished morphism as a usual morphism defines a morphism",
                input_types := [ "category", "object", "object", "morphism_in_range_category_of_homomorphism_structure" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat,
                        A,
                        InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, alpha ),
                        B
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "DistinguishedObjectOfHomomorphismStructure( cat )" ),
                    rec( src_template := "Range( alpha )", dst_template := "HomomorphismStructureOnObjects( cat, A, B )" ),
                ],
            ),
            rec(
                # ν⁻¹(ν(α)) = α
                description := "interpreting morphisms as morphisms from the distinguished object is an injective operation",
                input_types := [ "category", "object", "object", "morphism" ],
                func := function ( cat, A, B, alpha )
                    
                    return IsCongruentForMorphisms( cat,
                        InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ) ),
                        alpha
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                ],
            ),
            rec(
                # ν(ν⁻¹(α)) = α
                description := "interpreting morphisms as morphisms from the distinguished object is a surjective operation",
                input_types := [ "category", "object", "object", "morphism_in_range_category_of_homomorphism_structure" ],
                func := function ( cat, S, T, alpha )
                    
                    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
                        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, S, T, alpha ) ),
                        alpha
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "DistinguishedObjectOfHomomorphismStructure( cat )" ),
                    rec( src_template := "Range( alpha )", dst_template := "HomomorphismStructureOnObjects( cat, S, T )" ),
                ],
            ),
            rec(
                # naturality of ν: ν(α ⋅ ξ ⋅ β) = ν(ξ) ⋅ H(α, β)
                description := "interpreting morphisms as morphisms from the distinguished object is a natural transformation",
                input_types := [ "category", "object", "object", "object", "object", "morphism", "morphism", "morphism" ],
                func := function ( cat, A, B, C, D, alpha, xi, beta )
                    
                    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
                        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PreComposeList( cat, A, [ alpha, xi, beta ], D ) ),
                        PreCompose( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) )
                    );
                    
                end,
                preconditions := [
                    rec( src_template := "Source( alpha )", dst_template := "A" ),
                    rec( src_template := "Range( alpha )", dst_template := "B" ),
                    rec( src_template := "Source( xi )", dst_template := "B" ),
                    rec( src_template := "Range( xi )", dst_template := "C" ),
                    rec( src_template := "Source( beta )", dst_template := "C" ),
                    rec( src_template := "Range( beta )", dst_template := "D" ),
                ],
            ),
        ],
    ),
) );

BindGlobal( "CAP_JIT_INTERNAL_PROOF_ASSISTANT_PROPOSITIONS", rec(
    is_category := rec(
        description := "is indeed a category",
        operations := [ "PreCompose", "IdentityMorphism" ],
    ),
    is_equipped_with_preadditive_structure := rec(
        description := "is equipped with a preadditive structure",
        operations := [ "AdditionForMorphisms", "ZeroMorphism", "AdditiveInverseForMorphisms" ],
    ),
    is_equipped_with_linear_structure := rec(
        description := "is equipped with a linear structure",
        operations := [ "MultiplyWithElementOfCommutativeRingForMorphisms" ],
    ),
    has_zero_object := rec(
        description := "has a zero object",
        operations := [ "ZeroObject", "UniversalMorphismIntoZeroObject", "UniversalMorphismFromZeroObject" ],
    ),
    is_equipped_with_hom_structure := rec(
        description := "is equipped with a homomorphism structure",
        operations := [ "DistinguishedObjectOfHomomorphismStructure", "HomomorphismStructureOnObjects", "HomomorphismStructureOnMorphisms", "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure", "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ],
    ),
) );

BindGlobal( "CAP_JIT_INTERNAL_PROOF_ASSISTANT_ENHANCE_PROPOSITIONS", function ( propositions )
  local cat, obj, mor, prop, specification, test_arguments, id, operation_name, lemma;
    
    # use a terminal category for plausibility tests
    cat := TerminalCategoryWithSingleObject( );
    obj := UniqueObject( cat );
    mor := UniqueMorphism( cat );
    
    for id in RecNames( propositions ) do
        
        prop := propositions.(id);
        
        Assert( 0, not IsBound( prop.lemmata ) );
        
        prop.lemmata := [ ];
        
        for operation_name in prop.operations do
            
            Assert( 0, IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) );
            Assert( 0, IsBound( CAP_JIT_INTERNAL_PROOF_ASSISTANT_LEMMATA.(operation_name) ) );
            
            specification := CAP_JIT_INTERNAL_PROOF_ASSISTANT_LEMMATA.(operation_name);
            
            # various plausibility checks
            
            Assert( 0, not IsEmpty( specification.lemmata ) );
            Assert( 0, PositionSublist( CapJitPrettyPrintFunction( specification.lemmata[1].func ), "IsWellDefined" ) <> fail );
            
            for lemma in specification.lemmata do
                
                Assert( 0, Length( lemma.input_types ) = NumberArgumentsFunction( lemma.func ) );
                Assert( 0, lemma.input_types[1] = "category" );
                Assert( 0, IsBound( lemma.preconditions ) );
                
                # test `lemma.func` with inputs in the terminal category
                # the terminal category only has a hom structure if MonoidalCategories is already loaded
                # -> check if the operation can be computed first
                if CanCompute( cat, operation_name ) then
                    
                    test_arguments := List( lemma.input_types, function ( type )
                        
                        if type = "category" then
                            
                            return cat;
                            
                        elif type = "object" or type = "object_in_range_category_of_homomorphism_structure" then
                            
                            return obj;
                            
                        elif type = "morphism" or type = "morphism_in_range_category_of_homomorphism_structure" then
                            
                            return mor;
                            
                        elif type = "element_of_commutative_ring_of_linear_structure" then
                            
                            return 2;
                            
                        else
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            Error( "not handled yet" );
                            
                        fi;
                        
                    end );
                    
                    Assert( 0, CallFuncList( lemma.func, test_arguments ) );
                    
                fi;
                
            od;
            
            prop.lemmata := Concatenation( prop.lemmata, specification.lemmata );
            
        od;
        
    od;
    
end );

CAP_JIT_INTERNAL_PROOF_ASSISTANT_ENHANCE_PROPOSITIONS( CAP_JIT_INTERNAL_PROOF_ASSISTANT_PROPOSITIONS );

CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION := fail;

InstallMethod( StateProposition,
               [ IsCapCategory, IsString ],
               
  function ( cat, proposition_id )
    local proposition, claim_string;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION <> fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "there already is an active proposition, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_PROOF_ASSISTANT_PROPOSITIONS.(proposition_id) ) then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "\"", proposition_id, "\" is not a known proposition, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    proposition := CAP_JIT_INTERNAL_PROOF_ASSISTANT_PROPOSITIONS.(proposition_id);
    
    claim_string := Concatenation( Name( cat ), " ", proposition.description, "." );
    claim_string := Concatenation( [ UppercaseChar( claim_string[1] ) ], claim_string{[ 2 .. Length( claim_string ) ]} );
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION := rec(
        category := cat,
        claim_string := claim_string,
        lemmata := Filtered( proposition.lemmata, l -> not IsBound( l.category_filter ) or (Tester( l.category_filter )( cat ) and l.category_filter( cat )) ),
        active_lemma_index := 0,
    );
    
    Print( "Proposition:\n" );
    Print( claim_string, "\n" );
    
end );

InstallMethod( StateNextLemma,
               [ ],
               
  function ( )
    local cat, lemmata, active_lemma_index, active_lemma;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION = fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "no active proposition, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA <> fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "there already is an active lemma, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    cat := CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.category;
    lemmata := CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.lemmata;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.active_lemma_index = Length( lemmata ) then
        
        Print( "\n\nAll lemmata are proven.\n" );
        return;
        
    fi;
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.active_lemma_index := CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.active_lemma_index + 1;
    
    active_lemma_index := CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.active_lemma_index;
    
    active_lemma := lemmata[active_lemma_index];
    
    Print( "\n\nLemma ", active_lemma_index, ":\n" );
    StateLemma( active_lemma.description, active_lemma.func, cat, active_lemma.input_types, active_lemma.preconditions );
    
end );

InstallMethod( AssertProposition,
               [ ],
               
  function ( )
    local cat, claim_string;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION = fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "no active proposition, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA <> fail then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "there still is an active unproven lemma, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    if CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.active_lemma_index <> Length( CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.lemmata ) then
        
        # COVERAGE_IGNORE_BLOCK_START
        Error( "not all lemmata proven, you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    cat := CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.category;
    claim_string := CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION.claim_string;
    
    CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION := fail;
    
    Print( "\n\nSumming up, we have shown:\n" );
    Print( claim_string, " ∎\n" );
    
end );
