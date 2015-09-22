#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

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
InstallGlobalFunction( LeftOrRightCoactionObject,
               
  function( structure_morphism, coacting_object, left )
    local coaction_object, type, category;
    
    coaction_object := rec( );
    
    if left = true then
        
        type := TheTypeOfLeftCoactionObjects;
        
        category := LeftCoactionsCategory( coacting_object );
        
    else
        
        type := TheTypeOfRightCoactionObjects;
        
        category := RightCoactionsCategory( coacting_object );
        
    fi;
    
    ObjectifyWithAttributes( coaction_object, type,
                             StructureMorphism, structure_morphism,
                             UnderlyingActingObject, coacting_object,
                             ActionDomain, Source( structure_morphism ),
                             UnderlyingCategory, CapCategory( coacting_object )
                           );
    
    Add( category, coaction_object );
    
    return coaction_object;
    
end );

##
InstallMethod( LeftCoactionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
  
  function( structure_morphism, coacting_object )
    
    return LeftOrRightCoactionObject( structure_morphism, coacting_object, true );
    
end );

##
InstallMethod( RightCoactionObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
  
  function( structure_morphism, coacting_object )
    
    return LeftOrRightCoactionObject( structure_morphism, coacting_object, false );
    
end );
