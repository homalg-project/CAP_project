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
        
        text := Concatenation( text, "We have\n" );
        
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
            
            if filter = "object" then
                
                part := Concatenation( numeral, " object", plural, " ", ConcatenationOfStringsAsEnumerationWithAnd( names{positions} ) );
                
                part := ReplacedString( part, "a object ", "an object " );
            
            elif filter = "morphism" then
                
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
                
                part := Concatenation( numeral, " morphism", plural, " ", ConcatenationOfStringsAsEnumerationWithAnd( morphisms ) );
                
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
    Display( func );
    
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
    Display( func );
    
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
        
        Print( "With this, the claim follows.\n" );
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
        
        Error( "function is not reduced to `{...} -> true`, not clearing lemma; you can 'return;' to bail out" );
        return;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
end );
