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
## Add Operations
####################################

##
InstallMethod( AddKernelObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelFunction( category, func );
    
    SetCanComputeKernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelObject,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local kernel;
        
        kernel := func( mor );
        
        Add( CapCategory( mor ), kernel );
        
        SetFilterObj( kernel, WasCreatedAsKernel );
        
        AddToGenesis( kernel, "KernelDiagram", mor );
        
        return kernel;
        
    end );
    
end );

## convenience method
##
InstallMethod( KernelLift,
               [ IsCapCategoryObject, IsCapCategoryMorphism ],
               
  function( kernel, test_morphism )
  
    return KernelLift( Genesis( kernel )!.KernelDiagram, test_morphism );
  
end );

##
InstallMethod( AddKernelLift,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelLiftFunction( category, func );
    
    SetCanComputeKernelLift( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelLift,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor, test_morphism )
        local kernel_lift, kernel;
        
        if HasKernelObject( mor ) then
        
          return KernelLiftWithGivenKernel( mor, test_morphism, KernelObject( mor ) );
        
        fi;
        
        kernel_lift := func( mor, test_morphism );
        
        Add( CapCategory( mor ), kernel_lift );

        kernel := Range( kernel_lift );
        
        SetKernelObject( mor, kernel );
        
        SetFilterObj( kernel, WasCreatedAsKernel );
        
        AddToGenesis( kernel, "KernelDiagram", mor );
        
        return kernel_lift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "KernelLift", 2 ) );
    
end );

##
InstallMethod( AddKernelLiftWithGivenKernel,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelLiftWithGivenKernelFunction( category, func );
    
    SetCanComputeKernelLiftWithGivenKernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelLiftWithGivenKernel,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, test_morphism, kernel )
        local kernel_lift;
        
        kernel_lift := func( mor, test_morphism, kernel );
        
        Add( CapCategory( mor ), kernel_lift );
        
        return kernel_lift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "KernelLiftWithGivenKernel", 3 ) );
    
end );

##
InstallMethod( AddKernelEmb,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelEmbFunction( category, func );
    
    SetCanComputeKernelEmb( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelEmb,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local kernel_emb, kernel;
        
        if HasKernelObject( mor ) then
          
          return KernelEmbWithGivenKernel( mor, KernelObject( mor ) );
          
        fi;
        
        kernel_emb := func( mor );
        
        Add( CapCategory( mor ), kernel_emb );
        
        SetIsMonomorphism( kernel_emb, true );
        
        kernel := Source( kernel_emb );
        
        SetKernelObject( mor, kernel );
        
        SetFilterObj( kernel, WasCreatedAsKernel );
        
        AddToGenesis( kernel, "KernelDiagram", mor );
        
        SetKernelEmb( kernel, kernel_emb );
        
        #Is this necessary (and in all other analogous situations?): SetKernelEmbWithGivenKernel( mor, kernel, kernel_emb );
        
        return kernel_emb;
        
    end );
    
end );

##
InstallMethod( AddKernelEmbWithGivenKernel,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelEmbWithGivenKernelFunction( category, func );
    
    SetCanComputeKernelEmbWithGivenKernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelEmbWithGivenKernel,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, kernel )
        local kernel_emb;
        
        kernel_emb := func( mor, kernel );
        
        Add( CapCategory( mor ), kernel_emb );
        
        SetIsMonomorphism( kernel_emb, true );
        
        SetKernelEmb( kernel, kernel_emb );
        
        return kernel_emb;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "KernelEmbWithGivenKernel", 2 ) );

end );


####################################
## Attributes
####################################

