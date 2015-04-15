DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_RECORD" );

InstallValue( CAP_INTERNAL_METHOD_NAME_RECORD, rec( 
MonoAsKernelLift := rec(
  installation_name := "MonoAsKernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "MonoAsKernelLift" ),

EpiAsCokernelColift := rec(
  installation_name := "EpiAsCokernelColift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "EpiAsCokernelColift" ),

IdentityMorphism := rec(
  installation_name := "IdentityMorphism",
  filter_list := [ "object" ] ),

InverseImmutable := rec(
  installation_name := "InverseOp",
  filter_list := [ "morphism" ] ),

KernelObject := rec(
  installation_name := "KernelObject",
  filter_list := [ "morphism" ],
  universal_type := "Limit" ),

KernelEmb := rec(
  installation_name := "KernelEmb",
  filter_list := [ "morphism" ],
  universal_object_position := "Source",
  universal_type := "Limit" ),

KernelEmbWithGivenKernelObject := rec(
  installation_name := "KernelEmbWithGivenKernelObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "KernelEmbWithGivenKernelObject",
  universal_type := "Limit" ),

KernelLift := rec(
  installation_name := "KernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "KernelLift",
  universal_object_position := "Range",
  universal_type := "Limit" ),

KernelLiftWithGivenKernelObject := rec(
  installation_name := "KernelLiftWithGivenKernelObject",
  filter_list := [ "morphism", "morphism", "object" ],
  cache_name := "KernelLiftWithGivenKernelObject",
  universal_type := "Limit" ),

Cokernel := rec(
  installation_name := "Cokernel",
  filter_list := [ "morphism" ],
  universal_type := "Colimit" ),

CokernelProj := rec(
  installation_name := "CokernelProj",
  filter_list := [ "morphism" ],
  universal_object_position := "Range",
  universal_type := "Colimit" ),

CokernelProjWithGivenCokernel := rec(
  installation_name := "CokernelProjWithGivenCokernel",
  filter_list := [ "morphism", "object" ],
  cache_name := "CokernelProjWithGivenCokernel",
  universal_type := "Colimit" ),

CokernelColift := rec(
  installation_name := "CokernelColift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "CokernelColift",
  universal_object_position := "Source",
  universal_type := "Colimit" ),

CokernelColiftWithGivenCokernel := rec(
  installation_name := "CokernelColiftWithGivenCokernel",
  filter_list := [ "morphism", "morphism", "object" ],
  cache_name := "CokernelColiftWithGivenCokernel",
  universal_type := "Colimit" ),

PreCompose := rec(
  installation_name := "PreCompose",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "PreCompose",
  
  pre_function := function( mor_left, mor_right )
    
    if not IsEqualForObjects( Range( mor_left ), Source( mor_right ) ) then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end ),

PostCompose := rec(
  installation_name := "PostCompose",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "PostCompose",
  no_install := true ), #there is no Add-method

ZeroObject := rec(
  installation_name := "ZeroObject",
  filter_list := [ "category" ],
  cache_name := "ZeroObject" ), 

ZeroMorphism := rec(
  installation_name := "ZeroMorphism",
  filter_list := [ "object", "object" ],
  cache_name := "ZeroMorphism" ),

DirectSum := rec(
  installation_name := "DirectSumOp",
  filter_list := [ IsList, "object" ],
  argument_list := [ 1 ],
  cache_name := "DirectSumOp",
  universal_type := "LimitColimit",
  no_install := true ),

TerminalObject := rec(
  installation_name := "TerminalObject",
  filter_list := [ "category" ],
  cache_name := "TerminalObject",
  universal_type := "Limit" ),

UniversalMorphismIntoTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObject",
  filter_list := [ "object" ],
  universal_object_position := "Range",
  universal_type := "Limit",
  no_install := true ),

UniversalMorphismIntoTerminalObjectWithGivenTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
  universal_type := "Limit" ),

InitialObject := rec(
  installation_name := "InitialObject",
  filter_list := [ "category" ],
  cache_name := "InitialObject",
  universal_type := "Colimit" ),

UniversalMorphismFromInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObject",
  filter_list := [ "object" ],
  universal_object_position := "Source",
  universal_type := "Colimit",
  no_install := true ),

UniversalMorphismFromInitialObjectWithGivenInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject",
  universal_type := "Colimit" ),

