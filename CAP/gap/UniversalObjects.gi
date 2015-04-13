#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Universal Objects
##
#############################################################################

#FIXME: Add CanComputePreCompose to assumptions in implied methods

##
InstallMethod( AddToGenesis,
               [ IsCapCategoryCell, IsString, IsObject ], 

  function( cell, genesis_entry_name, genesis_entry )
    
    if HasGenesis( cell ) then
      
      AUTODOC_APPEND_RECORD_WRITEONCE( Genesis( cell ), rec( (genesis_entry_name) := genesis_entry ) );
      
   else
      
      SetGenesis( cell, rec( (genesis_entry_name) := genesis_entry ) );
      
   fi;
   
end );

####################################
##
## Kernel
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( KernelLift,
               [ IsCapCategoryObject, IsCapCategoryMorphism ],
               
  function( kernel, test_morphism )
  
    return KernelLift( Genesis( kernel )!.KernelObjectDiagram, test_morphism );
  
end );

##
InstallMethod( KernelEmb,
               [ IsCapCategoryObject and WasCreatedAsKernelObject ],
               
  function( kernel )
  
    return KernelEmb( Genesis( kernel )!.KernelObjectDiagram );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( KernelObjectFunctorial,
               [ IsList ],
                                  
  function( morphism_of_morphisms )
    
    return KernelObjectFunctorial( morphism_of_morphisms[1], morphism_of_morphisms[2][1], morphism_of_morphisms[3] );
    
end );

####################################
##
## Cokernel
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( CokernelColift,
               [ IsCapCategoryObject, IsCapCategoryMorphism ],
               
  function( cokernel, test_morphism )
  
    return CokernelColift( Genesis( cokernel )!.CokernelDiagram, test_morphism );
  
end );

##
InstallMethod( CokernelProj,
               [ IsCapCategoryObject and WasCreatedAsCokernel ],
               
  function( cokernel )
    
    return CokernelProj( Genesis( cokernel )!.CokernelDiagram );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( CokernelFunctorial,
               [ IsList ],
                                  
  function( morphism_of_morphisms )
    
    return CokernelFunctorial( morphism_of_morphisms[1], morphism_of_morphisms[2][2], morphism_of_morphisms[3] );
    
end );

####################################
##
## Coproduct and Pushout
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( InjectionOfCofactor,
               
  function( object_product_list, injection_number )
    local number_of_objects;
    
    if WasCreatedAsCoproduct( object_product_list ) and WasCreatedAsPushout( object_product_list ) then
        
      ## this might only happen when
      ## the function which was added to construct the coproduct/pushout does not return
      ## a new object but some part of its input
      
      return Error( "this object is a coproduct and a pushout concurrently, thus the injection is ambiguous" );
        
    fi;
    
    ## convenience: first argument was created as a coproduct
    if WasCreatedAsCoproduct( object_product_list ) then
    
      number_of_objects := Length( Genesis( object_product_list )!.CoproductDiagram );
      
      if injection_number < 1 or injection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
      
      fi;
    
      return InjectionOfCofactorOfCoproductWithGivenCoproduct( Genesis( object_product_list )!.CoproductDiagram, injection_number, object_product_list );
    
    fi;
    
    ## convenience: first argument was created as a pushout
    if WasCreatedAsPushout( object_product_list ) then
    
      number_of_objects := Length( Genesis( object_product_list )!.PushoutDiagram );
      
      if injection_number < 1 or injection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
      
      fi;
    
      return InjectionOfCofactorOfPushoutWithGivenPushout( Genesis( object_product_list )!.PushoutDiagram, injection_number, object_product_list );
    
    fi;
    
    ## first argument is a product object
    number_of_objects := Length( object_product_list );
  
    if injection_number < 0 or injection_number > number_of_objects then
    
      Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
    
    fi;
    
    if IsCapCategoryObject( object_product_list[1] ) then
      
      return InjectionOfCofactorOfCoproductOp( object_product_list, injection_number, object_product_list[1] );
    
    else ## IsCapCategoryMorphism( object_product_list[1] ) = true
      
      return InjectionOfCofactorOfPushoutOp( object_product_list, injection_number, object_product_list[1] );
      
    fi;
    
end );

####################################
##
## Coproduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( Coproduct,
  
  function( arg )
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryObject ) then
       
       return CoproductOp( arg[1], arg[1][1] );
       
    fi;
    
    return CoproductOp( arg, arg[ 1 ] );
    
end );

