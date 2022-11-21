# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

#####################################
##
## Reps for object and morphism
##
#####################################

# backwards compatibility
BindGlobal( "IsCapTerminalCategoryObjectRep", IsCapTerminalCategoryObject );

# backwards compatibility
BindGlobal( "IsCapTerminalCategoryMorphismRep", IsCapTerminalCategoryMorphism );

#####################################
##
## Constructor
##
#####################################

##
BindGlobal( "CAP_INTERNAL_CREATE_TerminalCategory",
  function(  )
    local cat;
    
    cat := CreateCapCategory( "TerminalCategory", IsCapTerminalCategory, IsCapTerminalCategoryObject, IsCapTerminalCategoryMorphism, IsCapCategoryTwoCell );
    
    SetIsTerminalCategory( cat, true );
    
    INSTALL_TERMINAL_CATEGORY_FUNCTIONS( cat );
    
    Finalize( cat );
    
    return cat;
    
end );

##
InstallMethod( UniqueObject,
               [ IsCapTerminalCategory ],
               
  function( category )
    local object;
    
    object := CreateCapCategoryObjectWithAttributes( category, IsZeroForObjects, true );
    
    SetIsWellDefined( object, true );
    
    return object;
    
end );

##
InstallMethod( UniqueMorphism,
               [ IsCapTerminalCategory ],
               
  function( category )
    local object, morphism;
    
    object := UniqueObject( category );
    
    morphism := CreateCapCategoryMorphismWithAttributes( category, object, object, IsOne, true );
    
    SetIsWellDefined( morphism, true );
    
    return morphism;
    
end );

################################
##
## Category functions
##
################################

##
BindGlobal( "INSTALL_TERMINAL_CATEGORY_FUNCTIONS",
            
  function( cat )
    local obj_function_list, obj_func, morphism_function_list, morphism_function, i;
    
    obj_function_list := [ AddZeroObject,
                           AddKernelObject,
                           AddCokernelObject,
                           AddDirectProduct ];
    
    obj_func := function( arg ) return UniqueObject( cat ); end;
    
    for i in obj_function_list do
        
        i( cat, obj_func );
        
    od;
    
    morphism_function_list := [ AddIdentityMorphism,
                                AddPreCompose,
                                AddLiftAlongMonomorphism,
                                AddColiftAlongEpimorphism,
                                AddInverseForMorphisms,
                                AddKernelEmbedding,
                                AddKernelEmbeddingWithGivenKernelObject,
                                AddKernelLiftWithGivenKernelObject,
                                AddCokernelProjection,
                                AddCokernelProjectionWithGivenCokernelObject,
                                AddCokernelColift,
                                AddCokernelColiftWithGivenCokernelObject,
                                AddProjectionInFactorOfDirectProduct,
                                AddProjectionInFactorOfDirectProductWithGivenDirectProduct,
                                AddUniversalMorphismIntoDirectProduct,
                                AddUniversalMorphismIntoDirectProductWithGivenDirectProduct ];
    
    morphism_function := function( arg ) return UniqueMorphism( cat ); end;
    
    for i in morphism_function_list do
        
        i( cat, morphism_function );
        
    od;
    
end );

################################
##
## Functor constructors
##
################################

##
InstallMethod( FunctorFromTerminalCategory,
               [ IsCapCategoryObject ],
               
  function( object )
    local functor;
    
    functor := CapFunctor( Concatenation( "InjectionInto", Name( CapCategory( object ) ) ), CAP_INTERNAL_TERMINAL_CATEGORY, CapCategory( object ) );
    
    functor!.terminal_object_functor_object := object;
    
    AddObjectFunction( functor,
                       
      function( arg )
        
        return functor!.terminal_object_functor_object;
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( arg )
        
        return IdentityMorphism( functor!.terminal_object_functor_object );
        
    end );
    
    return functor;
    
end );

##
#= comment for Julia
InstallMethod( FunctorFromTerminalCategory,
               [ IsCapCategoryMorphism and IsOne ],
               
  morphism -> FunctorFromTerminalCategory( Source( morphism ) )
  
);
# =#
