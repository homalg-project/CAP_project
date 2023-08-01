# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Add Functions

#! @Section Prepare functions

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

## prepare functions for (co)products

##
BindGlobal( "CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT",
  function( binary_direct_product_func, category )
    return function( cat, diagram )
      local direct_product, i;
        
        # Direct product diagrams are supposed to have at least length 1
        direct_product := diagram[ 1 ];
        
        for i in [ 2 .. Length( diagram ) ] do
            direct_product := binary_direct_product_func( cat, direct_product, diagram[ i ] );
        od;
        
        return direct_product;
    end;
end );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT,
                       "BinaryDirectSumToDirectSum",
                       "turns a binary direct sum function into a n-ary direct sum function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT,
                       "BinaryDirectProductToDirectProduct",
                       "turns a binary direct product function into a n-ary direct product function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_BINARY_DIRECT_PRODUCT_TO_DIRECT_PRODUCT,
                       "BinaryCoproductToCoproduct",
                       "turns a binary coproduct function into a n-ary coproduct function" );

##
BindGlobal( "GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT",
  function( direct_product_method, limit_or_colimit )
    return function( projection_in_factor_of_binary_direct_product_func, category )
        return function( cat, diagram, projection_number )
          local projection, left_hand_side_diagram, left_hand_side_direct_product, i, current_factor, current_projection;
            
            if projection_number = 1 then
                projection := IdentityMorphism( diagram[ 1 ] );
            else
                left_hand_side_diagram := diagram{ [ 1 .. ( projection_number - 1 ) ] };
                left_hand_side_direct_product := direct_product_method( left_hand_side_diagram );
                
                projection := projection_in_factor_of_binary_direct_product_func( cat, left_hand_side_direct_product, diagram[ projection_number ], 2 );
            fi;
            
            for i in [ ( projection_number + 1 ) .. Length( diagram ) ] do
                if limit_or_colimit = "limit" then
                    current_factor := Source( projection );
                else
                    current_factor := Range( projection );
                fi;
                
                current_projection := projection_in_factor_of_binary_direct_product_func( cat, current_factor, diagram[ i ], 1 );

                if limit_or_colimit = "limit" then
                    projection := PreCompose( current_projection, projection );
                else
                    projection := PreCompose( projection, current_projection );
                fi;
            od;
            
            return projection;
    end;
  end;
end );

CAPAddPrepareFunction( GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT( DirectSum, "limit" ),
                       "ProjectionInFactorOfBinaryDirectSumToProjectionInFactorOfDirectSum",
                       "turns a projection in factor of binary direct sum function into a projection in factor of n-ary direct sum function",
                       [ "DirectSum" ] );

CAPAddPrepareFunction( GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT( DirectProduct, "limit" ),
                       "ProjectionInFactorOfBinaryDirectProductToProjectionInFactorOfDirectProduct",
                       "turns a projection in factor of binary direct product function into a projection in factor of n-ary direct product function",
                       [ "DirectProduct" ] );

CAPAddPrepareFunction( GET_CAP_PREFUNCTION_PROJECTION_IN_FACTOR_OF_BINARY_DIRECT_PRODUCT_TO_PROJECTION_IN_FACTOR_OF_DIRECT_PRODUCT( Coproduct, "colimit" ),
                       "InjectionOfCofactorOfBinaryCoproductToInjectionOfCofactorOfCoproduct",
                       "turns an injection of cofactor of binary coproduct function into an injection of cofactor of n-ary coproduct function",
                       [ "Coproduct" ] );

##
BindGlobal( "CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT",
  function( universal_morphism_into_binary_direct_product_func, category )
    return function( cat, diagram, test_object, tau )
      local universal_morphism, i;
        
        # Direct product diagrams are supposed to have at least length 1
        universal_morphism := tau[ 1 ];
        
        for i in [ 2 .. Length( diagram ) ] do
            universal_morphism := universal_morphism_into_binary_direct_product_func( cat, universal_morphism, tau[ i ] );
        od;
        
        return universal_morphism;
    end;
end );

CAPAddPrepareFunction( CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT,
                       "UniversalMorphismIntoBinaryDirectSumToUniversalMorphismIntoDirectSum",
                       "turns a universal morphism into binary direct sum function into a universal morphism into n-ary direct sum function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT,
                       "UniversalMorphismIntoBinaryDirectProductToUniversalMorphismIntoDirectProduct",
                       "turns a universal morphism into binary direct product function into a universal morphism into n-ary direct product function" );

CAPAddPrepareFunction( CAP_PREFUNCTION_UNIVERSAL_MORPHISM_INTO_BINARY_DIRECT_PRODUCT_TO_UNIVERSAL_MORPHISM_INTO_DIRECT_PRODUCT,
                       "UniversalMorphismFromBinaryCoproductToUniversalMorphismFromCoproduct",
                       "turns a universal morphism from binary coproduct function into a universal morphism from n-ary coproduct function" );
