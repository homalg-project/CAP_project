# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Managing Derived Methods

DeclareRepresentation( "IsDerivedMethodRep",
                       IsAttributeStoringRep and IsDerivedMethod,
                       [] );
DeclareRepresentation( "IsDerivedMethodGraphRep",
                       IsAttributeStoringRep and IsDerivedMethodGraph,
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
      NewType( TheFamilyOfDerivations, IsDerivedMethodRep ),
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
  local filter;
  filter := CategoryFilter( d );
  if IsFilter( filter ) then
      return Tester( filter )( C ) and filter( C );
  elif IsFunction( filter ) then
      return filter( C );
  else
      Error( "Category filter is not a filter or function" );
  fi;
end );

InstallMethod( InstallDerivationForCategory,
               [ IsDerivedMethod, IsPosInt, IsCapCategory ],
function( d, weight, C )
  local method_name, implementation_list, add_method, add_name, general_filter_list,
        installation_name, nr_arguments, cache_name, current_filters, current_implementation,
        function_called_before_installation;
  
  Info( DerivationInfo, 1, Concatenation( "install(",
                                          String( weight ),
                                          ") ",
                                          TargetOperation( d ),
                                          ": ",
                                          DerivationName( d ), "\n" ) );
  
  method_name := TargetOperation( d );
  implementation_list := DerivationFunctionsWithExtraFilters( d );
  add_name := Concatenation( "Add", method_name );
  ## getting the filters and installation name from the record
  
#   if not IsBoundGlobal( add_name ) then
#       
#       general_filter_list := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).filter_list;
#       installation_name := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).installation_name;
#       general_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( general_filter_list, C );
#       
#       nr_arguments := Length( general_filter_list );
#       if nr_arguments > 1 then
#         cache_name := CAP_INTERNAL_METHOD_NAME_RECORD.(method_name).cache_name;
#         PushOptions( rec( InstallMethod := InstallMethodWithCache,
#                           Cache := GET_METHOD_CACHE( C, cache_name, nr_arguments ) ) );
#       fi;
#       
#       for current_implementation in implementation_list do
#           
#           current_filters := CAP_INTERNAL_MERGE_FILTER_LISTS( general_filter_list, 
#                                                               current_implementation[ 2 ] );
#           
#           InstallMethodWithToDoForIsWellDefined( ValueGlobal( installation_name ),
#                                                 current_filters,
#                                                 current_implementation[ 1 ] );
#       od;
#       
#       if nr_arguments > 1 then
#           PopOptions( );
#       fi;
#       
#   else
      if HasFunctionCalledBeforeInstallation( d ) then
          
          FunctionCalledBeforeInstallation( d )( C );
          
      fi;
      
      add_method := ValueGlobal( add_name );
      add_method( C, implementation_list, weight : SetPrimitive := false, IsDerivation := true );
      
#   fi;
  
end );

InstallMethod( DerivationResultWeight,
               [ IsDerivedMethod, IsDenseList ],
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
               IsDerivedMethodGraphRep ) );
  
  SetOperations( G, operations );
  
  for op_name in operations do
    G!.derivations_by_target.( op_name ) := [];
    G!.derivations_by_used_ops.( op_name ) := [];
  od;
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
               [ IsDerivedMethodGraphRep, IsDerivedMethod ],
