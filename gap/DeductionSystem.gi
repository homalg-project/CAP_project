#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

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
                             Eval, object,
                             History, [ ] );
    
    
