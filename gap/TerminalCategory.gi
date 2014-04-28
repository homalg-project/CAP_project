#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

#####################################
##
## Reps for object and morphism
##
#####################################

DeclareRepresentation( "IsHomalgTerminalCategoryObjectRep",
                       IsAttributeStoringRep and IsHomalgCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsHomalgTerminalCategoryMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgTerminalCategoryObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgTerminalCategoryObjectRep ) );

BindGlobal( "TheTypeOfHomalgTerminalCategoryMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgTerminalCategoryMorphismRep ) );

#####################################
##
## Constructor
##
#####################################

InstallValue( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY,
              
              CreateHomalgCategory( "TerminalCategory" ) );

SetFilterObj( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY, IsTerminalCategory );

InstallValue( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT,
              
              AsCatObject( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ) );

##
InstallMethod( Object,
               [ IsHomalgCategory and IsTerminalCategory ],
               
  function( category )
    local object;
    
    object := rec( );
    
    ObjectifyWithAttributes( object, TheTypeOfHomalgTerminalCategoryObject,
                             IsZero, true );
    
    Add( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY, object );
    
    SetIsZero( object, true );
    
    return object;
    
end );

##
InstallMethod( Morphism,
               [ IsHomalgCategory and IsTerminalCategory ],
               
  function( category )
    local morphism, object;
    
    morphism := rec( );
    
    object := Object( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgTerminalCategoryMorphism,
                             Source, object,
                             Range, object,
                             IsOne, true );
    
    Add( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY, morphism );
    
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
                           AddDirectSum_OnObjects,
                           AddKernel,
                           AddCokernel,
                           AddDirectProduct ];
    
    obj_func := function( arg ) return Object( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end;
    
    for i in obj_function_list do
        
        i( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY, obj_func );
        
    od;
    
    morphism_function_list := [ AddIdentityMorphism,
                                AddPreCompose,
                                AddMorphismIntoZeroObject,
                                AddMorphismFromZeroObject,
                                AddInjectionFromFirstSummand,
                                AddInjectionFromSecondSummand,
                                AddProjectionInFirstFactor,
                                AddProjectionInSecondFactor,
                                AddMonoAsKernelLift,
                                AddEpiAsCokernelColift,
                                AddInverse,
                                AddKernelEmb,
                                AddKernelEmbWithGivenKernel,
                                AddKernelLiftWithGivenKernel,
                                AddCokernelProj,
                                AddCokernelProjWithGivenCokernel,
                                AddCokernelColift,
                                AddCokernelColiftWithGivenCokernel,
                                AddProjectionInFirstFactorOfDirectProduct,
                                AddProjectionInSecondFactorOfDirectProduct,
                                AddProjectionInFirstFactorOfDirectProductWithGivenDirectProduct,
                                AddProjectionInSecondFactorOfDirectProductWithGivenDirectProduct,
                                AddUniversalMorphismIntoDirectProduct,
                                AddUniversalMorphismIntoDirectProductWithGivenDirectProduct ];
    
    morphism_function := function( arg ) return Morphism( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end;
    
    for i in morphism_function_list do
        
        i( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY, morphism_function );
        
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
               [ IsHomalgCategoryObject and CanComputeIdentityMorphism ],
               
  function( object )
    local functor;
    
    functor := HomalgFunctor( Concatenation( "InjectionInto", Name( HomalgCategory( object ) ) ), CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY, HomalgCategory( object ) );
    
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
               [ IsHomalgCategoryMorphism and IsOne ],
               
  morphism -> FunctorFromTerminalCategory( Source( morphism ) )
  
);