##
InstallGlobalFunction( UniversalMorphismFromCoproduct,

  function( arg )
    local diagram;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromCoproductOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    diagram := List( arg, Source );
    
    return UniversalMorphismFromCoproductOp( diagram, arg, diagram[1] );
  
end );

####################################
## Categorical methods
####################################

##
InstallMethod( InjectionOfCofactorOfCoproduct,
               [ IsList, IsInt ],
               
  function( object_product_list, injection_number )
    
    return InjectionOfCofactorOfCoproductOp( object_product_list, injection_number, object_product_list[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( CoproductFunctorial,
               [ IsList ],
                                  
  function( morphism_list )
    
    return CoproductFunctorialOp( morphism_list, morphism_list[1] );
    
end );


####################################
##
## Direct Product and FiberProduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( ProjectionInFactor,
               
  function( object_product_list, projection_number )
    local number_of_objects;
    
    if WasCreatedAsDirectProduct( object_product_list ) and WasCreatedAsFiberProduct( object_product_list ) then
        
        ## this might only happen when
        ## the function which was added to construct the product/ pullback does not return
        ## a new object but some part of its input
        
        return Error( "this object is a product and a pullback concurrently, thus the projection is ambiguous" );
        
    fi;
    
    ## convenience: first argument was created as direct product
    if WasCreatedAsDirectProduct( object_product_list ) then
    
      number_of_objects := Length( Genesis( object_product_list )!.DirectProductDiagram );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorOfDirectProductWithGivenDirectProduct( Genesis( object_product_list )!.DirectProductDiagram, projection_number, object_product_list );
    
    fi;
    
    ## convenience: first argument was created as a pullback
    if WasCreatedAsFiberProduct( object_product_list ) then
    
      number_of_objects := Length( Genesis( object_product_list )!.FiberProductDiagram );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorOfFiberProductWithGivenFiberProduct( Genesis( object_product_list )!.FiberProductDiagram, projection_number, object_product_list );
    
    fi;
    
    ## assumption: first argument is a product object
    number_of_objects := Length( object_product_list );
  
    if projection_number < 0 or projection_number > number_of_objects then
    
      Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
    
    fi;
    
    if IsCapCategoryObject( object_product_list[1] )  then 
      
      return ProjectionInFactorOfDirectProductOp( object_product_list, projection_number, object_product_list[1] );
      
    else # IsCapCategoryMorphism( object_product_list[1] ) = true
      
      return ProjectionInFactorOfFiberProductOp( object_product_list, projection_number, object_product_list[1] );
      
    fi;
  
end );


####################################
##
## Direct Product
##
####################################

####################################
## Convenience methods
####################################

## GAP-Hack in order to avoid the pre-installed GAP-method DirectProduct
BindGlobal( "CAP_INTERNAL_DIRECT_PRODUCT_SAVE", DirectProduct );

MakeReadWriteGlobal( "DirectProduct" );

DirectProduct := function( arg )
  
  if Length( arg ) = 1
     and IsList( arg[1] ) 
     and ForAll( arg[1], IsCapCategoryObject ) then
     
     return DirectProductOp( arg[1], arg[1][1] );
     
  fi;
  
  if ( ForAll( arg, IsCapCategory ) or ForAll( arg, IsCapCategoryObject ) or ForAll( arg, IsCapCategoryMorphism ) ) and Length( arg ) > 0 then
      
      return DirectProductOp( arg, arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DIRECT_PRODUCT_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "DirectProduct" );

##
InstallGlobalFunction( UniversalMorphismIntoDirectProduct,

  function( arg )
    local diagram;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoDirectProductOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    ##convenience: UniversalMorphismIntoDirectProduct( test_projection_1, ..., test_projection_k )
    diagram := List( arg, Range );
    
    return UniversalMorphismIntoDirectProductOp( diagram, arg, diagram[1] );
  
end );

####################################
## Categorical methods
####################################

##
InstallMethod( ProjectionInFactorOfDirectProduct,
               [ IsList, IsInt ],
               
  function( object_product_list, projection_number )
    
    return ProjectionInFactorOfDirectProductOp( object_product_list, projection_number, object_product_list[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( DirectProductFunctorial,
               [ IsList ],
                                  
  function( morphism_list )
    
    return DirectProductFunctorialOp( morphism_list, morphism_list[1] );
    
end );


####################################
##
## Direct sum
##
####################################

####################################
## Technical methods
####################################

## Immediate methods which link DirectProduct and Coproduct to
## DirectSum in the additive case
InstallImmediateMethod( IS_IMPLIED_DIRECT_SUM,
                        IsCapCategoryObject and WasCreatedAsDirectProduct and IsAdditiveCategory,
                        0,
                        
  function( direct_product )
    local summands;
    
    summands := Genesis( direct_product )!.DirectProductDiagram;
    
    SetDirectSumOp( summands, summands[1], direct_product );
    
    AddToGenesis( direct_product, "DirectProductDiagram", summands );
    
    AddToGenesis( direct_product, "CoproductDiagram", summands ); 
    
    SetFilterObj( direct_product, WasCreatedAsDirectSum );
    
    SetFilterObj( direct_product, WasCreatedAsCoproduct );
    
    SetCoproductOp( summands, summands[1], direct_product );
    
    return true;
    
end );

InstallImmediateMethod( IS_IMPLIED_DIRECT_SUM,
                        IsCapCategoryObject and WasCreatedAsCoproduct and IsAdditiveCategory,
                        0,
                        
  function( coproduct )
    local summands;
  
    summands := Genesis( coproduct )!.CoproductDiagram;
  
    SetDirectSumOp( summands, summands[1], coproduct );
    
    AddToGenesis( coproduct, "DirectProductDiagram", summands );
    
    AddToGenesis( coproduct, "CoproductDiagram", summands ); 
    
    SetFilterObj( coproduct, WasCreatedAsDirectSum );
    
    SetFilterObj( coproduct, WasCreatedAsDirectProduct );
    
    SetDirectProductOp( summands, summands[1], coproduct );
    
    return true;
    
end );

####################################
## Convenience methods
####################################

## GAP-Hack in order to avoid the pre-installed GAP-method DirectSum
BindGlobal( "CAP_INTERNAL_DIRECT_SUM_SAVE", DirectSum );

MakeReadWriteGlobal( "DirectSum" );

DirectSum := function( arg )
  
  if Length( arg ) = 1
     and IsList( arg[1] )
     and ForAll( arg[1], IsCapCategoryObject ) then
     
     return DirectSumOp( arg[1], arg[1][1] );
     
   fi;
  
  if ( ForAll( arg, IsCapCategory ) or ForAll( arg, IsCapCategoryObject ) or ForAll( arg, IsCapCategoryMorphism ) ) and Length( arg ) > 0 then
      
      return DirectSumOp( arg, arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DIRECT_SUM_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "DirectSum" );

####################################
## Add methods
####################################

##
BindGlobal( "CAP_INTERNAL_ADD_DIRECT_SUM_RECORD", 
            ShallowCopy( CAP_INTERNAL_METHOD_NAME_RECORD.DirectSum ) );

CAP_INTERNAL_ADD_DIRECT_SUM_RECORD.function_name := "DirectSum";

CAP_INTERNAL_ADD_DIRECT_SUM_RECORD.post_function :=
  function( object_product_list, method_selection_object, direct_sum )
    
    AddToGenesis( direct_sum, "DirectProductDiagram", object_product_list );
        
    AddToGenesis( direct_sum, "CoproductDiagram", object_product_list );
    
    SetFilterObj( direct_sum, WasCreatedAsDirectSum );
    
    ## this will treat direct_sum as if it was a direct product (see immediate method above)
    SetFilterObj( direct_sum, WasCreatedAsDirectProduct );
    
    ## this will treat direct_sum as if it was a coproduct (see immediate method above)
    SetFilterObj( direct_sum, WasCreatedAsCoproduct );
    
end;

####################################
## Functorial operations
####################################

##
InstallMethod( DirectSumFunctorial,
               [ IsList ],
                                  
  function( morphism_list )
    
    return DirectSumFunctorialOp( morphism_list, morphism_list[1] );
    
end );

####################################
## Categorical methods
####################################

##
InstallMethod( MorphismBetweenDirectSums,
               [ IsList ],
               
  function( morphism_matrix )
    local morphism_matrix_listlist, row, rows, cols;
    
    morphism_matrix_listlist := [ ];
    
    for row in morphism_matrix do
      
      Append( morphism_matrix_listlist, row );
      
    od;
    
    rows := Length( morphism_matrix );
    
    cols := Length( morphism_matrix[1] );
    
    return MorphismBetweenDirectSumsOp( morphism_matrix_listlist, rows, cols, morphism_matrix[1][1] );
    
end );

##
InstallMethodWithCacheFromObject( MorphismBetweenDirectSumsOp,
                                  [ IsList, IsInt, IsInt, IsCapCategoryMorphism ],
                                  
  function( morphism_matrix_listlist, rows, cols, caching_object )
    local morphism_matrix, i, diagram_direct_sum_source, diagram_direct_sum_range, test_diagram_product, test_diagram_coproduct, morphism_into_product;
    
    Error( "test" );
    
    morphism_matrix := [ ];
    
    for i in [ 1 .. rows ] do
      
      Add( morphism_matrix, morphism_matrix_listlist{[(i-1)*cols + 1 .. i*cols]} );
      
    od;
    
    diagram_direct_sum_source := List( morphism_matrix, row -> Source( row[1] ) );
    
    diagram_direct_sum_range := List( morphism_matrix[1], entry -> Range( entry ) );
    
    test_diagram_coproduct := [ ];
    
    for test_diagram_product in morphism_matrix do
      
      Add( test_diagram_coproduct, UniversalMorphismIntoDirectProduct( diagram_direct_sum_range, test_diagram_product ) );
      
    od;
    
    return UniversalMorphismFromCoproduct( diagram_direct_sum_source, test_diagram_coproduct );
    
end: ArgumentNumber := 4 );

####################################
##
## Zero Object
##
####################################

####################################
## Technical methods
####################################

## Immediate methods which link InitialObject and TerminalObject to
## ZeroObject in the additive case
InstallImmediateMethod( IS_IMPLIED_ZERO_OBJECT,
                        IsCapCategoryObject and WasCreatedAsTerminalObject and IsAdditiveCategory,
                        0,
                        
  function( terminal_object )
    local category;
    
    category := CapCategory( terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsZeroObject );
    
    SetZeroObject( category, terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsInitialObject );
    
    SetInitialObject( category, terminal_object );
    
    return true;
    
end );

##
InstallImmediateMethod( IS_IMPLIED_ZERO_OBJECT,
                        IsCapCategoryObject and WasCreatedAsInitialObject and IsAdditiveCategory,
                        0,
                        
  function( initial_object )
    local category;
    
    category := CapCategory( initial_object );
    
    SetFilterObj( initial_object, WasCreatedAsZeroObject );
    
    SetZeroObject( category, initial_object );
    
    SetFilterObj( initial_object, WasCreatedAsTerminalObject );
    
    SetTerminalObject( category, initial_object );
    
    return true;
    
end );

####################################
## Convenience methods
####################################

##
InstallMethod( ZeroObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return ZeroObject( CapCategory( cell ) );
    
end );

##
InstallMethod( MorphismFromZeroObject,
               [ IsCapCategoryObject ],
               
   function( obj )
   
     return UniversalMorphismFromInitialObject( obj );
   
end );

##
InstallMethod( MorphismIntoZeroObject,
               [ IsCapCategoryObject ],
               
   function( obj )
   
     return UniversalMorphismIntoTerminalObject( obj );
   
end );

####################################
## Add methods
####################################

InstallMethod( AddZeroObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddZeroObject( category, func, 100 );
    
end );

##
InstallMethod( AddZeroObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    
    SetZeroObjectFunction( category, func );
    
    SetCanComputeZeroObject( category, true );
    
    AddPrimitiveOperation( category!.derivations_weight_list, "ZeroObject", weight );
    
end );

##
InstallMethodWithToDoForIsWellDefined( ZeroObject,
                                       [ IsCapCategory ],
                                       
  function( category )
    local zero_object;
    
    if not CanComputeZeroObject( category ) then
        
        Error( "no possibility to construct zero object" );
        
    fi;
    
    zero_object := ZeroObjectFunction( category )();
    
    Add( category, zero_object );
    
    SetIsWellDefined( zero_object, true );
    
    SetIsZero( zero_object, true );
    
    SetFilterObj( zero_object, WasCreatedAsZeroObject );
    
    ## this will treat zero_object as if it was a terminal object (see immediate method above)
    SetFilterObj( zero_object, WasCreatedAsTerminalObject );
    
    ## this will treat zero_object as if it was an initial object (see immediate method above)
    SetFilterObj( zero_object, WasCreatedAsInitialObject );
    
    return zero_object;
    
end );

####################################
##
## Terminal Object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( TerminalObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return TerminalObject( CapCategory( cell ) );
    
end );

####################################
## Add methods
####################################

##
InstallMethod( AddTerminalObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddTerminalObject( category, func, 100 );
    
end );

##
InstallMethod( AddTerminalObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    
    SetTerminalObjectFunction( category, func );
    
    SetCanComputeTerminalObject( category, true );
    
    AddPrimitiveOperation( category!.derivations_weight_list, "TerminalObject", weight );
    
end );

##
# Because the diagram of the terminal object is empty, the user
# must not install UniversalMorphismIntoTerminalObject without installing TerminalObject.
# Thus the following implication is unnecessary:
# InstallTrueMethod( CanComputeTerminalObject, CanComputeUniversalMorphismIntoTerminalObject );

## Maybe set IsWellDefined by default.
InstallMethod( TerminalObject,
               [ IsCapCategory and HasTerminalObjectFunction ],
               
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObjectFunction( category )();
    
    Add( category, terminal_object );
    
    SetIsWellDefined( terminal_object, true );
    
    SetFilterObj( terminal_object, WasCreatedAsTerminalObject );
    
    return terminal_object;
    
end );

##
BindGlobal( "CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_RECORD", 
            ShallowCopy( CAP_INTERNAL_METHOD_NAME_RECORD.UniversalMorphismIntoTerminalObject ) );

CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_RECORD.function_name := "UniversalMorphismIntoTerminalObject";

CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_RECORD.redirect_function :=
  function( test_source )
    local category;
    
    category := CapCategory( test_source );
        
    if HasTerminalObject( category ) then
    
      return [ true, UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( category ) ) ];
      
    fi;
    
    return [ false ];
    
end;

CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_RECORD.post_function :=
  function( test_source, universal_morphism )
    local category, terminal_object;
    
    category := CapCategory( test_source );
    
    terminal_object := Range( universal_morphism );
    
    SetTerminalObject( category, terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsTerminalObject );
    
end;

####################################
##
## Initial Object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( InitialObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return InitialObject( CapCategory( cell ) );
    
end );

####################################
## Add methods
####################################

##
InstallMethod( AddInitialObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddInitialObject( category, func, 100 );
    
end );

##
InstallMethod( AddInitialObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    
    SetInitialObjectFunction( category, func );
    
    SetCanComputeInitialObject( category, true );
    
    AddPrimitiveOperation( category!.derivations_weight_list, "InitialObject", weight );
    
end );

##
# Because the diagram of the initial object is empty, the user
# must not install UniversalMorphismFromInitialObject without installing InitialObject.
# Thus the following implication is unnecessary:
# InstallTrueMethod( CanComputeInitialObject, CanComputeUniversalMorphismFromInitialObject );

## Maybe set IsWellDefined by default?
InstallMethod( InitialObject,
               [ IsCapCategory and HasInitialObjectFunction ],
               
  function( category )
    local initial_object;
    
    initial_object := InitialObjectFunction( category )();
    
    Add( category, initial_object );
    
    SetIsWellDefined( initial_object, true );
    
    SetFilterObj( initial_object, WasCreatedAsInitialObject );
    
    return initial_object;
    
end );

##
BindGlobal( "CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_RECORD", 
            ShallowCopy( CAP_INTERNAL_METHOD_NAME_RECORD.UniversalMorphismFromInitialObject ) );

CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_RECORD.function_name := "UniversalMorphismFromInitialObject";

CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_RECORD.redirect_function :=
  function( test_sink )
    local category;
    
    category := CapCategory( test_sink );
    
    if HasInitialObject( category ) then
      
      return [ true, UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( category ) ) ];
      
    fi;
    
    return [ false ];
    
end;

CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_RECORD.post_function :=
  function( test_sink, universal_morphism )
    local category, initial_object;
    
    category := CapCategory( test_sink );
    
    initial_object := Source( universal_morphism );
    
    SetInitialObject( category, initial_object );
    
    SetFilterObj( initial_object, WasCreatedAsInitialObject );
    
end;

####################################
##
## FiberProduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( FiberProduct,
  
  function( arg )
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return FiberProductOp( arg[1], arg[1][1] );
       
     fi;
    
    return FiberProductOp( arg, arg[ 1 ] );
    
end );

