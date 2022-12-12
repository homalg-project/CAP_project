# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Managing Derived Methods

BindGlobal( "TheFamilyOfDerivations",
            NewFamily( "TheFamilyOfDerivations" ) );
BindGlobal( "TheFamilyOfDerivationGraphs",
            NewFamily( "TheFamilyOfDerivationGraphs" ) );
BindGlobal( "TheFamilyOfOperationWeightLists",
            NewFamily( "TheFamilyOfOperationWeightLists" ) );
BindGlobal( "TheFamilyOfStringMinHeaps",
            NewFamily( "TheFamilyOfStringMinHeaps" ) );

BindGlobal( "TheTypeOfDerivedMethods", NewType( TheFamilyOfDerivations, IsDerivedMethod ) );
BindGlobal( "TheTypeOfDerivationsGraphs", NewType( TheFamilyOfDerivationGraphs, IsDerivedMethodGraph ) );
BindGlobal( "TheTypeOfOperationWeightLists", NewType( TheFamilyOfOperationWeightLists, IsOperationWeightList ) );
BindGlobal( "TheTypeOfStringMinHeaps", NewType( TheFamilyOfStringMinHeaps, IsStringMinHeap ) );

InstallGlobalFunction( "ActivateDerivationInfo",
  function( )
    SetInfoLevel( DerivationInfo, 1 );
end );

InstallGlobalFunction( "DeactivateDerivationInfo",
  function( )
    SetInfoLevel( DerivationInfo, 0 );
end );

InstallMethod( MakeDerivation,
               [ IsString, IsFunction, IsDenseList, IsPosInt, IsFunction, IsFunction ],
               
function( name, target_op, used_op_names_with_multiples_and_category_getters, weight, func, category_filter )
    
    if PositionSublist( String( category_filter ), "CanCompute" ) <> fail then
        
        Print( "WARNING: The CategoryFilter of a derivation for ", NameFunction( target_op ), " uses `CanCompute`. Please register all preconditions explicitly.\n" );
        
    fi;
    
    if NumberArgumentsFunction( category_filter ) = 0 or NumberArgumentsFunction( category_filter ) > 1 then
        
        Error( "the CategoryFilter of a derivation must accept exactly one argument" );
        
    fi;
    
    if IsProperty( category_filter ) then
        
        category_filter := Tester( category_filter ) and category_filter;
        
    fi;
    
    return ObjectifyWithAttributes(
        rec( ), TheTypeOfDerivedMethods,
        DerivationName, name,
        DerivationWeight, weight,
        DerivationFunction, func,
        CategoryFilter, category_filter,
        TargetOperation, NameFunction( target_op ),
        UsedOperationsWithMultiplesAndCategoryGetters, used_op_names_with_multiples_and_category_getters
    );
    
end );

InstallMethod( String,
               [ IsDerivedMethod ],
function( d )
  return Concatenation( "derivation ", DerivationName( d ),
                        " of operation ", TargetOperation( d ) );
end );

InstallMethod( ViewObj,
               [ IsDerivedMethod ],
function( d )
  Print( "<", String( d ), ">" );
end );

InstallMethod( IsApplicableToCategory,
               [ IsDerivedMethod, IsCapCategory ],
function( d, C )
  return CategoryFilter( d )( C );
end );

InstallMethod( InstallDerivationForCategory,
               [ IsDerivedMethod, IsPosInt, IsCapCategory ],
function( d, weight, C )
  local method_name, func, add_method, add_name, general_filter_list,
        installation_name, nr_arguments, cache_name, current_filters, current_implementation,
        function_called_before_installation;
  
  Info( DerivationInfo, 1, Concatenation( "install(",
                                          String( weight ),
                                          ") ",
                                          TargetOperation( d ),
                                          ": ",
                                          DerivationName( d ), "\n" ) );
  
  method_name := TargetOperation( d );
  func := DerivationFunction( d );
  add_name := Concatenation( "Add", method_name );
  add_method := ValueGlobal( add_name );
  
  if HasFunctionCalledBeforeInstallation( d ) then
      
      FunctionCalledBeforeInstallation( d )( C );
      
  fi;
  
  # use the add method with signature IsCapCategory, IsList, IsInt to avoid
  # the convenience for AddZeroObject etc.
  add_method( C, [ Pair( func, [ ] ) ], weight : IsDerivation := true );
  
end );

