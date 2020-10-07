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

DeclareRepresentation( "IsCapTerminalCategoryObjectRep",
                       IsAttributeStoringRep and IsCapCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsCapTerminalCategoryMorphismRep",
                       IsAttributeStoringRep and IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfCapTerminalCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapTerminalCategoryObjectRep ) );

BindGlobal( "TheTypeOfCapTerminalCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapTerminalCategoryMorphismRep ) );

#####################################
##
## Constructor
##
#####################################

InstallValue( CAP_INTERNAL_TERMINAL_CATEGORY,
              
              CreateCapCategory( "TerminalCategory" ) );

SetFilterObj( CAP_INTERNAL_TERMINAL_CATEGORY, IsTerminalCategory );

InstallValue( CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT,
              
              AsCatObject( CAP_INTERNAL_TERMINAL_CATEGORY ) );

##
InstallMethod( UniqueObject,
               [ IsCapCategory and IsTerminalCategory ],
               
  function( category )
    local object;
    
    object := ObjectifyWithAttributes( rec( ), TheTypeOfCapTerminalCategoryObject,
                                       IsZeroForObjects, true );
    
    Add( CAP_INTERNAL_TERMINAL_CATEGORY, object );
    
    SetIsWellDefined( object, true );
    
    return object;
    
end );

##
InstallMethod( UniqueMorphism,
               [ IsCapCategory and IsTerminalCategory ],
               
  function( category )
    local morphism, object;
    
    object := UniqueObject( CAP_INTERNAL_TERMINAL_CATEGORY );
    
    morphism := ObjectifyWithAttributes( rec( ), TheTypeOfCapTerminalCategoryMorphism,
                                         Source, object,
                                         Range, object,
                                         IsOne, true );
    
    Add( CAP_INTERNAL_TERMINAL_CATEGORY, morphism );
    
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
            
  function( )
    local obj_function_list, obj_func, morphism_function_list, morphism_function, i;
    
    obj_function_list := [ AddZeroObject,
                           AddKernelObject,
                           AddCokernelObject,
                           AddDirectProduct ];
    
    obj_func := function( arg ) return UniqueObject( CAP_INTERNAL_TERMINAL_CATEGORY ); end;
    
    for i in obj_function_list do
        
        i( CAP_INTERNAL_TERMINAL_CATEGORY, obj_func );
        
    od;
    
    morphism_function_list := [ AddIdentityMorphism,
                                AddPreCompose,
                                AddLiftAlongMonomorphism,
                                AddColiftAlongEpimorphism,
                                AddInverse,
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
    
    morphism_function := function( arg ) return UniqueMorphism( CAP_INTERNAL_TERMINAL_CATEGORY ); end;
    
    for i in morphism_function_list do
        
        i( CAP_INTERNAL_TERMINAL_CATEGORY, morphism_function );
        
    od;
    
end );

INSTALL_TERMINAL_CATEGORY_FUNCTIONS( );

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
InstallMethod( FunctorFromTerminalCategory,
               [ IsCapCategoryMorphism and IsOne ],
               
  morphism -> FunctorFromTerminalCategory( Source( morphism ) )
  
);

Finalize( CAP_INTERNAL_TERMINAL_CATEGORY );
