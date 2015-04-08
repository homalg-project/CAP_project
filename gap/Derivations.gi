#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Managing derived methods
#!
##
#############################################################################

DeclareRepresentation( "IsDerivationRep",
                       IsAttributeStoringRep and IsDerivation,
                       [] );
DeclareRepresentation( "IsDerivationGraphRep",
                       IsAttributeStoringRep and IsDerivationGraph,
                       [] );
DeclareRepresentation( "IsOperationWeightListRep",
                       IsAttributeStoringRep and IsOperationWeightList,
                       [] );

BindGlobal( "TheFamilyOfDerivations",
            NewFamily( "TheFamilyOfDerivations" ) );
BindGlobal( "TheFamilyOfDerivationGraphs",
            NewFamily( "TheFamilyOfDerivationGraphs" ) );
BindGlobal( "TheFamilyOfOperationWeightLists",
            NewFamily( "TheFamilyOfOperationWeightLists" ) );


InstallGlobalFunction( "ActivateDerivationInfo",
  function( )
    SetInfoLevel( DerivationInfo, 1 );
end );

InstallGlobalFunction( "DeactivateDerivationInfo",
  function( )
    SetInfoLevel( DerivationInfo, 0 );
end );

InstallMethod( MakeDerivation,
               [ IsString, IsFunction, IsDenseList,
                 IsPosInt, IsDenseList, IsFunction ],
function( name, target_op, used_ops_with_multiples,
          weight, implementations_with_extra_filters,
          category_filter )
  local d, used_ops, used_op_multiples, used_op_names_with_multiples;
  d := rec();
  used_ops := List( used_ops_with_multiples,
                    l -> NameFunction( l[ 1 ] ) );
  used_op_multiples := List( used_ops_with_multiples, l -> l[ 2 ] );
  used_op_names_with_multiples :=
    List( used_ops_with_multiples,
          l -> [ NameFunction( l[ 1 ] ), l[ 2 ] ] );
  ObjectifyWithAttributes
    ( d,
      NewType( TheFamilyOfDerivations, IsDerivationRep ),
      DerivationName, name,
      DerivationWeight, weight,
      DerivationFunctionsWithExtraFilters, implementations_with_extra_filters,
      CategoryFilter, category_filter,
      TargetOperation, NameFunction( target_op ),
      UsedOperations, used_ops,
      UsedOperationsWithMultiples, used_op_names_with_multiples,
      UsedOperationMultiples, used_op_multiples );
  # TODO options
  return d;
end );

InstallMethod( String,
               [ IsDerivation ],
function( d )
  return Concatenation( "derivation ", DerivationName( d ),
                        " of operation ", TargetOperation( d ) );
end );

InstallMethod( ViewObj,
               [ IsDerivation ],
function( d )
  Print( "<", String( d ), ">" );
end );

InstallMethod( IsApplicableToCategory,
               [ IsDerivation, IsCapCategory ],
function( d, C )
  local filter;
  filter := CategoryFilter( d );
  return Tester( filter )( C ) and filter( C );
end );

InstallMethod( InstallDerivationForCategory,
               [ IsDerivation, IsPosInt, IsCapCategory ],
function( d, weight, C )
  local method_name, general_filter_list, installation_name, nr_arguments,
        cache_name, current_implementation, current_filters;
  
  Info( DerivationInfo, 1, Concatenation( "install(",
                                          String( weight ),
                                          ") ",
                                          TargetOperation( d ),
                                          ": ",
                                          DerivationName( d ), "\n" ) );
  
  method_name := TargetOperation( d );
  ## getting the filters and installation name from the record
  general_filter_list := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).filter_list;
  installation_name := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).installation_name;
  general_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( general_filter_list, C );
  
  nr_arguments := Length( general_filter_list );
  if nr_arguments > 1 then
    cache_name := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).cache_name;
    PushOptions( rec( InstallMethod := InstallMethodWithCache,
                      Cache := GET_METHOD_CACHE( C, cache_name, nr_arguments ) ) );
  fi;
  
  for current_implementation in DerivationFunctionsWithExtraFilters( d ) do
      
      current_filters := CAP_INTERNAL_MERGE_FILTER_LISTS( general_filter_list, 
                                                          current_implementation[ 2 ] );
      
      InstallMethodWithToDoForIsWellDefined( ValueGlobal( installation_name ),
                                             current_filters,
                                             current_implementation[ 1 ] );
  od;
  
  if nr_arguments > 1 then
      PopOptions( );
  fi;
  