InstallMethod( DerivationResultWeight,
               [ IsDerivedMethod, IsDenseList ],
function( d, op_weights )
  local w, used_op_multiples, i, op_w, mult;
  Display( "WARNING: DerivationResultWeight is deprecated and will not be supported after 2023.08.26.\n" );
  w := DerivationWeight( d );
  used_op_multiples := UsedOperationsWithMultiplesAndCategoryGetters( d );
  for i in [ 1 .. Length( used_op_multiples ) ] do
    op_w := op_weights[ i ];
    mult := used_op_multiples[ i ][ 2 ];
    if op_w = infinity then
      return infinity;
    fi;
    w := w + op_w * mult;
  od;
  return w;
end );

InstallMethod( MakeDerivationGraph,
               [ IsDenseList ],
function( operations )
  local G, op_name;
  G := rec( derivations_by_target := rec(),
              derivations_by_used_ops := rec() );
  G := ObjectifyWithAttributes( G, TheTypeOfDerivationsGraphs );
  
  SetOperations( G, operations );
  
  for op_name in operations do
    G!.derivations_by_target.( op_name ) := [];
    G!.derivations_by_used_ops.( op_name ) := [];
  od;
  
  # derivations not using any operations
  G!.derivations_by_used_ops.none := [];
  
  return G;
end );

InstallMethod( AddOperationsToDerivationGraph,
               [ IsDerivedMethodGraph, IsDenseList ],
               
  function( graph, operations )
    local op_name;
    
    Append( Operations( graph ), operations );
    
    for op_name in operations do
        
        graph!.derivations_by_target.( op_name ) := [];
        graph!.derivations_by_used_ops.( op_name ) := [];
        
    od;
    
end );

InstallMethod( String,
               [ IsDerivedMethodGraph ],
function( G )
  return "derivation graph";
end );

InstallMethod( ViewObj,
               [ IsDerivedMethodGraph ],
function( G )
  Print( "<", String( G ), ">" );
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsDerivedMethod ],
function( G, d )
  local method_name, filter_list, number_of_proposed_arguments, current_function_argument_number, target_op, x;
  
  if IsIdenticalObj( G, CAP_INTERNAL_DERIVATION_GRAPH ) then
    
    method_name := TargetOperation( d );
    
    if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(method_name) ) then
        
        Error( "trying to add a derivation to CAP_INTERNAL_DERIVATION_GRAPH for a method not in CAP_INTERNAL_METHOD_NAME_RECORD" );
        
    fi;
    
    filter_list := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).filter_list;
    
    number_of_proposed_arguments := Length( filter_list );
    
    current_function_argument_number := NumberArgumentsFunction( DerivationFunction( d ) );
    
    if current_function_argument_number >= 0 and current_function_argument_number <> number_of_proposed_arguments then
        Error( "While adding a derivation for ", method_name, ": given function has ", String( current_function_argument_number ),
               " arguments but should have ", String( number_of_proposed_arguments ) );
    fi;
    
  fi;
  
  target_op := TargetOperation( d );
  
  Add( G!.derivations_by_target.( target_op ), d );
  for x in UsedOperationsWithMultiplesAndCategoryGetters( d ) do
    # We add all operations, even those with category getters: In case the category getter
    # returns the category itself, this allows to recursively trigger derivations correctly.
    Add( G!.derivations_by_used_ops.( x[1] ), d );
  od;
  
  if IsEmpty( UsedOperationsWithMultiplesAndCategoryGetters( d ) ) then
    
    Add( G!.derivations_by_used_ops.none, d );
    
  fi;
  
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsFunction ],
               
  function( graph, target_op, func )
    
    AddDerivation( graph, target_op, fail, func );
    
end );