function( G, d )
  local method_name, filter_list, number_of_proposed_arguments, current_function_argument_number, current_additional_filter_list_length, impl, op_name;
  
  if IsIdenticalObj( G, CAP_INTERNAL_DERIVATION_GRAPH ) then
    
    method_name := TargetOperation( d );
    
    if not method_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
        
        Error( "trying to add a derivation to CAP_INTERNAL_DERIVATION_GRAPH for a method not in CAP_INTERNAL_METHOD_NAME_RECORD" );
        
    fi;
    
    filter_list := CAP_INTERNAL_METHOD_NAME_RECORD!.(method_name).filter_list;
    
    number_of_proposed_arguments := Length( filter_list );
    
    for impl in DerivationFunctionsWithExtraFilters( d ) do
        
        current_function_argument_number := NumberArgumentsFunction( impl[ 1 ] );
        
        if current_function_argument_number >= 0 and current_function_argument_number <> number_of_proposed_arguments then
            Error( "While adding a derivation for ", method_name, ": given function has ", String( current_function_argument_number ),
                   " arguments but should have ", String( number_of_proposed_arguments ) );
        fi;
        
        current_additional_filter_list_length := Length( impl[ 2 ] );
        
        if current_additional_filter_list_length > 0 and current_additional_filter_list_length <> number_of_proposed_arguments then
            Error( "While adding a derivation for ", method_name, ": there are ", String( current_additional_filter_list_length ),
                   " additional filters but there should be ", String( number_of_proposed_arguments ), " (or none)" );
        fi;
        
    od;
    
    if NumberArgumentsFunction( CategoryFilter( d ) ) = 0 or NumberArgumentsFunction( CategoryFilter( d ) ) > 1 then
        
        Error( "the CategoryFilter of a derivation must accept exactly one argument" );
        
    fi;
    
  fi;
  
  Add( G!.derivations_by_target.( TargetOperation( d ) ), d );
  for op_name in UsedOperations( d ) do
    Add( G!.derivations_by_used_ops.( op_name ), d );
  od;
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsFunction ],
               
  function( graph, target_op, implementations_with_extra_filters )
    
    AddDerivation( graph,
                   target_op,
                   [ ],
                   [ [ implementations_with_extra_filters, [ ] ] ] );
                   
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsDenseList ],
               
  function( graph, target_op, implementations_with_extra_filters )
    
    AddDerivation( graph,
                   target_op,
                   [ ],
                   [ [ implementations_with_extra_filters, [ ] ] ] );
                   
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsDenseList, IsFunction ],
               
  function( graph, target_op, used_ops_with_multiples,
            implementations_with_extra_filters )
    
    AddDerivation( graph,
                  target_op,
                  used_ops_with_multiples,
                  [ [ implementations_with_extra_filters, [ ] ] ] );
    
end );

InstallMethod( AddDerivation,
               [ IsDerivedMethodGraph, IsFunction, IsDenseList, IsDenseList ],
               
  function( graph, target_op, used_ops_with_multiples,
            implementations_with_extra_filters )
    local weight, category_filter, description, derivation, collected_list,
          operations_in_graph, current_list, current_implementation, loop_multiplier,
          preconditions_complete, function_called_before_installation;
    
    weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    loop_multiplier := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "WeightLoopMultiple", 2 );
    preconditions_complete := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "ConditionsListComplete", false );
    function_called_before_installation := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "FunctionCalledBeforeInstallation", false );
    
    ## get used ops
    ## Is this the right place? Or should this only be done when no ops are given?
    operations_in_graph := Operations( graph );
    
    collected_list := [ ];
    
    if preconditions_complete = false then
        for current_implementation in implementations_with_extra_filters do

            current_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( current_implementation[ 1 ], operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS );
            current_list := List( current_list, i -> [ ValueGlobal( i[ 1 ] ), i[2] ]);
            collected_list := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, current_list );

        od;
    fi;
    
    used_ops_with_multiples := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, used_ops_with_multiples );
    
    derivation := MakeDerivation( description,
                                  target_op,
                                  used_ops_with_multiples,
                                  weight,
                                  implementations_with_extra_filters,
                                  category_filter );
    
    if function_called_before_installation <> false then
        
        SetFunctionCalledBeforeInstallation( derivation, function_called_before_installation );
        
    fi;
    
    ## This sanity check should be obsolete
    # CAP_INTERNAL_DERIVATION_SANITY_CHECK( graph, derivation );
    
    AddDerivation( graph, derivation );
end );

