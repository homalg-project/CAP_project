# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Implementations
#

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

##
InstallMethod( RightActionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( structure_morphism, acting_object )
    
    return RightActionObject( structure_morphism, RightActionsCategory( acting_object ) );
    
end );
