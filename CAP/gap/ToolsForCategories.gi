# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

#####################################
##
## Install add
##
#####################################

InstallGlobalFunction( "CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING", function ( string, args... )
  local category, is_ring_element, ring, n;
    
    if not IsString( string ) then
        
        Error( string, " is not a string" );
        
    fi;
    
    if Length( args ) > 1 then
        
        Error( "CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING must be called with at most two arguments" );
        
    elif Length( args ) = 1 then
        
        category := args[1];
        
    else
        
        category := false;
        
    fi;
    
    if string = "pair_of_morphisms" then
        
        string := "2_tuple_of_morphisms";
        
    fi;
    
    if string = "bool" then
        
        return rec( filter := IsBool );
        
    elif string = "integer" then
        
        return rec( filter := IsInt );
        
    elif string = "nonneg_integer_or_infinity" then
        
        return rec( filter := IsCyclotomic );
        
    elif string = "category" then
        
        return CapJitDataTypeOfCategory( category );
        
    elif string = "object" then
        
        return CapJitDataTypeOfObjectOfCategory( category );
        
    elif string = "morphism" then
        
        return CapJitDataTypeOfMorphismOfCategory( category );
        
    elif string = "twocell" then
        
        return CapJitDataTypeOfTwoCellOfCategory( category );
        
    elif string = "list_of_objects" then
        
        return CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( category ) );
        
    elif string = "list_of_morphisms" then
        
        return CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( category ) );
        
    elif string = "list_of_lists_of_morphisms" then
        
        return CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( category ) ) );
        
    elif string = "list_of_twocells" then
        
        return CapJitDataTypeOfListOf( CapJitDataTypeOfTwoCellOfCategory( category ) );
        
    elif string = "object_in_range_category_of_homomorphism_structure" then
        
        if category <> false and not HasRangeCategoryOfHomomorphismStructure( category ) then
            
            Display( Concatenation( "WARNING: You are calling an Add function for a CAP operation for \"", Name( category ), "\" which is part of a homomorphism structure but the category has no RangeCategoryOfHomomorphismStructure (yet)" ) );
            
        fi;
        
        if category = false or not HasRangeCategoryOfHomomorphismStructure( category ) then
            
            return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "object" );
            
        else
            
            return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "object", RangeCategoryOfHomomorphismStructure( category ) );
            
        fi;
        
    elif string = "morphism_in_range_category_of_homomorphism_structure" then
        
        if category <> false and not HasRangeCategoryOfHomomorphismStructure( category ) then
            
            Display( Concatenation( "WARNING: You are calling an Add function for a CAP operation for \"", Name( category ), "\" which is part of a homomorphism structure but the category has no RangeCategoryOfHomomorphismStructure (yet)" ) );
            
        fi;
        
        if category = false or not HasRangeCategoryOfHomomorphismStructure( category ) then
            
            return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "morphism" );
            
        else
            
            return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "morphism", RangeCategoryOfHomomorphismStructure( category ) );
            
        fi;
        
    elif string = "object_datum" then
        
        if category <> false then
            
            # might be `fail`
            return ObjectDatumType( category );
            
        else
            
            return fail;
            
        fi;
        
    elif string = "morphism_datum" then
        
        if category <> false then
            
            # might be `fail`
            return MorphismDatumType( category );
            
        else
            
            return fail;
            
        fi;
        
    elif string = "object_or_fail" or string = "morphism_or_fail" or string = "list_or_morphisms_or_fail" then
        
        # cannot be express "or fail" yet
        return fail;
        
    elif string = "element_of_commutative_ring_of_linear_structure" then
        
        if category <> false and not HasCommutativeRingOfLinearCategory( category ) then
            
            Print( "WARNING: You are calling an Add function for a CAP operation for \"", Name( category ), "\" which is part of the linear structure over a commutative ring but the category has no CommutativeRingOfLinearCategory (yet).\n" );
            
        fi;
        
        if category = false or not HasCommutativeRingOfLinearCategory( category ) then
            
            is_ring_element := IsRingElement;
            
        else
            
            ring := CommutativeRingOfLinearCategory( category );
            
            if IsBoundGlobal( "IsHomalgRing" ) and ValueGlobal( "IsHomalgRing" )( ring ) then
                
                is_ring_element := ValueGlobal( "IsHomalgRingElement" );
                
            else
                
                is_ring_element := IsRingElement;
                
            fi;
            
        fi;
        
        return rec(
            filter := is_ring_element,
        );
        
    elif string = "list_of_elements_of_commutative_ring_of_linear_structure" then
        
        if category <> false and not HasCommutativeRingOfLinearCategory( category ) then
            
            Print( "WARNING: You are calling an Add function for a CAP operation for \"", Name( category ), "\" which is part of the linear structure over a commutative ring but the category has no CommutativeRingOfLinearCategory (yet).\n" );
            
        fi;
        
        if category = false or not HasCommutativeRingOfLinearCategory( category ) then
            
            is_ring_element := IsRingElement;
            
        else
            
            ring := CommutativeRingOfLinearCategory( category );
            
            if IsBoundGlobal( "IsHomalgRing" ) and ValueGlobal( "IsHomalgRing" )( ring ) then
                
                is_ring_element := ValueGlobal( "IsHomalgRingElement" );
                
            else
                
                is_ring_element := IsRingElement;
                
            fi;
            
        fi;
        
        return CapJitDataTypeOfListOf( is_ring_element );
        
    elif string = "list_of_integers_and_list_of_morphisms" then
        
        return CapJitDataTypeOfNTupleOf( 2,
                       CapJitDataTypeOfListOf( rec( filter := IsInt ) ),
                       CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( category ) ) );
        
    elif string = "arbitrary_list" then
        
        return CapJitDataTypeOfListOf( IsObject );
        
    elif EndsWith( string, "_tuple_of_morphisms" ) and ForAll( string{[ 1 .. Length( string ) - Length( "_tuple_of_morphisms" ) ]}, IsDigitChar ) then
        
        n := Int( string{[ 1 .. Length( string ) - Length( "_tuple_of_morphisms" ) ]} );
        
        return rec(
            filter := IsNTuple,
            element_types := ListWithIdenticalEntries( n, CapJitDataTypeOfMorphismOfCategory( category ) ),
        );
        
    else
        
        Error( "filter type ", string, " is not recognized, see the documentation for allowed values" );
        
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_GET_DATA_TYPES_FROM_STRINGS,
  
  function( list, args... )
    local category;
    
    if Length( args ) > 1 then
        
        Error( "CAP_INTERNAL_GET_DATA_TYPES_FROM_STRINGS must be called with at most two arguments" );
        
    elif Length( args ) = 1 then
        
        category := args[1];
        
    else
        
        category := false;
        
    fi;
    
    return List( list, l -> CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( l, category ) );
    
