#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Additional properties of Proj-categories
##
#############################################################################

############################################
##
##  Section New properties of Cap_categories
##
############################################

## FIXME: Move this to the point where it is used.
## Use if HasIsFinalized and IsFinalized before testing anything else

InstallMethod( IsProjCategory,
               " for CAP categories",
               [ IsCapCategory ],
               
  function( category )
    local installed_ops;
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        
    fi;
    
    installed_ops := ListInstalledOperationsOfCategory( category );
    
    if not IsAdditiveCategory( category ) then
        
        return false;
        
    elif not IsRigidSymmetricClosedMonoidalCategory( category ) then
        
        return false;
        
    elif not "Lift" in installed_ops then
        
        return false;
        
    elif not "KernelEmbedding" in installed_ops then
      
      return false;
      
    fi;
    
    return true;
    
end );