# Contrary to the documentation, for internal code we allow used_ops_with_multiples_and_category_getters to be equal to fail
# to distinguish the case of no preconditions given
InstallOtherMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsObject, IsFunction ],
               
  function( graph, target_op, used_ops_with_multiples_and_category_getters, func )
    local weight, category_filter, description, loop_multiplier, category_getters, function_called_before_installation, operations_in_graph, collected_list, used_op_names_with_multiples_and_category_getters, derivation, x;
    
    Assert( 0, used_ops_with_multiples_and_category_getters = fail or IsList( used_ops_with_multiples_and_category_getters ) );
    
    weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    loop_multiplier := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "WeightLoopMultiple", 2 );
    category_getters := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryGetters", rec( ) );
    function_called_before_installation := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "FunctionCalledBeforeInstallation", false );
    
    ## get used ops
    operations_in_graph := Operations( graph );
    
    used_op_names_with_multiples_and_category_getters := fail;
    
    #= comment for Julia
    collected_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( func, operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS, category_getters );
    
    if used_ops_with_multiples_and_category_getters = fail then
        
        used_op_names_with_multiples_and_category_getters := collected_list;
        
    fi;
    # =#
    
    if used_ops_with_multiples_and_category_getters <> fail then
        
        used_op_names_with_multiples_and_category_getters := [ ];
        
        for x in used_ops_with_multiples_and_category_getters do
            
            if Length( x ) < 2 or not IsFunction( x[1] ) or not IsInt( x[2] ) then
                
                Error( "preconditions must be of the form `[op, mult, getter]`, where `getter` is optional" );
                
            fi;
            
            if (Length( x ) = 2 or (Length( x ) = 3 and x[3] = fail)) and x[1] = target_op then
                
                Error( "A derivation for ", NameFunction( target_op ), " has itself as a precondition. This is not supported because we cannot compute a well-defined weight.\n" );
                
            fi;
            
            if Length( x ) = 2 then
                
                Add( used_op_names_with_multiples_and_category_getters, [ NameFunction( x[1] ), x[2], fail ] );
                
            elif Length( x ) = 3 then
                
                if x <> fail and not (IsFunction( x[3] ) and NumberArgumentsFunction( x[3] ) = 1) then
                    
                    Error( "the category getter must be a single-argument function" );
                    
                fi;
                
                Add( used_op_names_with_multiples_and_category_getters, [ NameFunction( x[1] ), x[2], x[3] ] );
                
            else
                
                Error( "The list of preconditions must be a list of pairs or triples." );
                
            fi;
            
        od;
        
        #= comment for Julia
        if Length( collected_list ) <> Length( used_op_names_with_multiples_and_category_getters ) or not ForAll( collected_list, c -> c in used_op_names_with_multiples_and_category_getters ) then
            
            SortBy( used_op_names_with_multiples_and_category_getters, x -> x[1] );
            SortBy( collected_list, x -> x[1] );
            
            Print(
                "WARNING: You have installed a derivation for ", NameFunction( target_op ), " with preconditions ", used_op_names_with_multiples_and_category_getters,
                " but the automated detection has detected the following list of preconditions: ", collected_list, ".\n",
                "If this is a bug in the automated detection, please report it.\n"
            );
            
        fi;
        # =#
        
    fi;
    
    if used_op_names_with_multiples_and_category_getters = fail then
        
        return;
        
    fi;
    
    derivation := MakeDerivation( description,
                                  target_op,
                                  used_op_names_with_multiples_and_category_getters,
                                  weight,
                                  func,
                                  category_filter );
    
    if function_called_before_installation <> false then
        
        SetFunctionCalledBeforeInstallation( derivation, function_called_before_installation );
        
    fi;
    
    AddDerivation( graph, derivation );
    
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsDenseList ],
               
  function( graph, target_op, implementations_with_extra_filters )
    
    Error( "passing a list of functions to `AddDerivation` is not supported anymore" );
    
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsDenseList, IsDenseList ],
               
  function( graph, target_op, used_ops_with_multiples, implementations_with_extra_filters )
    
    Error( "passing a list of functions to `AddDerivation` is not supported anymore" );
    
end );

InstallGlobalFunction( AddDerivationToCAP,
  
  function( arg )
    local list;
    
    list := Concatenation( [ CAP_INTERNAL_DERIVATION_GRAPH ], arg );
    
    CallFuncList( AddDerivation, list );
    
end );