end );

InstallGlobalFunction( CAP_INTERNAL_REPLACED_STRING_WITH_FILTER,
  
  function( filter_string, args... )
    local category, data_type;
    
    if Length( args ) > 1 then
        
        Error( "CAP_INTERNAL_REPLACED_STRING_WITH_FILTER must be called with at most two arguments" );
        
    elif Length( args ) = 1 then
        
        category := args[1];
        
    else
        
        category := false;
        
    fi;
    
    data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( filter_string, category );
    
    if data_type = fail then
        
        return IsObject;
        
    elif IsSpecializationOfFilter( IsNTuple, data_type.filter ) then
        
        # `IsNTuple` deliberately does not imply `IsList` because we want to treat tuples and lists in different ways in CompilerForCAP.
        # However, on the GAP level tuples are just dense lists.
        return IsDenseList;
        
    elif IsBoundGlobal( "IsHomalgRingElement" ) and IsSpecializationOfFilter( ValueGlobal( "IsHomalgRingElement" ), data_type.filter ) then
        
        # Some things (e.g. integers) do not lie in the filter `IsHomalgRingElement` but are actually elements of homalg rings (e.g. `HomalgRingOfIntegers( )`).
        return IsRingElement;
        
    else
        
        return data_type.filter;
        
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS,
  
  function( list, args... )
    local category;
    
    if Length( args ) > 1 then
        
        Error( "CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS must be called with at most two arguments" );
        
    elif Length( args ) = 1 then
        
        category := args[1];
        
    else
        
        category := false;
        
    fi;
    
    return List( list, l -> CAP_INTERNAL_REPLACED_STRING_WITH_FILTER( l, category ) );
    
end );

InstallGlobalFunction( CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS_FOR_JULIA,
  
  function( list, args... )
    local category;
    
    if Length( args ) > 1 then
        
        Error( "CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS_FOR_JULIA must be called with at most two arguments" );
        
    elif Length( args ) = 1 then
        
        category := args[1];
        
    else
        
        category := false;
        
    fi;
    
    return List( list, function ( l )
      local filter;
        
        filter := CAP_INTERNAL_REPLACED_STRING_WITH_FILTER( l, category );
        
        if filter = IsList then
            
            return ValueGlobal( "IsJuliaObject" );
            
        else
            
            return filter;
            
        fi;
        
    end );
    
end );

InstallGlobalFunction( "CAP_INTERNAL_MERGE_FILTER_LISTS",
  
  function( filter_list, additional_filters )
    local i;
    filter_list := ShallowCopy( filter_list );
    
    if Length( filter_list ) < Length( additional_filters ) then
        Error( "too many additional filters" );
    fi;
    
    for i in [ 1 .. Length( additional_filters ) ] do
        if IsBound( additional_filters[ i ] ) then
            filter_list[ i ] := filter_list[ i ] and additional_filters[ i ];
        fi;
    od;
    
    return filter_list;
end );