##
InstallMethod( ProjectionInFactorOfFiberProduct,
               [ IsList, IsInt ],
               
  function( diagram, projection_number )
    
    return ProjectionInFactorOfFiberProductOp( diagram, projection_number, diagram[1] );
    
end );

##
InstallGlobalFunction( UniversalMorphismIntoFiberProduct,

  function( arg )
    local diagram, pullback_or_diagram, source;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoFiberProductOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    pullback_or_diagram := arg[ 1 ];
    
    source := arg{[ 2 .. Length( arg ) ]};
    
    if WasCreatedAsFiberProduct( pullback_or_diagram ) then
    
      diagram := Genesis( pullback_or_diagram )!.FiberProductDiagram;
    
      return UniversalMorphismIntoFiberProductOp( diagram, source, diagram[1] );
    
    fi;
    
    return UniversalMorphismIntoFiberProductOp( pullback_or_diagram, source, pullback_or_diagram[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( FiberProductFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return FiberProductFunctorialOp( morphism_of_morphisms, morphism_of_morphisms[1][1] );
      
end );

####################################
##
## Pushout
##
####################################

InstallGlobalFunction( Pushout,
  
  function( arg )
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return PushoutOp( arg[1], arg[1][1] );
       
     fi;
    
    return PushoutOp( arg, arg[ 1 ] );
    
end );

####################################
## Add Operations
####################################

##
InstallMethod( AddPushout,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetPushoutFunction( category, func );
    
    SetCanComputePushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( PushoutOp,
                                           [ IsList, IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( diagram, method_selection_morphism )
        local cobase, pushout;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
        fi;
        
        pushout := func( diagram );
        
        SetFilterObj( pushout, WasCreatedAsPushout );
        
        AddToGenesis( pushout, "PushoutDiagram", diagram );
        
        Add( category, pushout );
        
        return pushout;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "PushoutOp", 2 ) );
    
end );

## convenience method
##
InstallMethod( InjectionOfCofactorOfPushout,
               [ IsList, IsInt ],
               
  function( diagram, injection_number )
    
    return InjectionOfCofactorOfPushoutOp( diagram, injection_number, diagram[1] );
    
end );

##
InstallMethod( AddInjectionOfCofactorOfPushout,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorOfPushoutFunction( category, func );
    
    SetCanComputeInjectionOfCofactorOfPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfPushoutOp,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryMorphism and MorphismFilter( category ), ],
                                             
      function( diagram, injection_number, method_selection_morphism )
        local cobase, injection_of_cofactor, pushout;
        
        if HasPushoutOp( diagram, method_selection_morphism ) then
          
          return InjectionOfCofactorOfPushoutWithGivenPushout( diagram, injection_number, PushoutOp( diagram, method_selection_morphism ) );
          
        fi;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
        fi;
        
        injection_of_cofactor := func( diagram, injection_number );
        
        Add( CapCategory( method_selection_morphism ), injection_of_cofactor );
        
        pushout := Range( injection_of_cofactor );
        
        AddToGenesis( pushout, "PushoutDiagram", diagram );

        SetPushoutOp( diagram, method_selection_morphism, pushout );
        
        SetFilterObj( pushout, WasCreatedAsPushout );
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorOfPushoutOp", 3 ) );

end );

##
InstallMethod( AddInjectionOfCofactorOfPushoutWithGivenPushout,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorOfPushoutWithGivenPushoutFunction( category, func );
    
    SetCanComputeInjectionOfCofactorOfPushoutWithGivenPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfPushoutWithGivenPushout,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                             
      function( diagram, injection_number, pushout )
        local cobase, injection_of_cofactor;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
        fi;
        
        injection_of_cofactor := func( diagram, injection_number, pushout );
        
        Add( category, injection_of_cofactor );
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorOfPushoutWithGivenPushout", 3 ) );

end );

##
InstallGlobalFunction( UniversalMorphismFromPushout,

  function( arg )
    local diagram, pushout_or_diagram, sink;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromPushoutOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    pushout_or_diagram := arg[ 1 ];
    
    sink := arg{[ 2 .. Length( arg ) ]};
    
    if WasCreatedAsPushout( pushout_or_diagram ) then
    
      diagram := Genesis( pushout_or_diagram )!.PushoutDiagram;
    
      return UniversalMorphismFromPushoutOp( diagram, sink, diagram[1] );
    
    fi;
    
    return UniversalMorphismFromPushoutOp( pushout_or_diagram, sink, pushout_or_diagram[1] );
    
end );

##
InstallMethod( AddUniversalMorphismFromPushout,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromPushoutFunction( category, func );
    
    SetCanComputeUniversalMorphismFromPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( diagram, sink, method_selection_morphism )
        local cobase, test_object, components, universal_morphism, pushout;
        
        if HasPushoutOp( diagram, diagram[1] ) then
        
          return UniversalMorphismFromPushoutWithGivenPushout( 
                   diagram, 
                   sink,
                   PushoutOp( diagram, diagram[1] )
                 );
          
        fi;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
        fi;
        
        test_object := Range( sink[1] );
        
        components := sink;
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be equal in given sink-diagram" );
            
        fi;
        
        ## here the user also needs the diagram
        universal_morphism := func( diagram, sink );
        
        Add( category, universal_morphism );
        
        pushout := Source( universal_morphism );
        
        AddToGenesis( pushout, "PushoutDiagram",diagram );
        
        SetPushoutOp( diagram, diagram[1], pushout );
        
        Add( CapCategory( diagram[1] ), pushout );
        
        SetFilterObj( pushout, WasCreatedAsPushout );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromPushoutOp", 3 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromPushoutWithGivenPushout,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromPushoutWithGivenPushoutFunction( category, func );
    
    SetCanComputeUniversalMorphismFromPushoutWithGivenPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutWithGivenPushout,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryObject and ObjectFilter( category ) 
                                           ],
                                           
      function( diagram, sink, pushout )
        local cobase, test_object, components, universal_morphism;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
        fi;
        
        test_object := Range( sink[1] );
        
        components := sink; #FIXME: components superfluous
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be equal in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( diagram, sink, pushout );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromPushoutWithGivenPushout", 3 ) );
    
end );



####################################
## Functorial operations
####################################

##
InstallMethod( PushoutFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return PushoutFunctorialOp( morphism_of_morphisms, morphism_of_morphisms[1][1] );
      
end );


####################################
##
## Image
##
####################################

##
InstallMethod( AddImageObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetImageFunction( category, func );
    
    SetCanComputeImageObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageObject,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local image;
        
        image := func( mor );
        
        Add( category, image );
        
        SetFilterObj( image, WasCreatedAsImageObject );
        
        AddToGenesis( image, "ImageDiagram", mor );
        
        return image;
        
    end );
    
end );