InstallGlobalFunction( AddWithGivenDerivationPairToCAP,
  
  function( target_op, without_given_func, with_given_func )
    local without_given_name, with_given_name;
    
    without_given_name := NameFunction( target_op );
    
    with_given_name := CAP_INTERNAL_METHOD_NAME_RECORD.(without_given_name).with_given_without_given_name_pair[2];
    
    AddDerivationToCAP( target_op, without_given_func );
    AddDerivationToCAP( ValueGlobal( with_given_name ), with_given_func );
    
end );

InstallMethod( DerivationsUsingOperation,
               [ IsDerivedMethodGraph, IsString ],
function( G, op_name )
  return G!.derivations_by_used_ops.( op_name );
end );

InstallMethod( DerivationsOfOperation,
               [ IsDerivedMethodGraph, IsString ],
function( G, op_name )
  return G!.derivations_by_target.( op_name );
end );

InstallMethod( MakeOperationWeightList,
               [ IsCapCategory, IsDerivedMethodGraph ],
function( C, G )
  local operation_weights, operation_derivations, owl, op_name;
    
    operation_weights := rec( );
    operation_derivations := rec( );
    
    for op_name in Operations( G ) do
        operation_weights.( op_name ) := infinity;
        operation_derivations.( op_name ) := fail;
    od;
    
    owl := ObjectifyWithAttributes(
        rec( operation_weights := operation_weights, operation_derivations := operation_derivations ), TheTypeOfOperationWeightLists,
        DerivationGraph, G,
        CategoryOfOperationWeightList, C
    );
    
    return owl;
    
end );

InstallMethod( String,
               [ IsOperationWeightList ],
function( owl )
  return Concatenation( "operation weight list for ",
                        String( CategoryOfOperationWeightList( owl ) ) );
end );

InstallMethod( ViewObj,
               [ IsOperationWeightList ],
function( owl )
  Print( "<", String( owl ), ">" );
end );

InstallMethod( CurrentOperationWeight,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  if IsBound( owl!.operation_weights.( op_name ) ) then
      return owl!.operation_weights.( op_name );
  fi;
  return infinity;
end );

InstallMethod( OperationWeightUsingDerivation,
               [ IsOperationWeightList, IsDerivedMethod ],
function( owl, d )
  local category, category_operation_weights, weight, operation_weights, operation_name, operation_weight, x;
    
    category := CategoryOfOperationWeightList( owl );
    category_operation_weights := owl!.operation_weights;
    
    weight := DerivationWeight( d );
    
    for x in UsedOperationsWithMultiplesAndCategoryGetters( d ) do
        
        if x[3] = fail then
            
            operation_weights := category_operation_weights;
            
        else
            
            operation_weights := x[3](category)!.derivations_weight_list!.operation_weights;
            
        fi;
        
        operation_name := x[1];
        
        if not IsBound( operation_weights.(operation_name) ) then
            
            return infinity;
            
        fi;
        
        operation_weight := operation_weights.(operation_name);
        
        if operation_weight = infinity then
            
            return infinity;
            
        fi;
        
        weight := weight + operation_weight * x[2];
        
    od;
    
    return weight;
    
end );

InstallMethod( DerivationOfOperation,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  return owl!.operation_derivations.( op_name );
end );

BindGlobal( "TryToInstallDerivation", function ( owl, d )
  local new_weight, target, current_weight, current_derivation, derivations_of_target, new_pos, current_pos;
    
    if not IsApplicableToCategory( d, CategoryOfOperationWeightList( owl ) ) then
        return fail;
    fi;
    
    new_weight := OperationWeightUsingDerivation( owl, d );
    
    if new_weight = infinity then
        return fail;
    fi;
    
    target := TargetOperation( d );
    
    current_weight := CurrentOperationWeight( owl, target );
    current_derivation := DerivationOfOperation( owl, target );
    
    if current_derivation <> fail then
        
        derivations_of_target := DerivationsOfOperation( DerivationGraph( owl ), target );
        
        new_pos := PositionProperty( derivations_of_target, x -> IsIdenticalObj( x, d ) );
        current_pos := PositionProperty( derivations_of_target, x -> IsIdenticalObj( x, current_derivation ) );
        
        Assert( 0, new_pos <> fail );
        Assert( 0, current_pos <> fail );
        
    fi;

    if new_weight < current_weight or (new_weight = current_weight and current_derivation <> fail and new_pos < current_pos) then
        
        if not IsIdenticalObj( current_derivation, d ) then
            
            InstallDerivationForCategory( d, new_weight, CategoryOfOperationWeightList( owl ) );
            
        fi;
        
        owl!.operation_weights.( target ) := new_weight;
        owl!.operation_derivations.( target ) := d;
        
        return new_weight;
        
    else
        
        return fail;
        
    fi;
    
end );

