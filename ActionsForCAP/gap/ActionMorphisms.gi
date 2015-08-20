#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

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
      
      if not IsIdenticalObj( CapCategory( source ), CapCategory( range ) ) then
        
        Error( "the given source and range have to be objects in the same category" );
        
      fi;
      
      if not IsIdenticalObj( UnderlyingCategory( source ), CapCategory( underlying_morphism ) ) then
        
        Error( "the given morphism has be in the underlying category of the source and range" );
        
      fi;
      
      action_morphism := rec( );
      
      if left = true then
        
        type := TheTypeOfLeftActionMorphisms;
        
      else
        
        type := TheTypeOfRightActionMorphisms;
        
      fi;
      
      ObjectifyWithAttributes( action_morphism, type,
                               UnderlyingMorphism, underlying_morphism,
                               Source, source,
                               Range, range,
                               UnderlyingActingObject, UnderlyingActingObject( source )
                             );
      
      Add( CapCategory( source ), action_morphism );
      
      return action_morphism;
    
end );

