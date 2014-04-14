#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

######################################
##
## Reps, types, stuff.
##
######################################

DeclareRepresentation( "IsHomalgCategoryObjectRep",
                       IsAttributeStoringRep and IsHomalgCategoryObject,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategoryObjects",
        NewFamily( "TheFamilyOfHomalgCategoryObjects" ) );

BindGlobal( "TheTypeOfHomalgCategoryObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryObjectRep ) );

######################################
##
## Immediate Methods
##
######################################

InstallTrueMethod( IsInjective and IsProjective, IsHomalgCategoryObject and IsZero );

#######################################
##
## Technical implications
##
#######################################

InstallTrueMethod( WasCreatedAsDirectSum, HasFirstSummand and HasSecondSummand );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT,
                       
  function( category, object )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "HomalgCategory" ] ],
                                                         [ category, object ],
                                                         [ "CanComputeMonoAsKernelLift",
                                                           "CanComputeEpiAsCokernelColift",
                                                           "CanComputeIdentityMorphism",
                                                           "CanComputeInverse",
                                                           "CanComputeKernel",
                                                           "CanComputeKernelEmb",
                                                           "CanComputeKernelEmbWithGivenKernel",
                                                           "CanComputeKernelLift",
                                                           "CanComputeKernelLiftWithGivenKernel",
                                                           "CanComputeCokernel",
                                                           "CanComputeCokernelProj",
                                                           "CanComputeCokernelProjWithGivenCokernel",
                                                           "CanComputeCokernelColift",
                                                           "CanComputeCokernelColiftWithGivenCokernel",
                                                           "CanComputePreCompose",
                                                           "CanComputePostCompose",
                                                           "CanComputeZeroObject",
                                                           "CanComputeMorphismFromZeroObject",
                                                           "CanComputeMorphismIntoZeroObject",
                                                           "CanComputeZeroMorphism",
                                                           "CanComputeDirectSum",
                                                           "CanComputeProjectionInFirstFactor",
                                                           "CanComputeProjectionInSecondFactor",
                                                           "CanComputeInjectionFromFirstSummand",
                                                           "CanComputeInjectionFromSecondSummand"
                                                         # ...
                                                         ] );
 
    AddToToDoList( entry );
    
end );

#######################################
##
## Attributes of universal objects
##
#######################################

##
InstallMethod( KernelEmb,
               [ IsHomalgCategoryObject and WasCreatedAsKernel ],
               
  function( kernel )
  
    return KernelEmb( Genesis( kernel )!.diagram );
    
end );

##
InstallMethod( CokernelProj,
               [ IsHomalgCategoryObject and WasCreatedAsCokernel ],

  function( cokernel )

    return CokernelProj( Genesis( cokernel )!.diagram );

end );

##
InstallMethod( ProjectionInFirstFactor,
               [ IsHomalgCategoryObject and WasCreatedAsDirectProduct ],

  function( direct_product )
    local object_A, object_B;

    object_A := Genesis( direct_product )!.FirstFactor;

    object_B := Genesis( direct_product )!.SecondFactor;
  
    return ProjectionInFirstFactor( object_A, object_B );
  
end );

##
InstallMethod( ProjectionInSecondFactor,
               [ IsHomalgCategoryObject and WasCreatedAsDirectProduct ],

  function( direct_product )
    local object_A, object_B;

    object_A := Genesis( direct_product )!.FirstFactor;

    object_B := Genesis( direct_product )!.SecondFactor;

    return ProjectionInSecondFactor( object_A, object_B );

end );

#######################################
##
## Operations
##
#######################################

InstallMethod( Add,
               [ IsHomalgCategory, IsHomalgCategoryObject ],
               
  function( category, object )
    local filter;
    
    if HasHomalgCategory( object ) then
        
        if IsIdenticalObj( HomalgCategory( object ), category ) then
            
            return;
            
        else
            
            Error( "this object already has a category" );
            
        fi;
        
    fi;
    
    filter := ObjectFilter( category );
    
    SetFilterObj( object, filter );
    
    ## Homalg category is set by immediate method
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT( category, object );
    
end );

InstallTrueMethod( CanComputeZeroMorphism, CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject );

##TODO
InstallMethodWithCacheFromObject( ZeroMorphism,
                                  [ IsHomalgCategoryObject and CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject,
                                    IsHomalgCategoryObject and CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject ],
                                  
  function( obj_source, obj_range )
    
    return PreCompose( MorphismIntoZeroObject( obj_source ), MorphismFromZeroObject( obj_range ) );
    
end );

#######################################
##
## Implied operations
##
#######################################

## Direct Product
##
InstallTrueMethod( CanComputeProjectionInFirstFactor, CanComputeDirectProduct and CanComputeProjectionInFirstFactorWithGivenDirectProduct );

InstallMethod( ProjectionInFirstFactor,
               [ IsHomalgCategoryObject and CanComputeDirectProduct and CanComputeProjectionInFirstFactorWithGivenDirectProduct,
               IsHomalgCategoryObject and CanComputeDirectProduct and CanComputeProjectionInFirstFactorWithGivenDirectProduct ],

  function( object_A, object_B )

    return ProjectionInFirstFactorWithGivenDirectProduct( object_A, object_B, DirectProductObject( object_A, object_B ) );

end );


##
InstallTrueMethod( CanComputeProjectionInSecondFactor, CanComputeDirectProduct and CanComputeProjectionInSecondFactorWithGivenDirectProduct );

InstallMethod( ProjectionInSecondFactor,
               [ IsHomalgCategoryObject and CanComputeDirectProduct and CanComputeProjectionInSecondFactorWithGivenDirectProduct,
               IsHomalgCategoryObject and CanComputeDirectProduct and CanComputeProjectionInSecondFactorWithGivenDirectProduct ],

  function( object_A, object_B )

    return ProjectionInSecondFactorWithGivenDirectProduct( object_A, object_B, DirectProductObject( object_A, object_B ) );

end );