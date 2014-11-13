#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

## RETHINK THIS WHOLE STRUCTURE

########################################
##
## Global logic files
##
########################################

InstallValue( CATEGORIES_LOGIC_FILES,
              
  rec(
      
      Propositions := rec(
          General := [
                       Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [ ],
          IsAbCategory := [ ],
          IsPreAdditiveCategory := [ ],
          IsAdditiveCategory := [ ],
          IsPreAbelianCategory := [ ],
          IsAbelianCategory := [ ] ),
      Predicates := rec(
          General := [
                       Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForGeneralCategories.tex" )
          ],
          IsEnrichedOverCommutativeRegularSemigroup := [ ],
          IsAbCategory := [ ],
          IsPreAdditiveCategory := [ ],
          IsAdditiveCategory := [ ],
          IsPreAbelianCategory := [ ],
          IsAbelianCategory := [ ] ),
      EvalRules := rec(
          General := [ 
                     Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForGeneralCategories.tex" )
          ],
          IsEnrichedOverCommutativeRegularSemigroup := [ ],
          IsAbCategory := [ ],
          IsPreAdditiveCategory := [ ],
          IsAdditiveCategory := [ ],
          IsPreAbelianCategory := [ ],
          IsAbelianCategory := [ ] )
     ) );

InstallGlobalFunction( AddTheoremFileToCategory,
                       
  function( category, filename )
    local theorem_list, i;
    
    Add( category!.logical_implication_files.Propositions.General, filename );
    
    if not HasDeductiveSystem( category ) then
        
        return;
        
    fi;
    
    theorem_list := READ_THEOREM_FILE( filename );
    
    for i in theorem_list do
        
        ADD_THEOREM_TO_CATEGORY( category, i );
        
    od;
    
end );

InstallGlobalFunction( AddPredicateImplicationFileToCategory,
                       
  function( category, filename )
    local theorem_list, i;
    
    Add( category!.logical_implication_files.Predicates.General, filename );
    
    if not HasDeductiveSystem( category ) then
        
        return;
        
    fi;
    
    theorem_list := READ_PREDICATE_IMPLICATION_FILE( filename );
    
    for i in theorem_list do
        
        ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY( category, DeductiveSystem( category ), i );
        
    od;
    
end );

InstallGlobalFunction( AddEvalRuleFileToCategory,
                       
  function( category, filename )
    local theorem_list, i;
    
    Add( category!.logical_implication_files.Predicates.General, filename );
    
    if not HasDeductiveSystem( category ) then
        
        return;
        
    fi;
    
    theorem_list := READ_EVAL_RULE_FILE( filename );
    
    for i in theorem_list do
        
        ADD_EVAL_RULES_TO_CATEGORY( category, i );
        
    od;
    
end );

InstallGlobalFunction( INSTALL_LOGICAL_IMPLICATIONS_HELPER,
                       
  function( category, deductive_category, current_filter )
    local i, theorem_list, current_theorem;
    
    for i in category!.logical_implication_files.Propositions.( current_filter ) do
        
        theorem_list := READ_THEOREM_FILE( i );
        
        for current_theorem in theorem_list do
            
            ADD_THEOREM_TO_CATEGORY( category, current_theorem );
            
        od;
        
    od;
    
    for i in category!.logical_implication_files.Predicates.( current_filter ) do
        
        theorem_list := READ_PREDICATE_IMPLICATION_FILE( i );
        
        for current_theorem in theorem_list do
            
            ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY( category, deductive_category, current_theorem );
            
        od;
        
    od;
    
        for i in category!.logical_implication_files.EvalRules.( current_filter ) do
            
            theorem_list := READ_EVAL_RULE_FILE( i );
            
            for current_theorem in theorem_list do
                
                ADD_EVAL_RULES_TO_CATEGORY( category, current_theorem );
                
            od;
            
        od;
    
end );


BindGlobal( "INSTALL_LOGICAL_IMPLICATIONS_IMMEDIATE_PART",
            
  function( )
    local current_filter;
    
    for current_filter in [ "IsEnrichedOverCommutativeRegularSemigroup",
                            "IsAbCategory",
                            "IsPreAdditiveCategory",
                            "IsAdditiveCategory",
                            "IsPreAbelianCategory",
                            "IsAbelianCategory" ] do
                            
        InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                                IsHomalgCategory and HasDeductiveSystem and ValueGlobal( current_filter ),
                                0,
                                
          function( category )
            
            INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), current_filter );
            
            TryNextMethod( );
            
        end );
    
    od;
    
end );

INSTALL_LOGICAL_IMPLICATIONS_IMMEDIATE_PART( );

###################################
##
## Theorem part
##
###################################

