#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Opposite category
##
#############################################################################

###################################
##
#! @Section Filter
##
###################################

DeclareRepresentation( "IsHomalgCategoryOppositeObjectRep",
                       IsAttributeStoringRep and IsHomalgCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsHomalgCategoryOppositeMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCategoryOppositeObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryOppositeObjectRep ) );

BindGlobal( "TheTypeOfHomalgCategoryOppositeMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryOppositeMorphismRep ) );


###################################
##
#! @Section Functor is an involution
##
###################################

##
InstallImmediateMethod( Opposite,
                        IsHomalgCategory and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##
InstallImmediateMethod( Opposite,
                        IsHomalgCategoryObject and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##
InstallImmediateMethod( Opposite,
                        IsHomalgCategoryMorphism and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##################################
##
## Construtor
##
##################################

##
InstallMethod( Opposite,
               [ IsHomalgCategoryObject ],
               
  function( object )
    local opposite_object;
    
    opposite_object := rec( );
    
    ObjectifyWithAttributes( opposite_object, TheTypeOfHomalgCategoryOppositeObjects,
                             Opposite, object );
    
    Add( Opposite( HomalgCategory( object ) ), opposite_object );
    
    return opposite_object;
    
end );

##
InstallMethod( Opposite,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local opposite_morphism;
    
    opposite_morphism := rec( );
    
    ObjectifyWithAttributes( opposite_morphism, TheTypeOfHomalgCategoryOppositeMorphisms,
                             Opposite, morphism );
    
    Add( Opposite( HomalgCategory( morphism ) ), opposite_morphism );
    
    return opposite_morphism;
    
end );

##
InstallMethod( Opposite,
               [ IsHomalgCategory, IsString ],
               
  function( category, name )
    local opposite_category;
    
    opposite_category := CreateHomalgCategory( name );
    
    SetWasCreatedAsOppositeCategory( opposite_category, true );
    
    SetOpposite( opposite_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY( category );
    
    return opposite_category;
    
end );

##
InstallMethod( Opposite,
               [ IsHomalgCategory ],
               
  function( category )
    local opposite_category;
    
    opposite_category := Concatenation( "Opposite of ", Name( category ) );
    
    return Opposite( category, opposite_category );
    
end );

##################################
##
## Methods
##
##################################

##
InstallImmediateMethod( Source,
                        IsHomalgCategoryOppositeMorphismRep,
                        0,
                        
  function( morphism )
    
    return Opposite( Range( Opposite( morphism ) ) );
    
end );

##
InstallImmediateMethod( Range,
                        IsHomalgCategoryOppositeMorphismRep,
                        0,
                        
  function( morphism )
    
    return Opposite( Source( Opposite( morphism ) ) );
    
end );

##
InstallMethod( PreCompose,
               [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
               
  function( left, right )
    
    return Opposite( PreCompose( Opposite( right ), Opposite( left ) ) );
    
end );

##
InstallMethod( PostCompose,
               [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
               
  function( left, right )
    
    return Opposite( PreCompose( Opposite( left ), Opposite( right ) ) );
    
end );

##
InstallMethod( IdentityMorphism,
               [ IsHomalgCategoryOppositeObjectRep ],
               
  function( obj )
    
    return Opposite( IdentityMorphism( Opposite( obj ) ) );
    
end );

##
InstallMethod( ZeroObject,
               [ IsHomalgCategory and WasCreatedAsOppositeCategory ],
               
  function( category )
    
    return Opposite( ZeroObject( Opposite( category ) ) );
    
end );

## TODO: Massig todo-list entries die attribute von Category/Object/Morphism auf Opposite übertragen.

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY,
                       
  function( category )
    local entry_list, entry;
    
    entry_list := [ [ "CanComputeMonoAsKernelLift", "CanComputeEpiAsCokernelColift" ],
                  [ "CanComputeEpiAsCokernelColift", "CanComputeMonoAsKernelLift" ],
                    "CanComputeIdentityMorphism",
                    "CanComputeInverse",
                  [ "CanComputeKernel", "CanComputeCokernel" ],
                  [ "CanComputeKernelEmb", "CanComputeCokernelProj" ],
                  [ "CanComputeKernelLift", "CanComputeCokernelColift" ],
                  [ "CanComputeCokernel", "CanComputeKernel" ],
                  [ "CanComputeCokernelProj", "CanComputeKernelEmb" ],
                  [ "CanComputeCokernelColift", "CanComputeKernelLift" ],
                  [ "CanComputePreCompose", "CanComputePostCompose" ],
                  [ "CanComputePostCompose", "CanComputePreCompose" ],
                    "CanComputeZeroObject",
                  [ "CanComputeMorphismFromZeroObject", "CanComputeMorphismIntoZeroObject" ],
                  [ "CanComputeMorphismIntoZeroObject", "CanComputeMorphismFromZeroObject" ],
                    "CanComputeZeroMorphism",
                    "CanComputeDirectSum",
                  [ "CanComputeProjectionInFirstFactor", "CanComputeInjectionFromFirstSummand" ],
                  [ "CanComputeProjectionInSecondFactor", "CanComputeInjectionFromSecondSummand" ],
                  [ "CanComputeInjectionFromFirstSummand", "CanComputeProjectionInFirstFactor" ],
                  [ "CanComputeInjectionFromSecondSummand", "CanComputeProjectionInSecondFactor" ]
                  # ...
                  ];
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ category, [ Opposite, category ] ],
                                                         entry_list );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ [ Opposite, category ], category ],
                                                         entry_list );
 
    AddToToDoList( entry );
    
end );