InstallMethod( AddDerivationPair,
               [ IsDerivedMethodGraph, IsFunction, IsFunction, IsFunction, IsFunction ],
               
  function( graph, target_op1, target_op2, implementations_with_extra_filters1, implementations_with_extra_filters2 )
    
    Display( "WARNING: AddDerivationPair is deprecated and will not be supported after 2022.10.26. Please use AddDerivation instead.\n" );
    
    AddDerivationPair( graph,
                       target_op1,
                       target_op2,
                       [ ],
                       [ [ implementations_with_extra_filters1, [ ] ] ],
                       [ [ implementations_with_extra_filters2, [ ] ] ] );
                   
end );

InstallMethod( AddDerivationPair,
               [ IsDerivedMethodGraph, IsFunction, IsFunction, IsDenseList, IsDenseList ],
               
  function( graph, target_op1, target_op2, implementations_with_extra_filters1, implementations_with_extra_filters2 )
    
    Display( "WARNING: AddDerivationPair is deprecated and will not be supported after 2022.10.26. Please use AddDerivation instead.\n" );
    
    AddDerivationPair( graph,
                       target_op1,
                       target_op2,
                       [ ],
                       implementations_with_extra_filters1,
                       implementations_with_extra_filters2 );
                   
end );

InstallMethod( AddDerivationPair,
               [ IsDerivedMethodGraph, IsFunction, IsFunction, IsDenseList, IsFunction, IsFunction ],
               
  function( graph, target_op1, target_op2, used_ops_with_multiples,
            implementations_with_extra_filters1, implementations_with_extra_filters2 )
    
    Display( "WARNING: AddDerivationPair is deprecated and will not be supported after 2022.10.26. Please use AddDerivation instead.\n" );
    
    AddDerivationPair( graph,
                       target_op1,
                       target_op2,
                       used_ops_with_multiples,
                       [ [ implementations_with_extra_filters1, [ ] ] ],
                       [ [ implementations_with_extra_filters2, [ ] ] ] );
    
end );

InstallMethod( AddDerivationPair,
               [ IsDerivedMethodGraph, IsFunction, IsFunction, IsDenseList, IsDenseList, IsDenseList ],
               
  function( graph, target_op1, target_op2, used_ops_with_multiples,
            implementations_with_extra_filters1, implementations_with_extra_filters2 )
    local weight, category_filter, description, derivation1, derivation2, collected_list,
          operations_in_graph, current_list, current_implementation, loop_multiplier,
          preconditions_complete;
    
    Display( "WARNING: AddDerivationPair is deprecated and will not be supported after 2022.10.26. Please use AddDerivation instead.\n" );
    
    weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    loop_multiplier := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "WeightLoopMultiple", 2 );
    preconditions_complete := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "ConditionsListComplete", false );
    
    ## get used ops
    ## Is this the right place? Or should this only be done when no ops are given?
    operations_in_graph := Operations( graph );
    
    collected_list := [ ];
    
    if preconditions_complete = false then
        for current_implementation in Concatenation( implementations_with_extra_filters1, implementations_with_extra_filters2 ) do
            
            current_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( current_implementation[ 1 ], operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS );
            current_list := List( current_list, i -> [ ValueGlobal( i[ 1 ] ), i[ 2 ] ]);
            collected_list := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, current_list );
            
        od;
    fi;
    
    used_ops_with_multiples := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, used_ops_with_multiples );
    
    derivation1 := MakeDerivation( description,
                                  target_op1,
                                  used_ops_with_multiples,
                                  weight,
                                  implementations_with_extra_filters1,
                                  category_filter );
    
    derivation2 := MakeDerivation( description,
                                   target_op2,
                                   used_ops_with_multiples,
                                   weight,
                                   implementations_with_extra_filters2,
                                   category_filter );
    
    AddDerivation( graph, derivation1 );
    AddDerivation( graph, derivation2 );
    
end );

InstallGlobalFunction( AddDerivationToCAP,
  
  function( arg )
    local list;
    
    list := Concatenation( [ CAP_INTERNAL_DERIVATION_GRAPH ], arg );
    
    CallFuncList( AddDerivation, list );
    
end );

