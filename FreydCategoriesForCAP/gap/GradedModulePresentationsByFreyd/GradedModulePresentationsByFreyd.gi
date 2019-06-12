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
      
      category := FREYD_CATEGORY( underlying_category: FinalizeCategory := false );
      
      ## you may replace generic methods of the category here
      
      Finalize( category );
      
      graded_ring := UnderlyingGradedRing( underlying_category );
      
      category!.Name := Concatenation( "Category of f.p. graded left modules over ", RingName( graded_ring ) );
      
      SetFilterObj( category, IsFpGradedLeftModules );
      
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
      
      category := FREYD_CATEGORY( underlying_category: FinalizeCategory := false );
      
      ## you may replace generic methods of the category here
      
      Finalize( category );
      
      graded_ring := UnderlyingGradedRing( underlying_category );
      
      category!.Name := Concatenation( "Category of f.p. graded right modules over ", RingName( graded_ring ) );
      
      SetFilterObj( category, IsFpGradedRightModules );
      
      return category;
      
end );

######################################
##
## Section Specialised constructors
##
######################################

##
InstallMethod( FreydCategoryObject,
               [ IsGradedRowMorphism ],
  function( relation_morphism )
    local category, object, type;
    
    object := FREYD_CATEGORY_OBJECT( relation_morphism );
    
    SetFilterObj( object, IsFpGradedLeftModulesObject );
    
    return object;    
    
end );

##
InstallMethod( FreydCategoryObject,
               [ IsGradedColumnMorphism ],
  function( relation_morphism )
    local category, object, type;
    
    object := FREYD_CATEGORY_OBJECT( relation_morphism );
    
    SetFilterObj( object, IsFpGradedRightModulesObject );
    
    return object;    
    
end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsFpGradedLeftModulesObject,
                 IsGradedRowMorphism,
                 IsFpGradedLeftModulesObject ],
  function( source, morphism_datum, range )
    local underlying_category, morphism, category, type;
    
    morphism := FREYD_CATEGORY_MORPHISM( source, morphism_datum, range );
    
    SetFilterObj( morphism, IsFpGradedLeftModulesMorphism );
    
    return morphism;

end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsFpGradedRightModulesObject,
                 IsGradedColumnMorphism,
                 IsFpGradedRightModulesObject ],
  function( source, morphism_datum, range )
    local underlying_category, morphism, category, type;
    
    morphism := FREYD_CATEGORY_MORPHISM( source, morphism_datum, range );
    
    SetFilterObj( morphism, IsFpGradedRightModulesMorphism );
    
    return morphism;

end );
