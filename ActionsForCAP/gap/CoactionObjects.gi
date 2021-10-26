# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Implementations
#

DeclareRepresentation( "IsLeftCoactionObjectRep",
                       IsLeftCoactionObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftCoactionObjects",
            NewFamily( "TheFamilyOfLeftCoactionObjects" ) );

BindGlobal( "TheTypeOfLeftCoactionObjects",
            NewType( TheFamilyOfLeftCoactionObjects,
                     IsLeftCoactionObjectRep ) );


DeclareRepresentation( "IsRightCoactionObjectRep",
                       IsRightCoactionObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightCoactionObjects",
            NewFamily( "TheFamilyOfRightCoactionObjects" ) );

BindGlobal( "TheTypeOfRightCoactionObjects",
            NewType( TheFamilyOfRightCoactionObjects,
                     IsRightCoactionObjectRep ) );


#############################
##
## Constructors
##
#############################

##
InstallMethod( LeftCoactionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( structure_morphism, coacting_object )
    
    return LeftCoactionObject( structure_morphism, LeftCoactionsCategory( coacting_object ) );
    
end );

##
InstallMethod( RightCoactionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( structure_morphism, coacting_object )
    
    return RightCoactionObject( structure_morphism, RightCoactionsCategory( coacting_object ) );
    
end );