InstallGlobalFunction( AddDerivationPairToCAP,
  
  function( arg )
    
    Display( "WARNING: AddDerivationPairToCAP is deprecated and will not be supported after 2022.10.26. Please use AddDerivationToCAP instead.\n" );
    
    CallFuncList( AddDerivationPair, Concatenation( [ CAP_INTERNAL_DERIVATION_GRAPH ], arg ) );
    
end );

InstallGlobalFunction( AddWithGivenDerivationPairToCAP,
  
  function( arg )
    local op_without_given, op_with_given, recnames, new_arg, i, test_arg, func_arg;
    
    op_without_given := NameFunction( arg[ 1 ] );
    
    op_with_given := CAP_INTERNAL_METHOD_NAME_RECORD.(op_without_given).with_given_without_given_name_pair[ 2 ];
    
    ## Check whether arguments need to be filled
    
    test_arg := arg[ Length( arg ) - 1 ];
    
    if Length( arg ) = 2 or ( not IsFunction( test_arg ) and not ( IsList( test_arg ) and IsList( test_arg[ 1 ] ) ) ) then
        
        Print(
          Concatenation(
          "WARNING: AddWithGivenDerivationPairToCAP with a single function is deprecated and will not be supported after 2022.05.06. ",
          "Please use AddDerivationToCAP instead and make sure that suitable WithGiven derivations are installed.\n"
          )
        );
        
        # we only get one function -> leave the other for the usual WithGiven derivation
        CallFuncList( AddDerivationToCAP, arg );
        
        return;
        
    fi;
    
    if Length( arg ) = 3 and ForAll( arg, IsFunction ) then
        
        AddDerivationToCAP( arg[ 1 ], arg[ 2 ] );
        AddDerivationToCAP( ValueGlobal( op_with_given ), arg[ 3 ] );
        
        return;
        
    fi;
    
    Print(
      Concatenation(
      "WARNING: AddWithGivenDerivationPairToCAP is deprecated and will not be supported after 2022.10.26 except when passing exactly three functions.",
      "Please use AddDerivationToCAP instead.\n"
      )
    );
    
    new_arg := Concatenation( [ CAP_INTERNAL_DERIVATION_GRAPH, arg[ 1 ], ValueGlobal( op_with_given ) ], arg{[ 2 .. Length( arg ) ]} );
    
    CallFuncList( AddDerivationPair, new_arg );
    
end );

InstallMethod( DerivationsUsingOperation,
               [ IsDerivedMethodGraphRep, IsString ],
function( G, op_name )
  return G!.derivations_by_used_ops.( op_name );
end );

InstallMethod( DerivationsOfOperation,
               [ IsDerivedMethodGraphRep, IsString ],
function( G, op_name )
  return G!.derivations_by_target.( op_name );
end );

InstallMethod( MakeOperationWeightList,
               [ IsCapCategory, IsDerivedMethodGraph ],
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
  if IsBound( owl!.operation_weights.( op_name ) ) then
      return owl!.operation_weights.( op_name );
  fi;
  return infinity;
end );

