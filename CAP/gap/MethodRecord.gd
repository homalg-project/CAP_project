DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_RECORD" );

InstallValue( CAP_INTERNAL_METHOD_NAME_RECORD, rec(
MonoAsKernelLift := rec(
  installation_name := "MonoAsKernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "MonoAsKernelLift",
  return_type := "morphism",
  
  post_function := function( alpha, beta, lift )
    
    if lift = fail then
        
        Error( "Mono as kernel lift doesn't exist" );
        
    fi;
    
  end,
  dual_operation := "EpiAsCokernelColift" ),

EpiAsCokernelColift := rec(
  installation_name := "EpiAsCokernelColift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "EpiAsCokernelColift",
  return_type := "morphism",
  post_function := function( alpha, beta, colift )
    
    if colift = fail then
        
        Error( "Epi as cokernel colift doesn't exist" );
        
    fi;
    
  end,
  dual_operation := "MonoAsKernelLift" ),

Lift := rec(
  installation_name := "Lift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "Lift",
  return_type := "morphism",
  
  post_function := function( alpha, beta, lift )
    
    if lift = fail then
        
        Error( "Lift doesn't exist" );
        
    fi;
    
  end,
  dual_operation := "Colift" ),

Colift := rec(
  installation_name := "Colift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "Colift",
  return_type := "morphism",
  post_function := function( alpha, beta, colift )
    
    if colift = fail then
        
        Error( "Colift doesn't exist" );
        
    fi;
    
  end,
  dual_operation := "Lift" ),

IdentityMorphism := rec(
  installation_name := "IdentityMorphism",
  filter_list := [ "object" ],
  return_type := "morphism",
  post_function := function( object, identity_morphism )
    
    SetIsIdenticalToIdentityMorphism( identity_morphism, true );
    
  end ),

InverseImmutable := rec(
  installation_name := "InverseOp",
  filter_list := [ "morphism" ],
  return_type := "morphism" ),

KernelObject := rec(
  installation_name := "KernelObject",
  filter_list := [ "morphism" ],
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "Cokernel" ),

KernelEmb := rec(
  installation_name := "KernelEmb",
  filter_list := [ "morphism" ],
  universal_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelProj" ),

KernelEmbWithGivenKernelObject := rec(
  installation_name := "KernelEmbWithGivenKernelObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "KernelEmbWithGivenKernelObject",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelProjWithGivenCokernel"),

KernelLift := rec(
  installation_name := "KernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "KernelLift",
  universal_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelColift" ),

KernelLiftWithGivenKernelObject := rec(
  installation_name := "KernelLiftWithGivenKernelObject",
  filter_list := [ "morphism", "morphism", "object" ],
  cache_name := "KernelLiftWithGivenKernelObject",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelColiftWithGivenCokernel" ),

Cokernel := rec(
  installation_name := "Cokernel",
  filter_list := [ "morphism" ],
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "KernelObject" ),

CokernelProj := rec(
  installation_name := "CokernelProj",
  filter_list := [ "morphism" ],
  universal_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelEmb" ),

CokernelProjWithGivenCokernel := rec(
  installation_name := "CokernelProjWithGivenCokernel",
  filter_list := [ "morphism", "object" ],
  cache_name := "CokernelProjWithGivenCokernel",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelEmbWithGivenKernelObject" ),

CokernelColift := rec(
  installation_name := "CokernelColift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "CokernelColift",
  universal_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelLift" ),

CokernelColiftWithGivenCokernel := rec(
  installation_name := "CokernelColiftWithGivenCokernel",
  filter_list := [ "morphism", "morphism", "object" ],
  cache_name := "CokernelColiftWithGivenCokernel",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelLiftWithGivenKernelObject" ),

PreCompose := rec(
  installation_name := "PreCompose",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "PreCompose",
  
  pre_function := function( mor_left, mor_right )
    
    if IsEqualForObjects( Range( mor_left ), Source( mor_right ) ) = fail then
      
      return [ false, "cannot decide whether morphisms are composable" ];
      
    fi;
    
    if not IsEqualForObjects( Range( mor_left ), Source( mor_right ) ) then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "PostCompose" ),

PostCompose := rec(
  installation_name := "PostCompose",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "PostCompose",
  
  pre_function := function( mor_right, mor_left )
    
    if IsEqualForObjects( Range( mor_left ), Source( mor_right ) ) = fail then
      
      return [ false, "cannot decide whether morphisms are composable" ];
      
    fi;
    
    if not IsEqualForObjects( Range( mor_left ), Source( mor_right ) ) then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end,
  
  return_type := "morphism",
  dual_operation := "PreCompose" ),

ZeroObject := rec(
  installation_name := "ZeroObject",
  filter_list := [ "category" ],
  cache_name := "ZeroObject",
  return_type := "object" ), 

UniversalMorphismFromZeroObject := rec(
  installation_name := "UniversalMorphismFromZeroObject",
  filter_list := [ "object" ],
  universal_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoZeroObject",
  
  ## this redirect and this post function have to be given manually, because
  ## they call the setter and getter functions of CapCategory( diagram ), and 
  ## not of diagram.
  redirect_function := function( test_sink )
    local category;
    
    category := CapCategory( test_sink );
    
    if HasZeroObject( category ) then
      
      return [ true, UniversalMorphismFromZeroObjectWithGivenZeroObject( test_sink, ZeroObject( category ) ) ];
      
    fi;
    
    return [ false ];
    
  end,
  
  post_function := function( test_sink, universal_morphism )
    local category, zero_object;
    
    category := CapCategory( test_sink );
    
    zero_object := Source( universal_morphism );
    
    SetZeroObject( category, zero_object );
    
    SetFilterObj( zero_object, WasCreatedAsZeroObject );
    
  end ),
  
UniversalMorphismFromZeroObjectWithGivenZeroObject := rec(
  installation_name := "UniversalMorphismFromZeroObjectWithGivenZeroObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismFromZeroObjectWithGivenZeroObject",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoZeroObjectWithGivenZeroObject" ),

UniversalMorphismIntoZeroObject := rec(
  installation_name := "UniversalMorphismIntoZeroObject",
  filter_list := [ "object" ],
  universal_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromZeroObject",
  
  ## this redirect and this post function have to be given manually, because
  ## they call the setter and getter functions of CapCategory( diagram ), and 
  ## not of diagram.
  redirect_function := function( test_source )
    local category;
    
    category := CapCategory( test_source );
        
    if HasZeroObject( category ) then
    
      return [ true, UniversalMorphismIntoZeroObjectWithGivenZeroObject( test_source, ZeroObject( category ) ) ];
      
    fi;
    
    return [ false ];
    
  end,

  post_function := function( test_source, universal_morphism )
    local category, zero_object;
    
    category := CapCategory( test_source );
    
    zero_object := Range( universal_morphism );
    
    SetTerminalObject( category, zero_object );
    
    SetFilterObj( zero_object, WasCreatedAsTerminalObject );
    
  end ),

UniversalMorphismIntoZeroObjectWithGivenZeroObject := rec(
  installation_name := "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromZeroObjectWithGivenZeroObject" ),

IsomorphismFromZeroObjectToInitialObject := rec(
  installation_name := "IsomorphismFromZeroObjectToInitialObject",
  filter_list := [ "category" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromZeroObjectToInitialObject",
  return_type := "morphism",
  dual_operation := "IsomorphismFromTerminalObjectToZeroObject" ),

IsomorphismFromInitialObjectToZeroObject := rec(
  installation_name := "IsomorphismFromInitialObjectToZeroObject",
  filter_list := [ "category" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromInitialObjectToZeroObject",
  return_type := "morphism",
  dual_operation := "IsomorphismFromZeroObjectToTerminalObject" ),

IsomorphismFromZeroObjectToTerminalObject := rec(
  installation_name := "IsomorphismFromZeroObjectToTerminalObject",
  filter_list := [ "category" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromZeroObjectToTerminalObject",
  return_type := "morphism",
  dual_operation := "IsomorphismFromInitialObjectToZeroObject" ),

IsomorphismFromTerminalObjectToZeroObject := rec(
  installation_name := "IsomorphismFromTerminalObjectToZeroObject",
  filter_list := [ "category" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromTerminalObjectToZeroObject",
  return_type := "morphism",
  dual_operation := "IsomorphismFromZeroObjectToInitialObject" ),

ZeroMorphism := rec(
  installation_name := "ZeroMorphism",
  filter_list := [ "object", "object" ],
  cache_name := "ZeroMorphism",
  return_type := "morphism" ),

DirectSum := rec(
  installation_name := "DirectSumOp",
  filter_list := [ IsList, "object" ],
  argument_list := [ 1 ],
  cache_name := "DirectSumOp",
  universal_type := "LimitColimit",
  return_type := "object"
  ),

ProjectionInFactorOfDirectSum := rec(
  installation_name := "ProjectionInFactorOfDirectSumOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectSumOp",
  universal_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfDirectSum" ),

ProjectionInFactorOfDirectSumWithGivenDirectSum := rec(
  installation_name := "ProjectionInFactorOfDirectSumWithGivenDirectSum",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectSumWithGivenDirectSum",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfDirectSumWithGivenDirectSum" ),

UniversalMorphismIntoDirectSum := rec(
  installation_name := "UniversalMorphismIntoDirectSumOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectSumOp",
  universal_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromDirectSum",
  
  pre_function := function( diagram, source, method_selection_object )
    local test_object, current_morphism, current_return;
    
    test_object := Source( source[1] );
    
    for current_morphism in source{[2 .. Length( source ) ]} do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismIntoDirectSumWithGivenDirectSum := rec(
  installation_name := "UniversalMorphismIntoDirectSumWithGivenDirectSum",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectSumWithGivenDirectSum",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromDirectSumWithGivenDirectSum",
  
  pre_function := function( diagram, source, direct_sum )
    local test_object, current_morphism, current_return;
    
    test_object := Source( source[1] );
    
    for current_morphism in source{[2 .. Length( source ) ]} do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

InjectionOfCofactorOfDirectSum := rec(
  installation_name := "InjectionOfCofactorOfDirectSumOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfDirectSumOp",
  universal_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectSum" ),

InjectionOfCofactorOfDirectSumWithGivenDirectSum := rec(
  installation_name := "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectSumWithGivenDirectSum" ),

UniversalMorphismFromDirectSum := rec(
  installation_name := "UniversalMorphismFromDirectSumOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromDirectSumOp",
  universal_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectSum",
  
  pre_function := function( diagram, sink, method_selection_object )
    local test_object, current_morphism, current_return;
    
    test_object := Range( sink[1] );
    
    for current_morphism in sink{[2 .. Length( sink ) ]} do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismFromDirectSumWithGivenDirectSum := rec(
  installation_name := "UniversalMorphismFromDirectSumWithGivenDirectSum",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromDirectSumWithGivenDirectSum",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectSumWithGivenDirectSum",
  
  pre_function := function( diagram, sink, direct_sum )
    local test_object, current_morphism, current_return;
    
    test_object := Range( sink[1] );
    
    for current_morphism in sink{[2 .. Length( sink ) ]} do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

TerminalObject := rec(
  installation_name := "TerminalObject",
  filter_list := [ "category" ],
  cache_name := "TerminalObject",
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "InitialObject" ),

UniversalMorphismIntoTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObject",
  filter_list := [ "object" ],
  universal_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromInitialObject",
  
  ## this redirect and this post function have to be given manually, because
  ## they call the setter and getter functions of CapCategory( diagram ), and 
  ## not of diagram.
  redirect_function := function( test_source )
    local category;
    
    category := CapCategory( test_source );
        
    if HasTerminalObject( category ) then
    
      return [ true, UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( category ) ) ];
      
    fi;
    
    return [ false ];
    
  end,

  post_function := function( test_source, universal_morphism )
    local category, terminal_object;
    
    category := CapCategory( test_source );
    
    terminal_object := Range( universal_morphism );
    
    SetTerminalObject( category, terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsTerminalObject );
    
  end ),

UniversalMorphismIntoTerminalObjectWithGivenTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromInitialObjectWithGivenInitialObject" ),

InitialObject := rec(
  installation_name := "InitialObject",
  filter_list := [ "category" ],
  cache_name := "InitialObject",
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "TerminalObject"
),

UniversalMorphismFromInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObject",
  filter_list := [ "object" ],
  universal_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoTerminalObject",
  
  ## this redirect and this post function have to be given manually, because
  ## they call the setter and getter functions of CapCategory( diagram ), and 
  ## not of diagram.
  redirect_function := function( test_sink )
    local category;
    
    category := CapCategory( test_sink );
    
    if HasInitialObject( category ) then
      
      return [ true, UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( category ) ) ];
      
    fi;
    
    return [ false ];
    
  end,
  
  post_function := function( test_sink, universal_morphism )
    local category, initial_object;
    
    category := CapCategory( test_sink );
    
    initial_object := Source( universal_morphism );
    
    SetInitialObject( category, initial_object );
    
    SetFilterObj( initial_object, WasCreatedAsInitialObject );
    
  end ),

UniversalMorphismFromInitialObjectWithGivenInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ),

DirectProduct := rec(
  installation_name := "DirectProductOp",
  filter_list := [ IsList, "object" ],
  cache_name := "DirectProductOp",
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "Coproduct" ),

ProjectionInFactorOfDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectProductOp",
  universal_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfCoproduct" ),

ProjectionInFactorOfDirectProductWithGivenDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfCoproductWithGivenCoproduct" ),

UniversalMorphismIntoDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectProductOp",
  universal_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromCoproduct",
  
  pre_function := function( diagram, source, method_selection_object )
    local test_object, current_morphism, current_return;
    
    test_object := Source( source[1] );
    
    for current_morphism in source{[2 .. Length( source ) ]} do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismIntoDirectProductWithGivenDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromCoproductWithGivenCoproduct",
  
  pre_function := function( diagram, source, direct_product )
    local test_object, current_morphism, current_return;
    
    test_object := Source( source[1] );
    
    for current_morphism in source{[2 .. Length( source ) ]} do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

IsEqualForMorphisms := rec(
  installation_name := "IsEqualForMorphisms",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "IsEqualForMorphisms",
  well_defined_todo := false,
  
  pre_function := function( morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  
  redirect_function := function( morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then 
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  post_function := function( morphism_1, morphism_2, return_value )
    
    if return_value = true then
      
      INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS( morphism_1, morphism_2 );
    
    fi;
    
  end,
  
  return_type := "bool" ),

IsIdenticalForMorphisms := rec(
  installation_name := "IsIdenticalForMorphisms",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "IsIdenticalForMorphisms",
  well_defined_todo := false,
  
  pre_function := function( morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  
  redirect_function := function( morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then 
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsIdenticalForMorphismsOnMor := rec(
  installation_name := "IsIdenticalForMorphismsOnMor",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "IsIdenticalForMorphismsOnMor",
  well_defined_todo := false,
  
  redirect_function := function( morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then 
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsEqualForObjects := rec(
  installation_name := "IsEqualForObjects",
  filter_list := [ "object", "object" ],
  cache_name := "IsEqualForObjects",
  well_defined_todo := false,
  
  redirect_function := function( object_1, object_2 )
    
    if IsIdenticalObj( object_1, object_2 ) then
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  post_function := function( object_1, object_2, return_value )
    
    if return_value = true then
      
      INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS( object_1, object_2 );
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsZeroForMorphisms := rec(
  installation_name := "IsZero",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

AdditionForMorphisms := rec(
  installation_name := "\+",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "AdditionForMorphisms",
  
  pre_function := function( morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  return_type := "morphism" ),

AdditiveInverseForMorphisms := rec(
  installation_name := "AdditiveInverse",
  filter_list := [ "morphism" ],
  return_type := "morphism" ),

Coproduct := rec(
  installation_name := "CoproductOp",
  filter_list := [ IsList, "object" ],
  cache_name := "CoproductOp",
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "DirectProduct" ),

InjectionOfCofactorOfCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfCoproductOp",
  universal_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectProduct" ),

InjectionOfCofactorOfCoproductWithGivenCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ),

UniversalMorphismFromCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromCoproductOp",
  universal_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectProduct",
  
  pre_function := function( diagram, sink, method_selection_object )
    local test_object, current_morphism, current_return;
    
    test_object := Range( sink[1] );
    
    for current_morphism in sink{[2 .. Length( sink ) ]} do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismFromCoproductWithGivenCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductWithGivenCoproduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromCoproductWithGivenCoproduct",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  
  pre_function := function( diagram, sink, coproduct )
    local test_object, current_morphism, current_return;
    
    test_object := Range( sink[1] );
    
    for current_morphism in sink{[2 .. Length( sink ) ]} do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

IsEqualAsSubobjects := rec(
  installation_name := "IsEqualAsSubobjects",
  filter_list := [ [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  cache_name := "IsEqualAsSubobjects",
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEqualAsFactorobjects" ),

IsEqualAsFactorobjects := rec(
  installation_name := "IsEqualAsFactorobjects",
  filter_list := [ [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  cache_name := "IsEqualAsFactorobjects",
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEqualAsSubobjects" ),

Dominates := rec(
  installation_name := "Dominates",
  filter_list := [ [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  cache_name := "Dominates",
  well_defined_todo := false,
  dual_operation := "Codominates",
  
  pre_function := function( sub1, sub2 )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Range( sub1 ), Range( sub2 ) );
    
    if is_equal_for_objects = fail then
        
        return [ false, "cannot decide whether those are subobjects of the same object" ];
    
    elif is_equal_for_objects = false then
        
        return [ false, "subobjects of different objects are not comparable by dominates" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool" ),

Codominates := rec(
  installation_name := "Codominates",
  filter_list := [ [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  cache_name := "Codominates",
  well_defined_todo := false,
  dual_operation := "Dominates",
  
  pre_function := function( factor1, factor2 )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Source( factor1 ), Source( factor2 ) );
    
    if is_equal_for_objects = fail then
        
        return [ false, "cannot decide whether those are factors of the same object" ];
    
    elif is_equal_for_objects = false then
        
        return [ false, "factors of different objects are not comparable by codominates" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool" ),

FiberProduct := rec(
  installation_name := "FiberProductOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductOp",
  universal_type := "Limit",
  dual_operation := "Pushout",
  
  pre_function := function( diagram, method_selection_morphism )
    local base, current_morphism, current_value;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "object" ),

ProjectionInFactorOfFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductOp",
  filter_list := [ IsList, IsInt, "morphism" ],
  cache_name := "ProjectionInFactorOfFiberProductOp",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfCofactorOfPushout",
  
  pre_function := function( diagram, projection_number, method_selection_morphism )
    local base, current_morphism, current_value;
    
    if not projection_number in [ 1 .. Length( diagram ) ] then
        return[ false, Concatenation( "there does not exist a ", String( projection_number ), "th projection" ) ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

ProjectionInFactorOfFiberProductWithGivenFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  universal_type := "Limit",
  dual_operation := "InjectionOfCofactorOfPushoutWithGivenPushout",
  
  pre_function := function( diagram, projection_number, pullback )
    local base, current_morphism, current_value;
    
    if not projection_number in [ 1 .. Length( diagram ) ] then
        return[ false, Concatenation( "there does not exist a ", String( projection_number ), "th projection" ) ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismIntoFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductOp",
  filter_list := [ IsList, IsList, "morphism" ],
  cache_name := "UniversalMorphismIntoFiberProductOp",
  universal_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromPushout",
  
  pre_function := function( diagram, source, method_selection_morphism )
    local base, current_morphism, current_value, current_morphism_position, test_object;
    
    if Length( diagram ) <> Length( source ) then
        return [ false, "fiber product diagram and test diagram must have equal length" ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    test_object := Source( source[1] );
    
    for current_morphism in source{[ 2 .. Length( source ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test source have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test source do not have equal sources" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Source( diagram[ current_morphism_position ] ), Range( source[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismIntoFiberProductWithGivenFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromPushoutWithGivenPushout",
  
  pre_function := function( diagram, source, pullback )
    local base, current_morphism, current_value, current_morphism_position, test_object;
    
    if Length( diagram ) <> Length( source ) then
        return [ false, "fiber product diagram and test diagram must have equal length" ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    test_object := Source( source[1] );
    
    for current_morphism in source{[ 2 .. Length( source ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test source have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test source do not have equal sources" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Source( diagram[ current_morphism_position ] ), Range( source[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

Pushout := rec(
  installation_name := "PushoutOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "PushoutOp",
  universal_type := "Colimit",
  dual_operation := "FiberProduct",
  
  pre_function := function( diagram, method_selection_morphism )
    local cobase, current_morphism, current_value;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "object" ),

InjectionOfCofactorOfPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutOp",
  filter_list := [ IsList, IsInt, "morphism" ],
  cache_name := "InjectionOfCofactorOfPushoutOp",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionInFactorOfFiberProduct",
  
  pre_function := function( diagram, injection_number, method_selection_morphism )
    local cobase, current_morphism, current_value;
    
    if not injection_number in [ 1 .. Length( diagram ) ] then
        return[ false, Concatenation( "there does not exist a ", String( injection_number ), "th injection" ) ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

InjectionOfCofactorOfPushoutWithGivenPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutWithGivenPushout",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfPushoutWithGivenPushout",
  universal_type := "Colimit",
  dual_operation := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  
  pre_function := function( diagram, injection_number, pushout )
    local cobase, current_morphism, current_value;
    
    if not injection_number in [ 1 .. Length( diagram ) ] then
        return[ false, Concatenation( "there does not exist a ", String( injection_number ), "th injection" ) ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromPushout := rec(
  installation_name := "UniversalMorphismFromPushoutOp",
  filter_list := [ IsList, IsList, "morphism" ],
  cache_name := "UniversalMorphismFromPushoutOp",
  universal_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoFiberProduct",
  
  pre_function := function( diagram, sink, method_selection_morphism )
    local cobase, current_morphism, current_value, current_morphism_position, test_object;
    
    if Length( diagram ) <> Length( sink ) then
        return [ false, "pushout diagram and test diagram must have equal length" ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber pushout must have equal sources" ];
        fi;
        
    od;
    
    test_object := Range( sink[1] );
    
    for current_morphism in sink{[ 2 .. Length( sink ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test sink have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test sink do not have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Range( diagram[ current_morphism_position ] ), Source( sink[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromPushoutWithGivenPushout := rec(
  installation_name := "UniversalMorphismFromPushoutWithGivenPushout",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromPushoutWithGivenPushout",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  
  pre_function := function( diagram, sink, pushout )
    local cobase, current_morphism, current_value, current_morphism_position, test_object;
    
    if Length( diagram ) <> Length( sink ) then
        return [ false, "pushout diagram and test diagram must have equal length" ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber pushout must have equal sources" ];
        fi;
        
    od;
    
    test_object := Range( sink[1] );
    
    for current_morphism in sink{[ 2 .. Length( sink ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test sink have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test sink do not have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Range( diagram[ current_morphism_position ] ), Source( sink[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

ImageObject := rec(
  installation_name := "ImageObject",
  filter_list := [ "morphism" ],
  universal_type := "Limit",
  return_type := "object" ),

ImageEmbedding := rec(
  installation_name := "ImageEmbedding",
  filter_list := [ "morphism" ],
  universal_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism" ),

ImageEmbeddingWithGivenImageObject := rec(
  installation_name := "ImageEmbeddingWithGivenImageObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "ImageEmbeddingWithGivenImageObject",
  universal_type := "Limit",
  return_type := "morphism" ),

IsWellDefinedForMorphisms := rec(
  installation_name := "IsWellDefined",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  no_install := true,
  return_type := "bool" ),

IsWellDefinedForObjects := rec(
  installation_name := "IsWellDefined",
  filter_list := [ "object" ],
  well_defined_todo := false,
  return_type := "bool" ),

IsZeroForObjects := rec(
  installation_name := "IsZero",
  filter_list := [ "object" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "object" ),

IsMonomorphism := rec(
  installation_name := "IsMonomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEpimorphism",
  property_of := "morphism" ),

IsEpimorphism := rec(
  installation_name := "IsEpimorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsMonomorphism",
  property_of := "morphism" ),

IsIsomorphism := rec(
  installation_name := "IsIsomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

IsEndomorphism := rec(
  installation_name := "IsEndomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

IsAutomorphism := rec(
  installation_name := "IsAutomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

IsOne := rec(
  installation_name := "IsOne",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

IsSplitMonomorphism := rec(
  installation_name := "IsSplitMonomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsSplitEpimorphism",
  property_of := "morphism" ),

IsSplitEpimorphism := rec(
  installation_name := "IsSplitEpimorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsSplitMonomorphism",
  property_of := "morphism" ),

IsIdempotent := rec(
  installation_name := "IsIdempotent",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

IsProjective := rec(
  installation_name := "IsProjective",
  filter_list := [ "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsInjective",
  property_of := "object" ),

IsInjective := rec(
  installation_name := "IsInjective",
  filter_list := [ "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsProjective",
  property_of := "object" ),

IsTerminal := rec(
  installation_name := "IsTerminal",
  filter_list := [ "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsInitial",
  property_of := "object" ),

IsInitial := rec(
  installation_name := "IsInitial",
  filter_list := [ "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsTerminal",
  property_of := "object" ),

IsIdenticalToIdentityMorphism := rec(
  installation_name := "IsIdenticalToIdentityMorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism" ),

CoastrictionToImage := rec(
  installation_name := "CoastrictionToImage",
  filter_list := [ "morphism" ],
  universal_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism" ),

CoastrictionToImageWithGivenImageObject := rec(
  installation_name := "CoastrictionToImageWithGivenImageObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "CoastrictionToImageWithGivenImageObject",
  universal_type := "Limit",
  return_type := "morphism" ),

UniversalMorphismFromImage := rec(
  installation_name := "UniversalMorphismFromImage",
  filter_list := [ "morphism", IsList ],
  cache_name := "UniversalMorphismFromImage",
  universal_object_position := "Source",
  universal_type := "Limit",
  
  pre_function := function( morphism, test_factorization )
    local value;
    
    value := IsEqualForObjects( Source( morphism ), Source( test_factorization[ 1 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( morphism ), Range( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether range of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source and range of test factorization are equal" ];
    elif value = false then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromImageWithGivenImageObject := rec(
  installation_name := "UniversalMorphismFromImageWithGivenImageObject",
  filter_list := [ "morphism", IsList, "object" ],
  cache_name := "UniversalMorphismFromImageWithGivenImageObject",
  universal_type := "Limit",
  
  pre_function := function( morphism, test_factorization, image )
    local value;
    
    value := IsEqualForObjects( Source( morphism ), Source( test_factorization[ 1 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( morphism ), Range( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether range of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source and range of test factorization are equal" ];
    elif value = false then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism" ),

KernelObjectFunctorial := rec(
  installation_name := "KernelObjectFunctorial",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "KernelObjectFunctorial",
  no_install := true,
  return_type := "morphism",
  dual_operation := "CokernelFunctorial" ), #there is no Add-method

CokernelFunctorial := rec(
  installation_name := "CokernelFunctorial",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "CokernelFunctorial",
  no_install := true,
  return_type := "morphism",
  dual_operation := "KernelObjectFunctorial" ), #there is no Add-method

TerminalObjectFunctorial := rec(
  installation_name := "TerminalObjectFunctorial",
  filter_list := [ "category" ],
  cache_name := "TerminalObjectFunctorial",
  no_install := true,
  return_type := "morphism",
  dual_operation := "InitialObjectFunctorial" ),

InitialObjectFunctorial := rec(
  installation_name := "InitialObjectFunctorial",
  filter_list := [ "category" ],
  cache_name := "InitialObjectFunctorial",
  no_install := true,
  return_type := "morphism",
  dual_operation := "TerminalObjectFunctorial" ),

DirectProductFunctorial := rec(
  installation_name := "DirectProductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectProductFunctorialOp",
  no_install := true,
  return_type := "morphism",
  dual_operation := "CoproductFunctorial" ), #there is no Add-method

CoproductFunctorial := rec(
  installation_name := "CoproductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "CoproductFunctorialOp",
  no_install := true,
  return_type := "morphism",
  dual_operation := "DirectProductFunctorial" ), #there is no Add-method

DirectSumFunctorial := rec(
  installation_name := "DirectSumFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectSumFunctorialOp",
  no_install := true,
  return_type := "morphism" ), #there is no Add-method

FiberProductFunctorial := rec(
  installation_name := "FiberProductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductFunctorialOp",
  no_install := true,
  return_type := "morphism",
  dual_operation := "PushoutFunctorial" ), #there is no Add-method

PushoutFunctorial := rec(
  installation_name := "PushoutFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "PushoutFunctorialOp",
  no_install := true,
  return_type := "morphism",
  dual_operation := "FiberProductFunctorial" ), #there is no Add-method

# GeneralizedMorphismFromFactorToSubobject := rec(
#   installation_name := "GeneralizedMorphismFromFactorToSubobject",
#   filter_list := [ ],
#   cache_name := "GeneralizedMorphismFromFactorToSubobject" ),

HorizontalPreCompose := rec(
  installation_name := "HorizontalPreCompose",
  filter_list := [ "twocell", "twocell" ],
  cache_name := "HorizontalPreCompose",
  dual_operation := "HorizontalPostCompose",
  
  pre_function := function( twocell_1, twocell_2 )
    local value;
    
    value := IsEqualForObjects( Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) );
    if value = fail then
        return [ false, "cannot decide whether 2-cells are horizontally composable" ];
    elif value = false then
        return [ false, "2-cells are not horizontally composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

VerticalPreCompose := rec(
  installation_name := "VerticalPreCompose",
  filter_list := [ "twocell", "twocell" ],
  cache_name := "VerticalPreCompose",
  dual_operation := "VerticalPostCompose",
  
  pre_function := function( twocell_1, twocell_2 )
    local value;
    
    value := IsIdenticalForMorphisms( Range( twocell_1 ), Source( twocell_2 ) );
    if value = fail then
        return [ false, "cannot decide whether 2-cells are vertically composable" ];
    elif value = false then
        return [ false, "2-cells are not vertically composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

IdentityTwoCell := rec(
  installation_name := "IdentityTwoCell",
  filter_list := [ "twocell" ],
  return_type := "twocell" ),

# HonestRepresentative := rec(
#   installation_name := "HonestRepresentative",
#   filter_list := [ ],
#   cache_name := "HonestRepresentative" ),

IsWellDefinedForTwoCells := rec(
  installation_name := "IsWellDefined",
  filter_list := [ "twocell" ],
  well_defined_todo := false,
  no_install := true,
  return_type := "bool" ),
  
DirectSumDiagonalDifference := rec(
  installation_name := "DirectSumDiagonalDifferenceOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectSumDiagonalDifferenceOp",
  no_install := true,
  return_type := "morphism",
  dual_operation := "DirectSumCodiagonalDifference" ),
  
FiberProductEmbeddingInDirectSum := rec(
  installation_name := "FiberProductEmbeddingInDirectSumOp",
  argument_list := [ 1 ],
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductEmbeddingInDirectSumOp",
  return_type := "morphism",
  dual_operation := "DirectSumProjectionInPushout" ),
  
IsomorphismFromFiberProductToKernelOfDiagonalDifference := rec(
  installation_name := "IsomorphismFromFiberProductToKernelOfDiagonalDifferenceOp",
  filter_list := [ IsList, "morphism" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromFiberProductToKernelOfDiagonalDifferenceOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout" ),
  
IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct := rec(
  installation_name := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProductOp",
  filter_list := [ IsList, "morphism" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProductOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromPushoutToCokernelOfDiagonalDifference" ),

IsomorphismFromPushoutToCokernelOfDiagonalDifference := rec(
  installation_name := "IsomorphismFromPushoutToCokernelOfDiagonalDifferenceOp",
  filter_list := [ IsList, "morphism" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromPushoutToCokernelOfDiagonalDifferenceOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct" ),

IsomorphismFromCokernelOfDiagonalDifferenceToPushout := rec(
  installation_name := "IsomorphismFromCokernelOfDiagonalDifferenceToPushoutOp",
  filter_list := [ IsList, "morphism" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromCokernelOfDiagonalDifferenceToPushoutOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromFiberProductToKernelOfDiagonalDifference" ),

IsomorphismFromImageObjectToKernelOfCokernel := rec(
  installation_name := "IsomorphismFromImageObjectToKernelOfCokernel",
  filter_list := [ "morphism" ],
  cache_name := "IsomorphismFromImageObjectToKernelOfCokernel",
  return_type := "morphism" ),

IsomorphismFromDirectSumToDirectProduct := rec(
  installation_name := "IsomorphismFromDirectSumToDirectProductOp",
  filter_list := [ IsList, "object" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromDirectSumToDirectProductOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoproductToDirectSum" ),

IsomorphismFromDirectSumToCoproduct := rec(
  installation_name := "IsomorphismFromDirectSumToCoproductOp",
  filter_list := [ IsList, "object" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromDirectSumToCoproductOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectProductToDirectSum" ),

IsomorphismFromDirectProductToDirectSum := rec(
  installation_name := "IsomorphismFromDirectProductToDirectSumOp",
  filter_list := [ IsList, "object" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromDirectProductToDirectSumOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectSumToCoproduct" ),

IsomorphismFromCoproductToDirectSum := rec(
  installation_name := "IsomorphismFromCoproductToDirectSumOp",
  filter_list := [ IsList, "object" ],
  argument_list := [ 1 ],
  cache_name := "IsomorphismFromCoproductToDirectSumOp",
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectSumToCoproduct" ),

DirectSumCodiagonalDifference := rec(
  installation_name := "DirectSumCodiagonalDifferenceOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectSumCodiagonalDifferenceOp",
  no_install := true,
  return_type := "morphism",
  dual_operation := "DirectSumDiagonalDifference" ),
  
DirectSumProjectionInPushout := rec(
  installation_name := "DirectSumProjectionInPushoutOp",
  filter_list := [ IsList, "morphism" ],
  argument_list := [ 1 ],
  cache_name := "DirectSumProjectionInPushoutOp",
  return_type := "morphism",
  dual_operation := "FiberProductEmbeddingInDirectSum" )
  )

);
