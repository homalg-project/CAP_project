# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

InstallValue( CAP_PREPARE_FUNCTION_RECORD, rec( ) );

InstallGlobalFunction( CAPOperationPrepareFunction,
  function( prepare_function, category, func )
    local current_prepare_function, prepare_function_symbol_list, current_operation;
    
    if not IsString( prepare_function ) then
        Error( "first argument must be a string" );
        return;
    fi;
    
    if not IsCapCategory( category ) then
        Error( "second argument must be a category" );
        return;
    fi;
    
    if not IsFunction( func ) then
        Error( "third argument must be a function" );
        return;
    fi;
    
    if not IsBound( CAP_PREPARE_FUNCTION_RECORD.( prepare_function ) ) then
        Error( "No compatible prepare function found, see ListCAPPrepareFunctions(); for a list of prepare functions" );
        return;
    fi;
    
    current_prepare_function := CAP_PREPARE_FUNCTION_RECORD.( prepare_function );
    prepare_function_symbol_list := current_prepare_function[ 3 ];
    current_prepare_function := current_prepare_function[ 1 ];
    
    for current_operation in prepare_function_symbol_list do
        if not CanCompute( category, current_operation ) then
            Print( "Warning: Operation ", current_operation, " is not installed for category ", Name( category ), "\n",
                   "         but is needed for another categorical operation\n" );
        fi;
    od;
    
    return current_prepare_function( func, category );
    
end );

InstallGlobalFunction( CAPAddPrepareFunction,
  function( prepare_function, name, doc_string, arg... )
    local precondition_list, operation_names, used_symbol_list, current_precondition;
    
    #= comment for Julia
    if Length( arg ) = 1 then
        precondition_list := arg[ 1 ];
    else
        precondition_list := [ ];
    fi;
    
    if not IsList( precondition_list ) then
        Error( "optional fourth argument must be a list" );
        return;
    fi;
    
    operation_names := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    for current_precondition in precondition_list do
        if not current_precondition in operation_names then
            Error( Concatenation( "Precondition ", current_precondition, " not in list of known category functions" ) );
        fi;
    od;
    
    used_symbol_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( prepare_function, operation_names, 1, rec( ), rec( ) );
    used_symbol_list := List( used_symbol_list, i -> i[ 1 ] );
    used_symbol_list := Concatenation( used_symbol_list, precondition_list );
    used_symbol_list := DuplicateFreeList( used_symbol_list );
    
    CAP_PREPARE_FUNCTION_RECORD.(name) := [ prepare_function, doc_string, used_symbol_list ];
    # =#
    
end );

InstallGlobalFunction( ListCAPPrepareFunctions,
  function( )
    local rec_names, current_entry, current_rec_name, current_precondition;
    
    rec_names := RecNames( CAP_PREPARE_FUNCTION_RECORD );
    
    for current_rec_name in rec_names do
        current_entry := CAP_PREPARE_FUNCTION_RECORD.(current_rec_name);
        Print( "Prepare function: ", current_rec_name, "\n" );
        Print( "  ", current_entry[ 2 ],"\n" );
        if Length( current_entry[ 3 ] ) > 0 then
            Print( "\nNeeds:\n" );
            for current_precondition in current_entry[ 3 ] do
                Print( "* ", current_precondition, "\n" );
            od;
        fi;
        Print( "\n" );
    od;
end );