## convenience
##
InstallMethod( KernelEmb,
               [ IsCapCategoryObject and WasCreatedAsKernel ],
               
  function( kernel )
  
    return KernelEmb( Genesis( kernel )!.KernelDiagram );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeKernelLift, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

InstallMethodWithCacheFromObject( KernelLift,
                                  [ IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                                    -9999, #FIXME
                                    
  function( mor, test_morphism )
    local kernel_lift, kernel;
    
    ## KernelEmb passes its kernel object to the kernel lift
    kernel_lift := MonoAsKernelLift( KernelEmb( mor ), test_morphism );
    
    return kernel_lift;
    
end );

##
InstallTrueMethod( CanComputeKernelLiftWithGivenKernel, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

InstallMethodWithCacheFromObject( KernelLiftWithGivenKernel,
                                  [ IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsCapCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsCapCategoryObject and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                                  -9999, #FIXME
                                           
    function( mor, test_morphism, kernel )
      
      return MonoAsKernelLift( KernelEmb( kernel ), test_morphism );
      
end );

##
InstallTrueMethod( CanComputeKernel, CanComputeKernelEmb );

InstallMethod( KernelObject,
               [ IsCapCategoryMorphism and CanComputeKernelEmb ],
               -9999, #FIXME
               
  function( mor )
    
    return Source( KernelEmb( mor ) );
    
end );


##
InstallTrueMethod( CanComputeKernelEmb, CanComputeKernel and CanComputeKernelEmbWithGivenKernel );

InstallMethod( KernelEmb,
               [ IsCapCategoryMorphism and CanComputeKernel and CanComputeKernelEmbWithGivenKernel ],
               -9999, #FIXME
               
  function( mor )
    
    return KernelEmbWithGivenKernel( mor, KernelObject( mor ) );
    
end );

##
InstallTrueMethod( CanComputeKernelLift, CanComputeKernel and CanComputeKernelLiftWithGivenKernel );

InstallMethod( KernelLift,
               [ IsCapCategoryMorphism and CanComputeKernel and CanComputeKernelLiftWithGivenKernel,
                 IsCapCategoryMorphism ],
               -9999, #FIXME
               
  function( morphism, test_morphism )
    
    return KernelLiftWithGivenKernel( morphism, test_morphism, KernelObject( morphism ) );
    
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

##
InstallTrueMethod( CanComputeKernelObjectFunctorial,
                   CanComputeKernelLift and CanComputeKernelEmb and CanComputePreCompose );

InstallMethodWithCacheFromObject( KernelObjectFunctorial,
                                  [ IsCapCategoryMorphism and CanComputeKernelLift and CanComputeKernelEmb and CanComputePreCompose,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism ],
                                  
  function( alpha, mu, alpha_p )
    
    return KernelLift(
                alpha_p,
                PreCompose( KernelEmb( alpha ), mu )
              );
    
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelFunction( category, func );
    
    SetCanComputeCokernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( Cokernel,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local cokernel;
        
        cokernel := func( mor );
        
        Add( CapCategory( mor ), cokernel );
        
        SetFilterObj( cokernel, WasCreatedAsCokernel );
        
        AddToGenesis( cokernel,"CokernelDiagram", mor );
        
        return cokernel;
        
    end );
    
end );

## convenience
##
InstallMethod( CokernelColift,
               [ IsCapCategoryObject, IsCapCategoryMorphism ],
               
  function( cokernel, test_morphism )
  
    return CokernelColift( Genesis( cokernel )!.CokernelDiagram, test_morphism );
  
end );

##
InstallMethod( AddCokernelColift,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelColiftFunction( category, func );
    
    SetCanComputeCokernelColift( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CokernelColift,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor, test_morphism )
        local cokernel_colift, cokernel;
        
        if HasCokernel( mor ) then
          
          return CokernelColiftWithGivenCokernel( mor, test_morphism, Cokernel( mor ) );
          
        fi;
        
        cokernel_colift := func( mor, test_morphism );
        
        Add( CapCategory( mor ), cokernel_colift );
        
        cokernel := Source( cokernel_colift );
        
        SetFilterObj( cokernel, WasCreatedAsCokernel );
        
        AddToGenesis( cokernel, "CokernelDiagram", mor );
        
        return cokernel_colift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CokernelColift", 2 ) );
    
end );

##
InstallMethod( AddCokernelColiftWithGivenCokernel,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelColiftWithGivenCokernelFunction( category, func );
    
    SetCanComputeCokernelColiftWithGivenCokernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CokernelColiftWithGivenCokernel,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, test_morphism, cokernel )
        local cokernel_colift;
        
        cokernel_colift := func( mor, test_morphism, cokernel );
        
        Add( CapCategory( mor ), cokernel_colift );
        
        return cokernel_colift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CokernelColiftWithGivenCokernel", 3 ) );
    
end );

##
InstallMethod( AddCokernelProj,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelProjFunction( category, func );
    
    SetCanComputeCokernelProj( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CokernelProj,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local cokernel_proj, cokernel;
        
        if HasCokernel( mor ) then
          
          return CokernelProjWithGivenCokernel( mor, Cokernel( mor ) );
          
        fi;
        
        cokernel_proj := func( mor );
        
        Add( CapCategory( mor ), cokernel_proj );
        
        SetIsEpimorphism( cokernel_proj, true );

        cokernel := Range( cokernel_proj );
        
        SetCokernel( mor, cokernel );
        
        SetFilterObj( cokernel, WasCreatedAsCokernel );
        
        AddToGenesis( cokernel, "CokernelDiagram", mor );

        SetCokernelProj( cokernel, cokernel_proj );
        
        return cokernel_proj;
        
    end );
    
end );

##
InstallMethod( AddCokernelProjWithGivenCokernel,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelProjWithGivenCokernelFunction( category, func );
    
    SetCanComputeCokernelProjWithGivenCokernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CokernelProjWithGivenCokernel,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, cokernel )
        local cokernel_proj;
        
        cokernel_proj := func( mor, cokernel );
        
        Add( CapCategory( mor ), cokernel_proj );
        
        SetIsEpimorphism( cokernel_proj, true );

        SetCokernelProj( cokernel, cokernel_proj );
        
        return cokernel_proj;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CokernelProjWithGivenCokernel", 2 ) );
    
end );

####################################
## Attributes 
####################################

##
InstallMethod( CokernelProj,
               [ IsCapCategoryObject and WasCreatedAsCokernel ],
               
  function( cokernel )
    
    return CokernelProj( Genesis( cokernel )!.CokernelDiagram );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeCokernelColift, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

InstallMethodWithCacheFromObject( CokernelColift,
                                  [ IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                                  -9999, #FIXME
                                  
  function( mor, test_morphism )
    
    return EpiAsCokernelColift( CokernelProj( mor ), test_morphism );
    
end );

##
InstallTrueMethod( CanComputeCokernelColiftWithGivenCokernel, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

InstallMethodWithCacheFromObject( CokernelColiftWithGivenCokernel,
                                  [ IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsCapCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsCapCategoryObject and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                                           
    function( mor, test_morphism, cokernel )
      
      return EpiAsCokernelColift( CokernelProj( cokernel ), test_morphism );
      
end );


##
InstallTrueMethod( CanComputeCokernel, CanComputeCokernelProj );

InstallMethod( Cokernel,
               [ IsCapCategoryMorphism and CanComputeCokernelProj ],
               -9999, #FIXME
                                  
  function( mor )
    
    return Range( CokernelProj( mor ) );
    
end );

##
InstallTrueMethod( CanComputeCokernelProj, CanComputeCokernel and CanComputeCokernelProjWithGivenCokernel );

InstallMethod( CokernelProj,
               [ IsCapCategoryMorphism and CanComputeCokernel and CanComputeCokernelProjWithGivenCokernel ],
               -9999, #FIXME
               
  function( mor )
    
    return CokernelProjWithGivenCokernel( mor, Cokernel( mor ) );
    
end );

##
InstallTrueMethod( CanComputeCokernelColift, CanComputeCokernel and CanComputeCokernelColiftWithGivenCokernel );

InstallMethod( CokernelColift,
               [ IsCapCategoryMorphism and CanComputeCokernel and CanComputeCokernelColiftWithGivenCokernel,
                 IsCapCategoryMorphism ],
               -9999, #FIXME
               
  function( morphism, test_morphism )
    
    return CokernelColiftWithGivenCokernel( morphism, test_morphism, Cokernel( morphism ) );
    
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

##
InstallTrueMethod( CanComputeCokernelFunctorial,
                   CanComputeCokernelColift and CanComputeCokernelProj and CanComputePreCompose );

InstallMethodWithCacheFromObject( CokernelFunctorial,
                                  [ IsCapCategoryMorphism and CanComputeCokernelColift and CanComputeCokernelProj and CanComputePreCompose,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism ],
                                  
  function( alpha, nu, alpha_p )
    
    return CokernelColift(
                alpha,
                PreCompose( nu, CokernelProj( alpha_p ) )
              );
    
end );

####################################
##
## Coproduct and Pushout
##
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
    
      number_of_objects := Length( Genesis( object_product_list )!.Cofactors );
      
      if injection_number < 1 or injection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
      
      fi;
    
      return InjectionOfCofactorOfCoproductWithGivenCoproduct( Genesis( object_product_list )!.Cofactors, injection_number, object_product_list );
    
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
  
    if number_of_objects = 1 then
        
      return IdentityMorphism( object_product_list[1] );
          
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

InstallGlobalFunction( Coproduct,
  
  function( arg )
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryObject ) then
       
       return CoproductOp( arg[1], arg[1][1] );
       
    fi;
    
    if Length( arg ) = 1 then
      
      return arg[1];
        
    fi;
    
    return CoproductOp( arg, arg[ 1 ] );
    
end );

##
InstallMethod( AddCoproduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCoproductFunction( category, func );
    
    SetCanComputeCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                           [ IsList, IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local coproduct;
        
        coproduct := func( object_product_list );
        
        Add( CapCategory( method_selection_object ), coproduct );
        
        AddToGenesis( coproduct, "Cofactors", object_product_list );
        
        SetFilterObj( coproduct, WasCreatedAsCoproduct );
        
        return coproduct;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CoproductOp", 2 ) );
    
end );

## convenience method
##
InstallMethod( InjectionOfCofactorOfCoproduct,
               [ IsList, IsInt ],
               
  function( object_product_list, injection_number )
    
    return InjectionOfCofactorOfCoproductOp( object_product_list, injection_number, object_product_list[1] );
    
end );

##
InstallMethod( AddInjectionOfCofactorOfCoproduct,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorOfCoproductFunction( category, func );
    
    SetCanComputeInjectionOfCofactorOfCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfCoproductOp,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, injection_number, method_selection_object )
        local injection_of_cofactor, coproduct;
        
        if HasCoproductOp( object_product_list, method_selection_object ) then
          
          return InjectionOfCofactorOfCoproductWithGivenCoproduct( object_product_list, injection_number, CoproductOp( object_product_list, method_selection_object ) );
          
        fi;
        
        injection_of_cofactor := func( object_product_list, injection_number );
        
        Add( CapCategory( method_selection_object ), injection_of_cofactor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitMonomorphism( injection_of_cofactor, true );
          
        fi;
        
        coproduct := Range( injection_of_cofactor );
        
        AddToGenesis( coproduct, "Cofactors", object_product_list );
        
        SetCoproductOp( object_product_list, method_selection_object, coproduct );
        
        SetFilterObj( coproduct, WasCreatedAsCoproduct );
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorOfCoproductOp", 3 ) );

end );

##
InstallMethod( AddInjectionOfCofactorOfCoproductWithGivenCoproduct,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorOfCoproductWithGivenCoproductFunction( category, func );
    
    SetCanComputeInjectionOfCofactorOfCoproductWithGivenCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfCoproductWithGivenCoproduct,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, injection_number, coproduct )
        local injection_of_cofactor;
        
        injection_of_cofactor := func( object_product_list, injection_number, coproduct );
        
        Add( category, injection_of_cofactor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitMonomorphism( injection_of_cofactor, true );
          
        fi;
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorOfCoproductWithGivenCoproduct", 3 ) );

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

##
InstallMethod( AddUniversalMorphismFromCoproduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromCoproductFunction( category, func );
    
    SetCanComputeUniversalMorphismFromCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( diagram, sink, method_selection_object )
        local test_object, components, coproduct_objects, universal_morphism, coproduct;
        
        ##TODO: superfluous
        components := sink;
        
        coproduct_objects := diagram;
        
        if HasCoproductOp( coproduct_objects, coproduct_objects[1] ) then
          
          return UniversalMorphismFromCoproductWithGivenCoproduct(
                   diagram,
                   sink,
                   CoproductOp( coproduct_objects, coproduct_objects[1] )
                 );
          
        fi;
        
        test_object := Range( sink[1] );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be equal in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( diagram, sink );
        
        Add( category, universal_morphism );
        
        coproduct := Source( universal_morphism );
        
        AddToGenesis( coproduct, "Cofactors", coproduct_objects );
        
        SetCoproductOp( coproduct_objects, coproduct_objects[1], coproduct );
        
        SetFilterObj( coproduct, WasCreatedAsCoproduct );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromCoproductOp", 3 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromCoproductWithGivenCoproduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromCoproductWithGivenCoproductFunction( category, func );
    
    SetCanComputeUniversalMorphismFromCoproductWithGivenCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductWithGivenCoproduct,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( diagram, sink, coproduct )
        local test_object, components, coproduct_objects, universal_morphism;
        
        test_object := Range( sink[1] );
        
        components := sink; #components superfluous
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be equal in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( diagram, sink, coproduct );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromCoproductWithGivenCoproduct", 3 ) );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeCoproduct, CanComputeInjectionOfCofactorOfCoproduct );

##
## this methods is installed using the (cache of the (object of the second argument) )
InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                       [ IsList,
                                         IsCapCategoryObject and CanComputeInjectionOfCofactorOfCoproduct ],
                                        -9999, #FIXME
                                        
  function( object_product_list, method_selection_object )
    
    return Range( InjectionOfCofactorOfCoproduct( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeUniversalMorphismFromCoproduct,
                   CanComputeCoproduct and CanComputeUniversalMorphismFromCoproductWithGivenCoproduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductOp,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject and CanComputeCoproduct and CanComputeUniversalMorphismFromCoproductWithGivenCoproduct ],
                                         -9999, #FIXME
                                       
  function( diagram, sink, method_selection_object )
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( diagram, sink, CallFuncList( Coproduct, List( sink, Source ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeInjectionOfCofactorOfCoproduct, CanComputeCoproduct and CanComputeInjectionOfCofactorOfCoproductWithGivenCoproduct );

InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfCoproductOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and CanComputeCoproduct and CanComputeInjectionOfCofactorOfCoproductWithGivenCoproduct, ],
                                         -9999, #FIXME
                                         
  function( object_product_list, injection_number, method_selection_object )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct( object_product_list, injection_number, CallFuncList( Coproduct, object_product_list ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

####################################
## Functorial operations
####################################

##
InstallMethod( CoproductFunctorial,
               [ IsList ],
                                  
  function( morphism_list )
    
    return CoproductFunctorialOp( morphism_list, morphism_list[1] );
    
end );

##
InstallTrueMethod( CanComputeCoproductFunctorial,
                   CanComputeCoproduct and CanComputePreCompose and CanComputeInjectionOfCofactorOfCoproduct
                   and CanComputeUniversalMorphismFromCoproduct );

InstallMethodWithCacheFromObject( CoproductFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputeCoproduct
                                    and CanComputePreCompose
                                    and CanComputeInjectionOfCofactorOfCoproduct
                                    and CanComputeUniversalMorphismFromCoproduct ],
                                  
  function( morphism_list, caching_object )
    local coproduct_diagram, sink, diagram;
        
        coproduct_diagram := List( morphism_list, mor -> Range( mor ) );
        
        sink := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( morphism_list[i], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
        
        diagram := List( morphism_list, mor -> Source( mor ) );
        
        return UniversalMorphismFromCoproduct( diagram, sink );
        
end : ArgumentNumber := 2 );



####################################
##
## Direct Product and Pullback
##
####################################

## convenience method:
##
InstallGlobalFunction( ProjectionInFactor,
               
  function( object_product_list, projection_number )
    local number_of_objects;
    
    if WasCreatedAsDirectProduct( object_product_list ) and WasCreatedAsPullback( object_product_list ) then
        
        ## this might only happen when
        ## the function which was added to construct the product/ pullback does not return
        ## a new object but some part of its input
        
        return Error( "this object is a product and a pullback concurrently, thus the projection is ambiguous" );
        
    fi;
    
    ## convenience: first argument was created as direct product
    if WasCreatedAsDirectProduct( object_product_list ) then
    
      number_of_objects := Length( Genesis( object_product_list )!.DirectFactors );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorOfDirectProductWithGivenDirectProduct( Genesis( object_product_list )!.DirectFactors, projection_number, object_product_list );
    
    fi;
    
    ## convenience: first argument was created as a pullback
    if WasCreatedAsPullback( object_product_list ) then
    
      number_of_objects := Length( Genesis( object_product_list )!.PullbackDiagram );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorOfPullbackWithGivenPullback( Genesis( object_product_list )!.PullbackDiagram, projection_number, object_product_list );
    
    fi;
    
    ## assumption: first argument is a product object
    number_of_objects := Length( object_product_list );
  
    if projection_number < 0 or projection_number > number_of_objects then
    
      Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
    
    fi;
  
    if number_of_objects = 1 then
        
      return IdentityMorphism( object_product_list[1] );
          
    fi;
    
    if IsCapCategoryObject( object_product_list[1] )  then 
      
      return ProjectionInFactorOfDirectProductOp( object_product_list, projection_number, object_product_list[1] );
      
    else # IsCapCategoryMorphism( object_product_list[1] ) = true
      
      return ProjectionInFactorOfPullbackOp( object_product_list, projection_number, object_product_list[1] );
      
    fi;
  
end );


####################################
##
## Direct Product
##
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
      
      if Length( arg ) = 1 then 
      
        return arg[1];
        
      fi;
      
      return DirectProductOp( arg, arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DIRECT_PRODUCT_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "DirectProduct" );

##
InstallMethod( AddDirectProduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetDirectProductFunction( category, func );
    
    SetCanComputeDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                           [ IsList, IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local direct_product;
        
        direct_product := func( object_product_list );
        
        SetFilterObj( direct_product, WasCreatedAsDirectProduct );
        
        AddToGenesis( direct_product, "DirectFactors", object_product_list );
        
        Add( CapCategory( method_selection_object ), direct_product );
        
        return direct_product;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "DirectProductOp", 2 ) );
    
end );

##
InstallMethod( ProjectionInFactorOfDirectProduct,
               [ IsList, IsInt ],
               
  function( object_product_list, projection_number )
    
    return ProjectionInFactorOfDirectProductOp( object_product_list, projection_number, object_product_list[1] );
    
end );

##
InstallMethod( AddProjectionInFactorOfDirectProduct,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorOfDirectProductFunction( category, func );
    
    SetCanComputeProjectionInFactorOfDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfDirectProductOp,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, projection_number, method_selection_object )
        local projection_in_factor, direct_product;
        
        if HasDirectProductOp( object_product_list, method_selection_object ) then
          
          return ProjectionInFactorOfDirectProductWithGivenDirectProduct( object_product_list, projection_number, DirectProductOp( object_product_list, method_selection_object ) );
          
        fi;
        
        projection_in_factor := func( object_product_list, projection_number );
        
        Add( CapCategory( method_selection_object ), projection_in_factor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitEpimorphism( projection_in_factor, true );
          
        fi;
        
        direct_product := Source( projection_in_factor );
        
        AddToGenesis( direct_product, "DirectFactors", object_product_list );
        
        SetDirectProductOp( object_product_list, method_selection_object, direct_product );
        
        SetFilterObj( direct_product, WasCreatedAsDirectProduct );
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorOfDirectProductOp", 3 ) );

end );

##
InstallMethod( AddProjectionInFactorOfDirectProductWithGivenDirectProduct,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorOfDirectProductWithGivenDirectProductFunction( category, func );
    
    SetCanComputeProjectionInFactorOfDirectProductWithGivenDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfDirectProductWithGivenDirectProduct,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, projection_number, direct_product )
        local projection_in_factor;
        
        projection_in_factor := func( object_product_list, projection_number, direct_product );
        
        Add( category, projection_in_factor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitEpimorphism( projection_in_factor, true );
          
        fi;
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorOfDirectProductWithGivenDirectProduct", 3 ) );

end );

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

##
InstallMethod( AddUniversalMorphismIntoDirectProduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoDirectProductFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( diagram, source, method_selection_object )
        local test_object, components, direct_product_objects, universal_morphism, direct_product;
        
        #TODO: superfluous
        components := source;
        
        direct_product_objects := diagram;
        
        if HasDirectProductOp( direct_product_objects, direct_product_objects[1] ) then
        
          return UniversalMorphismIntoDirectProductWithGivenDirectProduct(
                   diagram,
                   source,
                   DirectProductOp( direct_product_objects, direct_product_objects[1] )
                 );
          
        fi;
        
        test_object := Source( source[1] );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be equal in given source-diagram" );
            
        fi;
        
        universal_morphism := func( diagram, source );
        
        Add( category, universal_morphism );
        
        direct_product := Range( universal_morphism );
        
        AddToGenesis( direct_product, "DirectFactors", direct_product_objects );
        
        SetDirectProductOp( direct_product_objects, direct_product_objects[1], direct_product );
        
        Add( CapCategory( direct_product_objects[1] ), direct_product );
        
        SetFilterObj( direct_product, WasCreatedAsDirectProduct );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoDirectProductOp", 3 ) );
    
end );

##
InstallMethod( AddUniversalMorphismIntoDirectProductWithGivenDirectProduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoDirectProductWithGivenDirectProductFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( diagram, source, direct_product )
        local test_object, components, direct_product_objects, universal_morphism;
        
        test_object := Source( source[1] );
        
        components := source;#FIXME: components superfluous
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be equal in given source-diagram" );
            
        fi;
        
        universal_morphism := func( diagram, source, direct_product );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoDirectProductWithGivenDirectProduct", 3 ) );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeDirectProduct, CanComputeProjectionInFactorOfDirectProduct );

##
InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                       [ IsList,
                                         IsCapCategoryObject and CanComputeProjectionInFactorOfDirectProduct ],
                                        -9999, #FIXME
                                        
  function( object_product_list, method_selection_object )
    
    return Source( ProjectionInFactorOfDirectProduct( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoDirectProduct,
                   CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject and CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct ],
                                         -9999, #FIXME
                                       
  function( diagram, source, method_selection_object )
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( diagram, source, CallFuncList( DirectProduct, List( source, Range ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeProjectionInFactorOfDirectProduct, CanComputeDirectProduct and CanComputeProjectionInFactorOfDirectProductWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfDirectProductOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and CanComputeDirectProduct and CanComputeProjectionInFactorOfDirectProductWithGivenDirectProduct ],
                                         -9999, #FIXME
                                         
  function( object_product_list, projection_number, method_selection_object )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct( object_product_list, projection_number, CallFuncList( DirectProduct, object_product_list ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

####################################
## Functorial operations
####################################

##
InstallMethod( DirectProductFunctorial,
               [ IsList ],
                                  
  function( morphism_list )
    
    return DirectProductFunctorialOp( morphism_list, morphism_list[1] );
    
end );

##
InstallTrueMethod( CanComputeDirectProductFunctorial,
                   CanComputeDirectProduct and CanComputePreCompose and CanComputeProjectionInFactorOfDirectProduct 
                   and CanComputeUniversalMorphismIntoDirectProduct );

InstallMethodWithCacheFromObject( DirectProductFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputeDirectProduct
                                    and CanComputePreCompose
                                    and CanComputeProjectionInFactorOfDirectProduct
                                    and CanComputeUniversalMorphismIntoDirectProduct ],
                                  
  function( morphism_list, caching_object )
    local direct_product_diagram, source, diagram;
        
        direct_product_diagram := List( morphism_list, mor -> Source( mor ) );
        
        source := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), morphism_list[i] ) );
        
        diagram := List( morphism_list, mor -> Range( mor ) );
        
        return UniversalMorphismIntoDirectProduct( diagram, source );
        
end : ArgumentNumber := 2 );


####################################
##
## Direct sum
##
####################################

## Immediate methods which link DirectProduct and Coproduct to
## DirectSum in the additive case
InstallImmediateMethod( IS_IMPLIED_DIRECT_SUM,
                        IsCapCategoryObject and WasCreatedAsDirectProduct and IsAdditiveCategory,
                        0,
                        
  function( direct_product )
    local summands;
    
    summands := Genesis( direct_product )!.DirectFactors;
    
    SetDirectSumOp( summands, summands[1], direct_product );
    
    AddToGenesis( direct_product, "DirectFactors", summands );
    
    AddToGenesis( direct_product, "Cofactors", summands ); 
    
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
  
    summands := Genesis( coproduct )!.Cofactors;
  
    SetDirectSumOp( summands, summands[1], coproduct );
    
    AddToGenesis( coproduct, "DirectFactors", summands );
    
    AddToGenesis( coproduct, "Cofactors", summands ); 
    
    SetFilterObj( coproduct, WasCreatedAsDirectSum );
    
    SetFilterObj( coproduct, WasCreatedAsDirectProduct );
    
    SetDirectProductOp( summands, summands[1], coproduct );
    
    return true;
    
end );


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
      
      if Length( arg ) = 1 then 
      
        return arg[1];
        
      fi;
      
      return DirectSumOp( arg, arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DIRECT_SUM_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "DirectSum" );

##
InstallMethod( AddDirectSum,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetDirectSumFunction( category, func );
    
    SetCanComputeDirectSum( category, true );
    
    InstallMethodWithToDoForIsWellDefined( DirectSumOp,
                                           [ IsList, IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local direct_sum;
        
        direct_sum := func( object_product_list );
        
        Add( CapCategory( method_selection_object ), direct_sum );
        
        AddToGenesis( direct_sum, "DirectFactors", object_product_list );
        
        AddToGenesis( direct_sum, "Cofactors", object_product_list );
        
        SetFilterObj( direct_sum, WasCreatedAsDirectSum );
        
        ## this will treat direct_sum as if it was a direct product (see immediate method above)
        SetFilterObj( direct_sum, WasCreatedAsDirectProduct );
        
        ## this will treat direct_sum as if it was a coproduct (see immediate method above)
        SetFilterObj( direct_sum, WasCreatedAsCoproduct );
        
        return direct_sum;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "DirectSumOp", 2 ) );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeDirectProduct,
                   CanComputeDirectSum );

InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                       [ IsList, IsCapCategoryObject and CanComputeDirectSum ],
                                       -9999 + 1, #FIXME
                                       
  function( object_product_list, method_selection_object )
    
    return DirectSumOp( object_product_list, method_selection_object );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeCoproduct,
                   CanComputeDirectSum );

InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                       [ IsList, IsCapCategoryObject and CanComputeDirectSum ],
                                       -9999 + 1, #FIXME
                                       
  function( object_product_list, method_selection_object )
    
    return DirectSumOp( object_product_list, method_selection_object );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2  );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct,
                   IsAdditiveCategory
                   and CanComputeInjectionOfCofactorOfCoproduct
                   and CanComputeAdditionForMorphisms 
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject 
                                     and IsAdditiveCategory
                                     and CanComputeInjectionOfCofactorOfCoproduct 
                                     and CanComputeAdditionForMorphisms
                                     and CanComputePreCompose ],
                                       -9999 - 1, #FIXME
                                       
  function( diagram, source, direct_product )
    local nr_components;
    
    nr_components := Length( source );
  
    return Sum( List( [ 1 .. nr_components ], 
     i -> PreCompose( source[ i ], InjectionOfCofactorOfCoproductWithGivenCoproduct( diagram, i, direct_product ) ) ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3  );

##
InstallTrueMethod( CanComputeUniversalMorphismFromCoproductWithGivenCoproduct,
                   IsAdditiveCategory
                   and CanComputeProjectionInFactorOfDirectProduct
                   and CanComputeAdditionForMorphisms 
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductWithGivenCoproduct,
                                       [ IsList,
                                         IsList,
                                         IsCapCategoryObject
                                     and IsAdditiveCategory
                                     and CanComputeProjectionInFactorOfDirectProduct
                                     and CanComputeAdditionForMorphisms
                                     and CanComputePreCompose ],
                                       -9999 - 1, #FIXME
                                       
  function( diagram, sink, coproduct )
    local nr_components;
    
    nr_components := Length( sink );
  
    return Sum( List( [ 1 .. nr_components ], 
      i -> PreCompose( ProjectionInFactorOfDirectProductWithGivenDirectProduct( diagram, i, coproduct ), sink[ i ] ) ) );
  
end  : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeAdditionForMorphisms,
                   IsAdditiveCategory
                   and CanComputeDirectSum
                   and CanComputeUniversalMorphismIntoDirectProduct
                   and CanComputeIdentityMorphism
                   and CanComputeUniversalMorphismFromCoproduct
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( \+,
                                       [ IsCapCategoryMorphism
                                     and IsAdditiveCategory
                                     and CanComputeDirectSum
                                     and CanComputeUniversalMorphismIntoDirectProduct
                                     and CanComputeIdentityMorphism
                                     and CanComputeUniversalMorphismFromCoproduct
                                     and CanComputePreCompose,
                                         IsCapCategoryMorphism ],
                                         -9999,
                                         
  function( mor1, mor2 )
    local return_value, B, direct_sum, componentwise_morphism, addition_morphism;
        
    if not IsIdenticalObj( CapCategory( mor1 ), CapCategory( mor2 ) ) or not IsEqualForObjects( Source( mor1 ), Source( mor2 ) ) or not IsEqualForObjects( Range( mor1 ), Range( mor2 ) ) then
      
      Error( "morphisms are not addable" );
      
    fi;
    
    B := Range( mor1 );
    
    direct_sum := DirectSum( B, B );
    
    componentwise_morphism := UniversalMorphismIntoDirectProduct( mor1, mor2 );
    
    addition_morphism := UniversalMorphismFromCoproduct( IdentityMorphism( B ), IdentityMorphism( B ) );
    
    return PreCompose( componentwise_morphism, addition_morphism );
    
end );

####################################
## Functorial operations
####################################

##
InstallTrueMethod( CanComputeDirectSumFunctorial, CanComputeDirectProductFunctorial and IsPreAdditiveCategory );

InstallMethod( DirectSumFunctorial,
               [ IsList ],
                                  
  function( morphism_list )
    
    return DirectProductFunctorial( morphism_list );
    
end );

##
InstallTrueMethod( CanComputeDirectSumFunctorial, CanComputeCoproductFunctorial and IsPreAdditiveCategory );

InstallMethod( DirectSumFunctorial,
               [ IsList ],
               -9999,
                                  
  function( morphism_list )
    
    return CoproductFunctorial( morphism_list );
    
end );

####################################
##
## Zero Object
##
####################################

##
InstallTrueMethod( WasCreatedAsZeroObject, IsZero );

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
## Add Operations
####################################

##
InstallTrueMethod( CanComputeTerminalObject, CanComputeZeroObject );

##
InstallMethod( AddZeroObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetZeroObjectFunction( category, func );
    
    SetCanComputeZeroObject( category, true );
    
end );

####################################
## Attributes
####################################

##
InstallMethod( ZeroObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return ZeroObject( CapCategory( cell ) );
    
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
## Renamed Operations
####################################

##
InstallMethodWithToDoForIsWellDefined( MorphismFromZeroObject,
                                       [ IsCapCategoryObject ],
                                       
   function( obj )
   
     return UniversalMorphismFromInitialObject( obj );
   
end );

##
InstallMethodWithToDoForIsWellDefined( MorphismIntoZeroObject,
                                       [ IsCapCategoryObject ],
                                       
   function( obj )
   
     return UniversalMorphismIntoTerminalObject( obj );
   
end );

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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetTerminalObjectFunction( category, func );
    
    SetCanComputeTerminalObject( category, true );
    
end );

##
InstallMethod( AddUniversalMorphismIntoTerminalObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoTerminalObjectFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoTerminalObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoTerminalObject,
                                           [ IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_source )
        local category, universal_morphism, terminal_object;
        
        category := CapCategory( test_source );
        
        if HasTerminalObject( category ) then
        
          return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( category ) );
          
        fi;
        
        universal_morphism := func( test_source );
        
        Add( CapCategory( test_source ), universal_morphism );
        
        terminal_object := Range( universal_morphism );
        
        SetTerminalObject( category, terminal_object );
        
        SetFilterObj( terminal_object, WasCreatedAsTerminalObject );
        
        return universal_morphism;
        
    end );
    
end );

##
InstallMethod( AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoTerminalObjectWithGivenTerminalObjectFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                                           [ IsCapCategoryObject and ObjectFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_source, terminal_object )
        local universal_morphism;
        
        universal_morphism := func( test_source, terminal_object );
        
        Add( CapCategory( test_source ), universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject", 2 ) );
    
end );

####################################
## Attributes
####################################

##
InstallMethod( TerminalObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return TerminalObject( CapCategory( cell ) );
    
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

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeUniversalMorphismIntoTerminalObject,
                   CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject );

InstallMethod( UniversalMorphismIntoTerminalObject,
               [ IsCapCategoryObject and CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject ],
               -9999, #FIXME
              
  function( test_source )
    
    return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( CapCategory( test_source ) ) );
    
end );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                   CanComputeZeroMorphism
                   and IsAdditiveCategory );

InstallMethod( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
               [ IsCapCategoryObject
                 and CanComputeZeroMorphism
                 and IsAdditiveCategory,
                 IsCapCategoryObject ],
                 -9999, #FIXME
                 
  function( test_source, terminal_object )
    
    return ZeroMorphism( test_source, terminal_object );
    
end );

##
InstallTrueMethod( CanComputeTerminalObject, CanComputeZeroObject );

##
InstallMethod( TerminalObject,
               [ IsCapCategoryObject and CanComputeZeroObject ],
               - 9999, # FIXME
               
  function( object )
    
    return ZeroObject( object );
    
end );

##
InstallMethod( TerminalObject,
               [ IsCapCategory and CanComputeZeroObject ],
               -9999,
               
  function( category )
    
    return ZeroObject( category );
    
end );

####################################
## Functorial operations
####################################

##
InstallTrueMethod( CanComputeTerminalObjectFunctorial,
                   CanComputeTerminalObject and CanComputeIdentityMorphism );

InstallMethod( TerminalObjectFunctorial,
               [ IsCapCategory and CanComputeTerminalObject and CanComputeIdentityMorphism ],
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return IdentityMorphism( terminal_object );
    
end );

##
InstallTrueMethod( CanComputeTerminalObjectFunctorial,
                   CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObject );

InstallMethod( TerminalObjectFunctorial,
               [ IsCapCategory and CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObject ],
                 -9999,
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return UniversalMorphismIntoTerminalObject( terminal_object );
    
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetInitialObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeInitialObject );
    
    SetCanComputeInitialObject( category, true );
    
end );

##
InstallMethod( AddUniversalMorphismFromInitialObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromInitialObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeUniversalMorphismFromInitialObject );
    
    SetCanComputeUniversalMorphismFromInitialObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromInitialObject,
                                           [ IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_sink )
        local category, universal_morphism, initial_object;
        
        category := CapCategory( test_sink );
        
        if HasInitialObject( category ) then
        
          return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( category ) );
          
        fi;
        
        universal_morphism := func( test_sink );
        
        Add( CapCategory( test_sink ), universal_morphism );
        
        initial_object := Source( universal_morphism );
        
        SetInitialObject( category, initial_object );
        
        SetFilterObj( initial_object, WasCreatedAsInitialObject );
        
        return universal_morphism;
        
    end );
    
end );

##
InstallMethod( AddUniversalMorphismFromInitialObjectWithGivenInitialObject,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromInitialObjectWithGivenInitialObjectFunction( category, func );
    
#     SetFilterObj( category, CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject );
    
    SetCanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromInitialObjectWithGivenInitialObject,
                                           [ IsCapCategoryObject and ObjectFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_sink, initial_object )
        local universal_morphism;
        
        universal_morphism := func( test_sink, initial_object );
        
        Add( CapCategory( test_sink ), universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromDirectProductWithGivenInitialObject", 2 ) );
    
end );

####################################
## Attributes
####################################

##
InstallMethod( InitialObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return InitialObject( CapCategory( cell ) );
    
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

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeUniversalMorphismFromInitialObject,
                   CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject );

InstallMethod( UniversalMorphismFromInitialObject,
               [ IsCapCategoryObject and CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject ],
               -9999, #FIXME
              
  function( test_sink )
    
    return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( CapCategory( test_sink ) ) );
    
end );

##
InstallTrueMethod( CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject,
                   CanComputeZeroMorphism
                   and IsAdditiveCategory );

InstallMethod( UniversalMorphismFromInitialObjectWithGivenInitialObject,
               [ IsCapCategoryObject
                 and CanComputeZeroMorphism
                 and IsAdditiveCategory,
                 IsCapCategoryObject ],
                 -9999, #FIXME
                 
  function( test_sink, initial_object )
    
    return ZeroMorphism( initial_object, test_sink );
    
end );

##
InstallTrueMethod( CanComputeInitialObject, CanComputeZeroObject );

##
InstallMethod( InitialObject,
               [ IsCapCategoryObject and CanComputeZeroObject ],
               - 9999, # FIXME
               
  function( object )
    
    return ZeroObject( object );
    
end );

##
InstallMethod( InitialObject,
               [ IsCapCategory and CanComputeZeroObject ],
               -9999,
               
  function( category )
    
    return ZeroObject( category );
    
end );

####################################
## Functorial operations
####################################

##
InstallTrueMethod( CanComputeInitialObjectFunctorial,
                   CanComputeInitialObject and CanComputeIdentityMorphism );

InstallMethod( InitialObjectFunctorial,
               [ IsCapCategory and CanComputeInitialObject and CanComputeIdentityMorphism ],
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return IdentityMorphism( initial_object );
    
end );

##
InstallTrueMethod( CanComputeInitialObjectFunctorial,
                   CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObject );

InstallMethod( InitialObjectFunctorial,
               [ IsCapCategory and CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObject ],
                 -9999,
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return UniversalMorphismFromInitialObject( initial_object );
    
end );

####################################
##
## Pullback
##
####################################

InstallGlobalFunction( FiberProduct,
  
  function( arg )
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return PullbackOp( arg[1], arg[1][1] );
       
     fi;
    
    #the pullback of a tuple of morphisms over the same base B can be interpreted
    #as the direct product in the category of morphisms over B. Thus it makes sense
    #to deal with the special case where only one morphism is considered as follows:
    if Length( arg ) = 1 then 
      
      return arg[1];
        
    fi;
    
    return PullbackOp( arg, arg[ 1 ] );
    
end );

####################################
## Add Operations
####################################

##
InstallMethod( AddFiberProduct,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetPullbackFunction( category, func );
    
    SetCanComputePullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( PullbackOp,
                                           [ IsList, IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( diagram, method_selection_morphism )
        local base, pullback;
        
        base := Range( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
        
          Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
        
        fi;
        
        pullback := func( diagram );
        
        SetFilterObj( pullback, WasCreatedAsPullback );
        
        AddToGenesis( pullback, "PullbackDiagram", diagram );
        
        Add( CapCategory( method_selection_morphism ), pullback );
        
        return pullback;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "PullbackOp", 2 ) );
    
end );

## convenience method:
##
InstallMethod( ProjectionInFactorOfPullback,
               [ IsList, IsInt ],
               
  function( diagram, projection_number )
    
    return ProjectionInFactorOfPullbackOp( diagram, projection_number, diagram[1] );
    
end );

##
InstallMethod( AddProjectionInFactorOfPullback,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorOfPullbackFunction( category, func );
    
    SetCanComputeProjectionInFactorOfPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackOp,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                                             
      function( diagram, projection_number, method_selection_morphism )
        local base, projection_in_factor, pullback;
        
        if HasPullbackOp( diagram, method_selection_morphism ) then
          
          return ProjectionInFactorOfPullbackWithGivenPullback( diagram, projection_number, PullbackOp( diagram, method_selection_morphism ) );
          
        fi;
        
        base := Range( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
        
          Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
        
        fi;
        
        projection_in_factor := func( diagram, projection_number );
        
        Add( CapCategory( method_selection_morphism ), projection_in_factor );
        
        pullback := Source( projection_in_factor );
        
        AddToGenesis( pullback, "PullbackDiagram", diagram );
        
        SetPullbackOp( diagram, method_selection_morphism, pullback );
        
        SetFilterObj( pullback, WasCreatedAsPullback );
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorOfPullbackOp", 3 ) );

end );

##
InstallMethod( AddProjectionInFactorOfPullbackWithGivenPullback,
               [ IsCapCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorOfPullbackWithGivenPullbackFunction( category, func );
    
    SetCanComputeProjectionInFactorOfPullbackWithGivenPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackWithGivenPullback,
                                           [ IsList,
                                             IsInt,
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                             
      function( diagram, projection_number, pullback )
        local base, projection_in_factor;
        
        base := Range( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
        
          Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
        
        fi;
        
        projection_in_factor := func( diagram, projection_number, pullback );
        
        Add( category, projection_in_factor );
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorOfPullbackWithGivenPullback", 3 ) );

end );

##
InstallGlobalFunction( UniversalMorphismIntoPullback,

  function( arg )
    local diagram, pullback_or_diagram, source;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoPullbackOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    pullback_or_diagram := arg[ 1 ];
    
    source := arg{[ 2 .. Length( arg ) ]};
    
    if WasCreatedAsPullback( pullback_or_diagram ) then
    
      diagram := Genesis( pullback_or_diagram )!.PullbackDiagram;
    
      return UniversalMorphismIntoPullbackOp( diagram, source, diagram[1] );
    
    fi;
    
    return UniversalMorphismIntoPullbackOp( pullback_or_diagram, source, pullback_or_diagram[1] );
    
end );

##
InstallMethod( AddUniversalMorphismIntoPullback,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoPullbackFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( diagram, source, method_selection_morphism )
        local base, test_object, components, universal_morphism, pullback;
        
        if HasPullbackOp( diagram, diagram[1] ) then
        
          return UniversalMorphismIntoPullbackWithGivenPullback( 
                   diagram, 
                   source,
                   PullbackOp( diagram, diagram[1] )
                 );
          
        fi;
        
        base := Range( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects(  Range( c ), base ) ) then
          
          Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
          
        fi;
        
        test_object := Source( source[1] );
        
        components := source; #FIXME components superfluous
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be equal in given source-diagram" );
            
        fi;
        
        ## here the user also needs the diagram
        universal_morphism := func( diagram, source );
        
        Add( category, universal_morphism );
        
        pullback := Range( universal_morphism );
        
        AddToGenesis( pullback, "PullbackDiagram", diagram );
        
        SetPullbackOp( diagram, diagram[1], pullback );
        
        Add( CapCategory( diagram[1] ), pullback );
        
        SetFilterObj( pullback, WasCreatedAsPullback );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoPullbackOp", 3 ) );
    
end );

##
InstallMethod( AddUniversalMorphismIntoPullbackWithGivenPullback,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoPullbackWithGivenPullbackFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoPullbackWithGivenPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackWithGivenPullback,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryObject and ObjectFilter( category ) 
                                           ],
                                           
      function( diagram, source, pullback )
        local base, test_object, components, universal_morphism;
        
        base := Range( diagram[1] );
        
        if not ForAll( diagram, c -> IsEqualForObjects( Range( c ), base ) ) then
          
          Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
          
        fi;
        
        test_object := Source( source[1] );
        
        components := source;
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsEqualForObjects( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be equal in given source-diagram" );
            
        fi;
        
        universal_morphism := func( diagram, source, pullback );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoPullbackWithGivenPullback", 3 ) );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputePullback, CanComputeDirectProduct and 
                                       CanComputeProjectionInFactorOfDirectProduct and 
                                       CanComputePreCompose and
                                       CanComputeAdditionForMorphisms and
                                       CanComputeAdditiveInverseForMorphisms and
                                       CanComputeKernel );

##
InstallMethodWithToDoForIsWellDefined( PullbackOp,
                                       [ IsList,
                                         IsCapCategoryMorphism and
                                         CanComputeDirectProduct and 
                                         CanComputeProjectionInFactorOfDirectProduct and 
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeKernel ],
                                         -9999, #FIXME
                                         
  function( diagram, method_selection_morphism )
    local base, direct_product_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2, pullback, diff;
    
    base := Range( diagram[1] );
    
    if not ForAll( diagram, c -> IsEqualForObjects( Range( c ), base ) ) then
    
      Error( "the given morphisms of the pullback diagram must have equal ranges\n" );
      
    fi;
    
    direct_product_diagram := List( diagram, Source );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), diagram[ i ] ) );
    
    mor1 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    diff := mor1 - mor2;
    
    pullback := KernelObject( diff );
    
    if IsBound( pullback!.Genesis.PullbackAsKernelDiagram ) then
        
        Error( "pullback has two origins, which leads to inconsistencies." );
        
    fi;
    
    #unfortunately this is necessary here
    AddToGenesis(  pullback, "PullbackAsKernelDiagram", diff );
    
    AddToGenesis( pullback, "PullbackDiagram", diagram );
    
    SetFilterObj( pullback, WasCreatedAsPullback );
    
    return pullback;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeProjectionInFactorOfPullback, CanComputeProjectionInFactorOfPullbackWithGivenPullback and 
                                                           CanComputePullback );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryMorphism and
                                         CanComputeProjectionInFactorOfPullbackWithGivenPullback and
                                         CanComputePullback ],
                                         
  function( diagram, projection_number, method_selection_morphism )
  
    return ProjectionInFactorOfPullbackWithGivenPullback( diagram, projection_number, PullbackOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeProjectionInFactorOfPullbackWithGivenPullback, CanComputeKernelEmb and
                                                                  CanComputeProjectionInFactorOfDirectProduct and
                                                                  CanComputePullback );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
# Of course, as mentioned in the introduction of this chapter, the user should never only install 
# the constructor of a universal object without also implementing the WithGiven-methods.
InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackWithGivenPullback,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and
                                         CanComputeKernelEmb and
                                         CanComputeProjectionInFactorOfDirectProduct and
                                         CanComputePullback ],
                                         -9999,
                                         
  function( diagram, projection_number, pullback )
    local embedding_in_direct_product, direct_product, direct_product_diagram, projection;
  
    if not WasCreatedAsKernel( pullback ) or not IsBound( Genesis( pullback )!.PullbackAsKernelDiagram ) then
    
      Error( "pullback had to be created as a kernel" );
    
    fi;
    
    embedding_in_direct_product := KernelEmb( Genesis( pullback )!.PullbackAsKernelDiagram );
    
    direct_product := Range( embedding_in_direct_product );
    
    if not WasCreatedAsDirectProduct( direct_product ) then
    
      Error( "pullback had to be created as a kernel of a morphism with a direct product as source" );
    
    fi;
    
    direct_product_diagram := direct_product!.Genesis.DirectFactors;
    
    projection := ProjectionInFactorOfDirectProductWithGivenDirectProduct( direct_product_diagram, projection_number, direct_product );
    
    return PreCompose( embedding_in_direct_product, projection );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoPullbackWithGivenPullback, CanComputeUniversalMorphismIntoDirectProduct and
                                                                             CanComputeKernelLift );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackWithGivenPullback,
                                       [
                                         IsList,
                                         IsList,
                                         IsCapCategoryObject
                                       ],
                                       
  function( diagram, source, pullback )
    local test_function;
    
    if not WasCreatedAsKernel( pullback ) then
      
      Error( "pullback had to be created as a kernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismIntoDirectProduct, source );
    
    return KernelLift( pullback, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethod( CanComputeUniversalMorphismIntoPullback, CanComputeUniversalMorphismIntoPullbackWithGivenPullback and 
                                                            CanComputePullback );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism ],
                                             
  function( diagram, source, method_selection_morphism )
    
    return UniversalMorphismIntoPullbackWithGivenPullback( diagram, source, PullbackOp( diagram, method_selection_morphism ) );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( PullbackFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return PullbackFunctorialOp( morphism_of_morphisms, morphism_of_morphisms[1][1] );
      
end );

##
InstallTrueMethod( CanComputePullbackFunctorial,
                   CanComputePullback
                   and CanComputePreCompose
                   and CanComputeProjectionInFactorOfPullback
                   and CanComputeUniversalMorphismIntoPullback );

InstallMethodWithCacheFromObject( PullbackFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputePullback
                                    and CanComputePreCompose
                                    and CanComputeProjectionInFactorOfPullback
                                    and CanComputeUniversalMorphismIntoPullback ],
                                  
  function( morphism_of_morphisms, base_morphism )
    local pullback_diagram, source, diagram;
        
        pullback_diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        source := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( ProjectionInFactorOfPullback( pullback_diagram, i ), morphism_of_morphisms[i][2] ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        return UniversalMorphismIntoPullback( diagram, source );
        
end : ArgumentNumber := 2 );


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
    
    #the pushout of a tuple of morphisms with same source B can be interpreted
    #as the direct product in the category of morphisms with source B. Thus it makes sense
    #to deal with the special case where only one morphism is considered as follows:
    if Length( arg ) = 1 then 
      
      return arg[1];
        
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
## Implied Operations
####################################

##
InstallTrueMethod( CanComputePushout, CanComputeCoproduct and 
                                      CanComputeInjectionOfCofactorOfCoproduct and 
                                      CanComputePreCompose and
                                      CanComputeAdditionForMorphisms and
                                      CanComputeAdditiveInverseForMorphisms and
                                      CanComputeCokernel );

##
InstallMethodWithToDoForIsWellDefined( PushoutOp,
                                       [ IsList,
                                         IsCapCategoryMorphism and
                                         CanComputeCoproduct and
                                         CanComputeInjectionOfCofactorOfCoproduct and
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeCokernel ],
                                         -9999, #FIXME
                                         
  function( diagram, method_selection_morphism )
    local cobase, coproduct_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2, pushout, diff;
    
    cobase := Source( diagram[1] );
        
    if not ForAll( diagram, c -> IsEqualForObjects( Source( c ), cobase ) ) then
           
       Error( "the given morphisms of the pushout diagram must have equal sources\n" );
           
    fi;
    
    coproduct_diagram := List( diagram, Range );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( diagram[ i ], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
    
    mor1 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    diff := mor1 - mor2;
    
    pushout := Cokernel( diff );
    
    if IsBound( pushout!.Genesis.PushoutAsCokernelDiagram ) then
        
        Error( "pushout has two origins, which leads to inconsistencies." );
        
    fi;
    
    #unfortunately this is necessary here
    AddToGenesis( pushout, "PushoutAsCokernelDiagram", diff );
    
    AddToGenesis( pushout, "PushoutDiagram", diagram );
    
    SetFilterObj( pushout, WasCreatedAsPushout );
    
    return pushout;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

#
InstallTrueMethod( CanComputeInjectionOfCofactorOfPushout, CanComputeInjectionOfCofactorOfPushoutWithGivenPushout and 
                                                           CanComputePushout );

InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfPushoutOp,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryMorphism and
                                         CanComputeInjectionOfCofactorOfPushoutWithGivenPushout and
                                         CanComputePushout ],
                                         
  function( diagram, injection_number, method_selection_morphism )
    
    return InjectionOfCofactorOfPushoutWithGivenPushout( diagram, injection_number, PushoutOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

# ##
InstallTrueMethod( CanComputeInjectionOfCofactorOfPushoutWithGivenPushout, CanComputeCokernelProj and
                                                                  CanComputeInjectionOfCofactorOfCoproduct and
                                                                  CanComputePushout );

# FIXME: WARNING: This method only applies if the pushout was created as a cokernel. If the
# user gives his own pushout method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOfPushoutWithGivenPushout,
                                       [ IsList,
                                         IsInt,
                                         IsCapCategoryObject and
                                         CanComputeCokernelProj and
                                         CanComputeInjectionOfCofactorOfCoproduct and
                                         CanComputePushout ],
                                         -9999,
                                         
  function( diagram, injection_number, pushout )
    local projection_from_coproduct, coproduct, coproduct_diagram, injection;
  
    if not WasCreatedAsCokernel( pushout ) or not IsBound( Genesis( pushout )!.PushoutAsCokernelDiagram ) then
    
      Error( "pushout had to be created as a cokernel" );
    
    fi;
    
    projection_from_coproduct := CokernelProj( Genesis( pushout )!.PushoutAsCokernelDiagram );
    
    coproduct := Source( projection_from_coproduct );
    
    if not WasCreatedAsCoproduct( coproduct ) then
    
      Error( "pushout had to be created as a cokernel of a morphism with a coproduct as range" );
    
    fi;
    
    coproduct_diagram := coproduct!.Genesis.Cofactors;
    
    injection := InjectionOfCofactorOfCoproductWithGivenCoproduct( coproduct_diagram, injection_number, coproduct );
    
    return PreCompose( injection, projection_from_coproduct );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeUniversalMorphismFromPushoutWithGivenPushout, CanComputeUniversalMorphismFromCoproduct and
                                                                           CanComputeCokernelColift );

# FIXME: WARNING: This method only applies if the pushout was created as a cokernel. If the
# user gives his own pushout method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutWithGivenPushout,
                                       [
                                         IsList,
                                         IsList,
                                         IsCapCategoryObject
                                       ],
                                       
  function( diagram, sink, pushout )
    local test_function;
    
    if not WasCreatedAsCokernel( pushout ) then
      
      Error( "pushout had to be created as a cokernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismFromCoproduct, sink );
    
    return CokernelColift( pushout, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethod( CanComputeUniversalMorphismFromPushout, CanComputeUniversalMorphismFromPushoutWithGivenPushout and 
                                                           CanComputePushout );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutOp,
                                           [ IsList,
                                             IsList,
                                             IsCapCategoryMorphism ],
                                             
  function( diagram, sink, method_selection_morphism )
    
    return UniversalMorphismFromPushoutWithGivenPushout( diagram, sink, PushoutOp( diagram, method_selection_morphism ) );
    
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

##
InstallTrueMethod( CanComputePushoutFunctorial,
                   CanComputePushout
                   and CanComputePreCompose
                   and CanComputeInjectionOfCofactorOfPushout
                   and CanComputeUniversalMorphismFromPushout );

InstallMethodWithCacheFromObject( PushoutFunctorialOp,
                                  [ IsList,
                                    IsCapCategoryMorphism
                                    and CanComputePushout
                                    and CanComputePreCompose
                                    and CanComputeInjectionOfCofactorOfPushout
                                    and CanComputeUniversalMorphismFromPushout ],
                                  
  function( morphism_of_morphisms, cobase_morphism )
    local pushout_diagram, sink, diagram;
        
        pushout_diagram := List( morphism_of_morphisms, mor -> mor[3] );
        
        sink := List( [ 1 .. Length( morphism_of_morphisms ) ], i -> PreCompose( morphism_of_morphisms[i][2], InjectionOfCofactorOfPushout( pushout_diagram, i ) ) );
        
        diagram := List( morphism_of_morphisms, mor -> mor[1] );
        
        return UniversalMorphismFromPushout( diagram, sink );
        
end : ArgumentNumber := 2 );


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
    
    SetCanComputeImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageObject,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local image;
        
        image := func( mor );
        
        Add( category, image );
        
        SetFilterObj( image, WasCreatedAsImage );
        
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
        
          return ImageEmbeddingWithGivenImage( mor, ImageObject( mor ) );
        
        fi;
        
        image_embedding := func( mor );
        
        Add( CapCategory( mor ), image_embedding );
        
        ##Implication (by definition of an image)
        SetIsMonomorphism( image_embedding, true );
        
        image := Source( image_embedding );
        
        AddToGenesis( image, "ImageDiagram", mor );
        
        SetFilterObj( image, WasCreatedAsImage );
        
        SetImageObject( mor, image );
        
        return image_embedding;
        
    end );
    
end );

##
InstallMethod( AddImageEmbeddingWithGivenImage,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetImageEmbeddingWithGivenImageFunction( category, func );
    
    SetCanComputeImageEmbeddingWithGivenImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageEmbeddingWithGivenImage,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, image )
        local image_embedding;
        
        image_embedding := func( mor, image );
        
        Add( category, image_embedding );
        
        return image_embedding;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ImageEmbeddingWithGivenImage", 2 ) );
    
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
        
          return CoastrictionToImageWithGivenImage( morphism, ImageObject( morphism ) );
        
        fi;
        
        coastriction_to_image := func( morphism );
        
        Add( CapCategory( morphism ), coastriction_to_image );
        
        image := Range( coastriction_to_image );
        
        AddToGenesis( image, "ImageDiagram", morphism );
        
        SetFilterObj( image, WasCreatedAsImage );
        
        SetImageObject( morphism, image );
        
        return coastriction_to_image;
        
    end );
    
end );

##
InstallMethod( AddCoastrictionToImageWithGivenImage,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCoastrictionToImageWithGivenImageFunction( category, func );
    
    SetCanComputeCoastrictionToImageWithGivenImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CoastrictionToImageWithGivenImage,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( morphism, image )
        local coastriction_to_image;
        
        coastriction_to_image := func( morphism, image );
        
        Add( category, coastriction_to_image );
        
        return coastriction_to_image;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CoastrictionToImageWithGivenImage", 2 ) );
    
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
          
          return UniversalMorphismFromImageWithGivenImage(
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
        
        SetFilterObj( image, WasCreatedAsImage );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromImage", 2 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromImageWithGivenImage,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromImageWithGivenImageFunction( category, func );
    
    SetCanComputeUniversalMorphismFromImageWithGivenImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImageWithGivenImage,
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
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromImageWithGivenImage", 3 ) );
    
end );

####################################
##
## Attributes
##
####################################

InstallMethod( ImageEmbedding,
               [ IsCapCategoryObject and WasCreatedAsImage ],
               
  function( image )
    
    return ImageEmbedding( Genesis( image )!.ImageDiagram );
    
end );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryObject and WasCreatedAsImage ],
               
  function( image )
    
    return CoastrictionToImage( Genesis( image )!.ImageDiagram );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeImage, CanComputeImageEmbedding );

InstallMethod( ImageObject,
               [ IsCapCategoryMorphism and CanComputeImageEmbedding ],
               -9999, #FIXME
                                    
  function( mor )
    local image;
    
    ## ImageEmbedding creates an ImageObject as source
    image := Source( ImageEmbedding( mor ) );
    
    return image;
    
end );

## Note: As long as the above derived ImageObject-function is used,
## there is no need to implement ImageEmbeddingWithGivenImage in order
## to keep these methods consistent.
##
InstallTrueMethod( CanComputeImageEmbedding, CanComputeKernelEmb and CanComputeCokernelProj );

InstallMethod( ImageEmbedding,
               [ IsCapCategoryMorphism and CanComputeImageEmbedding ],
               -9999, #FIXME
                                    
  function( mor )
    local image_embedding, image;
    
    ## consistency check
    if HasImageObject( mor ) then
      
      return ImageEmbeddingWithGivenImage( mor, ImageObject( mor ) );
      
    fi;
    
    image_embedding := KernelEmb( CokernelProj( mor ) );
    
    image := Source( image_embedding );
    
    AddToGenesis( image, "ImageDiagram", mor );
    
    SetFilterObj( image, WasCreatedAsImage );
    
    SetImageObject( mor, image );
    
    return image_embedding;
    
end );

##
InstallTrueMethod( CanComputeImageEmbedding, CanComputeImageEmbeddingWithGivenImage and CanComputeImage );

InstallMethod( ImageEmbedding,
               [ IsCapCategoryMorphism
                 and CanComputeImageEmbeddingWithGivenImage
                 and CanComputeImage ],
                 -9900, #FIXME
                 
  function( morphism )
    
    return ImageEmbeddingWithGivenImage( ImageObject( morphism ), morphism );
  
end );


##
InstallTrueMethod( CanComputeCoastrictionToImage, CanComputeCoastrictionToImageWithGivenImage and CanComputeImage );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryMorphism
                 and CanComputeCoastrictionToImageWithGivenImage 
                 and CanComputeImage ],
                 -9900, #FIXME
                 
  function( morphism )
    
    return CoastrictionToImageWithGivenImage( Image( morphism ), morphism );
    
end );

##
InstallTrueMethod( CanComputeCoastrictionToImage,
                   CanComputeImageEmbedding
                   and CanComputeMonoAsKernelLift );

InstallMethod( CoastrictionToImage,
               [ IsCapCategoryMorphism
                 and CanComputeImageEmbedding
                 and CanComputeMonoAsKernelLift ],
                 -9999, #FIXME
                 
  function( morphism )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return MonoAsKernelLift( image_embedding, morphism );
    
end );

##
InstallTrueMethod( CanComputeUniversalMorphismFromImage,
                   CanComputeUniversalMorphismFromImageWithGivenImage
                   and CanComputeImage );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImage,
               [ IsCapCategoryMorphism
                 and CanComputeUniversalMorphismFromImageWithGivenImage
                 and CanComputeImage,
                 IsList ],
                 -9900, #FIXME
                 
  function( morphism, test_factorization )
    
    return UniversalMorphismFromImageWithGivenImage( morphism, test_factorization, ImageObject( morphism ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 1 );

##
InstallTrueMethod( CanComputeUniversalMorphismFromImage,
                   CanComputeMonoAsKernelLift
                   and CanComputeImageEmbedding );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromImage,
               [ IsCapCategoryMorphism
                 and CanComputeMonoAsKernelLift
                 and CanComputeImageEmbedding,
                 IsList ],
                 -9999, #FIXME
                 
  function( morphism, test_factorization )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return MonoAsKernelLift( test_factorization[2], image_embedding );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 1 );
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