InstallGlobalFunction( ADD_THEOREM_TO_CATEGORY,
                       
  function( category, implication_record )
    local theorem_record, name;
    
    theorem_record := TheoremRecord( category );
    
    name := implication_record.Function;
    
    if not IsBound( theorem_record.( name ) ) then
        
        theorem_record.( name ) := [ implication_record ];
        
    else
        
        Add( theorem_record.( name ), implication_record );
        
    fi;
    
end );

InstallGlobalFunction( SANITIZE_RECORD,
                       
  function( record, arguments, result_object )
    local object, index_list, i, value_function, value;
    
    if not IsBound( record!.Object ) then
        
        object := "result";
        
    else
        
        object := record!.Object;
        
    fi;
    
    if IsString( object ) and LowercaseString( object ) = "result" then
        
        object := [ result_object ];
        
    elif IsString( object ) and LowercaseString( object ) = "all" then
        
        object := arguments;
        
    elif IsInt( object ) then
        
        object := [ arguments[ object ] ];
        
    elif IsList( object ) then
        
        index_list := object;
        
        object := [ arguments ];
        
        for i in index_list do
            
            if IsInt( i ) then
                
                object := List( object, j -> j[ i ] );
                
            elif IsString( i ) and LowercaseString( i ) = "all" then
                
                object := Concatenation( object );
                
            else
                
                Error( "wrong object format: only int and all" );
                
            fi;
            
        od;
        
    else
        
        Error( "wrong object type" );
        
    fi;
    
    if IsBound( record!.ValueFunction ) then
        
        value_function := record!.ValueFunction;
        
    else
        
        value_function := IdFunc;
        
    fi;
    
    if IsBound( record!.Value ) then
        
        value := record!.Value;
        
    else
        
        value := true;
        
    fi;
    
    if not IsBound( record!.compare_function ) then
        
        return List( object, i -> [ i, value_function, value ] );
        
    else
        
        return List( object, i -> [ i, value_function, value, record!.compare_function ] );
        
    fi;
    
end );

InstallGlobalFunction( INSTALL_TODO_FOR_LOGICAL_THEOREMS,
                       
  function( arg )
    local method_name, arguments, result_object,
          current_argument, crisp_category, deductive_category, theorem_list,
          current_theorem, todo_list_source, range, is_valid_theorem, sanitized_source,
          entry, current_source, sanitized_source_list;
    
    method_name := arg[ 1 ];
    
    arguments := arg[ 2 ];
    
    result_object := arg[ 3 ];
    
    if Length( arg ) = 4 then
        
        deductive_category := arg[ 4 ];
        
        crisp_category := UnderlyingHonestCategory( arg[ 4 ] );
        
    else
        
        current_argument := arguments[ 1 ];
        
        if IsHomalgCategory( current_argument ) then
           
            crisp_category := current_argument;
            
            deductive_category := DeductiveSystem( crisp_category );
            
        elif IsHomalgCategoryCell( current_argument ) then
            
            deductive_category := HomalgCategory( current_argument );
            
            crisp_category := UnderlyingHonestCategory( deductive_category );
            
        elif IsList( current_argument ) then
            
            deductive_category := HomalgCategory( current_argument[ 1 ] );
            
            crisp_category := UnderlyingHonestCategory( deductive_category );
            
        else
            
            Error( "Cannot figure out which category to use here" );
            
        fi;
        
    fi;
    
    if not IsBound( TheoremRecord( crisp_category).( method_name ) ) then
        
        return;
        
    fi;
    
    theorem_list := TheoremRecord( crisp_category ).( method_name );
    
    for current_theorem in theorem_list do
        
        todo_list_source := [ ];
        
        is_valid_theorem := true;
        
        for current_source in current_theorem.Source do
            
            sanitized_source_list := SANITIZE_RECORD( current_source, arguments, result_object );
            
            if IsBound( current_source!.Type ) and LowercaseString( current_source!.Type ) = "testdirect" then
                
                for sanitized_source in sanitized_source_list do
                    
                    if ( Length( sanitized_source ) = 3 and not sanitized_source[ 2 ]( sanitized_source[ 1 ] ) = sanitized_source[ 3 ] )
                       or ( Length( sanitized_source ) = 4 and not sanitized_source[ 4 ]( sanitized_source[ 2 ]( sanitized_source[ 1 ] ), sanitized_source[ 3 ] ) ) then
                        
                        is_valid_theorem := false;
                        
                        break;
                          
                    fi;
                  
                od;
                
            else
                
                for sanitized_source in sanitized_source_list do
                    
                    sanitized_source[ 2 ] := NameFunction( sanitized_source[ 2 ] );
                    
                    Add( todo_list_source, sanitized_source );
                    
                od;
                
            fi;
            
        od;
        
        if is_valid_theorem = false then
            
            continue;
            
        fi;
        
        range := SANITIZE_RECORD( current_theorem!.Range, arguments, result_object );
        
        ## NO ALL ALLOWED HERE!
        range := range[ 1 ];
        
        if Length( todo_list_source ) = 0 then
            
            Setter( range[ 2 ] )( range[ 1 ], range[ 3 ] );
            
            continue;
            
        fi;
        
        entry := ToDoListEntry( todo_list_source, range[ 1 ], NameFunction( range[ 2 ] ), range[ 3 ] );
        
        AddToToDoList( entry );
        
    od;
    
end );

