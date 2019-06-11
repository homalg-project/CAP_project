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
InstallMethod( SfpgrmodLeft,
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
      
      category := FREYD_CATEGORY( underlying_category );
      
      graded_ring := underlying_category!.homalg_graded_ring_for_category_of_graded_rows;
      
      category!.Name := Concatenation( "Category of graded left module presentations over ", RingName( graded_ring ) );
      
      SetFilterObj( category, IsSfpgrmodLeft );
      
      return category;
      
end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodRight,
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
      
      category := FREYD_CATEGORY( underlying_category );
      
      graded_ring := underlying_category!.homalg_graded_ring_for_category_of_graded_columns;
      
      category!.Name := Concatenation( "Category of graded right module presentations over ", RingName( graded_ring ) );
      
      SetFilterObj( category, IsSfpgrmodRight );
      
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
    
    SetFilterObj( object, IsGradedLeftModulePresentationForCAP );
    
    return object;    
    
end );

##
InstallMethod( FreydCategoryObject,
               [ IsGradedColumnMorphism ],
  function( relation_morphism )
    local category, object, type;
    
    object := FREYD_CATEGORY_OBJECT( relation_morphism );
    
    SetFilterObj( object, IsGradedRightModulePresentationForCAP );
    
    return object;    
    
end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsGradedLeftModulePresentationForCAP,
                 IsGradedRowMorphism,
                 IsGradedLeftModulePresentationForCAP ],
  function( source, morphism_datum, range )
    local underlying_category, morphism, category, type;
    
    morphism := FREYD_CATEGORY_MORPHISM( source, morphism_datum, range );
    
    SetFilterObj( morphism, IsGradedLeftModulePresentationMorphismForCAP );
    
    return morphism;

end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsGradedRightModulePresentationForCAP,
                 IsGradedColumnMorphism,
                 IsGradedRightModulePresentationForCAP ],
  function( source, morphism_datum, range )
    local underlying_category, morphism, category, type;
    
    morphism := FREYD_CATEGORY_MORPHISM( source, morphism_datum, range );
    
    SetFilterObj( morphism, IsGradedRightModulePresentationMorphismForCAP );
    
    return morphism;

end );