InstallMethod( InstallDerivationsUsingOperation,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  local Q, derivations_to_install, node, new_weight, target, d;
    
    Q := StringMinHeap();
    Add( Q, op_name, 0 );
    
    while not IsEmptyHeap( Q ) do
        
        node := ExtractMin( Q );
        
        op_name := node[ 1 ];
        
        for d in DerivationsUsingOperation( DerivationGraph( owl ), op_name ) do
            
            new_weight := TryToInstallDerivation( owl, d );
            
            if new_weight <> fail then
                
                target := TargetOperation( d );
                
                if Contains( Q, target ) then
                    
                    DecreaseKey( Q, target, new_weight );
                    
                else
                    
                    Add( Q, target, new_weight );
                    
                fi;
                
            fi;
            
        od;
        
    od;
    
end );  

InstallMethod( Reevaluate,
               [ IsOperationWeightList ],
function( owl )
  local new_weight, op_name, d;
    
    for op_name in Operations( DerivationGraph( owl ) ) do
        
        for d in DerivationsOfOperation( DerivationGraph( owl ), op_name ) do
            
            new_weight := TryToInstallDerivation( owl, d );
            
            if new_weight <> fail then
                
                InstallDerivationsUsingOperation( owl, TargetOperation( d ) );
                
            fi;
            
        od;
        
    od;
    
end );

InstallMethod( Saturate,
               [ IsOperationWeightList ],
  function( owl )
    local current_weight_list;

    while true do
        current_weight_list := StructuralCopy( owl!.operation_weights );
        Reevaluate( owl );
        if current_weight_list = owl!.operation_weights then
            break;
        fi;
    od;

end );

InstallMethod( AddPrimitiveOperation,
               [ IsOperationWeightList, IsString, IsInt ],
function( owl, op_name, weight )
    
    Info( DerivationInfo, 1, Concatenation( "install(",
                                  String( weight ),
                                  ") ",
                                  op_name,
                                  ": primitive installation\n" ) );
    
    owl!.operation_weights.( op_name ) := weight;
    owl!.operation_derivations.( op_name ) := fail;
    
    InstallDerivationsUsingOperation( owl, op_name );
    
end );

InstallMethod( PrintDerivationTree,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  local print_node, get_children;
  print_node := function( node )
    local w, mult, op, d;
    mult := node[ 2 ];
    op := node[ 1 ];
    if op = fail then
      Print( "  ", mult );
      return;
    fi;
    w := CurrentOperationWeight( owl, op );
    d := DerivationOfOperation( owl, op );
    if mult <> fail then
      Print( "+ ", mult, " * " );
    fi;
    if w = infinity then
      Print( "(not installed)" );
    else
      Print( "(", w, ")" );
    fi;
    Print( " ", op );
    if w <> infinity then
      Print( " " );
      if d = fail then
        Print( "[primitive]" );
      else
        Print( "[derived:", DerivationName( d ), "]" );
      fi;
    fi;
  end;
  get_children := function( node )
    local op, d;
    op := node[ 1 ];
    if op = fail then
      return [];
    fi;
    d := DerivationOfOperation( owl, op );
    if d = fail then
      return [];
    else
      return Concatenation( [ [ fail, DerivationWeight( d ) ] ],
                            UsedOperationsWithMultiplesAndCategoryGetters( d ) );
    fi;
  end;
  PrintTree( [ op_name, fail ],
             print_node,
             get_children );
end );


InstallGlobalFunction( StringMinHeap,
function()
  return Objectify( TheTypeOfStringMinHeaps,
                    rec( key := function(n) return n[2]; end,
                         str := function(n) return n[1]; end,
                         array := [],
                         node_indices := rec() ) );
end );

