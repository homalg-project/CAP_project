#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

####################################
##
## Auxiliary functions
##
####################################

InstallGlobalFunction( "RESOLVE_HISTORY",
                       
  function( list )
    local new_list, i;
    
    new_list := [ ];
    
    for i in list do
        
        if IsDeductionSystemCell( i ) then
            
            Add( new_list, History( i ) );
            
        else
            
            Add( new_list, i );
            
        fi;
        
    od;
    
    return new_list;
    
end );

####################################
##
## Reps and types
##
####################################

DeclareRepresentation( "IsDeductionSystemObjectRep",
                       IsHomalgCategoryObjectRep and IsDeductionSystemObject,
                       [ ] );

BindGlobal( "TheTypeOfDeductionSystemObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsDeductionSystemObjectRep ) );

DeclareRepresentation( "IsDeductionSystemMorphismRep",
                       IsHomalgCategoryMorphismRep and IsDeductionSystemMorphism,
                       [ ] );

BindGlobal( "TheTypeOfDeductionSystemMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsDeductionSystemMorphismRep ) );

####################################
##
## Add methods
##
####################################

InstallMethod( DeductionSystem,
               [ IsHomalgCategory ],
               
  function( category )
    local deduction_system;
    
    deduction_system := CreateHomalgCategory( Concatenation( "Deduction system of ", Name( category ) ) );
    
    SetUnderlyingHonestCategory( deduction_system, category );
    
    ADDS_FOR_DEDUCTION_SYSTEM( deduction_system, category );
    
    return deduction_system;
    
end );

##
InstallMethod( DeductionSystemObject,
               [ IsHomalgCategoryObject ],
               
  function( object )
    local deduction_object;
    
    deduction_object := rec( );
    
    ObjectifyWithAttributes( object, TheTypeOfDeductionSystemObject,
                             Eval, object );
    
    SetHistory( deduction_object, [ Eval, [ deduction_object ] ] );
    
    Add( DeductionSystem( HomalgCategory( object ) ), deduction_object );
    
    return deduction_object;
    
end );

##
InstallMethod( DeductionSystemObject,
               [ IsFunction, IsList ],
               
  function( func, argument_list )
    local deduction_object, resolved_history;
    
    deduction_object := rec( );
    
    resolved_history := RESOLVE_HISTORY( argument_list );
    
    ObjectifyWithAttributes( deduction_object, TheTypeOfDeductionSystemObject,
                             History, [ func, resolved_history ] );
    
    return deduction_object;
    
end );

##
InstallMethod( DeductionSystemMorphism,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local deduction_morphism, source, range;
    
    source := DeductionSystemObject( Source( morphism ) );
    
    range := DeductionSystemObject( Range( morphism ) );
    
    deduction_morphism := rec( );
    
    ObjectifyWithAttributes( deduction_morphism, TheTypeOfDeductionSystemMorphism,
                             Source, source,
                             Range, range,
                             Eval, morphism );
    
    SetHistory( deduction_morphism, [ Eval, [ deduction_morphism ] ] );
    
    Add( DeductionSystem( HomalgCategory( morphism ) ), deduction_morphism );
    
    return deduction_morphism;
    
end );

##
InstallMethod( DeductionSystemMorphism,
               [ IsDeductionSystemObject, IsFunction, IsList, IsDeductionSystemObject ],
               
  function( source, func, argument_list, range )
    local deduction_morphism, resolved_history;
    
    deduction_morphism := rec( );
    
    resolved_history := RESOLVE_HISTORY( argument_list );
    
    ObjectifyWithAttributes( deduction_morphism, TheTypeOfDeductionSystemMorphism,
                             History, [ func, resolved_history ],
                             Source, source,
                             Range, range );
    
    return deduction_morphism;
    
end );