# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CATEGORIES_LOGIC_FILES,
              
  rec(
      
      Propositions := rec(
          #= comment for Julia
          IsCapCategory := [
                       Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                         Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                            Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForAbCategories.tex" )
                          ],
          IsAdditiveCategory := [
                                  Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                    Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                  Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForAbelianCategories.tex" )
                               ],
          # =#
        ),
      Predicates := rec(
          #= comment for Julia
          IsCapCategory := [
                       # For performance reasons, these implications are hardcoded below.
                       #Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                         Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                            Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForAbCategories.tex" )
                          ],
          IsAdditiveCategory := [
                                  Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                    Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                 Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForAbelianCategories.tex" )
                               ],
          # =#
        ),
      EvalRules := rec(
          #= comment for Julia
          IsCapCategory := [
                      Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                        Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                           Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForAbCategories.tex" )
                          ],
          IsAdditiveCategory := [
                                Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                   Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForAbelianCategories.tex" )
                               ],
          # =#
        ),
     ) );

#= comment for Julia
InstallTrueMethod( IsTerminal, IsZeroForObjects and IsCapCategoryObject );
InstallTrueMethod( IsInitial, IsZeroForObjects and IsCapCategoryObject );
InstallTrueMethod( IsInjective, IsZeroForObjects and IsCapCategoryObject );
InstallTrueMethod( IsProjective, IsZeroForObjects and IsCapCategoryObject );

InstallTrueMethod( IsSplitMonomorphism, IsIsomorphism and IsCapCategoryMorphism );
InstallTrueMethod( IsSplitEpimorphism, IsIsomorphism and IsCapCategoryMorphism );

InstallTrueMethod( IsAutomorphism, IsOne and IsCapCategoryMorphism );

InstallTrueMethod( IsIsomorphism, IsAutomorphism and IsCapCategoryMorphism );
InstallTrueMethod( IsEndomorphism, IsAutomorphism and IsCapCategoryMorphism );
InstallTrueMethod( IsAutomorphism, IsEndomorphism and IsIsomorphism and IsCapCategoryMorphism );

InstallTrueMethod( IsMonomorphism, IsSplitMonomorphism and IsCapCategoryMorphism );
InstallTrueMethod( IsEpimorphism, IsSplitEpimorphism and IsCapCategoryMorphism );
# =#

InstallGlobalFunction( SetCapLogicInfo,
  
  function( arg )
    local level;
    
    if Length( arg ) = 0 then
        level := 1;
    else
        level := arg[ 1 ];
    fi;
    
    SetInfoLevel( CapLogicInfo, level );
    
end );

###################################
##
## Logic part 1: theorems
##
###################################


InstallGlobalFunction( AddTheoremFileToCategory,
                       
  function( category, filename )
    local theorem_list, i;
    
    theorem_list := READ_THEOREM_FILE( filename );
    
    for i in theorem_list do
        
        ADD_THEOREM_TO_CATEGORY( category, i );
        
    od;
    
end );