InstallMethod( String,
               [ IsStringMinHeap ],
function( H )
  return Concatenation( "min heap for strings, with size ",
                        String( HeapSize( H ) ) );
end );

InstallMethod( ViewObj,
               [ IsStringMinHeap ],
function( H )
  Print( "<", String( H ), ">" );
end );

InstallMethod( HeapSize,
               [ IsStringMinHeap ],
function( H )
  return Length( H!.array );
end );

InstallMethod( Add,
               [ IsStringMinHeap, IsString, IsInt ],
function( H, string, key )
  local array;
  array := H!.array;
  Add( array, [ string, key ] );
  H!.node_indices.( string ) := Length( array );
  DecreaseKey( H, string, key );
end );

InstallMethod( IsEmptyHeap,
               [ IsStringMinHeap ],
function( H )
  return IsEmpty( H!.array );
end );

InstallMethod( ExtractMin,
               [ IsStringMinHeap ],
function( H )
  local array, node, key;
  array := H!.array;
  node := array[ 1 ];
  Swap( H, 1, Length( array ) );
  Remove( array );
  key := H!.str( node );
  Unbind( H!.node_indices.( key ) );
  if not IsEmpty( array ) then
    Heapify( H, 1 );
  fi;
  return node;
end );

InstallMethod( DecreaseKey,
               [ IsStringMinHeap, IsString, IsInt ],
function( H, string, key )
  local array, i, parent;
  array := H!.array;
  i := H!.node_indices.( string );
  array[ i ][ 2 ] := key;
  parent := Int( i / 2 );
  while parent > 0 and H!.key( array[ i ] ) < H!.key( array[ parent ] ) do
    Swap( H, i, parent );
    i := parent;
    parent := Int( i / 2 );
  od;
end );

InstallMethod( Swap,
               [ IsStringMinHeap, IsPosInt, IsPosInt ],
function( H, i, j )
  local array, node_indices, str, tmp, key;
  array := H!.array;
  node_indices := H!.node_indices;
  str := H!.str;
  tmp := array[ i ];
  array[ i ] := array[ j ];
  array[ j ] := tmp;
  key := str( array[ i ] );
  node_indices.( key ) := i;
  key := str( array[ j ] );
  node_indices.( key ) := j;
end );

InstallMethod( Contains,
               [ IsStringMinHeap, IsString ],
function( H, string )
  return IsBound( H!.node_indices.( string ) );
end );

InstallMethod( Heapify,
               [ IsStringMinHeap, IsPosInt ],
function( H, i )
  local key, array, left, right, smallest;
  key := H!.key;
  array := H!.array;
  left := 2 * i;
  right := 2 * i + 1;
  smallest := i;
  if left <= HeapSize( H ) and key( array[ left ] ) < key( array[ smallest ] ) then
    smallest := left;
  fi;
  if right <= HeapSize( H ) and key( array[ right ] ) < key( array[ smallest ] ) then
    smallest := right;
  fi;
  if smallest <> i then
    Swap( H, i, smallest );
    Heapify( H, smallest );
  fi;
end );


InstallMethod( PrintTree,
               [ IsObject, IsFunction, IsFunction ],
function( root, print_node, get_children )
  PrintTreeRec( root, print_node, get_children, 0 );
end );

InstallMethod( PrintTreeRec,
               [ IsObject, IsFunction, IsFunction, IsInt ],
function( node, print_node, get_children, level )
  local i, child;
  for i in [ 1 .. level ] do
    Print( "   " );
  od;
  print_node( node );
  Print( "\n" );
  for child in get_children( node ) do
    PrintTreeRec( child, print_node, get_children, level + 1 );
  od;
end );

#################################
##
## Some print functions
##
#################################

