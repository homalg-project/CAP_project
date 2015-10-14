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
InstallGlobalFunction( LeftOrRightActionObject,
               
  function( structure_morphism, acting_object, left )
    local action_object, type, category;
    
    action_object := rec( );
    
    if left = true then
        
        type := TheTypeOfLeftActionObjects;
        
        category := LeftActionsCategory( acting_object );
        
    else
        
        type := TheTypeOfRightActionObjects;
        
        category := RightActionsCategory( acting_object );
        
    fi;
    
    ObjectifyWithAttributes( action_object, type,
                             StructureMorphism, structure_morphism,
                             UnderlyingActingObject, acting_object,
                             ActionDomain, Range( structure_morphism ),
                             UnderlyingCategory, CapCategory( acting_object )
                           );
    
    Add( category, action_object );
    
    return action_object;
    
end );

##
InstallMethod( LeftActionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
  
  function( structure_morphism, acting_object )
    
    return LeftOrRightActionObject( structure_morphism, acting_object, true );
    
end );

##
InstallMethod( RightActionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
  
  function( structure_morphism, acting_object )
    
    return LeftOrRightActionObject( structure_morphism, acting_object, false );
    
end );