InstallGlobalFunction( ADD_THEOREM_TO_CATEGORY,
                       
  function( category, implication_record )
    local theorem_record, name;
    
    theorem_record := TheoremRecord( category );
    
    name := implication_record.Function;
    
    if not IsBound( theorem_record.( name ) ) then
        
        theorem_record.( name ) := [ ];
        
    fi;
    
    Add( theorem_record.( name ), implication_record );
    
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
                       
  function( method_name, arguments, result_object, category )
    local current_argument, crisp_category, deductive_category, theorem_list,
          current_theorem, todo_list_source, range, is_valid_theorem, sanitized_source,
          entry, current_source, sanitized_source_list, current_argument_type, i;
    
    
    if not IsBound( TheoremRecord( category ).( method_name ) ) then
        
        return;
        
    fi;
    
    Info( CapLogicInfo, 1, Concatenation( "Creating todo list for operation ", method_name ) );
    
    theorem_list := TheoremRecord( category ).( method_name );
    
    Info( CapLogicInfo, 1, Concatenation( "Trying to create ", String( Length( theorem_list ) ), " theorems" ) );
    
    for current_theorem in theorem_list do
        
        ## check wether argument list matches here
        current_argument_type := current_theorem!.Variable_list;
        
        if Length( current_argument_type ) <> Length( arguments ) then
            
            Error( "while installing todo for logical theorems: got ", Length( arguments ), " arguments but expected ", Length( current_argument_type ) );
            
        fi;
        
        is_valid_theorem := true;
        
        for i in [ 1 .. Length( current_argument_type ) ] do
            
            if current_argument_type[ i ] = 0 then
                continue;
            fi;
            
            if not IsList( arguments[ i ] ) or not Length( arguments[ i ] ) = current_argument_type[ i ] then
                
                is_valid_theorem := false;
                
                break;
                
            fi;
            
        od;
        
        if not is_valid_theorem then
            continue;
        fi;
        
        todo_list_source := [ ];
        
        is_valid_theorem := true;
        
        for current_source in current_theorem.Source do
            
            sanitized_source_list := SANITIZE_RECORD( current_source, arguments, result_object );
            
            if IsBound( current_source!.Type ) and LowercaseString( current_source!.Type ) = "testdirect" then
                
                for sanitized_source in sanitized_source_list do
                    
                    if ( Length( sanitized_source ) = 3 and not sanitized_source[ 2 ]( sanitized_source[ 1 ] ) = sanitized_source[ 3 ] ) or
                       ( Length( sanitized_source ) = 4 and not sanitized_source[ 4 ]( sanitized_source[ 2 ]( sanitized_source[ 1 ] ), sanitized_source[ 3 ] ) ) then
                        
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
            
            Info( CapLogicInfo, 1, "Failed" );
            
            continue;
            
        fi;
        
        Info( CapLogicInfo, 1, "Success" );
        
        range := SANITIZE_RECORD( current_theorem!.Range, arguments, result_object );
        
        ## NO ALL ALLOWED HERE!
        range := range[ 1 ];
        
        if Length( todo_list_source ) = 0 then
            
            Setter( range[ 2 ] )( range[ 1 ], range[ 3 ] );
            
            continue;
            
        fi;
        
        entry := ToDoListEntry( todo_list_source, range[ 1 ], NameFunction( range[ 2 ] ), range[ 3 ] );
        
        SetDescriptionOfImplication( entry, Concatenation( "Implication from ", method_name ) );
        
        AddToToDoList( entry );
        
    od;
    
end );

##############################
##
## Logic part 2: predicates
##
##############################

InstallGlobalFunction( AddPredicateImplicationFileToCategory,
                       
  function( category, filename )
    local theorem_list, i;
    
    theorem_list := READ_PREDICATE_IMPLICATION_FILE( filename );
    
    SuspendMethodReordering( );
    
    for i in theorem_list do
        
        ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY( category, i );
        
    od;
    
    ResumeMethodReordering( );
    
end );

##
InstallGlobalFunction( ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY,
                       
  function( category, immediate_record )
    
    INSTALL_PREDICATE_IMPLICATION( category, immediate_record );
    
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
        
        Error( "unknown cell type" );
        
    fi;
    
    InstallTrueMethod( immediate_record!.Range and cell_filter, immediate_record!.Source and cell_filter );
    
end );

###############################
##
## Part 3: Eval rule API
##
###############################

##
InstallGlobalFunction( AddEvalRuleFileToCategory,
                       
  function( category, filename )
    local theorem_list, i;
    
    Add( category!.logical_implication_files.EvalRules.IsCapCategory, filename );
    
    if IsBound( category!.logical_implication_files.EvalRules.general_rules_already_read ) and
       category!.logical_implication_files.EvalRules.general_rules_already_read = true then
        
        theorem_list := READ_EVAL_RULE_FILE( filename );
        
        for i in theorem_list do
            
            ADD_EVAL_RULES_TO_CATEGORY( category, i );
            
        od;
        
    fi;
    
end );

##
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

###############################
##
## Technical functions
##
###############################

InstallGlobalFunction( INSTALL_LOGICAL_IMPLICATIONS_HELPER,
                       
  function( category, current_filter )
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
            
            ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY( category, current_theorem );
            
        od;
        
    od;
    
end );