##
InstallGlobalFunction( InstalledMethodsOfCategory,
  
  function( cell )
    local weight_list, list_of_methods, i, current_weight, can_compute, cannot_compute;
    
    if IsCapCategory( cell ) then
        weight_list := cell!.derivations_weight_list;
    elif IsCapCategoryCell( cell ) then
        weight_list := CapCategory( cell )!.derivations_weight_list;
    else
        Error( "Input must be a category or a cell" );
    fi;
    
    list_of_methods := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    list_of_methods := AsSortedList( list_of_methods );
    
    can_compute := [ ];
    cannot_compute := [ ];
    
    for i in list_of_methods do
        
        current_weight := CurrentOperationWeight( weight_list, i );
        
        if current_weight < infinity then
            Add( can_compute, [ i, current_weight ] );
        else
            Add( cannot_compute, i );
        fi;
        
    od;
    
    Print( "Can do the following basic methods at the moment:\n" );
    
    for i in can_compute do
        Print( "+ ", i[ 1 ], ", weight ", String( i[ 2 ] ), "\n" );
    od;
    
    Print( "\nThe following is still missing:\n" );
    
    for i in cannot_compute do
        Print( "- ", i, "\n" );
    od;
    
    Print( "\nPlease use DerivationsOfMethodByCategory( <category>, <name> ) to get\n",
           "information about how to add the missing methods\n" );
    
end );

##
InstallGlobalFunction( DerivationsOfMethodByCategory,
  
  function( category, name )
    local category_weight_list, current_weight, current_derivation, currently_installed_funcs, to_delete, weight_list, category_getter_string, possible_derivations, category_filter, weight, i, x;
    
    if IsFunction( name ) then
        name := NameFunction( name );
    fi;
    
    if not IsString( name ) then
        Error( "Usage is <category>,<string> or <category>,<CAP operation>\n" );
        return;
    fi;
    
    if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(name) ) then
        Error( name, " is not the name of a CAP operation." );
        return;
    fi;
    
    category_weight_list := category!.derivations_weight_list;
    
    current_weight := CurrentOperationWeight( category_weight_list, name );
    
    if current_weight < infinity then
    
        current_derivation := DerivationOfOperation( category_weight_list, name );
        
        Print( Name( category ), " can already compute ", TextAttr.b4, name, TextAttr.reset, " with weight " , current_weight, ".\n" );
        
        if current_derivation = fail then
            
            if IsBound( category!.primitive_operations.( name ) ) and category!.primitive_operations.( name ) = true then
                
                Print( "It was given as a primitive operation.\n" );
                
            else
                
                Print( "It was installed as a final or precompiled derivation.\n" );
                
            fi;
            
            currently_installed_funcs := category!.added_functions.( name );
            
            # delete overwritten funcs
            to_delete := [ ];
            
            for i in [ 1 .. Length( currently_installed_funcs ) ] do
                
                if ForAny( [ (i+1) .. Length( currently_installed_funcs ) ], j -> currently_installed_funcs[i][2] = currently_installed_funcs[j][2] ) then
                    
                    Add( to_delete, i );
                    
                fi;
                
            od;
            
            currently_installed_funcs := currently_installed_funcs{Difference( [ 1 .. Length( currently_installed_funcs ) ], to_delete )};
            
        else
            
            Print( "It was derived by ", TextAttr.b3, DerivationName( current_derivation ), TextAttr.reset, " using \n" );
            
            for x in UsedOperationsWithMultiplesAndCategoryGetters( current_derivation ) do
                
                if x[3] = fail then
                    
                    weight_list := category_weight_list;
                    category_getter_string := "";
                    
                else
                    
                    weight_list := x[3](category)!.derivations_weight_list;
                    category_getter_string := Concatenation( " in category obtained by applying ", String( x[3] ) );
                    
                fi;
                
                Print( "* ", TextAttr.b2, x[1], TextAttr.reset, " (", x[2], "x)", category_getter_string );
                Print( " installed with weight ", String( CurrentOperationWeight( weight_list, x[1] ) ) );
                Print( "\n" );
                
            od;
            
            currently_installed_funcs := [ Pair( DerivationFunction( current_derivation ), [ ] ) ];
            
        fi;
        
        Print( "\nThe following function" );
        
        if Length( currently_installed_funcs ) > 1 then
            Print( "s were" );
        else
            Print( " was" );
        fi;
        
        Print( " installed for this operation:\n\n" );
        
        for i in currently_installed_funcs do
            
            Print( "Filters: " );
            Print( String( i[ 2 ] ) );
            Print( "\n\n" );
            Display( i[ 1 ] );
            Print( "\n" );
            Print( "Source: ", FilenameFunc( i[ 1 ] ), ":", StartlineFunc( i[ 1 ] ), "\n" );
            Print( "\n" );
            
        od;
        
        Print( "#######\n\n" );
        
    else
        
        Print( TextAttr.b4, name, TextAttr.reset, " is currently not installed for ", Name( category ), ".\n\n" );
        
    fi;
    
    Print( "Possible derivations are:\n\n" );
    
    possible_derivations := DerivationsOfOperation( CAP_INTERNAL_DERIVATION_GRAPH, name );
    
    for current_derivation in possible_derivations do
        
        category_filter := CategoryFilter( current_derivation );
        
        if IsProperty( category_filter ) and Tester( category_filter )( category ) and not category_filter( category ) then
            continue;
        elif IsProperty( category_filter ) and not Tester( category_filter )( category ) then
            Print( "If ", Name( category ), " would be ", JoinStringsWithSeparator( Filtered( NamesFilter( category_filter ), name -> not StartsWith( name, "Has" ) ), " and " ), " then\n" );
            Print( TextAttr.b4, name, TextAttr.reset, " could be derived by\n" );
        elif IsFunction( category_filter ) and not category_filter( category ) then
            continue;
        else
            Print( TextAttr.b4, name, TextAttr.reset, " can be derived by\n" );
        fi;
        
        for x in UsedOperationsWithMultiplesAndCategoryGetters( current_derivation ) do
            
            if x[3] = fail then
                
                weight_list := category_weight_list;
                category_getter_string := "";
                
            else
                
                weight_list := x[3](category)!.derivations_weight_list;
                category_getter_string := Concatenation( " in category obtained by applying ", String( x[3] ) );
                
            fi;
            
            weight := CurrentOperationWeight( weight_list, x[1] );
            
            if weight < infinity then
                Print( "* ", TextAttr.b2, x[1], TextAttr.reset, " (", x[2], "x)", category_getter_string, ", (already installed with weight ", weight,")" );
            else
                Print( "* ", TextAttr.b1, x[1], TextAttr.reset, " (", x[2], "x)", category_getter_string );
            fi;
            
            Print( "\n" );
            
        od;
        
        Print( "with additional weight ", DerivationWeight( current_derivation ), ".\n\n" );
        
    od;
    