InstallGlobalFunction( "CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER",
  
  function( data_type, human_readable_identifier_list )
    local generic_help_string, filter, asserts_value_is_of_element_type, generic_assert_value_is_of_element_type;
    
    generic_help_string := " You can access the value via the local variable 'value' in a break loop.";
    
    filter := data_type.filter;
    
    # `IsBool( fail ) = true`, but we do not want to include `fail`
    if IsSpecializationOfFilter( IsBool, filter ) then
        
        return function( value )
            
            if not (value = true or value = false) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " is neither `true` nor `false`.", generic_help_string ] ) );
                
            fi;
            
        end;
        
    elif IsSpecializationOfFilter( IsFunction, filter ) then
        
        return function( value )
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
            if NumberArgumentsFunction( value ) >= 0 and NumberArgumentsFunction( value ) <> Length( data_type.signature[1] ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " has ", NumberArgumentsFunction( value ), " arguments but ", Length( data_type.signature[1] ), " were expected.", generic_help_string ] ) );
                
            fi;
            
        end;
        
    elif IsSpecializationOfFilter( IsList, filter ) then
        
        # In principle, we have to create an assertion function for each integer to get the human readable identifier correct.
        # The "correct" approach would be to generate those on demand but that would imply that we have to create assertion functions at runtime.
        # Thus, we take the pragmatic approach: We generate an assertion function for the first few entries, and a generic assertion function for all other entries.
        # For nested lists the number of assertion functions grows exponentially, so we choose a quite small number (4).
        asserts_value_is_of_element_type := List( [ 1 .. 4 ], i -> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( data_type.element_type, Concatenation( [ "the ", i, "-th entry of " ], human_readable_identifier_list ) ) );
        
        generic_assert_value_is_of_element_type := CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( data_type.element_type, Concatenation( [ "some entry of " ], human_readable_identifier_list )  );
        
        return function( value )
          local i;
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
            for i in [ 1 .. Length( value ) ] do
                
                #= comment for Julia
                # Julia does not have non-dense lists
                if not IsBound( value[i] ) then
                    
                    CallFuncList( Error, Concatenation( [ "the ", i, "-th entry of " ], human_readable_identifier_list, [ " is not bound.", generic_help_string ] ) );
                    
                fi;
                # =#
                
                if i <= 4 then
                    
                    asserts_value_is_of_element_type[i]( value[i] );
                    
                else
                    
                    generic_assert_value_is_of_element_type( value[i] );
                    
                fi;
                
            od;
            
        end;
        
    elif IsSpecializationOfFilter( IsNTuple, filter ) then
        
        asserts_value_is_of_element_type := List( [ 1 .. Length( data_type.element_types ) ], i -> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( data_type.element_types[i], Concatenation( [ "the ", i, "-th entry of " ], human_readable_identifier_list ) ) );
        
        return function( value )
          local i;
            
            # tuples are modeled as lists
            if not IsDenseList( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter IsDenseList (implementation filter of IsNTuple).", generic_help_string ] ) );
                
            fi;
            
            if Length( value ) <> Length( data_type.element_types ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " has length ", Length( value ), " but ", Length( data_type.element_types ), " was expected.", generic_help_string ] ) );
                
            fi;
            
            for i in [ 1 .. Length( value ) ] do
                
                asserts_value_is_of_element_type[i]( value[i] );
                
            od;
            
        end;
        
    elif IsSpecializationOfFilter( IsCapCategory, filter ) then
        
        return function( value )
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
            if not IsIdenticalObj( value, data_type.category ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " is not the expected category although it lies in the category filter of the expected category. This should never happen, please report this using the CAP_project's issue tracker.", generic_help_string ] ) );
                
            fi;
            
        end;
        
    elif IsSpecializationOfFilter( IsCapCategoryObject, filter ) then
        
        return function( value )
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
            CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( value, data_type.category, human_readable_identifier_list );
            
        end;
        
    elif IsSpecializationOfFilter( IsCapCategoryMorphism, filter ) then
        
        return function( value )
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
            CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( value, data_type.category, human_readable_identifier_list );
            
        end;
        
    elif IsSpecializationOfFilter( IsCapCategoryTwoCell, filter ) then
        
        return function( value )
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
            CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( value, data_type.category, human_readable_identifier_list );
            
        end;
        
    elif IsBoundGlobal( "IsHomalgRingElement" ) and IsSpecializationOfFilter( ValueGlobal( "IsHomalgRingElement" ), filter ) then
        
        return function( value )
            
            # Some things (e.g. integers) do not lie in the filter `IsHomalgRingElement` but are actually elements of homalg rings (e.g. `HomalgRingOfIntegers( )`).
            if not IsRingElement( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter IsRingElement.", generic_help_string ] ) );
                
            fi;
            
        end;
        
    else
        
        return function( value )
            
            if not filter( value ) then
                
                CallFuncList( Error, Concatenation( human_readable_identifier_list, [ " does not lie in the expected filter ", filter, ".", generic_help_string ] ) );
                
            fi;
            
        end;
        
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT,
    
  function( option_name, default )
    local value;
    
    value := ValueOption( option_name );
    
    if value = fail then
        return default;
    fi;
    
    return value;
end );

BindGlobal( "CAP_INTERNAL_REPLACE_ADDITIONAL_SYMBOL_APPEARANCE",
  
  function( appearance_list, replacement_record )
    local remove_list, new_appearances, current_appearance, pos, current_appearance_nr, current_replacement, i;
    
    appearance_list := StructuralCopy( appearance_list );
    
    remove_list := [];
    new_appearances := [];
    
    for current_appearance_nr in [ 1 .. Length( appearance_list ) ] do
        
        current_appearance := appearance_list[ current_appearance_nr ];
        
        if IsBound( replacement_record.(current_appearance[1]) ) then
            
            Add( remove_list, current_appearance_nr );
            
            for current_replacement in replacement_record.(current_appearance[1]) do
                
                pos := PositionProperty( appearance_list, x -> x[1] = current_replacement[1] and x[3] = current_appearance[3] );
                
                if pos = fail then
                    
                    Add( new_appearances, [ current_replacement[ 1 ], current_replacement[ 2 ] * current_appearance[ 2 ], current_appearance[3] ] );
                    
                else
                    
                    appearance_list[pos][2] := appearance_list[pos][2] + current_replacement[ 2 ] * current_appearance[ 2 ];
                    
                fi;
                
            od;
            
        fi;
        
    od;
    
    for i in Reversed( remove_list ) do
        
        Remove( appearance_list, i );
        
    od;
    
    return Concatenation( appearance_list, new_appearances );
    
end );

