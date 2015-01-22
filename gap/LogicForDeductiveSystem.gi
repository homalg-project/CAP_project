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
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                         Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                            Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForAbCategories.tex" )
                          ],
          IsPreAdditiveCategory := [
                                     Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForPreadditiveCategories.tex" )
                                   ],
          IsAdditiveCategory := [
                                  Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                    Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
#                                  Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PropositionsForAbelianCategories.tex" )
                               ] ),
      Predicates := rec(
          General := [
                       Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                         Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                            Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForAbCategories.tex" )
                          ],
          IsPreAdditiveCategory := [
                                     Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForPreadditiveCategories.tex" )
                                   ],
          IsAdditiveCategory := [
                                  Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                    Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                 Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "PredicateImplicationsForAbelianCategories.tex" )
                               ] ),
      EvalRules := rec(
          General := [
                      Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                        Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                           Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForAbCategories.tex" )
                          ],
          IsPreAdditiveCategory := [
                                   Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForPreadditiveCategories.tex" )
                                   ],
          IsAdditiveCategory := [
                                Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                   Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                Filename( DirectoriesPackageLibrary( "CategoriesForHomalg", "LogicForCategories" ), "RelationsForAbelianCategories.tex" )
                               ] ),
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

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                        IsCapCategory and HasDeductiveSystem and IsEnrichedOverCommutativeRegularSemigroup,
                        0,
                        
  function( category )
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), "IsEnrichedOverCommutativeRegularSemigroup" );
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                        IsCapCategory and HasDeductiveSystem and IsPreAdditiveCategory,
                        0,
                        
  function( category )
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), "IsPreAdditiveCategory" );
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                        IsCapCategory and HasDeductiveSystem and IsAdditiveCategory,
                        0,
                        
  function( category )
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), "IsAdditiveCategory" );
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                        IsCapCategory and HasDeductiveSystem and IsPreAbelianCategory,
                        0,
                        
  function( category )
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), "IsPreAbelianCategory" );
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                        IsCapCategory and HasDeductiveSystem and IsAbelianCategory,
                        0,
                        
  function( category )
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), "IsAbelianCategory" );
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS,
                        IsCapCategory and HasDeductiveSystem and IsAbCategory,
                        0,
                        
  function( category )
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, DeductiveSystem( category ), "IsAbCategory" );
    
    TryNextMethod( );
    
end );

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
        
        if IsCapCategory( current_argument ) then
           
            crisp_category := current_argument;
            
            deductive_category := DeductiveSystem( crisp_category );
            
        elif IsCapCategoryCell( current_argument ) then
            
            deductive_category := CapCategory( current_argument );
            
            crisp_category := UnderlyingHonestCategory( deductive_category );
            
        elif IsList( current_argument ) then
            
            deductive_category := CapCategory( current_argument[ 1 ] );
            
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
        
        if IsRecord( tree ) then
            
            tree := tree!.arguments[ i ];
            
        elif IsList( tree ) then
            
            tree := tree[ i ];
            
        else
            
            return fail;
            
        fi;
        
    od;
    
    return tree;
    
end );

##
InstallGlobalFunction( IS_EQUAL_FOR_SUBTREES_RECURSIVE,
            
  function( subtree1, subtree2 )
    local i;
    
    if IsRecord( subtree1 ) and IsRecord( subtree2 ) then
        
        return subtree1!.command = subtree2!.command and IS_EQUAL_FOR_SUBTREES_RECURSIVE( subtree1!.arguments, subtree2!.arguments );
        
    elif IsList( subtree1 ) and IsList( subtree2 ) then
        
        if not Length( subtree1 ) = Length( subtree2 ) then
            
            return false;
            
        fi;
        
        return ForAll( [ 1 .. Length( subtree1 ) ], i -> IS_EQUAL_FOR_SUBTREES_RECURSIVE( subtree1[ i ], subtree2[ i ] ) );
        
    else
        
        return IsIdenticalObj( subtree1, subtree2 );
    
    fi;
    
    return false;
    
end );