end );

InstallGlobalFunction( ListPrimitivelyInstalledOperationsOfCategory,
  
  function( arg )
    local cat, filter, names;
    
    if Length( arg ) < 1 then
        Error( "first argument needs to be <category>" );
    fi;
    
    cat := arg[ 1 ];
    
    if Length( arg ) > 1 then
        filter := arg[ 2 ];
    else
        filter := fail;
    fi;
    
    if IsCapCategoryCell( cat ) then
        cat := CapCategory( cat );
    fi;
    
    if not IsCapCategory( cat ) then
        Error( "input must be category or cell" );
    fi;
    
    names := Filtered( RecNames( cat!.primitive_operations ), x -> cat!.primitive_operations.(x) );
    
    if filter <> fail then
        names := Filtered( names, i -> PositionSublist( i, filter ) <> fail );
    fi;
    
    return AsSortedList( names );
    
end );

InstallGlobalFunction( ListInstalledOperationsOfCategory,
  
  function( arg )
    local category, filter, weight_list, list_of_methods, list_of_installed_methods;
    
    if Length( arg ) < 1 then
        Error( "first argument needs to be <category>" );
    fi;
    
    category := arg[ 1 ];
    
    if Length( arg ) > 1 then
        filter := arg[ 2 ];
    else
        filter := fail;
    fi;
    
    if IsCapCategoryCell( category ) then
        category := CapCategory( category );
    fi;
    
    if not IsCapCategory( category ) then
        Error( "input is not a category (cell)" );
        return;
    fi;
    
    weight_list := category!.derivations_weight_list;
    
    list_of_methods := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    list_of_methods := AsSortedList( list_of_methods );
    
    list_of_methods := Filtered( list_of_methods, i -> CurrentOperationWeight( weight_list, i ) < infinity );
    
    if filter <> fail then
        list_of_methods := Filtered( list_of_methods, i -> PositionSublist( i, filter ) <> fail );
    fi;
    
    return list_of_methods;
    
end );
