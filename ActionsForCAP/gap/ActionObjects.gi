#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsLeftActionObjectRep",
                       IsLeftActionObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftActionObjects",
            NewFamily( "TheFamilyOfLeftActionObjects" ) );

BindGlobal( "TheTypeOfLeftActionObjects",
            NewType( TheFamilyOfLeftActionObjects,
                     IsLeftActionObjectRep ) );


DeclareRepresentation( "IsRightActionObjectRep",
                       IsRightActionObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightActionObjects",
            NewFamily( "TheFamilyOfRightActionObjects" ) );

BindGlobal( "TheTypeOfRightActionObjects",
            NewType( TheFamilyOfRightActionObjects,
                     IsRightActionObjectRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( LeftActionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( structure_morphism, acting_object )
    
    return LeftActionObject( structure_morphism, LeftActionsCategory( acting_object ) );
    
end );
