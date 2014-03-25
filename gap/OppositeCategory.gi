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
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM( morphism );
    
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
               -1,
               
  function( left, right )
    
    return Opposite( PreCompose( Opposite( right ), Opposite( left ) ) );
    
end );

##
InstallMethod( PostCompose,
               [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( left, right )
    
    return Opposite( PreCompose( Opposite( left ), Opposite( right ) ) );
    
end );

##
InstallMethod( IdentityMorphism,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( obj )
    
    return Opposite( IdentityMorphism( Opposite( obj ) ) );
    
end );

##
InstallMethod( ZeroObject,
               [ IsHomalgCategory and WasCreatedAsOppositeCategory ],
               -1,
               
  function( category )
    
    return Opposite( ZeroObject( Opposite( category ) ) );
    
end );

##
InstallMethod( MonoAsKernelLift,
              [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
              -1,
              
  function( monomorphism, test_morphism )
    
    return Opposite( EpiAsCokernelColift( Opposite( monomorphism ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( EpiAsCokernelColift,
              [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
              -1,
              
  function( epimorphism, test_morphism )
    
    return Opposite( MonoAsKernelLift( Opposite( epimorphism ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( Inverse,
               [ IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( Inverse( Opposite( mor ) ) );
    
end );

##
InstallMethod( Kernel,
               [ IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( Cokernel( Opposite( mor ) ) );
    
end );

##
InstallMethod( KernelEmb,
               [ IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( CokernelProj( Opposite( mor ) ) );
    
end );

##
InstallMethod( KernelLift,
               [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor, test_morphism )
    
    return Opposite( CokernelColift( Opposite( mor ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( Cokernel,
               [ IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( Kernel( Opposite( mor ) ) );
    
end );

##
InstallMethod( CokernelProj,
               [ IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( KernelEmb( Opposite( mor ) ) );
    
end );

##
InstallMethod( CokernelColift,
               [ IsHomalgCategoryOppositeMorphismRep, IsHomalgCategoryOppositeMorphismRep ],
               -1,
               
  function( mor, test_morphism )
    
    return Opposite( KernelLift( Opposite( mor ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( MorphismFromZeroObject,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( obj )
    
    return Opposite( MorphismIntoZeroObject( Opposite( obj ) ) );
    
end );

##
InstallMethod( MorphismIntoZeroObject,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( obj )
    
    return Opposite( MorphismFromZeroObject( Opposite( obj ) ) );
    
end );

##
InstallMethod( ZeroMorphism,
               [ IsHomalgCategoryOppositeObjectRep, IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( obj_source, obj_range )
    
    return Opposite( ZeroMorphism( Opposite( obj_range ), Opposite( obj_source ) ) );
    
end );

##
InstallMethod( DirectSumOp,
               [ IsList, IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( obj_list, obj1 )
    
    return Opposite( DirectSumOp( List( obj_list, Opposite ), Opposite( obj1 ) ) );
    
end );

##
InstallMethod( ProjectionInFirstFactor,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( sum_obj )
    
    return Opposite( InjectionFromFirstSummand( Opposite( sum_obj ) ) );
    
end );

##
InstallMethod( ProjectionInSecondFactor,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( sum_obj )
    
    return Opposite( InjectionFromSecondSummand( Opposite( sum_obj ) ) );
    
end );

##
InstallMethod( InjectionFromFirstSummand,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( sum_obj )
    
    return Opposite( ProjectionInFirstFactor( Opposite( sum_obj ) ) );
    
end );

##
InstallMethod( InjectionFromSecondSummand,
               [ IsHomalgCategoryOppositeObjectRep ],
               -1,
               
  function( sum_obj )
    
    return Opposite( ProjectionInSecondFactor( Opposite( sum_obj ) ) );
    
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
    
    entry_list := List( entry_list, i -> [ "technical implication", i ] );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ category, [ Opposite, category ] ],
                                                         entry_list );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ [ Opposite, category ], category ],
                                                         entry_list );
 
    AddToToDoList( entry );
    
end );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM,

  function( morphism )
    local entry_list, entry;

    entry_list := [ [ "Mono is dual to epi", [ "IsMonomorphism", "IsEpimorphism" ] ],
                    [ "Epi is dual to mono", [ "IsEpimorphism", "IsMonomorphism" ] ],
                    [ "Iso is self dual", "IsIsomorphism"]
                  # ...
                  ];

    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "Opposite" ] ],
                                                         [ morphism, [ Opposite, morphism ] ],
                                                         entry_list );

    AddToToDoList( entry );

    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "Opposite" ] ],
                                                         [ [ Opposite, morphism ], morphism ],
                                                         entry_list );

    AddToToDoList( entry );

end );