##
InstallMethod( AddImageEmbedding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetImageEmbeddingFunction( category, func );
    
    SetCanComputeImageEmbedding( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageEmbedding,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local image_embedding, image;
        
        if HasImageObject( mor ) then
        
          return ImageEmbeddingWithGivenImageObject( mor, ImageObject( mor ) );
        
        fi;
        
        image_embedding := func( mor );
        
        Add( CapCategory( mor ), image_embedding );
        
        ##Implication (by definition of an image)
        SetIsMonomorphism( image_embedding, true );
        
        image := Source( image_embedding );
        
        AddToGenesis( image, "ImageDiagram", mor );
        
        SetFilterObj( image, WasCreatedAsImageObject );
        
        SetImageObject( mor, image );
        
        return image_embedding;
        
    end );
    
end );

##
InstallMethod( AddImageEmbeddingWithGivenImageObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetImageEmbeddingWithGivenImageObjectFunction( category, func );
    
    SetCanComputeImageEmbeddingWithGivenImageObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageEmbeddingWithGivenImageObject,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, image )
        local image_embedding;
        
        image_embedding := func( mor, image );
        
        Add( category, image_embedding );
        
        return image_embedding;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ImageEmbeddingWithGivenImageObject", 2 ) );
    
end );

##
InstallMethod( AddCoastrictionToImage,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCoastrictionToImageFunction( category, func );
    
    SetCanComputeCoastrictionToImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CoastrictionToImage,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( morphism )
        local coastriction_to_image, image;
        
        if HasImageObject( morphism ) then
        
          return CoastrictionToImageWithGivenImageObject( morphism, ImageObject( morphism ) );
        
        fi;
        
        coastriction_to_image := func( morphism );
        
        Add( CapCategory( morphism ), coastriction_to_image );
        
        image := Range( coastriction_to_image );
        
        AddToGenesis( image, "ImageDiagram", morphism );
        
        SetFilterObj( image, WasCreatedAsImageObject );
        
        SetImageObject( morphism, image );
        
        return coastriction_to_image;
        
    end );
    
