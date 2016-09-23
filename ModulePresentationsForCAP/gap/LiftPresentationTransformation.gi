#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#############################################################################

BindGlobal( "CAP_INTERNAL_LiftNaturalTransformationToGradedModuleFunctor",
  
  function( natural_transformation, left )
    local source_functor, range_functor, underlying_category, ring, new_category, object_function,
          morphism_function, new_functor, category_constructor, object_constructor, non_trivial_degree;
    
    if left then
        category_constructor := GradedLeftPresentations;
        object_constructor := AsGradedLeftPresentation;
        non_trivial_degree := NonTrivialDegreePerColumn;
    else
        category_constructor := GradedRightPresentations;
        object_constructor := AsGradedRightPresentation;
        non_trivial_degree := NonTrivialDegreePerRow;
    fi;
    
    source_functor := Source( natural_transformation );
    
    if not IsIdenticalToIdentityMorphism( source_functor ) then
        Error( "source is not identity functor" );
    fi;
    
    range_functor := Range( natural_transformation );
    
    underlying_category := AsCapCategory( Source( source_functor ) );
    
    ring := underlying_category!.ring_for_representation_category;
    
    new_category := category_constructor( ring );
    
    object_function := function( object )
      local underlying_presentation, new_object, new_degrees, connecting_morphism;
        
        underlying_presentation := UnderlyingPresentationObject( object );
        
        new_object := ApplyFunctor( range_functor, underlying_presentation );
        
        connecting_morphism := ApplyNaturalTransformation( natural_transformation, underlying_presentation );
        
        new_degrees := non_trivial_degree( UnderlyingMatrix( connecting_morphism ), GeneratorDegrees( object ) );
        
        return object_constructor( new_object, new_degrees );
        
    end;
    
    morphism_function := function( new_source, morphism, new_range )
      local new_underlying_morphism;
        
        new_underlying_morphism := ApplyFunctor( range_functor, UnderlyingPresentationMorphism( morphism ) );
        
        return GradedPresentationMorphism( new_source, new_underlying_morphism, new_range );
        
    end;
    
    new_functor := CapFunctor( Concatenation( "Graded ", Name( range_functor ) ), new_category, new_category );
    
    AddObjectFunction( new_functor, object_function );
    AddMorphismFunction( new_functor, morphism_function );
    
    return new_functor;
    
end );

InstallMethod( LiftNaturalTransformationToGradedModuleFunctorLeft,
               [ IsCapNaturalTransformation ],
               
  i -> CAP_INTERNAL_LiftNaturalTransformationToGradedModuleFunctor( i, true ) );

InstallMethod( LiftNaturalTransformationToGradedModuleFunctorRight,
               [ IsCapNaturalTransformation ],
               
  i -> CAP_INTERNAL_LiftNaturalTransformationToGradedModuleFunctor( i, false ) );