##
InstallGlobalFunction( "CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION",
  
  function( func, symbol_list, loop_multiple, replacement_record, category_getters )
    local func_as_string, func_stream, func_as_list, loop_power, symbol_appearance_list, current_symbol, category_getter, pos, i;
    
    if IsOperation( func ) then
        
        func_as_string := NameFunction( func );
        
    else
        
        func_as_string := "";
        
        func_stream := OutputTextString( func_as_string, false );
        
        SetPrintFormattingStatus( func_stream, false );
        
        PrintTo( func_stream, func );
        
        CloseStream( func_stream );
        
    fi;
    
    RemoveCharacters( func_as_string, "()[];," );
    
    NormalizeWhitespace( func_as_string );
    
    func_as_list := SplitString( func_as_string, " " );
    
    loop_power := 0;
    
    symbol_appearance_list := [ ];
    
    symbol_list := Concatenation( symbol_list, RecNames( replacement_record ) );
    
    # remove first "function" and last "end"
    Assert( 0, func_as_list[1] = "function" );
    Assert( 0, Last( func_as_list ) = "end" );
    
    func_as_list := func_as_list{[ 2 .. Length( func_as_list ) - 1 ]};
    
    for i in [ 1 .. Length( func_as_list ) ] do
        
        current_symbol := func_as_list[i];
        
        if current_symbol in symbol_list then
            
            # function cannot end with a symbol
            Assert( 0, i < Length( func_as_list ) );
            
            if IsBound( category_getters.(func_as_list[i + 1]) ) then
                
                category_getter := category_getters.(func_as_list[i + 1]);
                
            else
                
                category_getter := fail;
                
            fi;
            
            pos := PositionProperty( symbol_appearance_list, x -> x[1] = current_symbol and x[3] = category_getter );
            
            if pos = fail then
                
                Add( symbol_appearance_list, [ current_symbol, loop_multiple^loop_power, category_getter ] );
                
            else
                
                symbol_appearance_list[pos][2] := symbol_appearance_list[pos][2] + loop_multiple^loop_power;
                
            fi;
            
        # Technically, the head of a "for" loop is only executed once.
        # We could simply start the detection at "do", but this would exclude the header of "while" loops
        # which indeed is executed multiple times.
        elif current_symbol in [ "for", "while", "repeat", "function" ] then
            
            loop_power := loop_power + 1;
            
        # Technically, the part after "until" is also executed multiple times.
        elif current_symbol in [ "od", "until", "end" ] then
            
            loop_power := loop_power - 1;
            
        fi;
        
    od;
    
    if loop_power <> 0 then
        
        Error( "The automated detection of CAP operations could not detect loops properly. If the reserved word `for` appears in <func_as_string> (e.g. in a string), this is probably the cause. If not, please report this as a bug mentioning <func_as_string>." );
        
    fi;
    
    symbol_appearance_list := CAP_INTERNAL_REPLACE_ADDITIONAL_SYMBOL_APPEARANCE( symbol_appearance_list, replacement_record );
    return symbol_appearance_list;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_MERGE_PRECONDITIONS_LIST,
  
  function( list1, list2 )
    local pos, current_precondition;
    
    list2 := StructuralCopy( list2 );
    
    for current_precondition in list1 do
        
        pos := PositionProperty( list2, x -> x[1] = current_precondition[1] and x[3] = current_precondition[3] );
        
        if pos = fail then
            
            Add( list2, current_precondition );
            
        else
            
            list2[pos][2] := Maximum( list2[pos][2], current_precondition[2] );
            
        fi;
        
    od;
    
    return list2;
    
end );

##
InstallGlobalFunction( ListKnownCategoricalProperties,
                      
  function( category )
    local list, name;
    
    if not IsCapCategory( category ) then
      
      Error( "the input is not a category" );
      
    fi;
    
    list := [ ];
    
    for name in Set( Filtered( Concatenation( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST ), x -> x <> fail ) ) do
      
      if Tester( ValueGlobal( name ) )( category ) and ValueGlobal( name )( category ) then
        
        Add( list, name );
      
      fi;
      
    od;
    
    return list;
    
end );

InstallGlobalFunction( HelpForCAP,
  
  function()
    local filename, stream, string;
    
    filename := DirectoriesPackageLibrary( "CAP", "" );
    filename := filename[ 1 ];
    filename := Filename( filename, "help_for_CAP.md" );
    
    stream := InputTextFile( filename );
    string := ReadAll( stream );
    CloseStream( stream );
    
    Print( string );
    
end );

