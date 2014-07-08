#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Universal Objects
##
#############################################################################

####################################
##
## Kernel
##
####################################

####################################
## Add Operations
####################################

##
InstallMethod( AddKernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelFunction( category, func );
    
    SetCanComputeKernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelObject,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local kernel;
        
        kernel := func( mor );
        
        Add( HomalgCategory( mor ), kernel );
        
        SetFilterObj( kernel, WasCreatedAsKernel );
        
        SetGenesis( kernel, rec( diagram := mor ) );
        
        return kernel;
        
    end );
    
end );

##
InstallMethod( AddKernelLift,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelLiftFunction( category, func );
    
    SetCanComputeKernelLift( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "KernelLift", 2 );
    
    InstallMethodWithToDoForIsWellDefined( KernelLift,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor, test_morphism )
        local kernel_lift, kernel;
        
        if HasKernelObject( mor ) then
        
          return KernelLiftWithGivenKernel( mor, test_morphism, KernelObject( mor ) );
        
        fi;
        
        kernel_lift := func( mor, test_morphism );
        
        Add( HomalgCategory( mor ), kernel_lift );

        kernel := Range( kernel_lift );
        
        SetKernelObject( mor, kernel );
        
        SetFilterObj( kernel, WasCreatedAsKernel );
        
        SetGenesis( kernel, rec( diagram := mor ) );
        
        return kernel_lift;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##
InstallMethod( AddKernelLiftWithGivenKernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelLiftWithGivenKernelFunction( category, func );
    
    SetCanComputeKernelLiftWithGivenKernel( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "KernelLiftWithGivenKernel", 3 );
    
    InstallMethodWithToDoForIsWellDefined( KernelLiftWithGivenKernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, test_morphism, kernel )
        local kernel_lift;
        
        kernel_lift := func( mor, test_morphism, kernel );
        
        Add( HomalgCategory( mor ), kernel_lift );
        
        return kernel_lift;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##
InstallMethod( AddKernelEmb,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelEmbFunction( category, func );
    
    SetCanComputeKernelEmb( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelEmb,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local kernel_emb, kernel;
        
        if HasKernelObject( mor ) then
          
          return KernelEmbWithGivenKernel( mor, KernelObject( mor ) );
          
        fi;
        
        kernel_emb := func( mor );
        
        Add( HomalgCategory( mor ), kernel_emb );
        
        SetIsMonomorphism( kernel_emb, true );
        
        kernel := Source( kernel_emb );
        
        SetKernelObject( mor, kernel );
        
        SetFilterObj( kernel, WasCreatedAsKernel );
        
        SetGenesis( kernel, rec( diagram := mor ) );
        
        SetKernelEmb( kernel, kernel_emb );
        
        return kernel_emb;
        
    end );
    
end );

##
InstallMethod( AddKernelEmbWithGivenKernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelEmbWithGivenKernelFunction( category, func );
    
    SetCanComputeKernelEmbWithGivenKernel( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "KernelEmbWithGivenKernel", 2 );
    
    InstallMethodWithToDoForIsWellDefined( KernelEmbWithGivenKernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, kernel )
        local kernel_emb;
        
        kernel_emb := func( mor, kernel );
        
        Add( HomalgCategory( mor ), kernel_emb );
        
        SetIsMonomorphism( kernel_emb, true );
        
        SetKernelEmb( kernel, kernel_emb );
        
        return kernel_emb;
        
    end : InstallMethod := InstallMethodWithCache );

end );


####################################
## Attributes
####################################

##
InstallMethod( KernelEmb,
               [ IsHomalgCategoryObject and WasCreatedAsKernel ],
               
  function( kernel )
  
    return KernelEmb( Genesis( kernel )!.diagram );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeKernelLift, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

InstallMethodWithCacheFromObject( KernelLift,
                                  [ IsHomalgCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsHomalgCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                                    -9999, #FIXME
                                    
  function( mor, test_morphism )
    
    return MonoAsKernelLift( KernelEmb( mor ), test_morphism );
    
end );

##
InstallTrueMethod( CanComputeKernel, CanComputeKernelEmb );

InstallMethod( KernelObject,
               [ IsHomalgCategoryMorphism and CanComputeKernelEmb ],
               -9999, #FIXME
               
  function( mor )
    
    return Source( KernelEmb( mor ) );
    
end );


##
InstallTrueMethod( CanComputeKernelEmb, CanComputeKernel and CanComputeKernelEmbWithGivenKernel );

InstallMethod( KernelEmb,
               [ IsHomalgCategoryMorphism and CanComputeKernel and CanComputeKernelEmbWithGivenKernel ],
               -9999, #FIXME
               
  function( mor )
    
    return KernelEmbWithGivenKernel( mor, KernelObject( mor ) );
    
end );

####################################
##
## Cokernel
##
####################################

####################################
## Add Operations
####################################

##
InstallMethod( AddCokernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelFunction( category, func );
    
    SetCanComputeCokernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( Cokernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local cokernel;
        
        cokernel := func( mor );
        
        Add( HomalgCategory( mor ), cokernel );
        
        SetFilterObj( cokernel, WasCreatedAsCokernel );
        
        SetGenesis( cokernel, rec( diagram := mor ) );
        
        return cokernel;
        
    end );
    
end );

##
InstallMethod( AddCokernelColift,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelColiftFunction( category, func );
    
    SetCanComputeCokernelColift( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "CokernelColift", 2 );
    
    InstallMethodWithToDoForIsWellDefined( CokernelColift,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor, test_morphism )
        local cokernel_colift, cokernel;
        
        if HasCokernel( mor ) then
          
          return CokernelColiftWithGivenCokernel( mor, test_morphism, Cokernel( mor ) );
          
        fi;
        
        cokernel_colift := func( mor, test_morphism );
        
        Add( HomalgCategory( mor ), cokernel_colift );
        
        cokernel := Source( cokernel_colift );
        
        SetFilterObj( cokernel, WasCreatedAsCokernel );
        
        SetGenesis( cokernel, rec( diagram := mor ) );
        
        return cokernel_colift;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##
InstallMethod( AddCokernelColiftWithGivenCokernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelColiftWithGivenCokernelFunction( category, func );
    
    SetCanComputeCokernelColiftWithGivenCokernel( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "CokernelColiftWithGivenCokernel", 3 );
    
    InstallMethodWithToDoForIsWellDefined( CokernelColiftWithGivenCokernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, test_morphism, cokernel )
        local cokernel_colift;
        
        cokernel_colift := func( mor, test_morphism, cokernel );
        
        Add( HomalgCategory( mor ), cokernel_colift );
        
        return cokernel_colift;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##
InstallMethod( AddCokernelProj,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelProjFunction( category, func );
    
    SetCanComputeCokernelProj( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CokernelProj,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local cokernel_proj, cokernel;
        
        if HasCokernel( mor ) then
          
          return CokernelProjWithGivenCokernel( mor, Cokernel( mor ) );
          
        fi;
        
        cokernel_proj := func( mor );
        
        Add( HomalgCategory( mor ), cokernel_proj );
        
        SetIsEpimorphism( cokernel_proj, true );

        cokernel := Range( cokernel_proj );
        
        SetCokernel( mor, cokernel );
        
        SetGenesis( cokernel, rec( diagram := mor ) );

        SetCokernelProj( cokernel, cokernel_proj );
        
        return cokernel_proj;
        
    end );
    
end );

##
InstallMethod( AddCokernelProjWithGivenCokernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelProjWithGivenCokernelFunction( category, func );
    
    SetCanComputeCokernelProjWithGivenCokernel( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "CokernelProjWithGivenCokernel", 2 );
    
    InstallMethodWithToDoForIsWellDefined( CokernelProjWithGivenCokernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, cokernel )
        local cokernel_proj;
        
        cokernel_proj := func( mor, cokernel );
        
        Add( HomalgCategory( mor ), cokernel_proj );
        
        SetIsEpimorphism( cokernel_proj, true );

        SetCokernelProj( cokernel, cokernel_proj );
        
        return cokernel_proj;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

####################################
## Attributes 
####################################

##
InstallMethod( CokernelProj,
               [ IsHomalgCategoryObject and WasCreatedAsCokernel ],
               
  function( cokernel )
    
    return CokernelProj( Genesis( cokernel )!.diagram );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeCokernelColift, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

InstallMethodWithCacheFromObject( CokernelColift,
                                  [ IsHomalgCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsHomalgCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                                  -9999, #FIXME
                                  
  function( mor, test_morphism )
    
    return EpiAsCokernelColift( CokernelProj( mor ), test_morphism );
    
end );


##
InstallTrueMethod( CanComputeCokernel, CanComputeCokernelProj );

InstallMethod( Cokernel,
               [ IsHomalgCategoryMorphism and CanComputeCokernelProj ],
               -9999, #FIXME
                                  
  function( mor )
    
    return Range( CokernelProj( mor ) );
    
end );

##
InstallTrueMethod( CanComputeCokernelProj, CanComputeCokernel and CanComputeCokernelProjWithGivenCokernel );

InstallMethod( CokernelProj,
               [ IsHomalgCategoryMorphism and CanComputeCokernel and CanComputeCokernelProjWithGivenCokernel ],
               -9999, #FIXME
               
  function( mor )
    
    return CokernelProjWithGivenCokernel( mor, Cokernel( mor ) );
    
end );

####################################
##
## Direct Product for multiple objects
##
####################################

## GAP-Hack in order to avoid the pre-installed GAP-method DirectProduct
BindGlobal( "HOMALG_CATEGORIES_DIRECT_PRODUCT_SAVE", DirectProduct );

MakeReadWriteGlobal( "DirectProduct" );

DirectProduct := function( arg )
  
  if ( ForAll( arg, IsHomalgCategory ) or ForAll( arg, IsHomalgCategoryObject ) or ForAll( arg, IsHomalgCategoryMorphism ) ) and Length( arg ) > 0 then
      
      if Length( arg ) = 1 then 
      
        return arg[1];
        
      fi;
      
      return DirectProductOp( CallFuncList( Product, arg ), arg[ 1 ] );
      
  fi;
  
  return CallFuncList( HOMALG_CATEGORIES_DIRECT_PRODUCT_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "DirectProduct" );

##
InstallMethod( AddDirectProduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetDirectProductFunction( category, func );
    
    SetCanComputeDirectProduct( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "DirectProductOp", 2 );
    
    InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                           [ IsHomalgCategoryObject, IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local direct_product_for_multiple_objects;
        
        direct_product_for_multiple_objects := func( object_product_list );
        
        Add( HomalgCategory( method_selection_object ), direct_product_for_multiple_objects );
        
        SetFilterObj( direct_product_for_multiple_objects, WasCreatedAsDirectProduct );
        
        SetGenesis( direct_product_for_multiple_objects, rec( DirectFactors := object_product_list ) );
        
        return direct_product_for_multiple_objects;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##TODO: Install AddProjectionInFactor convenient method with 
##the direct product object as an input

##
InstallMethod( ProjectionInFactor,
               [ IsHomalgCategoryObject, IsInt ],
               
  function( object_product_list, projection_number )
    local number_of_objects;
    
    if WasCreatedAsDirectProduct( object_product_list ) then
    
      number_of_objects := Length( Components( Genesis( object_product_list )!.DirectFactors ) );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorWithGivenDirectProduct( Genesis( object_product_list )!.DirectFactors, object_product_list, projection_number );
    
    fi;
    
    number_of_objects := Length( Components( object_product_list ) );
  
    if projection_number < 0 or projection_number > number_of_objects then
    
      Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
    
    fi;
  
    if number_of_objects = 1 then
        
      return IdentityMorphism( object_product_list[1] );
          
    fi;
  
    return ProjectionInFactorOp( object_product_list, object_product_list[1], projection_number );
  
end );

##
InstallMethod( AddProjectionInFactor,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorFunction( category, func );
    
    SetCanComputeProjectionInFactor( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "ProjectionInFactorOp", 3 );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOp,
                                           [ IsHomalgCategoryObject, 
                                             IsHomalgCategoryObject and ObjectFilter( category ), 
                                             IsInt ],
                                             
      function( object_product_list, method_selection_object, projection_number )
        local projection_in_factor, direct_product;
        
        if HasDirectProductOp( object_product_list, method_selection_object ) then
          
          return ProjectionInFactorWithGivenDirectProduct( object_product_list, DirectProductOp( object_product_list, method_selection_object ), projection_number );
          
        fi;
        
        projection_in_factor := func( object_product_list, projection_number );
        
        Add( HomalgCategory( method_selection_object ), projection_in_factor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitEpimorphism( projection_in_factor, true );
          
        fi;
        
        direct_product := Source( projection_in_factor );
        
        SetGenesis( direct_product, rec( DirectFactors := object_product_list ) );
        
        SetDirectProductOp( object_product_list, method_selection_object, direct_product );
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache );

end );

##
InstallMethod( AddProjectionInFactorWithGivenDirectProduct,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorWithGivenDirectProductFunction( category, func );
    
    SetCanComputeProjectionInFactorWithGivenDirectProduct( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "ProjectionInFactorWithGivenDirectProduct", 3 );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorWithGivenDirectProduct,
                                           [ IsHomalgCategoryObject, 
                                             IsHomalgCategoryObject and ObjectFilter( category ), 
                                             IsInt ],
                                             
      function( object_product_list, direct_product, projection_number )
        local projection_in_factor;
        
        projection_in_factor := func( object_product_list, direct_product, projection_number );
        
        Add( category, projection_in_factor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitEpimorphism( projection_in_factor, true );
          
        fi;
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache );

end );

##
InstallGlobalFunction( UniversalMorphismIntoDirectProduct,

  function( arg )
    
    return UniversalMorphismIntoDirectProductOp( CallFuncList( Product, arg ), arg[1] );
  
end );

##
InstallMethod( AddUniversalMorphismIntoDirectProduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoDirectProductFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoDirectProduct( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "UniversalMorphismIntoDirectProductOp", 2 );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( sink, method_selection_morphism )
        local test_object, components, direct_product_objects, universal_morphism, direct_product;
        
        test_object := Source( sink[1] );
        
        components := Components( sink );
        
        direct_product_objects := CallFuncList( Product, List( Components( sink ), Range ) );
        
        if HasDirectProductOp( direct_product_objects, direct_product_objects[1] ) then
          
          return UniversalMorphismIntoDirectProductWithGivenDirectProduct( 
                   sink, 
                   DirectProductOp( direct_product_objects, direct_product_objects[1] ) 
                 );
          
        fi;
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be identical in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( sink );
        
        Add( category, universal_morphism );
        
        direct_product := Range( universal_morphism );
        
        SetGenesis( direct_product, rec( DirectFactors := direct_product_objects ) );
        
        SetDirectProductOp( direct_product_objects, direct_product_objects[1], direct_product );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##
InstallMethod( AddUniversalMorphismIntoDirectProductWithGivenDirectProduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoDirectProductWithGivenDirectProductFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "UniversalMorphismIntoDirectProductWithGivenDirectProduct", 2 );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( sink, direct_product )
        local test_object, components, direct_product_objects, universal_morphism;
        
        test_object := Source( sink[1] );
        
        components := Components( sink );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be identical in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( sink, direct_product );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeDirectProduct, CanComputeProjectionInFactor );

##
InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                       [ IsHomalgCategoryObject,
                                         IsHomalgCategoryObject and CanComputeProjectionInFactor ],
                                        -9999,
                                        
  function( object_product_list, method_selection_object )
    
    return Source( ProjectionInFactor( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoDirectProduct,
                   CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                       [ IsHomalgCategoryMorphism,
                                         IsHomalgCategoryMorphism and CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct ],
                                         -9999, #FIXME
                                       
  function( sink, method_selection_morphism )
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( sink, CallFuncList( DirectProduct, List( Components( sink ), Range ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

##
InstallTrueMethod( CanComputeProjectionInFactor, CanComputeDirectProduct and CanComputeProjectionInFactorWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOp,
                                       [ IsHomalgCategoryObject,
                                         IsHomalgCategoryObject and CanComputeDirectProduct and CanComputeProjectionInFactorWithGivenDirectProduct,
                                         IsInt ],
                                         -9999, #FIXME
                                         
  function( object_product_list, method_selection_object, projection_number )
    
    return ProjectionInFactorWithGivenDirectProduct( object_product_list, CallFuncList( DirectProduct, Components( object_product_list ) ), projection_number );
    
end : InstallMethod := InstallMethodWithCacheFromObject );


####################################
##
## Terminal Object
##
####################################

####################################
## Add Operations
####################################

##
InstallMethod( AddTerminalObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetTerminalObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeTerminalObject );
    
    SetCanComputeTerminalObject( category, true );
    
end );

##
InstallMethod( AddUniversalMorphismIntoTerminalObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoTerminalObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeUniversalMorphismIntoTerminalObject );
    
    SetCanComputeUniversalMorphismIntoTerminalObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoTerminalObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_sink )
        local category, universal_morphism, terminal_object;
        
        category := HomalgCategory( test_sink );
        
        if HasTerminalObject( category ) then
        
          return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_sink, TerminalObject( category ) );
          
        fi;
        
        universal_morphism := func( test_sink );
        
        Add( HomalgCategory( test_sink ), universal_morphism );
        
        terminal_object := Source( universal_morphism );
        
        SetTerminalObject( category, terminal_object );
        
        SetFilterObj( terminal_object, WasCreatedAsTerminalObject );
        
        return universal_morphism;
        
    end );
    
end );

##
InstallMethod( AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoTerminalObjectWithGivenTerminalObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject );
    
    SetCanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "UniversalMorphismIntoDirectProductWithGivenTerminalObject", 2 );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_sink, terminal_object )
        local universal_morphism;
        
        universal_morphism := func( test_sink, terminal_object );
        
        Add( HomalgCategory( test_sink ), universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

####################################
## Attributes
####################################

##
InstallMethod( TerminalObject,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return TerminalObject( HomalgCategory( cell ) );
    
end );

##
# Because the diagram of the terminal object is empty, the user
# must not install UniversalMorphismIntoTerminalObject without installing TerminalObject.
# Thus the following implication is unnecessary:
# InstallTrueMethod( CanComputeTerminalObject, CanComputeUniversalMorphismIntoTerminalObject );

## Maybe set IsWellDefined by default.
InstallMethodWithToDoForIsWellDefined( TerminalObject,
                                       [ IsHomalgCategory ],
                                       
  function( category )
    local terminal_object;
    
    if not CanComputeTerminalObject( category ) then
        
        Error( "no possibility to construct terminal object" );
        
    fi;
    
    terminal_object := TerminalObjectFunction( category )();
    
    Add( category, terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsTerminalObject );
    
    return terminal_object;
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeUniversalMorphismIntoTerminalObject,
                   CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject );

InstallMethod( UniversalMorphismIntoTerminalObject,
               [ IsHomalgCategoryObject and CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject ],
               -9999, #FIXME
              
  function( test_sink )
    
    return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_sink, TerminalObject( HomalgCategory( test_sink ) ) );
    
end );

####################################
##
## Initial Object
##
####################################

####################################
## Add Operations
####################################

##
InstallMethod( AddInitialObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetInitialObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeInitialObject );
    
    SetCanComputeInitialObject( category, true );
    
end );

##
InstallMethod( AddUniversalMorphismFromInitialObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromInitialObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeUniversalMorphismFromInitialObject );
    
    SetCanComputeUniversalMorphismFromInitialObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromInitialObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_source )
        local category, universal_morphism, initial_object;
        
        category := HomalgCategory( test_source );
        
        if HasInitialObject( category ) then
        
          return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_source, InitialObject( category ) );
          
        fi;
        
        universal_morphism := func( test_source );
        
        Add( HomalgCategory( test_source ), universal_morphism );
        
        initial_object := Source( universal_morphism );
        
        SetInitialObject( category, initial_object );
        
        SetFilterObj( initial_object, WasCreatedAsInitialObject );
        
        return universal_morphism;
        
    end );
    
end );

##
InstallMethod( AddUniversalMorphismFromInitialObjectWithGivenInitialObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromInitialObjectWithGivenInitialObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject );
    
    SetCanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "UniversalMorphismFromDirectProductWithGivenInitialObject", 2 );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromInitialObjectWithGivenInitialObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_source, initial_object )
        local universal_morphism;
        
        universal_morphism := func( test_source, initial_object );
        
        Add( HomalgCategory( test_source ), universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

####################################
## Attributes
####################################

##
InstallMethod( InitialObject,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return InitialObject( HomalgCategory( cell ) );
    
end );

##
# Because the diagram of the initial object is empty, the user
# must not install UniversalMorphismFromInitialObject without installing InitialObject.
# Thus the following implication is unnecessary:
# InstallTrueMethod( CanComputeInitialObject, CanComputeUniversalMorphismFromInitialObject );

## Maybe set IsWellDefined by default?
InstallMethodWithToDoForIsWellDefined( InitialObject,
                                       [ IsHomalgCategory ],
                                       
  function( category )
    local initial_object;
    
    if not CanComputeInitialObject( category ) then
        
        Error( "no possibility to construct initial object" );
        
    fi;
    
    initial_object := InitialObjectFunction( category )();
    
    Add( category, initial_object );
    
    SetFilterObj( initial_object, WasCreatedAsInitialObject );
    
    return initial_object;
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeUniversalMorphismFromInitialObject,
                   CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject );

InstallMethod( UniversalMorphismFromInitialObject,
               [ IsHomalgCategoryObject and CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject ],
               -9999, #FIXME
              
  function( test_source )
    
    return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_source, InitialObject( HomalgCategory( test_source ) ) );
    
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