InstallMethod( OperationWeightUsingDerivation,
               [ IsOperationWeightList, IsDerivedMethod ],
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
  local Q, node, weight, d, new_weight,
        target, current_weight, current_derivation,
        derivations_of_target, new_pos, current_pos;
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
      if new_weight = infinity then
        continue;
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
               [ IsOperationWeightListRep, IsString, IsInt ],
function( owl, op_name, weight )
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
    local string, weight_list, current_weight, current_derivation,
          currently_installed_funcs, to_delete, used_ops_with_multiples,
          possible_derivations, category_filter, i;
    
    if IsFunction( name ) then
        string := NameFunction( name );
    elif IsString( name ) then
        string := name;
    else
        Error( "Usage is <category>,<string> or <category>,<CAP operation>\n" );
        return;
    fi;
    
    if not IsBoundGlobal( string ) then
        Error( Concatenation( string, " is not bound globally." ) );
        return;
    fi;
    
    weight_list := category!.derivations_weight_list;
    
    current_weight := CurrentOperationWeight( weight_list, string );
    
    if current_weight < infinity then
    
        current_derivation := DerivationOfOperation( weight_list, string );
        
        Print( Name( category ), " can already compute ", TextAttr.b4, string, TextAttr.reset, " with weight " , String( current_weight ), ".\n" );
        
        if current_derivation = fail then
            
            if IsBound( category!.primitive_operations.( string ) ) and category!.primitive_operations.( string ) = true then
                
                Print( "It was given as a primitive operation.\n" );
                
            else
                
                Print( "It was installed as a final or precompiled derivation.\n" );
                
            fi;
            
            currently_installed_funcs := category!.added_functions.( string );
            
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
            
            used_ops_with_multiples := UsedOperationsWithMultiples( current_derivation );
            
            for i in used_ops_with_multiples do
                
                Print( "* ", TextAttr.b2, i[ 1 ], TextAttr.reset, " (", i[ 2 ], "x)" );
                Print( " installed with weight ", String( CurrentOperationWeight( weight_list, i[ 1 ] ) ) );
                Print( "\n" );
                
            od;
            
            currently_installed_funcs := DerivationFunctionsWithExtraFilters( current_derivation );
            
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
        
        Print( TextAttr.b4, string, TextAttr.reset, " is currently not installed for ", Name( category ), ".\n\n" );
        
    fi;
    
    Print( "Possible derivations are:\n\n" );
    
    possible_derivations := DerivationsOfOperation( CAP_INTERNAL_DERIVATION_GRAPH, string );
    
    for current_derivation in possible_derivations do
        
        category_filter := CategoryFilter( current_derivation );
        
        if IsFilter( category_filter ) and Tester( category_filter )( category ) and not category_filter( category ) then
            continue;
        elif IsFilter( category_filter ) and not Tester( category_filter )( category ) then
            Print( "If ", Name( category ), " would be ", JoinStringsWithSeparator( Filtered( NamesFilter( category_filter ), name -> not StartsWith( name, "Has" ) ), " and " ), " then\n" );
            Print( TextAttr.b4, string, TextAttr.reset, " could be derived by\n" );
        elif IsFunction( category_filter ) and not category_filter( category ) then
            continue;
        else
            Print( TextAttr.b4, string, TextAttr.reset, " can be derived by\n" );
        fi;
        
        used_ops_with_multiples := UsedOperationsWithMultiples( current_derivation );
        
        for i in used_ops_with_multiples do
            
            if CurrentOperationWeight( weight_list, i[ 1 ] ) < infinity then
                Print( "* ", TextAttr.b2, i[ 1 ], TextAttr.reset, " (", i[ 2 ], "x)", ", (already installed with weight ", String( CurrentOperationWeight( weight_list, i[ 1 ] ) ),")" );
            else
                Print( "* ", TextAttr.b1, i[ 1 ], TextAttr.reset, " (", i[ 2 ], "x)" );
            fi;
            
            Print( "\n" );
            
        od;
        
        Print( "with additional weight ", String( DerivationWeight( current_derivation ) ), ".\n\n" );
        
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
    
    names := AsSortedList( RecNames( cat!.primitive_operations ) );
    
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
      

InstallGlobalFunction( CAP_INTERNAL_DERIVATION_SANITY_CHECK,
                       
  function( graph, derivation )
    local possible_names, all_operations, function_object, function_string,
          string_stream, i;
    
    possible_names := UsedOperations( derivation );
    
    all_operations := Operations( graph );
    
    for function_object in DerivationFunctionsWithExtraFilters( derivation ) do
        
        function_object := function_object[ 1 ];
        
        function_string := "";
        
        string_stream := OutputTextString( function_string, false );
        
        SetPrintFormattingStatus( string_stream, false );
        
        PrintTo( string_stream, function_object );
        
        CloseStream( string_stream );
        
        RemoveCharacters( function_string, "()[];," );
        
        NormalizeWhitespace( function_string );
        
        function_string := SplitString( function_string, " " );
        
        for i in function_string do
            
            if i in all_operations and not i in possible_names then
                Error( Concatenation( "derivation with description\n", String( derivation ), "\n uses ", i, ",\n which is not part of its condition" ) );
            fi;
            
        od;
        
    od;
    
end );