InstallGlobalFunction( CachingStatistic,
  
  function( category, arg... )
    local operations, current_cache_name, current_cache;
    
    operations := arg;
    
    if Length( operations ) = 0 then
        operations := RecNames( category!.caches );
    fi;
    
    operations := ShallowCopy( operations );
    Sort( operations );
    
    Print( "Caching statistics for category ", Name( category ), "\n" );
    Print( "===============================================\n" );
    
    for current_cache_name in operations do
        Print( current_cache_name, ": " );
        if not IsBound( category!.caches.(current_cache_name) ) then
            Print( "not installed yet\n" );
            continue;
        fi;
        current_cache := category!.caches.(current_cache_name);
        if IsDisabledCache( current_cache ) then
            Print( "disabled\n" );
            continue;
        fi;
        if IsWeakCache( current_cache ) then
            Print( "weak cache, " );
        elif IsCrispCache( current_cache ) then
            Print( "crisp cache, " );
        fi;
        Print( "hits: ", String( current_cache!.hit_counter ), ", misses: ", String( current_cache!.miss_counter ), ", " );
        Print( String( Length( PositionsProperty( current_cache!.value, ReturnTrue ) ) ), " objects stored\n" );
    od;
    
end );

InstallGlobalFunction( InstallDeprecatedAlias,
  
  function( alias_name, function_name, deprecation_date )
    
    #= comment for Julia
    BindGlobal( alias_name, function ( args... )
      local result;
        
        Print(
          Concatenation(
          "WARNING: ", alias_name, " is deprecated and will not be supported after ", deprecation_date, ". Please use ", function_name, " instead.\n"
          )
        );
        
        result := CallFuncListWrap( ValueGlobal( function_name ), args );
        
        if not IsEmpty( result ) then
            
            return result[1];
            
        fi;
        
    end );
    # =#
    
end );

##
InstallGlobalFunction( "IsSpecializationOfFilter", function ( filter_1, filter_2 )
  local data_type_1, data_type_2;
    
    if IsString( filter_1 ) then
        
        data_type_1 := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( filter_1 );
        
        if data_type_1 = fail then
            
            filter_1 := IsObject;
            
        else
            
            filter_1 := data_type_1.filter;
            
        fi;
        
    fi;
    
    if IsString( filter_2 ) then
        
        data_type_2 := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( filter_2 );
        
        if data_type_2 = fail then
            
            filter_2 := IsObject;
            
        else
            
            filter_2 := data_type_2.filter;
            
        fi;
        
    fi;
    
    return IS_SUBSET_FLAGS( WITH_IMPS_FLAGS( FLAGS_FILTER( filter_2 ) ), WITH_IMPS_FLAGS( FLAGS_FILTER( filter_1 ) ) );
    
end );

##
InstallGlobalFunction( "IsSpecializationOfFilterList", function ( filter_list1, filter_list2 )
    
    if filter_list1 = "any" then
        
        return true;
        
    elif filter_list2 = "any" then
        
        return false;
        
    fi;
    
    return Length( filter_list1 ) = Length( filter_list2 ) and ForAll( [ 1 .. Length( filter_list1 ) ], i -> IsSpecializationOfFilter( filter_list1[i], filter_list2[i] ) );
    
end );

##
InstallGlobalFunction( InstallMethodForCompilerForCAP,
  
  function( args... )
    local operation, method, filters;
    
    # let InstallMethod do the type checking
    CallFuncList( InstallMethod, args );
    
    operation := First( args );
    method := Last( args );
    
    if IsList( args[Length( args ) - 1] ) then
        
        filters := args[Length( args ) - 1];
        
    elif IsList( args[Length( args ) - 2] ) then
        
        filters := args[Length( args ) - 2];
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "this should never happen" );
        
    fi;
    
    CapJitAddKnownMethod( operation, filters, method );
    
end );

##
InstallGlobalFunction( InstallOtherMethodForCompilerForCAP,
  
  function( args... )
    local operation, method, filters;
    
    # let InstallOtherMethod do the type checking
    CallFuncList( InstallOtherMethod, args );
    
    operation := First( args );
    method := Last( args );
    
    if IsList( args[Length( args ) - 1] ) then
        
        filters := args[Length( args ) - 1];
        
    elif IsList( args[Length( args ) - 2] ) then
        
        filters := args[Length( args ) - 2];
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "this should never happen" );
        
    fi;
    
    CapJitAddKnownMethod( operation, filters, method );
    
end );

##
BindGlobal( "CAP_JIT_INTERNAL_KNOWN_METHODS", rec( ) );