DirectProduct := rec(
  installation_name := "DirectProductOp",
  filter_list := [ IsList, "object" ],
  cache_name := "DirectProductOp",
  universal_type := "Limit" ),

ProjectionInFactorOfDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectProductOp",
  universal_object_position := "Source",
  universal_type := "Limit" ),

ProjectionInFactorOfDirectProductWithGivenDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
  universal_type := "Limit" ),

UniversalMorphismIntoDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectProductOp",
  universal_object_position := "Range",
  universal_type := "Limit",
  
  pre_function := function( diagram, source, method_selection_object )
    local test_object;
    
    test_object := Source( source[1] );
        
    if false in List( source{[2 .. Length( source ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
      
      return [ false, "sources of morphisms must be equal in given source diagram" ];
      
    fi;
    
    return [ true ];
  end ),

UniversalMorphismIntoDirectProductWithGivenDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  universal_type := "Limit",
  
  pre_function := function( diagram, source, direct_product )
  local test_object;
    
    test_object := Source( source[1] );
        
    if false in List( source{[2 .. Length( source ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
      
      return [ false, "sources of morphisms must be equal in given source diagram" ];
      
    fi;
    
    return [ true ];
  end ),

IsEqualForMorphisms := rec(
  installation_name := "IsEqualForMorphisms",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "IsEqualForMorphisms",
  well_defined_todo := false,
  no_install := true ),

IsEqualForObjects := rec(
  installation_name := "IsEqualForObjects",
  filter_list := [ "object", "object" ],
  cache_name := "IsEqualForObjects",
  well_defined_todo := false,
  no_install := true ),

IsZeroForMorphisms := rec(
  installation_name := "IsZero",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

AdditionForMorphisms := rec(
  installation_name := "\+",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "AdditionForMorphisms",
  
  pre_function := function( mor1, mor2 )
    
    if not IsEqualForObjects( Source( mor1 ), Source( mor2 ) ) or not IsEqualForObjects( Range( mor1 ), Range( mor2 ) ) then
        
        return [ false, "morphisms are not addable" ];
        
    fi; 
    
    return [ true ];
  end ),

AdditiveInverseForMorphisms := rec(
  installation_name := "AdditiveInverse",
  filter_list := [ "morphism" ] ),

Coproduct := rec(
  installation_name := "CoproductOp",
  filter_list := [ IsList, "object" ],
  cache_name := "CoproductOp",
  universal_type := "Colimit" ),

InjectionOfCofactorOfCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfCoproductOp",
  universal_object_position := "Range",
  universal_type := "Colimit" ),

InjectionOfCofactorOfCoproductWithGivenCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct",
  universal_type := "Colimit" ),

UniversalMorphismFromCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromCoproductOp",
  universal_object_position := "Source",
  universal_type := "Colimit",
  
  pre_function := function( diagram, sink, method_selection_object )
    local test_object;
    
    test_object := Range( sink[1] );
        
    if false in List( sink{[2 .. Length( sink ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
      
      return [ false, "ranges of morphisms must be equal in given sink diagram" ];
        
    fi;
        
    return [ true ];
  end ),

UniversalMorphismFromCoproductWithGivenCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductWithGivenCoproduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromCoproductWithGivenCoproduct",
  universal_type := "Colimit",
  
  pre_function := function( diagram, sink, coproduct )
    local test_object;
    
    test_object := Range( sink[1] );
        
    if false in List( sink{[2 .. Length( sink ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
      
      return [ false, "ranges of morphisms must be equal in given sink diagram" ];
        
    fi;
        
    return [ true ];
  end ),

IsEqualAsSubobjects := rec(
  installation_name := "IsEqualAsSubobjects",
  filter_list := [ [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  cache_name := "IsEqualAsSubobjects",
  well_defined_todo := false ),

IsEqualAsFactorobjects := rec(
  installation_name := "IsEqualAsFactorobjects",
  filter_list := [ [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  cache_name := "IsEqualAsFactorobjects",
  well_defined_todo := false ),

Dominates := rec(
  installation_name := "Dominates",
  filter_list := [ [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  cache_name := "Dominates",
  well_defined_todo := false,
  
  pre_function := function( sub1, sub2 )
    
    if not IsEqualForObjects( Range( sub1 ), Range( sub2 ) ) then
        
        return [ false, "subobjects of different objects are not comparable by dominates" ];
        
    fi;
    
    return [ true ];
  end ),

Codominates := rec(
  installation_name := "Codominates",
  filter_list := [ [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  cache_name := "Codominates",
  well_defined_todo := false,
  
  pre_function := function( factor1, factor2 )
    
    if not IsEqualForObjects( Source( factor1 ), Source( factor2 ) ) then
        
        return [ false, "factorobjects of different objects are not comparable by codominates" ];
        
    fi;
    
    return [ true ];
  end ),

FiberProduct := rec(
  installation_name := "FiberProductOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductOp",
  universal_type := "Limit",
  
  pre_function := function( diagram, method_selection_morphism )
    local base;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Range( c ), base ) ) then
    
      return [ false, "the given morphisms of the pullback diagram must have equal ranges" ];
    
    fi;
    
    return [ true ];
  end ),

ProjectionInFactorOfFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductOp",
  filter_list := [ IsList, IsInt, "morphism" ],
  cache_name := "ProjectionInFactorOfFiberProductOp",
  universal_object_position := "Source",
  universal_type := "Limit",
  
  pre_function := function( diagram, projection_number, method_selection_morphism )
    local base;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
    
      return [ false, "the given morphisms of the pullback diagram must have equal ranges" ];
    
    fi;
    
    return [ true ];
  end ),

ProjectionInFactorOfFiberProductWithGivenFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  universal_type := "Limit",
  
  pre_function := function( diagram, projection_number, pullback )
    local base;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
    
      return [ false, "the given morphisms of the pullback diagram must have equal ranges" ];
    
    fi;
    
    return [ true ];
  end ),

UniversalMorphismIntoFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductOp",
  filter_list := [ IsList, IsList, "morphism" ],
  cache_name := "UniversalMorphismIntoFiberProductOp",
  universal_object_position := "Range",
  universal_type := "Limit",
  
  pre_function := function( diagram, source, method_selection_morphism )
    local base, test_object;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
      
      return [ false, "the given morphisms of the pullback diagram must have equal ranges" ];
      
    fi;
    
    test_object := Source( source[1] );
    
    if false in List( source{[2 .. Length( source ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
        
        return [ false, "sources of morphisms must be equal in given source diagram" ];
        
    fi;
    
    return [ true ];
  end ),

UniversalMorphismIntoFiberProductWithGivenFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  universal_type := "Limit",
  
  pre_function := function( diagram, source, pullback )
    local base, test_object;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Range( c ), base ) ) then
      
      return [ false, "the given morphisms of the pullback diagram must have equal ranges" ];
      
    fi;
    
    test_object := Source( source[1] );
    
    if false in List( source{[2 .. Length( source ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
        
        return [ false, "sources of morphisms must be equal in given source diagram" ];
        
    fi;
    
    return [ true ];
  end ),

Pushout := rec(
  installation_name := "PushoutOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "PushoutOp",
  universal_type := "Colimit",
  
  pre_function := function( diagram, method_selection_morphism )
    local cobase;
    
    cobase := Source( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
       
       return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
       
    fi;
    
    return [ true ];
  end ),

InjectionOfCofactorOfPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutOp",
  filter_list := [ IsList, IsInt, "morphism" ],
  cache_name := "InjectionOfCofactorOfPushoutOp",
  universal_object_position := "Range",
  universal_type := "Colimit",
  
  pre_function := function( diagram, injection_number, method_selection_morphism )
    local cobase;
    
    cobase := Source( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
       
       return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
       
    fi;
    
    return [ true ];
  end ),

InjectionOfCofactorOfPushoutWithGivenPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutWithGivenPushout",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfPushoutWithGivenPushout",
  universal_type := "Colimit",
  
  pre_function := function( diagram, injection_number, pushout )
    local cobase;
    
    cobase := Source( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
       
       return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
       
    fi;
    
    return [ true ];
  end ),

UniversalMorphismFromPushout := rec(
  installation_name := "UniversalMorphismFromPushoutOp",
  filter_list := [ IsList, IsList, "morphism" ],
  cache_name := "UniversalMorphismFromPushoutOp",
  universal_object_position := "Source",
  universal_type := "Colimit",
  
  pre_function := function( diagram, sink, method_selection_morphism )
    local cobase, test_object;
    
    cobase := Source( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
       
       return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
       
    fi;
    
    test_object := Range( sink[1] );
    
    if false in List( sink{[2 .. Length( sink ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
        
        return [ false, "ranges of morphisms must be equal in given sink diagram" ];
        
    fi;
    
    return [ true ];
  end ),

UniversalMorphismFromPushoutWithGivenPushout := rec(
  installation_name := "UniversalMorphismFromPushoutWithGivenPushout",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromPushoutWithGivenPushout",
  universal_type := "Colimit",
  
  pre_function := function( diagram, sink, pushout )
    local cobase, test_object;
    
    cobase := Source( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
       
       return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
       
    fi;
    
    test_object := Range( sink[1] );
    
    if false in List( sink{[2 .. Length( sink ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
        
        return [ false, "ranges of morphisms must be equal in given sink diagram" ];
        
    fi; 
    
    return [ true ];
  end ),

ImageObject := rec(
  installation_name := "ImageObject",
  filter_list := [ "morphism" ],
  universal_type := "Limit" ),

ImageEmbedding := rec(
  installation_name := "ImageEmbedding",
  filter_list := [ "morphism" ],
  universal_object_position := "Source",
  universal_type := "Limit" ),

ImageEmbeddingWithGivenImageObject := rec(
  installation_name := "ImageEmbeddingWithGivenImageObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "ImageEmbeddingWithGivenImageObject",
  universal_type := "Limit" ),

IsWellDefinedForMorphisms := rec(
  installation_name := "IsWellDefined",
  filter_list := [ "morphism" ],
  well_defined_todo := false,
  no_install := true ),

IsWellDefinedForObjects := rec(
  installation_name := "IsWellDefined",
  filter_list := [ "object" ],
  well_defined_todo := false ),

IsZeroForObjects := rec(
  installation_name := "IsZero",
  filter_list := [ "object" ],
  well_defined_todo := false ),

IsMonomorphism := rec(
  installation_name := "IsMonomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

IsEpimorphism := rec(
  installation_name := "IsEpimorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

IsIsomorphism := rec(
  installation_name := "IsIsomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

CoastrictionToImage := rec(
  installation_name := "CoastrictionToImage",
  filter_list := [ "morphism" ],
  universal_object_position := "Range",
  universal_type := "Limit" ),

CoastrictionToImageWithGivenImageObject := rec(
  installation_name := "CoastrictionToImageWithGivenImageObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "CoastrictionToImageWithGivenImageObject",
  universal_type := "Limit" ),

UniversalMorphismFromImage := rec(
  installation_name := "UniversalMorphismFromImage",
  filter_list := [ "morphism", IsList ],
  cache_name := "UniversalMorphismFromImage",
  universal_object_position := "Source",
  universal_type := "Limit",
  
  pre_function := function( morphism, test_factorization )
    
    if ( Source( morphism ) <> Source( test_factorization[1] ) )
       or ( Range( morphism ) <> Range( test_factorization[2] ) )
       or ( Range( test_factorization[1] ) <> Range( test_factorization[2] ) ) then
        
        return [ false, "the input is not a proper factorization" ];
        
    fi;
    
    return [ true ];
  end ),

UniversalMorphismFromImageWithGivenImageObject := rec(
  installation_name := "UniversalMorphismFromImageWithGivenImageObject",
  filter_list := [ "morphism", IsList, "object" ],
  cache_name := "UniversalMorphismFromImageWithGivenImageObject",
  universal_type := "Limit",
  
  pre_function := function( morphism, test_factorization, image )
    
    if ( Source( morphism ) <> Source( test_factorization[1] ) )
       or ( Range( morphism ) <> Range( test_factorization[2] ) )
       or ( Range( test_factorization[1] ) <> Range( test_factorization[2] ) ) then
        
        return [ false, "the input is not a proper factorization" ];
        
    fi; 
    
    return [ true ];
  end ),

# DomainAssociatedMorphismCodomainTriple := rec(
#   installation_name := "DomainAssociatedMorphismCodomainTriple",
#   filter_list := [  ],
#   cache_name := "DomainAssociatedMorphismCodomainTriple" ),
# 
# Domain := rec(
#   installation_name := "DomainOp",
#   filter_list := [ ],
#   cache_name := "DomainOp" ),
# 
# Codomain := rec(
#   installation_name := "Codomain",
#   filter_list := [ ],
#   cache_name := "Codomain" ),
# 
# AssociatedMorphism := rec(
#   installation_name := "AssociatedMorphism",
#   filter_list := [ ],
#   cache_name := "AssociatedMorphism" ),
# 
# PseudoInverse := rec(
#   installation_name := "PseudoInverse",
#   filter_list := [ ],
#   cache_name := "PseudoInverse" ),

KernelObjectFunctorial := rec(
  installation_name := "KernelObjectFunctorial",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "KernelObjectFunctorial",
  no_install := true ), #there is no Add-method

CokernelFunctorial := rec(
  installation_name := "CokernelFunctorial",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "CokernelFunctorial",
  no_install := true ), #there is no Add-method

TerminalObjectFunctorial := rec(
  installation_name := "TerminalObjectFunctorial",
  filter_list := [ "category" ],
  cache_name := "TerminalObjectFunctorial",
  no_install := true ),

InitialObjectFunctorial := rec(
  installation_name := "InitialObjectFunctorial",
  filter_list := [ "category" ],
  cache_name := "InitialObjectFunctorial",
  no_install := true ),

DirectProductFunctorial := rec(
  installation_name := "DirectProductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectProductFunctorialOp",
  no_install := true ), #there is no Add-method

CoproductFunctorial := rec(
  installation_name := "CoproductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "CoproductFunctorialOp",
  no_install := true ), #there is no Add-method

DirectSumFunctorial := rec(
  installation_name := "DirectSumFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectSumFunctorialOp",
  no_install := true ), #there is no Add-method

FiberProductFunctorial := rec(
  installation_name := "FiberProductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductFunctorialOp",
  no_install := true ), #there is no Add-method

PushoutFunctorial := rec(
  installation_name := "PushoutFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "PushoutFunctorialOp",
  no_install := true  ), #there is no Add-method

# GeneralizedMorphismFromFactorToSubobject := rec(
#   installation_name := "GeneralizedMorphismFromFactorToSubobject",
#   filter_list := [ ],
#   cache_name := "GeneralizedMorphismFromFactorToSubobject" ),

HorizontalPreCompose := rec(
  installation_name := "HorizontalPreCompose",
  filter_list := [ "twocell", "twocell" ],
  cache_name := "HorizontalPreCompose",
  
  pre_function := function( twocell_1, twocell_2 )
    
    if not IsIdenticalObj( Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) ) then
        
        return [ false, "2-cells are not horizontally composable" ];
        
    fi;
    
    return [ true ];
  end ),

VerticalPreCompose := rec(
  installation_name := "VerticalPreCompose",
  filter_list := [ "twocell", "twocell" ],
  cache_name := "VerticalPreCompose",
  
  pre_function := function( twocell_1, twocell_2 )
    
    if not IsIdenticalObj( Range( twocell_1 ), Source( twocell_2 ) ) then
        
        return [ false, "2-cells are not vertically composable" ];
        
    fi;
    
    return [ true ];
  end ),

IdentityTwoCell := rec(
  installation_name := "IdentityTwoCell",
  filter_list := [ "twocell" ] ),

# HonestRepresentative := rec(
#   installation_name := "HonestRepresentative",
#   filter_list := [ ],
#   cache_name := "HonestRepresentative" ),

IsWellDefinedForTwoCells := rec(
  installation_name := "IsWellDefined",
  filter_list := [ "twocell" ],
  well_defined_todo := false,
  no_install := true ) )
);