##
BindGlobal( "IS_EQUAL_FOR_SUBTREES",
            
  function( arg )
    local first_subtree, i;
    
    if Length( arg ) < 2 then
        
        return true;
        
    fi;
    
    first_subtree := arg[ 1 ];
    
    for i in [ 2 .. Length( arg ) ] do
        
        if IS_EQUAL_FOR_SUBTREES_RECURSIVE( first_subtree, arg[ i ] ) = false then
            
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
InstallGlobalFunction( CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE,
                       
  function( history, command_tree )
    local object_history;
    
    if command_tree = SuPeRfail then
        
        return true;
        
    fi;
    
    if IsCapCategoryCell( history ) then
        
        history := History( history );
        
        if not IsRecord( history ) then
            
            return false;
            
        else
            
            return CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE( history, command_tree );
            
        fi;
        
    fi;
    
    if IsList( history ) and IsList( command_tree ) then
        
        if Length( history ) = Length( command_tree ) then
            
            return ForAll( [ 1 .. Length( history ) ], i -> CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE( history[ i ], command_tree[ i ] ) );
            
        fi;
        
    fi;
    
    if IsRecord( history ) and IsRecord( command_tree ) then
        
        return history!.command = command_tree!.command and CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE( history!.arguments, command_tree!.arguments );
        
    fi;
    
    return false;
    
end );

BindGlobal( "GET_FULL_POSITION",
            
  function( position, variable_name_record )
    local new_position, i;
    
    new_position := ShallowCopy( position );
    
    for i in [ 1 .. Length( new_position ) ] do
        
        if IsString( new_position[ i ] ) then
            
            new_position[ i ] := variable_name_record.( new_position[ i ] );
            
        fi;
        
    od;
    
    return new_position;
    
end );

BindGlobal( "GET_VARIABLE_FROM_POSITION",
            
  function( history, position )
    local variable, i;
    
    variable := history;
    
    for i in position do
        
        if IsCapCategoryCell( variable ) then
            
            variable := History( variable );
            
        fi;
        
        if IsRecord( variable ) then
            
            variable := variable!.arguments[ i ];
            
            continue;
            
        elif IsList( variable ) then
            
            variable := variable[ i ];
            
            continue;
            
        fi;
        
    od;
    
    return variable;
    
end );

##
BindGlobal( "FILL_VARIABLE_NAME_RECORD",
            
  function( history, variable_name_record )
    local filled_variable_record, name, current_position, current_variable, i;
    
    filled_variable_record := StructuralCopy( variable_name_record );
    
    for name in RecNames( filled_variable_record ) do
        
        current_position := filled_variable_record.( name );
        
        current_variable := GET_VARIABLE_FROM_POSITION( history, current_position );
        
        filled_variable_record.( name ) := current_variable;
        
    od;
    
    return filled_variable_record;
    
end );

##
BindGlobal( "CHECK_VARIABLE_PAIRS",
            
  function( history, variable_name_pairs, variable_name_record )
    local current_list, position_index, current_first_object, current_object;
    
    for current_list in variable_name_pairs do
        
        if Length( current_list ) < 2 then
            
            continue;
            
        fi;
        
        current_first_object := current_list[ 1 ];
        
        current_first_object := GET_VARIABLE_FROM_POSITION( history, GET_FULL_POSITION( current_first_object, variable_name_record ) );
        
        for position_index in [ 2 .. Length( current_list ) ] do
            
            current_object := GET_VARIABLE_FROM_POSITION( history, GET_FULL_POSITION( current_list[ position_index ], variable_name_record ) );
            
            if not current_object = current_first_object then
                
                return false;
                
            fi;
            
        od;
        
    od;
    
    return true;
    
end );

BindGlobal( "GET_VARIABLE_BY_NAME",
            
  function( name, variable_name_record )
    local name_and_index, variable;
    
    if IS_LIST_WITH_INDEX( name ) then
        
        name_and_index := SPLIT_INTO_LIST_NAME_AND_INDEX( name );
        
        variable := variable_name_record.( name_and_index[ 1 ] );
        
        if STRING_REPRESENTS_INTEGER( name_and_index[ 2 ] ) then
            
            variable := variable[ Int_SAVE( name_and_index[ 2 ] ) ];
            
        else
            
            variable := variable[ variable_name_record.( name_and_index[ 2 ] ) ];
            
        fi;
        
    else
        
        variable := variable_name_record.( name );
        
    fi;
    
    return variable;
    
end );

InstallGlobalFunction( SANITIZE_SOURCE_PART_WITH_EVERYTHING_GIVEN_RECURSIVE,
            
  function( source_rec, variable_name_rec )
    local new_rec, new_name;
    
    if IsRecord( source_rec ) then
        
        new_rec := rec( command := source_rec!.command );
        
        new_rec.arguments := List( source_rec.arguments, i -> SANITIZE_SOURCE_PART_WITH_EVERYTHING_GIVEN_RECURSIVE( i, variable_name_rec ) );
        
        return new_rec;
        
    elif IsInt( source_rec ) then
        
        return source_rec;
        
    elif IsString( source_rec ) then
        
        return GET_VARIABLE_BY_NAME( source_rec, variable_name_rec );
        
    fi;
    
end );

BindGlobal( "SANITIZE_SOURCE_PART",
            
  function( source_rec, history, variable_name_record )
    local new_source_rec, bound_variable_name, bound_variable_list, i, new_source_list;
    
    new_source_rec := StructuralCopy( source_rec );
    
    if source_rec!.bound_variable = fail then
        
        bound_variable_name := "xXx_my_super_crazy_dummy_variable_name_ausrufezeichen_xXx";
        
        bound_variable_list := [ 1 ];
        
    else
        
        bound_variable_name := source_rec!.bound_variable_name;
        
        if IsBound( source_rec!.bound_variable_name ) then
            
            bound_variable_list := variable_name_record.( source_rec.bound_variable_name );
            
        else
            
            bound_variable_list := source_rec.bound_variable_list_boundaries;
            
            for i in [ 1, 2 ] do
                
                if IsInt( bound_variable_list[ i ] ) then
                    
                    continue;
                    
                fi;
                
                if PositionSublist( bound_variable_list[ i ], "Length(" ) <> fail then
                    
                    bound_variable_list[ i ] := bound_variable_list[ i ]{[ PositionSublist( bound_variable_list[ i ], "Length(" ) + 7 .. Length( bound_variable_list[ i ] ) - 1 ]};
                    
                    bound_variable_list[ i ] := Length( variable_name_record.( bound_variable_list[ i ] ) );
                    
                else
                    
                    bound_variable_list[ i ] := variable_name_record.( bound_variable_list[ i ] );
                    
                fi;
                
            od;
            
            bound_variable_list := [ bound_variable_list[ 1 ] .. bound_variable_list[ 2 ] ];
            
        fi;
        
    fi;
    
    new_source_list := [ ];
    
    for i in bound_variable_list do
        
        variable_name_record.( bound_variable_name ) := i;
        
        Add( new_source_list, SANITIZE_SOURCE_PART_WITH_EVERYTHING_GIVEN_RECURSIVE( source_rec, variable_name_record ) );
        
    od;
    
    return new_source_list;
    
end );


##
InstallGlobalFunction( APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE,
                       
  function( history, rules )
    local return_rec, command, current_rules, rule_to_apply, command_to_check,
          command_from_history, to_be_applied, rule_applied, object_to_check, resolved_objects, i,
          replaced_history, part_for_well_defined, new_return, arguments, command_check, variable_name_record,
          variable_check;
    
    if IsCapCategoryCell( history ) then
        
        history := History( history );
        
        if not IsRecord( history ) then
            
            return fail;
            
        fi;
        
    fi;

    return_rec := rec( );
    
    command := history!.command;
    
    if not IsBound( rules.( command ) ) then
        
        return fail;
        
    fi;
    
    current_rules := rules.( command );
    
    rule_applied := false;
    
    for rule_to_apply in current_rules do
        
        command_check := CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE( history, rule_to_apply!.command_tree );
        
        if command_check = false then
            
            continue;
            
        fi;
        
        variable_name_record := FILL_VARIABLE_NAME_RECORD( history, rule_to_apply!.variable_record );
        
        variable_check := CHECK_VARIABLE_PAIRS( history, rule_to_apply!.equal_variable_positions, variable_name_record );
        
        if variable_check = false then
            
            continue;
            
        fi;
        
        ## if we get here, we have found a rule to apply
        
        replaced_history := GET_VARIABLE_FROM_POSITION( history, GET_FULL_POSITION( rule_to_apply!.replace, variable_name_record ) );
        
        part_for_well_defined := rule_to_apply!.source_list;
        
        part_for_well_defined := List( part_for_well_defined, i -> SANITIZE_SOURCE_PART( i, history, variable_name_record ) );
        
        part_for_well_defined := Flat( part_for_well_defined );
        
        rule_applied := true;
        
        break;
        
    od;
    
    if rule_applied = true then
        
        new_return := APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE( replaced_history, rules );
        
        if new_return = fail then
            
            return rec( new_history := replaced_history, part_for_is_well_defined := part_for_well_defined );
            
        else
            
            new_return!.part_for_is_well_defined := Concatenation( new_return!.part_for_is_well_defined, part_for_well_defined );
            
            return new_return;
            
        fi;
        
    fi;
    
    for arguments in [ 1 .. Length( history!.arguments ) ] do
        
        new_return := APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE( history!.arguments[ arguments ], rules );
        
        if new_return <> fail then
            
            history := StructuralCopy( history );
            
            history!.arguments[ arguments ] := new_return!.new_history;
            
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
    
end );

InstallGlobalFunction( ADD_EVAL_RULES_TO_CATEGORY,
                       
  function( category, rule_record )
    local command;
    
    if not IsBound( rule_record!.starting_command ) then
        
        return;
        
    fi;
    
    command := rule_record!.starting_command ;
    
    if not IsBound( category!.eval_rules ) then
        
        category!.eval_rules := rec( );
        
    fi;
    
    if not IsBound( category!.eval_rules.( command ) ) then
        
        category!.eval_rules.( command ) := [ ];
        
    fi;
    
    Add( category!.eval_rules.( command ), rule_record );
    
end );