###################################
##
## Predicate part
##
###################################

##
InstallGlobalFunction( ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY,
                       
  function( category, deductive_category, immediate_record )
    
    INSTALL_PREDICATE_IMPLICATION( deductive_category, immediate_record );
    
    if not IsBound( category!.predicate_implication ) then
        
        category!.predicate_implication := [ ];
        
    fi;
    
    Add( category!.predicate_implication, immediate_record );
    
end );

##
InstallGlobalFunction( INSTALL_PREDICATE_IMPLICATION,
                       
  function( category, immediate_record )
    local cell_filter;
    
    if LowercaseString( immediate_record!.CellType ) = "obj" then
        
        cell_filter := ObjectFilter( category );
        
    elif LowercaseString( immediate_record!.CellType ) = "mor" then
        
        cell_filter := MorphismFilter( category );
        
    else
        
        cell_filter := TwoCellFilter( category );
        
    fi;
    
    InstallTrueMethod( immediate_record!.Range and cell_filter, immediate_record!.Source and cell_filter );
    
end );

###################################
##
## Predicate part
##
###################################

##
BindGlobal( "GET_CORRECT_SUBTREE_ENTRY",
            
  function( tree, subtree_index_list )
    local i;
    
    for i in subtree_index_list do
        
        if IsList( tree ) and IsString( tree[ 1 ] ) then
            
            tree := tree[ 2 ];
            
        fi;
        
        if not IsList( tree ) or Length( tree ) < i then
            
            return fail;
            
        fi;
        
        tree := tree[ i ];
        
    od;
    
    return tree;
    
end );

##
InstallGlobalFunction( IS_EQUAL_FOR_SUBTREES_RECURSIVE,
            
  function( subtree1, subtree2 )
    local i;
    
    if not IsList( subtree1 ) and not IsList( subtree1 ) then
        
        return IsIdenticalObj( subtree1, subtree2 );
        
    fi;
    
    if IsString( subtree1 ) and IsString( subtree2 ) then
        
        return subtree1 = subtree2;
        
    fi;
    
    if IsList( subtree1 ) and IsList( subtree2 ) then
        
        return ForAll( [ 1 .. Length( subtree1 ) ], i -> IS_EQUAL_FOR_SUBTREES_RECURSIVE( subtree1[ i ], subtree2[ i ] ) );
        
    fi;
    
    return false;
    
end );

##
BindGlobal( "IS_EQUAL_FOR_SUBTREES",
            
  function( subtree_list )
    local first_subtree, i;
    
    if Length( subtree_list ) < 2 then
        
        return true;
        
    fi;
    
    first_subtree := subtree_list[ 1 ];
    
    for i in [ 2 .. Length( subtree_list ) ] do
        
        if IS_EQUAL_FOR_SUBTREES_RECURSIVE( first_subtree, subtree_list[ i ] ) = false then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end );

##
InstallGlobalFunction( FIX_WELL_DEFINED_PART,
            
  function( well_defined_part, history )
    local current_well_defined_part;
    
    if IsString( well_defined_part ) then
        
        return well_defined_part;
        
    fi;
    
    if IsList( well_defined_part ) and ForAll( well_defined_part, IsInt ) then
        
        return GET_CORRECT_SUBTREE_ENTRY( history, well_defined_part );
        
    fi;
    
    if IsList( well_defined_part ) then
        
        return List( well_defined_part, i -> FIX_WELL_DEFINED_PART( i, history ) );
        
    fi;
    
    return well_defined_part;
    
end );
    