end );

InstallMethod( DerivationResultWeight,
               [ IsDerivation, IsDenseList ],
function( d, op_weights )
  local w, used_op_multiples, i, op_w, mult;
  w := DerivationWeight( d );
  used_op_multiples := UsedOperationMultiples( d );
  for i in [ 1 .. Length( used_op_multiples ) ] do
    op_w := op_weights[ i ];
    mult := used_op_multiples[ i ];
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
  ObjectifyWithAttributes
    ( G,
      NewType( TheFamilyOfDerivationGraphs,
               IsDerivationGraphRep ),
      Operations, operations );
  for op_name in operations do
    G!.derivations_by_target.( op_name ) := [];
    G!.derivations_by_used_ops.( op_name ) := [];
  od;
  return G;
end );

InstallMethod( String,
               [ IsDerivationGraph ],
function( G )
  return "derivation graph";
end );

InstallMethod( ViewObj,
               [ IsDerivationGraph ],
function( G )
  Print( "<", String( G ), ">" );
end );

InstallMethod( AddDerivation,
               [ IsDerivationGraphRep, IsDerivation ],
function( G, d )
  local op_name;
  Add( G!.derivations_by_target.( TargetOperation( d ) ), d );
  for op_name in UsedOperations( d ) do
    Add( G!.derivations_by_used_ops.( op_name ), d );
  od;
end );

InstallMethod( AddDerivation,
               [ IsDerivationGraph, IsFunction, IsDenseList, IsFunction ],
               
  function( graph, target_op, used_ops_with_multiples,
            implementations_with_extra_filters )
    
    AddDerivation( graph,
                  target_op,
                  used_ops_with_multiples,
                  [ implementations_with_extra_filters, [ ] ] );
    
end );

BindGlobal( "CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT",
    
  function( option_name, default )
    local value;
    
    value := ValueOption( option_name );
    
    if value = fail then
        return default;
    fi;
    
    return value;
end );

InstallMethod( AddDerivation,
               [ IsDerivationGraph, IsFunction, IsDenseList, IsDenseList ],
               
  function( graph, target_op, used_ops_with_multiples,
            implementations_with_extra_filters )
    local weight, category_filter, description, derivation;
    
    weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    
    derivation := MakeDerivation( description,
                                  target_op,
                                  used_ops_with_multiples,
                                  weight,
                                  implementations_with_extra_filters,
                                  category_filter );
    
    AddDerivation( graph, derivation );
end );

InstallGlobalFunction( AddDerivationToCAP,
  
  function( arg )
    local list;
    
    list := Concatenation( [ CAP_INTERNAL_DERIVATION_GRAPH ], arg );
    
    CallFuncList( AddDerivation, list );
    
end );

InstallMethod( DerivationsUsingOperation,
               [ IsDerivationGraphRep, IsString ],
function( G, op_name )
  return G!.derivations_by_used_ops.( op_name );
end );

InstallMethod( DerivationsOfOperation,
               [ IsDerivationGraphRep, IsString ],
function( G, op_name )
  return G!.derivations_by_target.( op_name );
end );

InstallMethod( MakeOperationWeightList,
               [ IsCapCategory, IsDerivationGraph ],
function( C, G )
  local owl, op_name;
  owl := Objectify( NewType( TheFamilyOfOperationWeightLists,
                             IsOperationWeightListRep ),
                    rec( operation_weights := rec(),
                         operation_derivations := rec() ) );
  for op_name in Operations( G ) do
    owl!.operation_weights.( op_name ) := infinity;
    owl!.operation_derivations.( op_name ) := fail;
  od;
  SetDerivationGraph( owl, G );
  SetCategoryOfOperationWeightList( owl, C );
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
               [ IsOperationWeightListRep, IsString ],
function( owl, op_name )
  return owl!.operation_weights.( op_name );
end );

InstallMethod( OperationWeightUsingDerivation,
               [ IsOperationWeightList, IsDerivation ],
function( owl, d )
  return DerivationResultWeight
         ( d, List( UsedOperations( d ),
                    op_name -> CurrentOperationWeight( owl, op_name ) ) );
end );

