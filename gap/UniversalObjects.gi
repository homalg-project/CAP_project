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

#FIXME: Add CanComputePreCompose to assumptions in implied methods

##
InstallMethod( AddToGenesis,
               [ IsHomalgCategoryCell, IsString, IsObject ], 

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
        
        AddToGenesis( kernel, "KernelDiagram", mor );
        
        return kernel;
        
    end );
    
end );

## convenience method
##
InstallMethod( KernelLift,
               [ IsHomalgCategoryObject, IsHomalgCategoryMorphism ],
               
  function( kernel, test_morphism )
  
    return KernelLift( Genesis( kernel )!.KernelDiagram, test_morphism );
  
end );

##
InstallMethod( AddKernelLift,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelLiftFunction( category, func );
    
    SetCanComputeKernelLift( category, true );
    
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
        
        AddToGenesis( kernel, "KernelDiagram", mor );
        
        return kernel_lift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "KernelLift", 2 ) );
    
end );

##
InstallMethod( AddKernelLiftWithGivenKernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelLiftWithGivenKernelFunction( category, func );
    
    SetCanComputeKernelLiftWithGivenKernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( KernelLiftWithGivenKernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, test_morphism, kernel )
        local kernel_lift;
        
        kernel_lift := func( mor, test_morphism, kernel );
        
        Add( HomalgCategory( mor ), kernel_lift );
        
        return kernel_lift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "KernelLiftWithGivenKernel", 3 ) );
    
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
        
        AddToGenesis( kernel, "KernelDiagram", mor );
        
        SetKernelEmb( kernel, kernel_emb );
        
        #Is this necessary (and in all other analogous situations?): SetKernelEmbWithGivenKernel( mor, kernel, kernel_emb );
        
        return kernel_emb;
        
    end );
    
end );

##
InstallMethod( AddKernelEmbWithGivenKernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetKernelEmbWithGivenKernelFunction( category, func );
    
    SetCanComputeKernelEmbWithGivenKernel( category, true );
    
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
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "KernelEmbWithGivenKernel", 2 ) );

end );


####################################
## Attributes
####################################

##
InstallMethod( KernelEmb,
               [ IsHomalgCategoryObject and WasCreatedAsKernel ],
               
  function( kernel )
  
    return KernelEmb( Genesis( kernel )!.KernelDiagram );
    
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
    local kernel_lift, kernel;
    
    ## KernelEmb passes its kernel object to the kernel lift
    kernel_lift := MonoAsKernelLift( KernelEmb( mor ), test_morphism );
    
    return kernel_lift;
    
end );