end );

##
InstallMethod( AddCoastrictionToImageWithGivenImageObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCoastrictionToImageWithGivenImageObjectFunction( category, func );
    
    SetCanComputeCoastrictionToImageWithGivenImageObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CoastrictionToImageWithGivenImageObject,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( morphism, image )
        local coastriction_to_image;
        
        coastriction_to_image := func( morphism, image );
        
        Add( category, coastriction_to_image );
        
        return coastriction_to_image;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CoastrictionToImageWithGivenImageObject", 2 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromImage,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromImageFunction( category, func );
    
    SetCanComputeUniversalMorphismFromImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImage,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsList ],
                                           
      function( morphism, test_factorization )
        local universal_morphism, image;
        
        if HasImageObject( morphism ) then
          
          return UniversalMorphismFromImageWithGivenImageObject(
                   morphism,
                   test_factorization,
                   ImageObject( morphism )
                 );
          
        fi;
        
        if ( Source( morphism ) <> Source( test_factorization[1] ) )
           or ( Range( morphism ) <> Range( test_factorization[2] ) )
           or ( Range( test_factorization[1] ) <> Range( test_factorization[2] ) ) then
            
            Error( "the input is not a proper factorization\n" );
            
        fi;
        
        universal_morphism := func( morphism, test_factorization );
        
        Add( category, universal_morphism );
        
        image := Source( universal_morphism );
        
        AddToGenesis( image, "ImageDiagram", morphism );
        
        SetImageObject( morphism, image );
        
        SetFilterObj( image, WasCreatedAsImageObject );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromImage", 2 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromImageWithGivenImageObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromImageWithGivenImageObjectFunction( category, func );
    
    SetCanComputeUniversalMorphismFromImageWithGivenImageObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImageWithGivenImageObject,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsList,
                                             IsCapCategoryObject ],
                                           
      function( morphism, test_factorization, image )
        local universal_morphism;
        
        if ( Source( morphism ) <> Source( test_factorization[1] ) )
           or ( Range( morphism ) <> Range( test_factorization[2] ) )
           or ( Range( test_factorization[1] ) <> Range( test_factorization[2] ) ) then
            
            Error( "the input is not a proper factorization\n" );
            
        fi;
        
        ##FIXME: this is a monomorphism if test_factorization[2] was a monomorphism (i.e. a proper input)
        universal_morphism := func( morphism, test_factorization, image );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromImageWithGivenImageObject", 3 ) );
    
end );

####################################
##
## Attributes
##
####################################

InstallMethod( ImageEmbedding,
               [ IsCapCategoryObject and WasCreatedAsImageObject ],
               
  function( image )
    
    return ImageEmbedding( Genesis( image )!.ImageDiagram );
    
end );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryObject and WasCreatedAsImageObject ],
               
  function( image )
    
    return CoastrictionToImage( Genesis( image )!.ImageDiagram );
    
end );


####################################
##
## Scheme for Universal Object
##
####################################

####################################
## Add Operations
####################################

####################################
## Attributes
####################################

####################################
## Implied Operations
####################################