InstallMethod( DerivationOfOperation,
               [ IsOperationWeightListRep, IsString ],
function( owl, op_name )
  return owl!.operation_derivations.( op_name );
end );

InstallMethod( InstallDerivationsUsingOperation,
               [ IsOperationWeightListRep, IsString ],
function( owl, op_name )
  local Q, node, weight, d, new_weight, max_weight,
        target, new_node;
  Q := StringMinHeap();
  Add( Q, op_name, 0 );
  while not IsEmptyHeap( Q ) do
    node := ExtractMin( Q );
    op_name := node[ 1 ];
    weight := node[ 2 ];
    for d in DerivationsUsingOperation( DerivationGraph( owl ), op_name ) do
      if not IsApplicableToCategory( d, CategoryOfOperationWeightList( owl ) ) then
        continue;
      fi;
      new_weight := OperationWeightUsingDerivation( owl, d );
      target := TargetOperation( d );
      if new_weight < CurrentOperationWeight( owl, target ) then
        InstallDerivationForCategory( d, new_weight, CategoryOfOperationWeightList( owl ) );
        if Contains( Q, target ) then
          DecreaseKey( Q, target, new_weight );
        else
          Add( Q, target, new_weight );
        fi;
        owl!.operation_weights.( target ) := new_weight;
        owl!.operation_derivations.( target ) := d;
      fi;
    od;
  od;
end );  

InstallMethod( Reevaluate,
               [ IsOperationWeightList ],
function( owl )
  local op_name;
  for op_name in Operations( DerivationGraph( owl ) ) do
    if CurrentOperationWeight( owl, op_name ) < infinity then
      InstallDerivationsUsingOperation( owl, op_name );
    fi;
  od;
end );

InstallMethod( AddPrimitiveOperation,
               [ IsOperationWeightListRep, IsString, IsInt ],
function( owl, op_name, weight )
  owl!.operation_weights.( op_name ) := weight;
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
                            UsedOperationsWithMultiples( d ) );
    fi;
  end;
  PrintTree( [ op_name, fail ],
             print_node,
             get_children );
end );


DeclareRepresentation( "IsStringMinHeapRep",
                       IsComponentObjectRep and IsStringMinHeap,
                       [] );

BindGlobal( "TheFamilyOfStringMinHeaps",
            NewFamily( "TheFamilyOfStringMinHeaps" ) );

InstallGlobalFunction( StringMinHeap,
function()
  return Objectify( NewType( TheFamilyOfStringMinHeaps,
                             IsStringMinHeapRep ),
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
               [ IsStringMinHeapRep ],
function( H )
  return Length( H!.array );
end );

InstallMethod( Add,
               [ IsStringMinHeapRep, IsString, IsInt ],
function( H, string, key )
  local array, i;
  array := H!.array;
  i := Length( array ) + 1;
  H!.node_indices.( string ) := i;
  array[ i ] := [ string, key ];
  DecreaseKey( H, string, key );
end );

InstallMethod( IsEmptyHeap,
               [ IsStringMinHeapRep ],
function( H )
  return IsEmpty( H!.array );
end );

InstallMethod( ExtractMin,
               [ IsStringMinHeapRep ],
function( H )
  local array, node;
  array := H!.array;
  node := array[ 1 ];
  Swap( H, 1, Length( array ) );
  Unbind( array[ Length( array ) ] );
  Unbind( H!.node_indices.( H!.str( node ) ) );
  if not IsEmpty( array ) then
    Heapify( H, 1 );
  fi;
  return node;
end );

InstallMethod( DecreaseKey,
               [ IsStringMinHeapRep, IsString, IsInt ],
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
               [ IsStringMinHeapRep, IsPosInt, IsPosInt ],
function( H, i, j )
  local tmp, array, node_indices, str;
  array := H!.array;
  node_indices := H!.node_indices;
  str := H!.str;
  tmp := array[ i ];
  array[ i ] := array[ j ];
  array[ j ] := tmp;
  node_indices.( str( array[ i ] ) ) := i;
  node_indices.( str( array[ j ] ) ) := j;
end );

InstallMethod( Contains,
               [ IsStringMinHeapRep, IsString ],
function( H, string )
  return IsBound( H!.node_indices.( string ) );
end );

InstallMethod( Heapify,
               [ IsStringMinHeapRep, IsPosInt ],
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