InstallGlobalFunction( CapJitAddKnownMethod,
  
  function( operation, filters, method )
    local operation_name, wrapper_operation_name, known_methods;
    
    if not IsOperation( operation ) or not IsList( filters ) or not IsFunction( method ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "usage: CapJitAddKnownMethod( <operation>, <list of filters>, <method> )" );
        
    fi;
    
    if IsEmpty( filters ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "installing methods without filters is currently not supported" );
        
    fi;
    
    operation_name := NameFunction( operation );
    
    if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) and Length( filters ) = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( operation_name, " is already installed as a CAP operation with the same number of arguments" );
        
    fi;
    
    # check if we deal with a KeyDependentOperation
    if EndsWith( operation_name, "Op" ) then
        
        wrapper_operation_name := operation_name{[ 1 .. Length( operation_name ) - 2 ]};
        
        if IsBoundGlobal( wrapper_operation_name ) and ValueGlobal( wrapper_operation_name ) in WRAPPER_OPERATIONS then
            
            operation_name := wrapper_operation_name;
            
        fi;
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) then
        
        CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) := [ ];
        
    fi;
    
    known_methods := CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name);
    
    if IsSpecializationOfFilter( "category", filters[1] ) then
        
        if ForAny( known_methods, m -> Length( m.filters ) = Length( filters ) and ( IsSpecializationOfFilter( m.filters[1], filters[1] ) or IsSpecializationOfFilter( filters[1], m.filters[1] ) ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "there is already a method known for ", operation_name, " with a category filter which implies the current category filter or is implied by it" );
            
        fi;
        
    else
        
        if IsSpecializationOfFilter( filters[1], "category" ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The first filter is implied by `IsCapCategory`, this is not supported." );
            
        fi;
        
        if ForAny( known_methods,
            m -> Length( m.filters ) = Length( filters ) and ForAll( [ 1 .. Length( filters ) ], i -> IsSpecializationOfFilter( m.filters[i], filters[i] ) or IsSpecializationOfFilter( filters[i], m.filters[i] ) )
        ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "there is already a method known for ", operation_name, " with a comparable filter list (see documentation of `CapJitAddKnownMethod`)" );
            
        fi;
        
    fi;
    
    Add( known_methods, rec( filters := filters, method := method ) );
    
end );

##
BindGlobal( "CAP_JIT_INTERNAL_TYPE_SIGNATURES", rec( ) );

InstallGlobalFunction( "CapJitAddTypeSignature", function ( name, input_filters, output_data_type )
    
    #= comment for Julia
    if IsCategory( ValueGlobal( name ) ) and Length( input_filters ) = 1 then
        
        Error( "adding type signatures for GAP categories applied to a single argument is not supported" );
        
    fi;
    
    if input_filters <> "any" then
        
        if not IsList( input_filters ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list or the string \"any\"" );
            
        fi;
        
        if not ForAll( input_filters, filter -> IsFilter( filter ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list of filters or the string \"any\"" );
            
        fi;
        
        if ForAny( input_filters, f -> IsSpecializationOfFilter( IsFunction, f ) ) and (not IsFunction( output_data_type ) or NumberArgumentsFunction( output_data_type ) <> 2) then
            
            if not name in [ "CreateCapCategoryObjectWithAttributes", "CreateCapCategoryMorphismWithAttributes" ] then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print(
                    "WARNING: You are adding a type signature for ", name, " which can get a function as input but you do not compute the signature of the function. ",
                    "This will work for references to global functions but not for literal functions. ",
                    "See `List` in `CompilerForCAP/gap/InferDataTypes.gi` for an example of how to handle the signature of functions properly.\n"
                );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        fi;
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name) ) then
        
        CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name) := [ ];
        
    fi;
    
    if ForAny( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name), signature -> IsSpecializationOfFilterList( signature[1], input_filters ) or IsSpecializationOfFilterList( input_filters, signature[1] ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there already exists a signature for ", name, " with filters implying the current filters or being implied by them" );
        
    fi;
    
    if not ForAny( [ IsFilter, IsRecord, IsFunction ], f -> f( output_data_type ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<output_data_type> must be a filter, a record, or a function" );
        
    fi;
    
    if IsFilter( output_data_type ) then
        
        output_data_type := rec( filter := output_data_type );
        
    fi;
    
    Add( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name), [ input_filters, output_data_type ] );
    # =#
    
end );

##
BindGlobal( "CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED", rec( ) );

InstallGlobalFunction( "CapJitAddTypeSignatureDeferred", function ( package_name, name, input_filters, output_data_type )
    
    if input_filters <> "any" then
        
        if not IsList( input_filters ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list or the string \"any\"" );
            
        fi;
        
        if not ForAll( input_filters, filter -> IsString( filter ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list of strings or the string \"any\"" );
            
        fi;
        
    fi;
    
    if not IsString( output_data_type ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<output_data_type> must be a string" );
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name) ) then
        
        CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name) := [ ];
        
    fi;
    
    Add( CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name), [ name, input_filters, output_data_type ] );
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfListOf, function ( element_type )
    
    if IsFilter( element_type ) then
        
        element_type := rec( filter := element_type );
        
    fi;
    
    if not IsRecord( element_type ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<element_type> must be a filter or a record" );
        
    fi;
    
    return rec( filter := IsList, element_type := element_type );
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfNTupleOf, function ( n, element_types... )
    
    Assert( 0, Length( element_types ) = n );
    
    element_types := List( element_types, function ( t )
        
        if IsFilter( t ) then
            
            return rec( filter := t );
            
        else
            
            return t;
            
        fi;
        
    end );
    
    if not ForAll( element_types, t -> IsRecord( t ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<element_types...> must be filters or records" );
        
    fi;
    
    return rec( filter := IsNTuple, element_types := element_types );
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfCategory, function ( cat )
  local type;
    
    if cat = false then
        
        type := rec(
            filter := IsCapCategory,
        );
        
    else
        
        type := rec(
            filter := CategoryFilter( cat ),
            category := cat,
        );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfObjectOfCategory, function ( cat )
  local type;
    
    if cat = false then
        
        type := rec(
            filter := IsCapCategoryObject,
        );
        
    else
        
        type := rec(
            filter := ObjectFilter( cat ),
            category := cat,
        );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfMorphismOfCategory, function ( cat )
  local type;
    
    if cat = false then
        
        type := rec(
            filter := IsCapCategoryMorphism,
        );
        
    else
        
        type := rec(
            filter := MorphismFilter( cat ),
            category := cat,
        );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfTwoCellOfCategory, function ( cat )
  local type;
    
    if cat = false then
        
        type := rec(
            filter := IsCapCategoryTwoCell,
        );
        
    else
        
        type := rec(
            filter := TwoCellFilter( cat ),
            category := cat,
        );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapFixpoint, function ( predicate, func, initial_value )
  local x, y;
    
    y := initial_value;
    
    while true do
        x := y;
        y := func( x );
        if predicate( x, y ) then
            break;
        fi;
    od;
    
    return y;
    
end );

##
InstallMethod( Iterated,
               [ IsList, IsFunction, IsObject ],
               
  function( list, func, initial_value )
    
    return Iterated( Concatenation( [ initial_value ], list ), func );
    
end );

##
InstallMethod( Iterated,
               [ IsList, IsFunction, IsObject, IsObject ],
               
  function( list, func, initial_value, terminal_value )
    
    return Iterated( Concatenation( [ initial_value ], list, [ terminal_value ] ), func );
    
end );

##
InstallGlobalFunction( TransitivelyNeededOtherPackages, function ( package_name )
  local collected_dependencies, package_info, dep, p;
    
    collected_dependencies := [ package_name ];
    
    for dep in collected_dependencies do
        
        package_info := First( PackageInfo( dep ) );
        
        if package_info = fail then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( dep, " is not the name of an available package" );
            
        fi;
        
        for p in package_info.Dependencies.NeededOtherPackages do
            
            if not p[1] in collected_dependencies then
                
                Add( collected_dependencies, p[1] );
                
            fi;
            
        od;
        
    od;
    
    return collected_dependencies;
    
end );

##
InstallMethod( SafePosition,
               [ IsList, IsObject ],
               
  function( list, obj )
    local pos;
    
    pos := Position( list, obj );
    
    Assert( 0, pos <> fail );
    
    return pos;
    
end );

##
InstallMethod( SafeUniquePosition,
               [ IsList, IsObject ],
               
  function( list, obj )
    local positions;
    
    positions := Positions( list, obj );
    
    Assert( 0, Length( positions ) = 1 );
    
    return positions[1];
    
end );

##
InstallMethod( SafePositionProperty,
               [ IsList, IsFunction ],
               
  function( list, func )
    local pos;
    
    pos := PositionProperty( list, func );
    
    Assert( 0, pos <> fail );
    
    return pos;
    
end );

##
InstallMethod( SafeUniquePositionProperty,
               [ IsList, IsFunction ],
               
  function( list, func )
    local positions;
    
    positions := PositionsProperty( list, func );
    
    Assert( 0, Length( positions ) = 1 );
    
    return positions[1];
    
end );

##
InstallMethod( SafeFirst,
               [ IsList, IsFunction ],
               
  function( list, func )
    local entry;
    
    entry := First( list, func );
    
    Assert( 0, entry <> fail );
    
    return entry;
    
end );

##
InstallMethod( SafeUniqueEntry,
               [ IsList, IsFunction ],
               
  function( list, func )
    local positions;
    
    positions := PositionsProperty( list, func );
    
    Assert( 0, Length( positions ) = 1 );
    
    return list[positions[1]];
    
end );

##
#= comment for Julia
# We want `args` to be a list but in Julia it's a tuple -> we need a separate implementation for Julia
InstallGlobalFunction( NTuple, function ( n, args... )
    
    Assert( 0, Length( args ) = n );
    
    return args;
    
end );
# =#

##
InstallGlobalFunction( Pair, function ( first, second )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    return NTuple( 2, first, second );
    
end );

##
InstallGlobalFunction( Triple, function ( first, second, third )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    return NTuple( 3, first, second, third );
    
end );

##
InstallGlobalFunction( TransposedMatWithGivenDimensions, function ( nr_rows, nr_cols, listlist )
    
    if not ( Length( listlist ) = nr_rows and ForAll( listlist, row -> Length( row ) = nr_cols ) ) then
        Error( "the arguments passed to 'TransposedMatWithGivenDimensions' are inconsistent!\n" );
    fi;
    
    if nr_rows = 0 then
        return List( [ 1 .. nr_cols ], i -> [ ] );
    else
        return TransposedMat( listlist );
    fi;
    
end );

##
InstallGlobalFunction( HandlePrecompiledTowers, function ( category, underlying_category, constructor_name )
  local precompiled_towers, remaining_constructors_in_tower, precompiled_functions_adder, info;
    
    if not IsBound( underlying_category!.compiler_hints ) or not IsBound( underlying_category!.compiler_hints.precompiled_towers ) then
        
        return;
        
    fi;
    
    if not IsList( underlying_category!.compiler_hints.precompiled_towers ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "`underlying_category!.compiler_hints.precompiled_towers` must be a list" );
        
    fi;
    
    precompiled_towers := [ ];
    
    for info in underlying_category!.compiler_hints.precompiled_towers do
        
        if not (IsRecord( info ) and IsBound( info.remaining_constructors_in_tower ) and IsBound( info.precompiled_functions_adder )) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the entries of `underlying_category!.compiler_hints.precompiled_towers` must be records with components `remaining_constructors_in_tower` and `precompiled_functions_adder`" );
            
        fi;
        
        remaining_constructors_in_tower := info.remaining_constructors_in_tower;
        precompiled_functions_adder := info.precompiled_functions_adder;
        
        if not IsList( remaining_constructors_in_tower ) or IsEmpty( remaining_constructors_in_tower ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "`remaining_constructors_in_tower` must be a non-empty list" );
            
        fi;
        
        if not IsFunction( precompiled_functions_adder ) or NumberArgumentsFunction( precompiled_functions_adder ) <> 1 then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "`precompiled_functions_adder` must be a function accepting a single argument" );
            
        fi;
        
        if remaining_constructors_in_tower[1] = constructor_name then
            
            if Length( remaining_constructors_in_tower ) = 1 then
                
                if ValueOption( "no_precompiled_code" ) <> true then
                    
                    # add precompiled functions
                    CallFuncList( precompiled_functions_adder, [ category ] );
                    
                fi;
                
            else
                
                # pass information on to the next level
                Add( precompiled_towers, rec(
                    remaining_constructors_in_tower := remaining_constructors_in_tower{[ 2 .. Length( remaining_constructors_in_tower ) ]},
                    precompiled_functions_adder := precompiled_functions_adder,
                ) );
                
            fi;
            
        fi;
        
    od;
    
    if not IsEmpty( precompiled_towers ) then
        
        if not IsBound( category!.compiler_hints ) then
            
            category!.compiler_hints := rec( );
            
        fi;
        
        if not IsBound( category!.compiler_hints.precompiled_towers ) then
            
            category!.compiler_hints.precompiled_towers := [ ];
            
        fi;
        
        category!.compiler_hints.precompiled_towers := Concatenation( category!.compiler_hints.precompiled_towers, precompiled_towers );
        
    fi;
    
    # return void for Julia
    return;
    
end );

InstallGlobalFunction( CAP_JIT_INCOMPLETE_LOGIC, IdFunc );

##
#= comment for Julia
# Julia does not have non-dense lists and thus needs a separate implementation
InstallGlobalFunction( ListWithKeys, function ( list, func )
  local res, i;
    
    # see implementation of `List`
    
    res := EmptyPlist( Length( list ) );
    
    # hack to save type adjustments and conversions (e.g. to blist)
    if Length( list ) > 0 then
        
        res[Length( list )] := 1;
        
    fi;
    
    for i in [ 1 .. Length( list ) ] do
        
        res[i] := func( i, list[i] );
        
    od;
    
    return res;
    
end );
# =#

##
InstallGlobalFunction( SumWithKeys, function ( list, func )
  local sum, i;
    
    # see implementation of `Sum`
    
    if IsEmpty( list ) then
        
        sum := 0;
        
    else
        
        sum := func( 1, list[1] );
        
        for i in [ 2 .. Length( list ) ] do
            
            sum := sum + func( i, list[i] );
            
        od;
        
    fi;
    
    return sum;
    
end );

##
InstallGlobalFunction( ProductWithKeys, function ( list, func )
  local product, i;
    
    # adapted implementation of `Product`
    
    if IsEmpty( list ) then
        
        product := 1;
        
    else
        
        product := func( 1, list[1] );
        
        for i in [ 2 .. Length( list ) ] do
            
            product := product * func( i, list[i] );
            
        od;
        
    fi;
    
    return product;
    
end );

##
InstallGlobalFunction( ForAllWithKeys, function ( list, func )
  local i;
    
    # adapted implementation of `ForAll`
    
    for i in [ 1 .. Length( list ) ] do
        
        if not func( i, list[i] ) then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end );

##
InstallGlobalFunction( ForAnyWithKeys, function ( list, func )
  local i;
    
    # adapted implementation of `ForAny`
    
    for i in [ 1 .. Length( list ) ] do
        
        if func( i, list[i] ) then
            
            return true;
            
        fi;
        
    od;
    
    return false;
    
end );

##
InstallGlobalFunction( NumberWithKeys, function ( list, func )
  local nr, i;
    
    # adapted implementation of `Number`
    
    nr := 0;
    
    for i in [ 1 .. Length( list ) ] do
        
        if func( i, list[i] ) then
            
            nr := nr + 1;
            
        fi;
        
    od;
    
    return nr;
    
end );

##
#= comment for Julia
# Julia does not have non-dense lists and thus needs a separate implementation
InstallGlobalFunction( FilteredWithKeys, function ( list, func )
  local res, i, elm, j;
    
    # adapted implementation of `Filtered`
    
    res := list{[ ]};
    
    i := 0;
    
    for j in [ 1 .. Length( list ) ] do
        
        elm := list[j];
        
        if func( j, elm ) then
            
            i := i + 1;
            
            res[i] := elm;
            
        fi;
        
    od;
    
    return res;
    
end );
# =#

##
InstallGlobalFunction( FirstWithKeys, function ( list, func )
  local elm, i;
    
    # adapted implementation of `First`
    
    for i in [ 1 .. Length( list ) ] do
        
        elm := list[i];
        
        if func( i, elm ) then
            
            return elm;
            
        fi;
        
    od;
    
    return fail;
    
end );

##
InstallGlobalFunction( LastWithKeys, function ( list, func )
  local elm, i;
    
    # adapted implementation of `Last`
    
    for i in Reversed( [ 1 .. Length( list ) ] ) do
        
        elm := list[i];
        
        if func( i, elm ) then
            
            return elm;
            
        fi;
        
    od;
    
    return fail;
    
end );
