# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Implementations
#

DeclareRepresentation( "IsLeftActionMorphismRep",
                       IsLeftActionMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftActionMorphisms",
            NewFamily( "TheFamilyOfLeftActionMorphisms" ) );

BindGlobal( "TheTypeOfLeftActionMorphisms",
            NewType( TheFamilyOfLeftActionMorphisms,
                     IsLeftActionMorphismRep ) );


DeclareRepresentation( "IsRightActionMorphismRep",
                       IsRightActionMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightActionMorphisms",
            NewFamily( "TheFamilyOfRightActionMorphisms" ) );

BindGlobal( "TheTypeOfRightActionMorphisms",
            NewType( TheFamilyOfRightActionMorphisms,
                     IsRightActionMorphismRep ) );

#############################
##
## Constructors
##
#############################

InstallMethod( ActionMorphism,
               [ IsLeftOrRightActionObject, IsCapCategoryMorphism, IsLeftOrRightActionObject ],
               
  function( source, underlying_morphism, range )
    local left, action_morphism, type;
    
    left := IsLeftActionObject( source );
    
    if left then
        
        return LeftActionMorphism( source, underlying_morphism, range );
        
    else
        
        return RightActionMorphism( source, underlying_morphism, range );
        
    fi;
    
end );

