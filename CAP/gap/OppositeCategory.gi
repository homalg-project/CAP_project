#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Opposite category
##
#############################################################################

###################################
##
#! @Section Filter
##
###################################

DeclareRepresentation( "IsCapCategoryOppositeObjectRep",
                       IsAttributeStoringRep and IsCapCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsCapCategoryOppositeMorphismRep",
                       IsAttributeStoringRep and IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfCapCategoryOppositeObjects",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapCategoryOppositeObjectRep ) );

BindGlobal( "TheTypeOfCapCategoryOppositeMorphisms",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapCategoryOppositeMorphismRep ) );


###################################
##
#! @Section Functor is an involution
##
###################################

##
InstallImmediateMethod( Opposite,
                        IsCapCategory and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##
InstallImmediateMethod( Opposite,
                        IsCapCategoryObject and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##
InstallImmediateMethod( Opposite,
                        IsCapCategoryMorphism and HasOpposite,
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
InstallMethodWithToDoForIsWellDefined( Opposite,
                                       [ IsCapCategoryObject ],
                                       
  function( object )
    local opposite_object;
    
    opposite_object := rec( );
    
    ObjectifyWithAttributes( opposite_object, TheTypeOfCapCategoryOppositeObjects,
                             Opposite, object );
    
    Add( Opposite( CapCategory( object ) ), opposite_object );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT( object );
    
    return opposite_object;
    
end );

##
InstallMethodWithToDoForIsWellDefined( Opposite,
                                       [ IsCapCategoryMorphism ],
                                       
  function( morphism )
    local opposite_morphism;
    
    opposite_morphism := rec( );
    
    ObjectifyWithAttributes( opposite_morphism, TheTypeOfCapCategoryOppositeMorphisms,
                             Opposite, morphism );
    
    Add( Opposite( CapCategory( morphism ) ), opposite_morphism );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM( morphism );
    
    return opposite_morphism;
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    local opposite_category;
    
    opposite_category := CreateCapCategory( name );
    
    SetWasCreatedAsOppositeCategory( opposite_category, true );
    
    SetOpposite( opposite_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY( category );
    
    return opposite_category;
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategory ],
               
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
                        IsCapCategoryOppositeMorphismRep,
                        0,
                        
  function( morphism )
    
    return Opposite( Range( Opposite( morphism ) ) );
    
end );

##
InstallImmediateMethod( Range,
                        IsCapCategoryOppositeMorphismRep,
                        0,
                        
  function( morphism )
    
    return Opposite( Source( Opposite( morphism ) ) );
    
end );

##
InstallMethod( PreCompose,
               [ IsCapCategoryOppositeMorphismRep, IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( left, right )
    
    return Opposite( PreCompose( Opposite( right ), Opposite( left ) ) );
    
end );

##
InstallMethod( PostCompose,
               [ IsCapCategoryOppositeMorphismRep, IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( left, right )
    
    return Opposite( PreCompose( Opposite( left ), Opposite( right ) ) );
    
end );

##
InstallMethod( IdentityMorphism,
               [ IsCapCategoryOppositeObjectRep ],
               -1,
               
  function( obj )
    
    return Opposite( IdentityMorphism( Opposite( obj ) ) );
    
end );

##
InstallMethod( ZeroObject,
               [ IsCapCategory and WasCreatedAsOppositeCategory ],
               -1,
               
  function( category )
    
    return Opposite( ZeroObject( Opposite( category ) ) );
    
end );

##
InstallMethod( Lift,
              [ IsCapCategoryOppositeMorphismRep, IsCapCategoryOppositeMorphismRep ],
              -1,
              
  function( monomorphism, test_morphism )
    
    return Opposite( Colift( Opposite( monomorphism ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( Colift,
              [ IsCapCategoryOppositeMorphismRep, IsCapCategoryOppositeMorphismRep ],
              -1,
              
  function( epimorphism, test_morphism )
    
    return Opposite( Lift( Opposite( epimorphism ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( InverseOp,
               [ IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( Inverse( Opposite( mor ) ) );
    
end );

##
InstallMethod( Kernel,
               [ IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( Cokernel( Opposite( mor ) ) );
    
end );

##
InstallMethod( KernelEmb,
               [ IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( CokernelProj( Opposite( mor ) ) );
    
end );

##
InstallMethod( KernelLift,
               [ IsCapCategoryOppositeMorphismRep, IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor, test_morphism )
    
    return Opposite( CokernelColift( Opposite( mor ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( Cokernel,
               [ IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( Kernel( Opposite( mor ) ) );
    
end );

##
InstallMethod( CokernelProj,
               [ IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor )
    
    return Opposite( KernelEmb( Opposite( mor ) ) );
    
end );

##
InstallMethod( CokernelColift,
               [ IsCapCategoryOppositeMorphismRep, IsCapCategoryOppositeMorphismRep ],
               -1,
               
  function( mor, test_morphism )
    
    return Opposite( KernelLift( Opposite( mor ), Opposite( test_morphism ) ) );
    
end );

##
InstallMethod( MorphismFromZeroObject,
               [ IsCapCategoryOppositeObjectRep ],
               -1,
               
  function( obj )
    
    return Opposite( MorphismIntoZeroObject( Opposite( obj ) ) );
    
end );

##
InstallMethod( MorphismIntoZeroObject,
               [ IsCapCategoryOppositeObjectRep ],
               -1,
               
  function( obj )
    
    return Opposite( MorphismFromZeroObject( Opposite( obj ) ) );
    
end );

##
InstallMethod( ZeroMorphism,
               [ IsCapCategoryOppositeObjectRep, IsCapCategoryOppositeObjectRep ],
               -1,
               
  function( obj_source, obj_range )
    
    return Opposite( ZeroMorphism( Opposite( obj_range ), Opposite( obj_source ) ) );
    
end );

##
InstallMethod( IsWellDefined,
               [ IsCapCategoryOppositeObjectRep ],
               -1,
  function( obj )
    
    return IsWellDefined( Opposite( obj ) );
    
end );

##
InstallMethod( IsWellDefined,
               [ IsCapCategoryOppositeMorphismRep ],
               -1,
  function( mor )
    
    return IsWellDefined( Opposite( mor ) );
    
end );

# ##
# InstallMethod( DirectSumOp,
#                [ IsList, IsCapCategoryOppositeObjectRep ],
#                -1,
#                
#   function( obj_list, obj1 )
#     
#     return Opposite( DirectSumOp( List( obj_list, Opposite ), Opposite( obj1 ) ) );
#     
# end );
# 
# ##
# InstallMethod( ProjectionInFirstFactor,
#                [ IsCapCategoryOppositeObjectRep ],
#                -1,
#                
#   function( sum_obj )
#     
#     return Opposite( InjectionFromFirstSummand( Opposite( sum_obj ) ) );
#     
# end );
# 
# ##
# InstallMethod( ProjectionInSecondFactor,
#                [ IsCapCategoryOppositeObjectRep ],
#                -1,
#                
#   function( sum_obj )
#     
#     return Opposite( InjectionFromSecondSummand( Opposite( sum_obj ) ) );
#     
# end );
# 
# ##
# InstallMethod( InjectionFromFirstSummand,
#                [ IsCapCategoryOppositeObjectRep ],
#                -1,
#                
#   function( sum_obj )
#     
#     return Opposite( ProjectionInFirstFactor( Opposite( sum_obj ) ) );
#     
# end );
# 
# ##
# InstallMethod( InjectionFromSecondSummand,
#                [ IsCapCategoryOppositeObjectRep ],
#                -1,
#                
#   function( sum_obj )
#     
#     return Opposite( ProjectionInSecondFactor( Opposite( sum_obj ) ) );
#     
# end );

## TODO: Massig todo-list entries die attribute von Category/Object/Morphism auf Opposite übertragen.

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY,
                       
  function( category )
    local entry_list, entry;
    
    ## TODO: Maintain this list
    entry_list := [ [ "CanComputeLift", "CanComputeColift" ],
                    [ "CanComputeColift", "CanComputeLift" ],
                      "CanComputeIdentityMorphism",
                      "CanComputeInverseImmutable",
                    [ "CanComputeKernelObject", "CanComputeCokernel" ],
                    [ "CanComputeKernelEmb", "CanComputeCokernelProj" ],
                    [ "CanComputeKernelLift", "CanComputeCokernelColift" ],
                    [ "CanComputeCokernel", "CanComputeKernelObject" ],
                    [ "CanComputeCokernelProj", "CanComputeKernelEmb" ],
                    [ "CanComputeCokernelColift", "CanComputeKernelLift" ],
                    [ "CanComputePreCompose", "CanComputePostCompose" ],
                    [ "CanComputePostCompose", "CanComputePreCompose" ],
                      "CanComputeZeroObject",
                      "CanComputeZeroMorphism",
                      "CanComputeDirectSum"
#                     [ "CanComputeProjectionInFirstFactor", "CanComputeInjectionFromFirstSummand" ],
#                     [ "CanComputeProjectionInSecondFactor", "CanComputeInjectionFromSecondSummand" ],
#                     [ "CanComputeInjectionFromFirstSummand", "CanComputeProjectionInFirstFactor" ],
#                     [ "CanComputeInjectionFromSecondSummand", "CanComputeProjectionInSecondFactor" ]
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
                    [ "Iso is self dual", "IsIsomorphism" ],
                    [ "IsEndomorphism is self dual", "IsEndomorphism" ],
                    [ "automorphism is self dual", "IsAutomorphism" ],
                    [ "One is self dual", "IsOne" ],
                    [ "Epi is dual to mono", [ "IsSplitMonomorphism", "IsSplitEpimorphism" ] ],
                    [ "Mono is dual to epi", [ "IsSplitEpimorphism", "IsSplitMonomorphism" ] ],
                    [ "Idempotent is self dual", "IsIdempotent" ]#,
#                     [ "IsWellDefined", "IsWellDefined" ]
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

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT,

  function( object )
    local entry_list, entry;

    entry_list := [ [ "IsInjective", "IsProjective" ],
                    [ "IsProjective", "IsInjective" ],
                    [ "IsZero", "IsZero" ]#,
#                     [ "IsWellDefined", "IsWellDefined" ]
                  # ...
                  ];

    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "Opposite" ] ],
                                                         [ object, [ Opposite, object ] ],
                                                         entry_list );

    AddToToDoList( entry );

    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "Opposite" ] ],
                                                         [ [ Opposite, object ], object ],
                                                         entry_list );

    AddToToDoList( entry );

end );