##
InstallGlobalFunction( APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE,
                       
  function( history, rules )
    local return_rec, command, current_rules, rule_to_apply, command_to_check,
          command_from_history, to_be_applied, rule_applied, object_to_check, resolved_objects, i,
          replaced_history, part_for_well_defined, new_return, arguments;
    
    if not IsList( history ) then
        
        return fail;
        
    fi;
    
    if not IsString( history[ 1 ] ) then
        
        return fail;
        
    fi;

    return_rec := rec( );
    
    command := history[ 1 ];
    
    if not IsBound( rules.( command ) ) then
        
        return fail;
        
    fi;
    
    current_rules := rules.( command );
    
    rule_applied := false;
    
    for rule_to_apply in current_rules do
        
        ## Check string part
        to_be_applied := true;
        
        for command_to_check in rule_to_apply!.commands_to_check do
            
            command_from_history := GET_CORRECT_SUBTREE_ENTRY( history, command_to_check[ 1 ] );
            
            if not IsList( command_from_history ) then
                
                to_be_applied := false;
                
                break;
                
            fi;
            
            command_from_history := command_from_history[ 1 ];
            
            if not command_from_history = command_to_check[ 2 ] then
                
                to_be_applied := false;
                
                break;
                
            fi;
            
        od;
        
        if to_be_applied = false then
            
            continue;
            
        fi;
        
        ## Check equality of objects
        
        to_be_applied := true;
        
        for object_to_check in rule_to_apply.cells_to_check do
            
            resolved_objects := [ ];
            
            Add( resolved_objects, GET_CORRECT_SUBTREE_ENTRY( history, object_to_check[ 1 ] ) );
            
            if IsString( object_to_check[ 2 ] ) then
                
                if not IsHomalgCategoryCell( resolved_objects[ 1 ] ) then
                    
                    to_be_applied := false;
                    
                    break;
                    
                fi;
                
                object_to_check[ 2 ] := ValueGlobal( object_to_check[ 2 ] );
                
                if Tester( object_to_check[ 2 ] )( object_to_check[ 1 ] ) or EvalCanComputePredicates( HomalgCategory( object_to_check[ 1 ] ) ) then
                    
                    if not object_to_check[ 2 ]( object_to_check[ 1 ] ) then
                        
                        to_be_applied := false;
                        
                        break;
                        
                    fi;
                    
                fi;
                
            elif IsInt( object_to_check[ 2 ] ) then
                
                if not resolved_objects[ 1 ] = object_to_check[ 2 ] then
                    
                    to_be_applied := false;
                    
                    break;
                    
                fi;
                
            else
                
                Add( resolved_objects, GET_CORRECT_SUBTREE_ENTRY( history, object_to_check[ 2 ] ) );
                
                if ForAny( resolved_objects, i -> i = fail ) then
                    
                    to_be_applied := false;
                    
                    break;
                    
                fi;
                
                resolved_objects := IS_EQUAL_FOR_SUBTREES( resolved_objects );
                
                if resolved_objects = false then
                    
                    to_be_applied := false;
                    
                    break;
                    
                fi;
              
            fi;
            
        od;
        
        if to_be_applied = false then
            
            continue;
            
        fi;
        
        replaced_history := FIX_WELL_DEFINED_PART( rule_to_apply!.part_to_replace, history );
        
        if IsList( replaced_history ) and Length( replaced_history ) = 1 then
            
            replaced_history := replaced_history[ 1 ];
            
        fi;
        
        part_for_well_defined := rule_to_apply!.part_for_is_well_defined;
        
        rule_applied := true;
        
        break;
        
    od;
    
    if rule_applied = false then
        
        for arguments in [ 1 .. Length( history[ 2 ] ) ] do
            
            new_return := APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE( history[ 2 ][ arguments ], rules );
            
            if new_return <> fail then
                
                history := StructuralCopy( history );
                
                history[ 2 ][ arguments ] := new_return!.new_history;
                
                part_for_well_defined := new_return!.part_for_is_well_defined;
                
                new_return := APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE( history, rules );
                
                if new_return = fail then
                    
                    return rec( new_history := history, part_for_is_well_defined := part_for_well_defined );
                    
                else
                    
                    return rec( new_history := new_return!.new_history, part_for_is_well_defined := Concatenation( part_for_well_defined, new_return!.part_for_is_well_defined ) );
                    
                fi;
                
            fi;
            
        od;
        
        return fail;
        
    fi;
    
    part_for_well_defined := List( rule_to_apply!.part_for_is_well_defined, i -> FIX_WELL_DEFINED_PART( i, history ) );
    
    new_return := APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE( replaced_history, rules );
    
    if new_return = fail then
        
        return rec( new_history := replaced_history, part_for_is_well_defined := part_for_well_defined );
        
    fi;
    
    new_return!.part_for_is_well_defined := Concatenation( new_return!.part_for_is_well_defined, part_for_well_defined );
    
    return new_return;
    
end );

InstallGlobalFunction( ADD_EVAL_RULES_TO_CATEGORY,
                       
  function( category, rule_record )
    local command;
    
    if not IsBound( rule_record!.command ) then
        
        return;
        
    fi;
    
    command := rule_record!.command;
    
    if not IsBound( category!.eval_rules ) then
        
        category!.eval_rules := rec( );
        
    fi;
    
    if not IsBound( category!.eval_rules.( command ) ) then
        
        category!.eval_rules.( command ) := [ ];
        
    fi;
    
    Add( category!.eval_rules.( command ), rule_record );
    
end );

