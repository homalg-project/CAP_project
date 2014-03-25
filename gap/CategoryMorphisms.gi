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

DeclareRepresentation( "IsHomalgCategoryMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphism,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategoryMorphisms",
        NewFamily( "TheFamilyOfHomalgCategoryMorphisms" ) );

BindGlobal( "TheTypeOfHomalgCategoryMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryMorphismRep ) );

######################################
##
## Immediate Methods
##
######################################

InstallTrueMethod( IsSplitMonomorphism and IsSplitEpimorphism, IsHomalgCategoryMorphism and IsIsomorphism );

InstallTrueMethod( IsAutomorphism, IsHomalgCategoryMorphism and IsOne );

InstallTrueMethod( IsIsomorphism and IsEndomorphism, IsHomalgCategoryMorphism and IsAutomorphism );

InstallTrueMethod( IsMonomorphism, IsHomalgCategoryMorphism and IsSplitMonomorphism );

InstallTrueMethod( IsEpimorphism, IsHomalgCategoryMorphism and IsSplitEpimorphism );

#######################################
##
## Technical implications
##
#######################################

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM,

  function( category, morphism )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "HomalgCategory" ] ],
                                                         [ category, morphism ],
                                                         [ "CanComputeMonoAsKernelLift",
                                                           "CanComputeEpiAsCokernelColift",
                                                           "CanComputeIdentityMorphism",
                                                           "CanComputeInverse",
                                                           "CanComputeKernel",
                                                           "CanComputeKernelEmb",
                                                           "CanComputeKernelLift",
                                                           "CanComputeCokernel",
                                                           "CanComputeCokernelProj",
                                                           "CanComputeCokernelColift",
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

######################################
##
## Operations
##
######################################

InstallMethod( Add,
               [ IsHomalgCategory, IsHomalgCategoryMorphism ],
               
  function( category, morphism )
    local obj_filter, filter;
    
    if HasHomalgCategory( morphism ) then
        
        if IsIdenticalObj( HomalgCategory( morphism ), category ) then
            
            return;
            
        else
            
            Error( "this morphism already has a category" );
            
        fi;
        
    fi;
    
    Add( category, Source( morphism ) );
    
    Add( category, Range( morphism ) );
    
    filter := MorphismFilter( category );
    
    SetFilterObj( morphism, filter );
    
    ## Homalg category is set by immediate method

    INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT( category, morphism );
    
end );

######################################
##
## Implied operations
##
######################################

InstallTrueMethod( CanComputePostCompose, CanComputePreCompose );

InstallMethod( PostCompose,
               [ IsHomalgCategoryMorphism and CanComputePreCompose,
                 IsHomalgCategoryMorphism and CanComputePreCompose ],
               
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end );

InstallTrueMethod( CanComputeInverse, CanComputeMonoAsKernelLift and CanComputeIdentityMorphism );

##
InstallMethod( Inverse,
               [ IsHomalgCategoryMorphism and CanComputeMonoAsKernelLift and CanComputeIdentityMorphism ],
               -1,
               
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );
        
end );

InstallTrueMethod( CanComputeInverse, CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism );

##
InstallMethod( Inverse,
               [ IsHomalgCategoryMorphism and CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism ],
               -1,
               
  function( mor )
    local identity_of_source;
    
    identity_of_source := IdentityMorphism( Source( mor ) );
    
    return EpiAsCokernelColift( mor, identity_of_source );
      
end );                        

InstallTrueMethod( CanComputeKernelLift, CanComputeKernelEmb and CanComputeMonoAsKernelLift );

##
InstallMethod( KernelLift,
               [ IsHomalgCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift,
                 IsHomalgCategoryMorphism and CanComputeKernelEmb and CanComputeMonoAsKernelLift ],
                 -1,
                 
  function( mor, test_morphism )
    
    return MonoAsKernelLift( KernelEmb( mor ), test_morphism );
    
end );

InstallTrueMethod( CanComputeKernel, CanComputeKernelEmb );

##
InstallMethod( Kernel,
               [ IsHomalgCategoryMorphism and CanComputeKernelEmb ],
               -1,
               
  function( mor )
    
    return Source( KernelEmb( mor ) );
    
end );

InstallTrueMethod( CanComputeCokernelColift, CanComputeCokernelProj and CanComputeEpiAsCokernelColift );

##
InstallMethod( CokernelColift,
               [ IsHomalgCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift,
                 IsHomalgCategoryMorphism and CanComputeCokernelProj and CanComputeEpiAsCokernelColift ],
                 -1,
                 
  function( mor, test_morphism )
    
    return EpiAsCokernelColift( CokernelProj( mor ), test_morphism );
    
end );

InstallTrueMethod( CanComputeCokernel, CanComputeCokernelProj );

##
InstallMethod( Cokernel,
               [ IsHomalgCategoryMorphism and CanComputeCokernelProj ],
               -1,
               
  function( mor )
    
    return Range( CokernelProj( mor ) );
    
end );

