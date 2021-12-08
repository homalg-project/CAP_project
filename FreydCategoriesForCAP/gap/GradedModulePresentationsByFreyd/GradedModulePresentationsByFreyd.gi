##############################################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
## The CAP category of graded module presentations for CAP by use of Freyd categories
##
##############################################################################################


######################################
##
## Section CAP categories
##
######################################

# compute the category S-fpgrmod for a toric variety
InstallMethod( FpGradedLeftModules,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    
    return FreydCategory( CategoryOfGradedRows( graded_ring ) );
    
end );

##
InstallMethod( FreydCategory,
               [ IsCategoryOfGradedRows ],
    function( underlying_category )
      local category, graded_ring;
      
      graded_ring := UnderlyingGradedRing( underlying_category );
      
      category := FREYD_CATEGORY( underlying_category, Concatenation( "Category of f.p. graded left modules over ", RingName( graded_ring ) ) );
      
      SetFilterObj( category, IsFpGradedLeftModules );
      
      AddObjectRepresentation( category, IsFreydCategoryObject and HasRelationMorphism and IsFpGradedLeftModulesObject );
      
      AddMorphismRepresentation( category, IsFreydCategoryMorphism and HasUnderlyingMorphism and IsFpGradedLeftModulesMorphism );
      
      return category;
      
end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( FpGradedRightModules,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    
    return FreydCategory( CategoryOfGradedColumns( graded_ring ) );
    
end );

##
InstallMethod( FreydCategory,
               [ IsCategoryOfGradedColumns ],
    function( underlying_category )
      local category, graded_ring;
      
      graded_ring := UnderlyingGradedRing( underlying_category );
      
      category := FREYD_CATEGORY( underlying_category, Concatenation( "Category of f.p. graded right modules over ", RingName( graded_ring ) ) );
      
      SetFilterObj( category, IsFpGradedRightModules );
      
      AddObjectRepresentation( category, IsFreydCategoryObject and HasRelationMorphism and IsFpGradedRightModulesObject );
      
      AddMorphismRepresentation( category, IsFreydCategoryMorphism and HasUnderlyingMorphism and IsFpGradedRightModulesMorphism );
      
      return category;
      
end );