##
InstallTrueMethod( CanComputeKernelLiftWithGivenKernel, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

InstallMethodWithCacheFromObject( KernelLiftWithGivenKernel,
                                  [ IsHomalgCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsHomalgCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                                    IsHomalgCategoryObject and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                                           
    function( mor, test_morphism, kernel )
      
      return MonoAsKernelLift( KernelEmb( kernel ), test_morphism );
      
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
        
        AddToGenesis( cokernel,"CokernelDiagram", mor );
        
        return cokernel;
        
    end );
    
end );

## convenience
##
InstallMethod( CokernelColift,
               [ IsHomalgCategoryObject, IsHomalgCategoryMorphism ],
               
  function( cokernel, test_morphism )
  
    return CokernelColift( Genesis( cokernel )!.CokernelDiagram, test_morphism );
  
end );

##
InstallMethod( AddCokernelColift,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelColiftFunction( category, func );
    
    SetCanComputeCokernelColift( category, true );
    
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
        
        AddToGenesis( cokernel, "CokernelDiagram", mor );
        
        return cokernel_colift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CokernelColift", 2 ) );
    
end );

##
InstallMethod( AddCokernelColiftWithGivenCokernel,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCokernelColiftWithGivenCokernelFunction( category, func );
    
    SetCanComputeCokernelColiftWithGivenCokernel( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CokernelColiftWithGivenCokernel,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, test_morphism, cokernel )
        local cokernel_colift;
        
        cokernel_colift := func( mor, test_morphism, cokernel );
        
        Add( HomalgCategory( mor ), cokernel_colift );
        
        return cokernel_colift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CokernelColiftWithGivenCokernel", 3 ) );
    
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
        
        AddToGenesis( cokernel, "CokernelDiagram", mor );

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
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CokernelProjWithGivenCokernel", 2 ) );
    
end );

####################################
## Attributes 
####################################

##
InstallMethod( CokernelProj,
               [ IsHomalgCategoryObject and WasCreatedAsCokernel ],
               
  function( cokernel )
    
    return CokernelProj( Genesis( cokernel )!.CokernelDiagram );
    
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
InstallTrueMethod( CanComputeCokernelColiftWithGivenCokernel, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

InstallMethodWithCacheFromObject( CokernelColiftWithGivenCokernel,
                                  [ IsHomalgCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsHomalgCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                                    IsHomalgCategoryObject and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                                           
    function( mor, test_morphism, cokernel )
      
      return EpiAsCokernelColift( CokernelProj( cokernel ), test_morphism );
      
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
## Coproduct and Pushout
##
####################################

##
InstallGlobalFunction( InjectionOfCofactor,
               
  function( object_product_list, injection_number )
    local number_of_objects;
    
    if WasCreatedAsCoproduct( object_product_list ) then
    
      number_of_objects := Length( Components( Genesis( object_product_list )!.Cofactors ) );
      
      if injection_number < 1 or injection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
      
      fi;
    
      return InjectionOfCofactorWithGivenCoproduct( Genesis( object_product_list )!.Cofactors, injection_number, object_product_list );
    
    fi;
    
    if WasCreatedAsPushout( object_product_list ) then
    
      number_of_objects := Length( Components( Genesis( object_product_list )!.PushoutDiagram ) );
      
      if injection_number < 1 or injection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
      
      fi;
    
      return InjectionOfCofactorWithGivenPushout( Genesis( object_product_list )!.PushoutDiagram, injection_number, object_product_list );
    
    fi;
    
    number_of_objects := Length( Components( object_product_list ) );
  
    if injection_number < 0 or injection_number > number_of_objects then
    
      Error( Concatenation( "there does not exist a ", String( injection_number ), "-th injection" ) );
    
    fi;
  
    if number_of_objects = 1 then
        
      return IdentityMorphism( object_product_list[1] );
          
    fi;
  
    return InjectionOfCofactorOp( object_product_list, injection_number, object_product_list[1] );
  
end );

####################################
##
## Coproduct
##
####################################

InstallGlobalFunction( Coproduct,
  
  function( arg )
  
    if Length( arg ) = 1 then 
      
      return arg[1];
        
    fi;
    
    return CoproductOp( CallFuncList( Product, arg ), arg[ 1 ] );
    
end );

##
InstallMethod( AddCoproduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCoproductFunction( category, func );
    
    SetCanComputeCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                           [ IsHomalgCategoryObject, IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local coproduct;
        
        coproduct := func( object_product_list );
        
        Add( HomalgCategory( method_selection_object ), coproduct );
        
        AddToGenesis( coproduct, "Cofactors", object_product_list );
        
        SetFilterObj( coproduct, WasCreatedAsCoproduct );
        
        return coproduct;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "CoproductOp", 2 ) );
    
end );

##
InstallMethod( AddInjectionOfCofactor,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorFunction( category, func );
    
    SetCanComputeInjectionOfCofactor( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOp,
                                           [ IsHomalgCategoryObject, 
                                             IsInt,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, injection_number, method_selection_object )
        local injection_of_cofactor, coproduct;
        
        if HasCoproductOp( object_product_list, method_selection_object ) then
          
          return InjectionOfCofactorWithGivenCoproduct( object_product_list, injection_number, CoproductOp( object_product_list, method_selection_object ) );
          
        fi;
        
        injection_of_cofactor := func( object_product_list, injection_number );
        
        Add( HomalgCategory( method_selection_object ), injection_of_cofactor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitMonomorphism( injection_of_cofactor, true );
          
        fi;
        
        coproduct := Range( injection_of_cofactor );
        
        AddToGenesis( coproduct, "Cofactors", object_product_list );
        
        SetCoproductOp( object_product_list, method_selection_object, coproduct );
        
        SetFilterObj( coproduct, WasCreatedAsCoproduct );
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorOp", 3 ) );

end );

##
InstallMethod( AddInjectionOfCofactorWithGivenCoproduct,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorWithGivenCoproductFunction( category, func );
    
    SetCanComputeInjectionOfCofactorWithGivenCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorWithGivenCoproduct,
                                           [ IsHomalgCategoryObject, 
                                             IsInt,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, injection_number, coproduct )
        local injection_of_cofactor;
        
        injection_of_cofactor := func( object_product_list, injection_number, coproduct );
        
        Add( category, injection_of_cofactor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitMonomorphism( injection_of_cofactor, true );
          
        fi;
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorWithGivenCoproduct", 3 ) );

end );

##
InstallGlobalFunction( UniversalMorphismFromCoproduct,

  function( arg )
    
    return UniversalMorphismFromCoproductOp( CallFuncList( Product, arg ), arg[1] );
  
end );

##
InstallMethod( AddUniversalMorphismFromCoproduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromCoproductFunction( category, func );
    
    SetCanComputeUniversalMorphismFromCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( sink, method_selection_morphism )
        local test_object, components, coproduct_objects, universal_morphism, coproduct;
        
        test_object := Range( sink[1] );
        
        components := Components( sink );
        
        coproduct_objects := CallFuncList( Product, List( Components( sink ), Source ) );
        
        if HasCoproductOp( coproduct_objects, coproduct_objects[1] ) then
          
          return UniversalMorphismFromCoproductWithGivenCoproduct( 
                   sink, 
                   CoproductOp( coproduct_objects, coproduct_objects[1] ) 
                 );
          
        fi;
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be identical in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( sink );
        
        Add( category, universal_morphism );
        
        coproduct := Source( universal_morphism );
        
        AddToGenesis( coproduct, "Cofactors", coproduct_objects );
        
        SetCoproductOp( coproduct_objects, coproduct_objects[1], coproduct );
        
        SetFilterObj( coproduct, WasCreatedAsCoproduct );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromCoproductOp", 2 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromCoproductWithGivenCoproduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromCoproductWithGivenCoproductFunction( category, func );
    
    SetCanComputeUniversalMorphismFromCoproductWithGivenCoproduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductWithGivenCoproduct,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( sink, coproduct )
        local test_object, components, coproduct_objects, universal_morphism;
        
        test_object := Range( sink[1] );
        
        components := Components( sink );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be identical in given sink-diagram" );
            
        fi;
        
        universal_morphism := func( sink, coproduct );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromCoproductWithGivenCoproduct", 2 ) );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeCoproduct, CanComputeInjectionOfCofactor );

##
## this methods is installed using the (cache of the (object of the second argument) )
InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                       [ IsHomalgCategoryObject,
                                         IsHomalgCategoryObject and CanComputeInjectionOfCofactor ],
                                        -9999, #FIXME
                                        
  function( object_product_list, method_selection_object )
    
    return Range( InjectionOfCofactor( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeUniversalMorphismFromCoproduct,
                   CanComputeCoproduct and CanComputeUniversalMorphismFromCoproductWithGivenCoproduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductOp,
                                       [ IsHomalgCategoryMorphism,
                                         IsHomalgCategoryMorphism and CanComputeCoproduct and CanComputeUniversalMorphismFromCoproductWithGivenCoproduct ],
                                         -9999, #FIXME
                                       
  function( sink, method_selection_morphism )
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( sink, CallFuncList( Coproduct, List( Components( sink ), Source ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeInjectionOfCofactor, CanComputeCoproduct and CanComputeInjectionOfCofactorWithGivenCoproduct );

InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOp,
                                       [ IsHomalgCategoryObject,
                                         IsInt,
                                         IsHomalgCategoryObject and CanComputeCoproduct and CanComputeInjectionOfCofactorWithGivenCoproduct, ],
                                         -9999, #FIXME
                                         
  function( object_product_list, injection_number, method_selection_object )
    
    return InjectionOfCofactorWithGivenCoproduct( object_product_list, injection_number, CallFuncList( Coproduct, Components( object_product_list ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


####################################
##
## Direct Product and Pullback
##
####################################

##
InstallGlobalFunction( ProjectionInFactor,
               
  function( object_product_list, projection_number )
    local number_of_objects;
    
    if WasCreatedAsDirectProduct( object_product_list ) then
    
      number_of_objects := Length( Components( Genesis( object_product_list )!.DirectFactors ) );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorWithGivenDirectProduct( Genesis( object_product_list )!.DirectFactors, projection_number, object_product_list );
    
    fi;
    
    if WasCreatedAsPullback( object_product_list ) then
    
      number_of_objects := Length( Components( Genesis( object_product_list )!.PullbackDiagram ) );
      
      if projection_number < 1 or projection_number > number_of_objects then
      
        Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
      
      fi;
    
      return ProjectionInFactorOfPullbackWithGivenPullback( Genesis( object_product_list )!.PullbackDiagram, projection_number, object_product_list );
    
    fi;
    
    number_of_objects := Length( Components( object_product_list ) );
  
    if projection_number < 0 or projection_number > number_of_objects then
    
      Error( Concatenation( "there does not exist a ", String( projection_number ), "-th projection" ) );
    
    fi;
  
    if number_of_objects = 1 then
        
      return IdentityMorphism( object_product_list[1] );
          
    fi;
  
    return ProjectionInFactorOp( object_product_list, projection_number, object_product_list[1] );
  
end );


####################################
##
## Direct Product
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
    
    InstallMethodWithToDoForIsWellDefined( DirectProductOp,
                                           [ IsHomalgCategoryObject, IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local direct_product;
        
        direct_product := func( object_product_list );
        
        SetFilterObj( direct_product, WasCreatedAsDirectProduct );
        
        AddToGenesis( direct_product, "DirectFactors", object_product_list );
        
        Add( HomalgCategory( method_selection_object ), direct_product );
        
        return direct_product;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "DirectProductOp", 2 ) );
    
end );

##TODO: Install AddProjectionInFactor convenient method with 
##the direct product object as an input

##
InstallMethod( AddProjectionInFactor,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorFunction( category, func );
    
    SetCanComputeProjectionInFactor( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOp,
                                           [ IsHomalgCategoryObject,
                                             IsInt,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                             
      function( object_product_list, projection_number, method_selection_object )
        local projection_in_factor, direct_product;
        
        if HasDirectProductOp( object_product_list, method_selection_object ) then
          
          return ProjectionInFactorWithGivenDirectProduct( object_product_list, projection_number, DirectProductOp( object_product_list, method_selection_object ) );
          
        fi;
        
        projection_in_factor := func( object_product_list, projection_number );
        
        Add( HomalgCategory( method_selection_object ), projection_in_factor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitEpimorphism( projection_in_factor, true );
          
        fi;
        
        direct_product := Source( projection_in_factor );
        
        AddToGenesis( direct_product, "DirectFactors", object_product_list );
        
        SetDirectProductOp( object_product_list, method_selection_object, direct_product );
        
        SetFilterObj( direct_product, WasCreatedAsDirectProduct );
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorOp", 3 ) );

end );

##
InstallMethod( AddProjectionInFactorWithGivenDirectProduct,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorWithGivenDirectProductFunction( category, func );
    
    SetCanComputeProjectionInFactorWithGivenDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorWithGivenDirectProduct,
                                           [ IsHomalgCategoryObject,
                                             IsInt,
                                             IsHomalgCategoryObject and ObjectFilter( category ),  ],
                                             
      function( object_product_list, projection_number, direct_product )
        local projection_in_factor;
        
        projection_in_factor := func( object_product_list, projection_number, direct_product );
        
        Add( category, projection_in_factor );
        
        ## FIXME: it suffices that the category knows that it has a zero object
        if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
          
          SetIsSplitEpimorphism( projection_in_factor, true );
          
        fi;
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorWithGivenDirectProduct", 3 ) );

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
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( source, method_selection_morphism )
        local test_object, components, direct_product_objects, universal_morphism, direct_product;
        
        test_object := Source( source[1] );
        
        components := Components( source );
        
        direct_product_objects := CallFuncList( Product, List( Components( source ), Range ) );
        
        if HasDirectProductOp( direct_product_objects, direct_product_objects[1] ) then
        
          return UniversalMorphismIntoDirectProductWithGivenDirectProduct( 
                   source, 
                   DirectProductOp( direct_product_objects, direct_product_objects[1] ) 
                 );
          
        fi;
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be identical in given source-diagram" );
            
        fi;
        
        universal_morphism := func( source );
        
        Add( category, universal_morphism );
        
        direct_product := Range( universal_morphism );
        
        AddToGenesis( direct_product, "DirectFactors", direct_product_objects );
        
        SetDirectProductOp( direct_product_objects, direct_product_objects[1], direct_product );
        
        Add( HomalgCategory( direct_product_objects[1] ), direct_product );
        
        SetFilterObj( direct_product, WasCreatedAsDirectProduct );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoDirectProductOp", 2 ) );
    
end );

##
InstallMethod( AddUniversalMorphismIntoDirectProductWithGivenDirectProduct,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoDirectProductWithGivenDirectProductFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( source, direct_product )
        local test_object, components, direct_product_objects, universal_morphism;
        
        test_object := Source( source[1] );
        
        components := Components( source );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be identical in given source-diagram" );
            
        fi;
        
        universal_morphism := func( source, direct_product );
        
        Add( category, universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoDirectProductWithGivenDirectProduct", 2 ) );
    
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
                                        -9999, #FIXME
                                        
  function( object_product_list, method_selection_object )
    
    return Source( ProjectionInFactor( object_product_list, 1 ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoDirectProduct,
                   CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductOp,
                                       [ IsHomalgCategoryMorphism,
                                         IsHomalgCategoryMorphism and CanComputeDirectProduct and CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct ],
                                         -9999, #FIXME
                                       
  function( source, method_selection_morphism )
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( source, CallFuncList( DirectProduct, List( Components( source ), Range ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeProjectionInFactor, CanComputeDirectProduct and CanComputeProjectionInFactorWithGivenDirectProduct );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOp,
                                       [ IsHomalgCategoryObject,
                                         IsInt,
                                         IsHomalgCategoryObject and CanComputeDirectProduct and CanComputeProjectionInFactorWithGivenDirectProduct, ],
                                         -9999, #FIXME
                                         
  function( object_product_list, projection_number, method_selection_object )
    
    return ProjectionInFactorWithGivenDirectProduct( object_product_list, projection_number, CallFuncList( DirectProduct, Components( object_product_list ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

####################################
##
## Direct sum
##
####################################

## Immediate methods which link DirectProduct and Coproduct to
## DirectSum in the additive case
InstallImmediateMethod( IS_IMPLIED_DIRECT_SUM,
                        IsHomalgCategoryObject and WasCreatedAsDirectProduct and IsAdditiveCategory,
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
                        IsHomalgCategoryObject and WasCreatedAsCoproduct and IsAdditiveCategory,
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
BindGlobal( "HOMALG_CATEGORIES_DIRECT_SUM_SAVE", DirectSum );

MakeReadWriteGlobal( "DirectSum" );

DirectSum := function( arg )
  
  if ( ForAll( arg, IsHomalgCategory ) or ForAll( arg, IsHomalgCategoryObject ) or ForAll( arg, IsHomalgCategoryMorphism ) ) and Length( arg ) > 0 then
      
      if Length( arg ) = 1 then 
      
        return arg[1];
        
      fi;
      
      return DirectSumOp( CallFuncList( Product, arg ), arg[ 1 ] );
      
  fi;
  
  return CallFuncList( HOMALG_CATEGORIES_DIRECT_SUM_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "DirectSum" );

##
InstallMethod( AddDirectSum,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetDirectSumFunction( category, func );
    
    SetCanComputeDirectSum( category, true );
    
    InstallMethodWithToDoForIsWellDefined( DirectSumOp,
                                           [ IsHomalgCategoryObject, IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( object_product_list, method_selection_object )
        local direct_sum;
        
        direct_sum := func( object_product_list );
        
        Add( HomalgCategory( method_selection_object ), direct_sum );
        
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
                                       [ IsHomalgCategoryObject, IsHomalgCategoryObject and CanComputeDirectSum ],
                                       -9999 + 1, #FIXME
                                       
  function( object_product_list, method_selection_object )
    
    return DirectSumOp( object_product_list, method_selection_object );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeCoproduct,
                   CanComputeDirectSum );

InstallMethodWithToDoForIsWellDefined( CoproductOp,
                                       [ IsHomalgCategoryObject, IsHomalgCategoryObject and CanComputeDirectSum ],
                                       -9999 + 1, #FIXME
                                       
  function( object_product_list, method_selection_object )
    
    return DirectSumOp( object_product_list, method_selection_object );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2  );

##
InstallTrueMethod( CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct,
                   IsAdditiveCategory
                   and CanComputeInjectionOfCofactor
                   and CanComputeAdditionForMorphisms 
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoDirectProductWithGivenDirectProduct,
                                       [ IsHomalgCategoryMorphism,
                                         IsHomalgCategoryObject 
                                     and IsAdditiveCategory
                                     and CanComputeInjectionOfCofactor 
                                     and CanComputeAdditionForMorphisms
                                     and CanComputePreCompose ],
                                       -9999 - 1, #FIXME
                                       
  function( source, direct_product )
    local nr_components;
    
    nr_components := Length( Components( source ) );
  
    return Sum( List( [ 1 .. nr_components ], i -> PreCompose( source[ i ], InjectionOfCofactor( direct_product, i ) ) ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2  );

##
InstallTrueMethod( CanComputeUniversalMorphismFromCoproductWithGivenCoproduct,
                   IsAdditiveCategory
                   and CanComputeProjectionInFactor
                   and CanComputeAdditionForMorphisms 
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromCoproductWithGivenCoproduct,
                                       [ IsHomalgCategoryMorphism,
                                         IsHomalgCategoryObject
                                     and IsAdditiveCategory
                                     and CanComputeProjectionInFactor
                                     and CanComputeAdditionForMorphisms
                                     and CanComputePreCompose ],
                                       -9999 - 1, #FIXME
                                       
  function( sink, coproduct )
    local nr_components;
    
    nr_components := Length( Components( sink ) );
  
    return Sum( List( [ 1 .. nr_components ], i -> PreCompose( ProjectionInFactor( coproduct, i ), sink[ i ] ) ) );
  
end  : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeAdditionForMorphisms,
                   IsAdditiveCategory
                   and CanComputeDirectSum
                   and CanComputeUniversalMorphismIntoDirectProduct
                   and CanComputeIdentityMorphism
                   and CanComputeUniversalMorphismFromCoproduct
                   and CanComputePreCompose );

InstallMethodWithToDoForIsWellDefined( \+,
                                       [ IsHomalgCategoryMorphism
                                     and IsAdditiveCategory
                                     and CanComputeDirectSum
                                     and CanComputeUniversalMorphismIntoDirectProduct
                                     and CanComputeIdentityMorphism
                                     and CanComputeUniversalMorphismFromCoproduct
                                     and CanComputePreCompose,
                                         IsHomalgCategoryMorphism ],
                                         -9999,
                                         
  function( mor1, mor2 )
    local return_value, B, direct_sum, componentwise_morphism, addition_morphism;
        
    if not IsIdenticalObj( HomalgCategory( mor1 ), HomalgCategory( mor2 ) ) or not IsIdenticalObj( Source( mor1 ), Source( mor2 ) ) or not IsIdenticalObj( Range( mor1 ), Range( mor2 ) ) then
      
      Error( "morphisms are not addable" );
      
    fi;
    
    B := Range( mor1 );
    
    direct_sum := DirectSum( B, B );
    
    componentwise_morphism := UniversalMorphismIntoDirectProduct( mor1, mor2 );
    
    addition_morphism := UniversalMorphismFromCoproduct( IdentityMorphism( B ), IdentityMorphism( B ) );
    
    return PreCompose( componentwise_morphism, addition_morphism );
    
end );

####################################
##
## Zero Object
##
####################################

## Immediate methods which link InitialObject and TerminalObject to
## ZeroObject in the additive case
InstallImmediateMethod( IS_IMPLIED_ZERO_OBJECT,
                        IsHomalgCategoryObject and WasCreatedAsTerminalObject and IsAdditiveCategory,
                        0,
                        
  function( terminal_object )
    local category;
    
    category := HomalgCategory( terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsZeroObject );
    
    SetZeroObject( category, terminal_object );
    
    SetFilterObj( terminal_object, WasCreatedAsInitialObject );
    
    SetInitialObject( category, terminal_object );
    
    return true;
    
end );

##
InstallImmediateMethod( IS_IMPLIED_ZERO_OBJECT,
                        IsHomalgCategoryObject and WasCreatedAsInitialObject and IsAdditiveCategory,
                        0,
                        
  function( initial_object )
    local category;
    
    category := HomalgCategory( initial_object );
    
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetZeroObjectFunction( category, func );
    
    SetCanComputeZeroObject( category, true );
    
end );

####################################
## Attributes
####################################

##
InstallMethod( ZeroObject,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return ZeroObject( HomalgCategory( cell ) );
    
end );

##
InstallMethodWithToDoForIsWellDefined( ZeroObject,
                                       [ IsHomalgCategory ],
                                       
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
                                       [ IsHomalgCategoryObject ],
                                       
   function( obj )
   
     return UniversalMorphismFromInitialObject( obj );
   
end );

##
InstallMethodWithToDoForIsWellDefined( MorphismIntoZeroObject,
                                       [ IsHomalgCategoryObject ],
                                       
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetTerminalObjectFunction( category, func );
    
    SetCanComputeTerminalObject( category, true );
    
end );

##
InstallMethod( AddUniversalMorphismIntoTerminalObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoTerminalObjectFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoTerminalObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoTerminalObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_source )
        local category, universal_morphism, terminal_object;
        
        category := HomalgCategory( test_source );
        
        if HasTerminalObject( category ) then
        
          return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( category ) );
          
        fi;
        
        universal_morphism := func( test_source );
        
        Add( HomalgCategory( test_source ), universal_morphism );
        
        terminal_object := Range( universal_morphism );
        
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
    
    SetCanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_source, terminal_object )
        local universal_morphism;
        
        universal_morphism := func( test_source, terminal_object );
        
        Add( HomalgCategory( test_source ), universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject", 2 ) );
    
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
InstallMethod( TerminalObject,
               [ IsHomalgCategory and HasTerminalObjectFunction ],
               
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
               [ IsHomalgCategoryObject and CanComputeTerminalObject and CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject ],
               -9999, #FIXME
              
  function( test_source )
    
    return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( test_source, TerminalObject( HomalgCategory( test_source ) ) );
    
end );

##
InstallTrueMethod( CanComputeTerminalObject, CanComputeZeroObject );

##
InstallMethod( TerminalObject,
               [ IsHomalgCategoryObject and CanComputeZeroObject ],
               - 9999, # FIXME
               
  function( object )
    
    return ZeroObject( object );
    
end );

##
InstallMethod( TerminalObject,
               [ IsHomalgCategory and CanComputeZeroObject ],
               -9999,
               
  function( category )
    
    return ZeroObject( category );
    
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
                                           
      function( test_sink )
        local category, universal_morphism, initial_object;
        
        category := HomalgCategory( test_sink );
        
        if HasInitialObject( category ) then
        
          return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( category ) );
          
        fi;
        
        universal_morphism := func( test_sink );
        
        Add( HomalgCategory( test_sink ), universal_morphism );
        
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
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromInitialObjectWithGivenInitialObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( test_sink, initial_object )
        local universal_morphism;
        
        universal_morphism := func( test_sink, initial_object );
        
        Add( HomalgCategory( test_sink ), universal_morphism );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromDirectProductWithGivenInitialObject", 2 ) );
    
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
InstallMethod( InitialObject,
               [ IsHomalgCategory and HasInitialObjectFunction ],
               
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
               [ IsHomalgCategoryObject and CanComputeInitialObject and CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject ],
               -9999, #FIXME
              
  function( test_sink )
    
    return UniversalMorphismFromInitialObjectWithGivenInitialObject( test_sink, InitialObject( HomalgCategory( test_sink ) ) );
    
end );

##
InstallTrueMethod( CanComputeInitialObject, CanComputeZeroObject );

##
InstallMethod( InitialObject,
               [ IsHomalgCategoryObject and CanComputeZeroObject ],
               - 9999, # FIXME
               
  function( object )
    
    return ZeroObject( object );
    
end );

##
InstallMethod( InitialObject,
               [ IsHomalgCategory and CanComputeZeroObject ],
               -9999,
               
  function( category )
    
    return ZeroObject( category );
    
end );

####################################
##
## Pullback
##
####################################

InstallGlobalFunction( FiberProduct,
  
  function( arg )
  
    #the pullback of a tuple of morphisms over the same base B can be interpreted
    #as the direct product in the category of morphisms over B. Thus it makes sense
    #to deal with the special case where only one morphism is considered as follows:
    if Length( arg ) = 1 then 
      
      return arg[1];
        
    fi;
    
    return PullbackOp( CallFuncList( Product, arg ), arg[ 1 ] );
    
end );

####################################
## Add Operations
####################################

##
InstallMethod( AddPullback,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetPullbackFunction( category, func );
    
    SetCanComputePullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( PullbackOp,
                                           [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( diagram, method_selection_morphism )
        local base, pullback;
        
        base := Range( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj(  Range( c ), base ) ) then
        
          Error( "the given morphisms of the pullback diagram must have the same range\n" );
        
        fi;
        
        pullback := func( diagram );
        
        SetFilterObj( pullback, WasCreatedAsPullback );
        
        AddToGenesis( pullback, "PullbackDiagram", diagram );
        
        Add( HomalgCategory( method_selection_morphism ), pullback );
        
        return pullback;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "PullbackOp", 2 ) );
    
end );

##
InstallMethod( AddProjectionInFactorOfPullback,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorOfPullbackFunction( category, func );
    
    SetCanComputeProjectionInFactorOfPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOp,
                                           [ IsHomalgCategoryMorphism, 
                                             IsInt,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                             
      function( diagram, projection_number, method_selection_morphism )
        local base, projection_in_factor, pullback;
        
        if HasPullbackOp( diagram, method_selection_morphism ) then
          
          return ProjectionInFactorOfPullbackWithGivenPullback( diagram, projection_number, PullbackOp( diagram, method_selection_morphism ) );
          
        fi;
        
        base := Range( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj(  Range( c ), base ) ) then
        
          Error( "the given morphisms of the pullback diagram must have the same range\n" );
        
        fi;
        
        projection_in_factor := func( diagram, projection_number );
        
        Add( HomalgCategory( method_selection_morphism ), projection_in_factor );
        
        pullback := Source( projection_in_factor );
        
        AddToGenesis( pullback, "PullbackDiagram", diagram );
        
        SetPullbackOp( diagram, method_selection_morphism, pullback );
        
        SetFilterObj( pullback, WasCreatedAsPullback );
        
        return projection_in_factor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ProjectionInFactorOfPullbackOp", 3 ) );

end );

##
InstallMethod( AddProjectionInFactorOfPullbackWithGivenPullback,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetProjectionInFactorOfPullbackWithGivenPullbackFunction( category, func );
    
    SetCanComputeProjectionInFactorOfPullbackWithGivenPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackWithGivenPullback,
                                           [ IsHomalgCategoryMorphism,
                                             IsInt,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                             
      function( diagram, projection_number, pullback )
        local base, projection_in_factor;
        
        base := Range( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj(  Range( c ), base ) ) then
        
          Error( "the given morphisms of the pullback diagram must have the same range\n" );
        
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
    
    pullback_or_diagram := arg[ 1 ];
    
    source := arg{[ 2 .. Length( arg ) ]};
    
    if WasCreatedAsPullback( pullback_or_diagram ) then
    
      diagram := Genesis( pullback_or_diagram )!.PullbackDiagram;
    
      return UniversalMorphismIntoPullbackOp( diagram, CallFuncList( Product, source ), diagram[1] );
    
    fi;
    
    return UniversalMorphismIntoPullbackOp( pullback_or_diagram, CallFuncList( Product, source ), pullback_or_diagram[1] );
    
end );

##
InstallMethod( AddUniversalMorphismIntoPullback,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoPullbackFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
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
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj(  Range( c ), base ) ) then
          
          Error( "the given morphisms of the pullback diagram must have the same range\n" );
          
        fi;
        
        test_object := Source( source[1] );
        
        components := Components( source );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be identical in given source-diagram" );
            
        fi;
        
        ## here the user also needs the diagram
        universal_morphism := func( diagram, source );
        
        Add( category, universal_morphism );
        
        pullback := Range( universal_morphism );
        
        AddToGenesis( pullback, "PullbackDiagram", diagram );
        
        SetPullbackOp( diagram, diagram[1], pullback );
        
        Add( HomalgCategory( diagram[1] ), pullback );
        
        SetFilterObj( pullback, WasCreatedAsPullback );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismIntoPullbackOp", 3 ) );
    
end );

##
InstallMethod( AddUniversalMorphismIntoPullbackWithGivenPullback,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismIntoPullbackWithGivenPullbackFunction( category, func );
    
    SetCanComputeUniversalMorphismIntoPullbackWithGivenPullback( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackWithGivenPullback,
                                           [ IsHomalgCategoryMorphism, 
                                             IsHomalgCategoryMorphism, 
                                             IsHomalgCategoryObject and ObjectFilter( category ) 
                                           ],
                                           
      function( diagram, source, pullback )
        local base, test_object, components, universal_morphism;
        
        base := Range( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj( Range( c ), base ) ) then
          
          Error( "the given morphisms of the pullback diagram must have the same range\n" );
          
        fi;
        
        test_object := Source( source[1] );
        
        components := Components( source );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Source( c ), test_object ) ) then
            
            Error( "sources of morphisms must be identical in given source-diagram" );
            
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
                                       CanComputeProjectionInFactor and 
                                       CanComputePreCompose and
                                       CanComputeAdditionForMorphisms and
                                       CanComputeAdditiveInverseForMorphisms and
                                       CanComputeKernel );

##
InstallMethodWithToDoForIsWellDefined( PullbackOp,
                                       [ IsHomalgCategoryMorphism, 
                                         IsHomalgCategoryMorphism and
                                         CanComputeDirectProduct and 
                                         CanComputeProjectionInFactor and 
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeKernel ],
                                         -9999, #FIXME
                                         
  function( diagram, method_selection_morphism )
    local base, direct_product, number_of_morphisms, list_of_morphisms, mor1, mor2, pullback, diff;
    
    base := Range( diagram[1] );
    
    if not ForAll( Components( diagram ), c -> IsIdenticalObj( Range( c ), base ) ) then
    
      Error( "the given morphisms of the pullback diagram must have the same range\n" );
      
    fi;
    
    direct_product := CallFuncList( DirectProduct, List( Components( diagram ) , Source ) );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( ProjectionInFactor( direct_product, i ), diagram[ i ] ) );
    
    mor1 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismIntoDirectProduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    diff := mor1 - mor2;
    
    pullback := KernelObject( diff );
    
    AddToGenesis(  pullback, "PullbackAsKernelDiagram", diff );
    
    AddToGenesis( pullback, "PullbackDiagram", diagram );
    
    SetFilterObj( pullback, WasCreatedAsPullback );
    
    return pullback;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

##
InstallTrueMethod( CanComputeProjectionInFactorOfPullback, CanComputeProjectionInFactorOfPullbackWithGivenPullback and 
                                                           CanComputePullback );

InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOp,
                                       [ IsHomalgCategoryMorphism,
                                         IsInt,
                                         IsHomalgCategoryMorphism and
                                         CanComputeProjectionInFactorOfPullbackWithGivenPullback and
                                         CanComputePullback ],
                                         
  function( diagram, projection_number, method_selection_morphism )
  
    return ProjectionInFactorOfPullbackWithGivenPullback( diagram, projection_number, PullbackOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeProjectionInFactorOfPullbackWithGivenPullback, CanComputeKernelEmb and
                                                                  CanComputeProjectionInFactor and
                                                                  CanComputePullback );

# FIXME: WARNING: This method only applies if the pullback was created as a kernel AND if this kernel came from 
# the special construction from above. If the
# user gives his own pullback method, this derived method fails.
# Of course, as mentioned in the introduction of this chapter, the user should never only install 
# the constructor of a universal object without also implementing the WithGiven-methods.
InstallMethodWithToDoForIsWellDefined( ProjectionInFactorOfPullbackWithGivenPullback,
                                       [ IsHomalgCategoryMorphism,
                                         IsInt,
                                         IsHomalgCategoryObject and
                                         CanComputeKernelEmb and
                                         CanComputeProjectionInFactor and
                                         CanComputePullback ],
                                         
  function( diagram, projection_number, pullback )
    local embedding_in_direct_product, direct_product, projection;
  
    if not WasCreatedAsKernel( pullback ) or not IsBound( Genesis( pullback )!.PullbackAsKernelDiagram ) then
    
      Error( "pullback had to be created as a kernel" );
    
    fi;
    
    embedding_in_direct_product := KernelEmb( Genesis( pullback )!.PullbackAsKernelDiagram );
    
    direct_product := Range( embedding_in_direct_product );
    
    if not WasCreatedAsDirectProduct( direct_product ) then
    
      Error( "pullback had to be created as a kernel of a morphism with a direct product as source" );
    
    fi;
    
    projection := ProjectionInFactor( direct_product, projection_number );
    
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
                                         IsHomalgCategoryMorphism, 
                                         IsHomalgCategoryMorphism, 
                                         IsHomalgCategoryObject
                                       ],
                                       
  function( diagram, source, pullback )
    local test_function;
    
    if not WasCreatedAsKernel( pullback ) then
      
      Error( "pullback had to be created as a kernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismIntoDirectProduct, Components( source ) );
    
    return KernelLift( pullback, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethod( CanComputeUniversalMorphismIntoPullback, CanComputeUniversalMorphismIntoPullbackWithGivenPullback and 
                                                            CanComputePullback );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismIntoPullbackOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism ],
                                             
  function( diagram, source, method_selection_morphism )
    
    return UniversalMorphismIntoPullbackWithGivenPullback( diagram, source, PullbackOp( diagram, method_selection_morphism ) );
    
end );

####################################
##
## Pushout
##
####################################

InstallGlobalFunction( Pushout,
  
  function( arg )
  
    #the pushout of a tuple of morphisms with same source B can be interpreted
    #as the direct product in the category of morphisms with source B. Thus it makes sense
    #to deal with the special case where only one morphism is considered as follows:
    if Length( arg ) = 1 then 
      
      return arg[1];
        
    fi;
    
    return PushoutOp( CallFuncList( Product, arg ), arg[ 1 ] );
    
end );

####################################
## Add Operations
####################################

##
InstallMethod( AddPushout,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetPushoutFunction( category, func );
    
    SetCanComputePushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( PushoutOp,
                                           [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( diagram, method_selection_morphism )
        local cobase, pushout;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have the same source\n" );
           
        fi;
        
        pushout := func( diagram );
        
        SetFilterObj( pushout, WasCreatedAsPushout );
        
        AddToGenesis( pushout, "PushoutDiagram", diagram );
        
        Add( category, pushout );
        
        return pushout;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "PushoutOp", 2 ) );
    
end );

##
InstallMethod( AddInjectionOfCofactorOfPushout,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorOfPushoutFunction( category, func );
    
    SetCanComputeInjectionOfCofactorOfPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsInt,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ), ],
                                             
      function( diagram, injection_number, method_selection_morphism )
        local cobase, injection_of_cofactor, pushout;
        
        if HasPushoutOp( diagram, method_selection_morphism ) then
          
          return InjectionOfCofactorWithGivenPushout( diagram, injection_number, PushoutOp( diagram, method_selection_morphism ) );
          
        fi;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have the same source\n" );
           
        fi;
        
        injection_of_cofactor := func( diagram, injection_number );
        
        Add( HomalgCategory( method_selection_morphism ), injection_of_cofactor );
        
        pushout := Range( injection_of_cofactor );
        
        AddToGenesis( pushout, "PushoutDiagram", diagram );
        
        SetPushoutOp( diagram, method_selection_morphism, pushout );
        
        SetFilterObj( pushout, WasCreatedAsPushout );
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorOfPushoutOp", 3 ) );

end );

##
InstallMethod( AddInjectionOfCofactorWithGivenPushout,
               [ IsHomalgCategory, IsFunction ],

  function( category, func )
    
    SetInjectionOfCofactorWithGivenPushoutFunction( category, func );
    
    SetCanComputeInjectionOfCofactorWithGivenPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorWithGivenPushout,
                                           [ IsHomalgCategoryMorphism,
                                             IsInt,
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                             
      function( diagram, injection_number, pushout )
        local cobase, injection_of_cofactor;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have the same source\n" );
           
        fi;
        
        injection_of_cofactor := func( diagram, injection_number, pushout );
        
        Add( category, injection_of_cofactor );
        
        return injection_of_cofactor;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "InjectionOfCofactorWithGivenPushout", 3 ) );

end );

##
InstallGlobalFunction( UniversalMorphismFromPushout,

  function( arg )
    local diagram, pushout_or_diagram, sink;
    
    pushout_or_diagram := arg[ 1 ];
    
    sink := arg{[ 2 .. Length( arg ) ]};
    
    if WasCreatedAsPushout( pushout_or_diagram ) then
    
      diagram := Genesis( pushout_or_diagram )!.PushoutDiagram;
    
      return UniversalMorphismFromPushoutOp( diagram, CallFuncList( Product, sink ), diagram[1] );
    
    fi;
    
    return UniversalMorphismFromPushoutOp( pushout_or_diagram, CallFuncList( Product, sink ), pushout_or_diagram[1] );
    
end );

##
InstallMethod( AddUniversalMorphismFromPushout,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromPushoutFunction( category, func );
    
    SetCanComputeUniversalMorphismFromPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
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
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have the same source\n" );
           
        fi;
        
        test_object := Range( sink[1] );
        
        components := Components( sink );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be identical in given sink-diagram" );
            
        fi;
        
        ## here the user also needs the diagram
        universal_morphism := func( diagram, sink );
        
        Add( category, universal_morphism );
        
        pushout := Source( universal_morphism );
        
        AddToGenesis( pushout, "PushoutDiagram",diagram );
        
        SetPushoutOp( diagram, diagram[1], pushout );
        
        Add( HomalgCategory( diagram[1] ), pushout );
        
        SetFilterObj( pushout, WasCreatedAsPushout );
        
        return universal_morphism;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "UniversalMorphismFromPushoutOp", 3 ) );
    
end );

##
InstallMethod( AddUniversalMorphismFromPushoutWithGivenPushout,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetUniversalMorphismFromPushoutWithGivenPushoutFunction( category, func );
    
    SetCanComputeUniversalMorphismFromPushoutWithGivenPushout( category, true );
    
    InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutWithGivenPushout,
                                           [ IsHomalgCategoryMorphism, 
                                             IsHomalgCategoryMorphism, 
                                             IsHomalgCategoryObject and ObjectFilter( category ) 
                                           ],
                                           
      function( diagram, sink, pushout )
        local cobase, test_object, components, universal_morphism;
        
        cobase := Source( diagram[1] );
        
        if not ForAll( Components( diagram ), c -> IsIdenticalObj( Source( c ), cobase ) ) then
           
           Error( "the given morphisms of the pushout diagram must have the same source\n" );
           
        fi;
        
        test_object := Range( sink[1] );
        
        components := Components( sink );
        
        if false in List( components{[2 .. Length( components ) ]}, c -> IsIdenticalObj( Range( c ), test_object ) ) then
            
            Error( "ranges of morphisms must be identical in given sink-diagram" );
            
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
                                      CanComputeInjectionOfCofactor and 
                                      CanComputePreCompose and
                                      CanComputeAdditionForMorphisms and
                                      CanComputeAdditiveInverseForMorphisms and
                                      CanComputeCokernel );

##
InstallMethodWithToDoForIsWellDefined( PushoutOp,
                                       [ IsHomalgCategoryMorphism, 
                                         IsHomalgCategoryMorphism and
                                         CanComputeCoproduct and 
                                         CanComputeInjectionOfCofactor and 
                                         CanComputePreCompose and
                                         CanComputeAdditionForMorphisms and
                                         CanComputeAdditiveInverseForMorphisms and
                                         CanComputeCokernel ],
                                         -9999, #FIXME
                                         
  function( diagram, method_selection_morphism )
    local cobase, coproduct, number_of_morphisms, list_of_morphisms, mor1, mor2, pushout, diff;
    
    cobase := Source( diagram[1] );
        
    if not ForAll( Components( diagram ), c -> IsIdenticalObj( Source( c ), cobase ) ) then
           
       Error( "the given morphisms of the pushout diagram must have the same source\n" );
           
    fi;
    
    coproduct := CallFuncList( Coproduct, List( Components( diagram ), Range ) );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( diagram[ i ], InjectionOfCofactor( coproduct, i ) ) );
    
    mor1 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismFromCoproduct, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    diff := mor1 - mor2;
    
    pushout := Cokernel( diff );
    
    AddToGenesis( pushout, "PushoutAsCokernelDiagram", diff );
    
    AddToGenesis( pushout, "PushoutDiagram", diagram );
    
    SetFilterObj( pushout, WasCreatedAsPushout );
    
    return pushout;
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 2 );

#
InstallTrueMethod( CanComputeInjectionOfCofactorOfPushout, CanComputeInjectionOfCofactorWithGivenPushout and 
                                                           CanComputePushout );

InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorOp,
                                       [ IsHomalgCategoryMorphism,
                                         IsInt,
                                         IsHomalgCategoryMorphism and
                                         CanComputeInjectionOfCofactorWithGivenPushout and
                                         CanComputePushout ],
                                         
  function( diagram, injection_number, method_selection_morphism )
  
    return InjectionOfCofactorWithGivenPushout( diagram, injection_number, PushoutOp( diagram, method_selection_morphism ) );
  
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

# ##
InstallTrueMethod( CanComputeInjectionOfCofactorWithGivenPushout, CanComputeCokernelProj and
                                                                  CanComputeInjectionOfCofactor and
                                                                  CanComputePushout );

# FIXME: WARNING: This method only applies if the pushout was created as a cokernel. If the
# user gives his own pushout method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( InjectionOfCofactorWithGivenPushout,
                                       [ IsHomalgCategoryMorphism,
                                         IsInt,
                                         IsHomalgCategoryObject and 
                                         CanComputeCokernelProj and
                                         CanComputeInjectionOfCofactor and
                                         CanComputePushout ],
                                         
  function( diagram, injection_number, pushout )
    local projection_from_coproduct, coproduct, injection;
  
    if not WasCreatedAsCokernel( pushout ) or not IsBound( Genesis( pushout )!.PushoutAsCokernelDiagram ) then
    
      Error( "pushout had to be created as a cokernel" );
    
    fi;
    
    projection_from_coproduct := CokernelProj( Genesis( pushout )!.PushoutAsCokernelDiagram );
    
    coproduct := Source( projection_from_coproduct );
    
    if not WasCreatedAsCoproduct( coproduct ) then
    
      Error( "pushout had to be created as a cokernel of a morphism with a coproduct as range" );
    
    fi;
    
    injection := InjectionOfCofactor( coproduct, injection_number );
    
    return PreCompose( injection, projection_from_coproduct );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );

##
InstallTrueMethod( CanComputeUniversalMorphismFromPushoutWithGivenPushout, CanComputeUniversalMorphismFromCoproduct and
                                                                           CanComputeCokernelColift );

# FIXME: WARNING: This method only applies if the pushout was created as a cokernel. If the
# user gives his own pushout method, this derived method fails.
InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutWithGivenPushout,
                                       [ 
                                         IsHomalgCategoryMorphism, 
                                         IsHomalgCategoryMorphism, 
                                         IsHomalgCategoryObject
                                       ],
                                       
  function( diagram, sink, pushout )
    local test_function;
    
    if not WasCreatedAsCokernel( pushout ) then
      
      Error( "pushout had to be created as a cokernel" );
      
    fi;
    
    test_function := CallFuncList( UniversalMorphismFromCoproduct, Components( sink ) );
    
    return CokernelColift( pushout, test_function );
    
end : InstallMethod := InstallMethodWithCacheFromObject, ArgumentNumber := 3 );


##
InstallTrueMethod( CanComputeUniversalMorphismFromPushout, CanComputeUniversalMorphismFromPushoutWithGivenPushout and 
                                                           CanComputePushout );

InstallMethodWithToDoForIsWellDefined( UniversalMorphismFromPushoutOp,
                                           [ IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism,
                                             IsHomalgCategoryMorphism ],
                                             
  function( diagram, sink, method_selection_morphism )
    
    return UniversalMorphismFromPushoutWithGivenPushout( diagram, sink, PushoutOp( diagram, method_selection_morphism ) );
    
end );

####################################
##
## Image
##
####################################

##
InstallMethod( AddImage,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetImageFunction( category, func );
    
    SetCanComputeImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageObject,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetImageEmbeddingFunction( category, func );
    
    SetCanComputeImageEmbedding( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageEmbedding,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( mor )
        local image_embedding, image;
        
        if HasImageObject( mor ) then
        
          return ImageEmbeddingWithGivenImage( mor, ImageObject( mor ) );
        
        fi;
        
        image_embedding := func( mor );
        
        Add( HomalgCategory( mor ), image_embedding );
        
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetImageEmbeddingWithGivenImageFunction( category, func );
    
    SetCanComputeImageEmbeddingWithGivenImage( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ImageEmbeddingWithGivenImage,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( mor, image )
        local image_embedding;
        
        image_embedding := func( mor, image );
        
        Add( category, image_embedding );
        
        return image_embedding;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ImageEmbeddingWithGivenImage", 2 ) );
    
end );

####################################
##
## Attributes
##
####################################

InstallMethod( ImageEmbedding,
               [ IsHomalgCategoryObject and WasCreatedAsImage ],
               
  function( image )
    
    return ImageEmbedding( Genesis( image )!.ImageDiagram );
    
end );

####################################
## Implied Operations
####################################

##
InstallTrueMethod( CanComputeImage, CanComputeImageEmbedding );

InstallMethod( ImageObject,
               [ IsHomalgCategoryMorphism and CanComputeImageEmbedding ],
               -9999, #FIXME
                                    
  function( mor )
    local image;
    
    ## ImageEmbedding creates an ImageObject as source
    image := Source( ImageEmbedding( mor ) );
    
    return image;
    
end );

##
InstallTrueMethod( CanComputeImageEmbedding, CanComputeKernelEmb and CanComputeCokernelProj );

InstallMethod( ImageEmbedding,
               [ IsHomalgCategoryMorphism and CanComputeImageEmbedding ],
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

