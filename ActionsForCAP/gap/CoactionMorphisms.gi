#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsLeftCoactionMorphismRep",
                       IsLeftCoactionMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftCoactionMorphisms",
            NewFamily( "TheFamilyOfLeftCoactionMorphisms" ) );

BindGlobal( "TheTypeOfLeftCoactionMorphisms",
            NewType( TheFamilyOfLeftCoactionMorphisms,
                     IsLeftCoactionMorphismRep ) );


DeclareRepresentation( "IsRightCoactionMorphismRep",
                       IsRightCoactionMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightCoactionMorphisms",
            NewFamily( "TheFamilyOfRightCoactionMorphisms" ) );

BindGlobal( "TheTypeOfRightCoactionMorphisms",
            NewType( TheFamilyOfRightCoactionMorphisms,
                     IsRightCoactionMorphismRep ) );

#############################
##
## Constructors
##
#############################

InstallMethod( CoactionMorphism,
               [ IsLeftOrRightCoactionObject, IsCapCategoryMorphism, IsLeftOrRightCoactionObject ],
               
  function( source, underlying_morphism, range )
    local left, coaction_morphism, type;
      
      left := IsLeftCoactionObject( source );
      
      if not IsIdenticalObj( CapCategory( source ), CapCategory( range ) ) then
        
        Error( "the given source and range have to be objects in the same category" );
        
      fi;
      
      if not IsIdenticalObj( UnderlyingCategory( source ), CapCategory( underlying_morphism ) ) then
        
        Error( "the given morphism has be in the underlying category of the source and range" );
        
      fi;
      
      if left = true then
        
        type := TheTypeOfLeftCoactionMorphisms;
        
      else
        
        type := TheTypeOfRightCoactionMorphisms;
        
      fi;
      
      coaction_morphism := ObjectifyWithAttributes( rec( ), type,
                                                    UnderlyingMorphism, underlying_morphism,
                                                    Source, source,
                                                    Range, range,
                                                    UnderlyingActingObject, UnderlyingActingObject( source )
                                                  );
      
      Add( CapCategory( source ), coaction_morphism );
      
      return coaction_morphism;
    
end );
