#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsCAPCategoryOfProjectiveGradedLeftModulesMorphismRep",
                       IsCAPCategoryOfProjectiveGradedLeftModulesMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPCategoryOfProjectiveGradedLeftModulesMorphisms",
        NewFamily( "TheFamilyOfCAPCategoryOfProjectiveGradedLeftModulesMorphisms" ) );

BindGlobal( "TheTypeOfCAPCategoryOfProjectiveGradedLeftModulesMorphisms",
        NewType( TheFamilyOfCAPCategoryOfProjectiveGradedLeftModulesMorphisms,
                IsCAPCategoryOfProjectiveGradedLeftModulesMorphismRep ) );

DeclareRepresentation( "IsCAPCategoryOfProjectiveGradedRightModulesMorphismRep",
                       IsCAPCategoryOfProjectiveGradedRightModulesMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPCategoryOfProjectiveGradedRightModulesMorphisms",
        NewFamily( "TheFamilyOfCAPCategoryOfProjectiveGradedRightModulesMorphisms" ) );

BindGlobal( "TheTypeOfCAPCategoryOfProjectiveGradedRightModulesMorphisms",
        NewType( TheFamilyOfCAPCategoryOfProjectiveGradedRightModulesMorphisms,
                IsCAPCategoryOfProjectiveGradedRightModulesMorphismRep ) );
                
####################################
##
## Constructors
##
####################################

##
InstallMethod( CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgMatrix, 
                                                                      IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],

  function( source, homalg_matrix, range )
    local cap_category_of_projective_graded_modules_morphism, homalg_graded_ring, category, left, type;
    
    # get category of source
    category := CapCategory( source );
    
    # check that source and range are objects in the same category
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      return Error( "source and range are not defined over identical categories" );
      
    fi;
    
    # extract the homalg_graded_ring
    homalg_graded_ring := HomalgRing( homalg_matrix );
    
    # make a number of sanity tests (for left presentations actually!)
    if not IsIdenticalObj( homalg_graded_ring, UnderlyingHomalgGradedRing( source ) ) then
      
      return Error( "the matrix is defined over a different ring than the objects" );
      
    fi;

    # work out if we are considering left or right presentations
    left := IsCAPCategoryOfProjectiveGradedLeftModulesObject( source );
    
    # and correspondingly check the dimensions of the matrix
    if left then
      
      if NrRows( homalg_matrix ) <> Rank( source ) then
          
          Error( "the number of rows of the given matrix is incorrect" );
          
      fi;
      
      if NrColumns( homalg_matrix ) <> Rank( range ) then
        
        Error( "the number of columns of the given matrix is incorrect" );
        
      fi;
      
    else
      
      if NrColumns( homalg_matrix ) <> Rank( source ) then
        
        Error( "the number of columns of the given matrix is incorrect" );
        
      fi;
      
      if NrRows( homalg_matrix ) <> Rank( range ) then
        
        Error( "the number of rows of the given matrix is incorrect" );
        
      fi;
      
    fi;
    
    # now create the morphism
    cap_category_of_projective_graded_modules_morphism := rec( );

    # define the type
    if left then
        type := TheTypeOfCAPCategoryOfProjectiveGradedLeftModulesMorphisms;
    else
        type := TheTypeOfCAPCategoryOfProjectiveGradedRightModulesMorphisms;
    fi;    
    
    ObjectifyWithAttributes( cap_category_of_projective_graded_modules_morphism, type, 
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, homalg_graded_ring,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    # add the morphism to the category
    Add( category, cap_category_of_projective_graded_modules_morphism );
    
    # and return the morphism
    return cap_category_of_projective_graded_modules_morphism;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism ], 999, # FIX ME FIX ME FIX ME!!!               
               
  function( cap_category_of_projective_graded_modules_morphism )

    if IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( cap_category_of_projective_graded_modules_morphism ) then
  
      Print( "A morphism in the category of projective graded left modules over ", 
                                   RingName( UnderlyingHomalgGradedRing( cap_category_of_projective_graded_modules_morphism ) ),
                                   " with matrix: \n" );
    
      Display( UnderlyingHomalgMatrix( cap_category_of_projective_graded_modules_morphism ) );
    
    else

      Print( "A morphism in the category of projective graded right modules over ", 
                                   RingName( UnderlyingHomalgGradedRing( cap_category_of_projective_graded_modules_morphism ) ),
                                   " with matrix: \n" );
      
      Display( UnderlyingHomalgMatrix( cap_category_of_projective_graded_modules_morphism ) );

    fi;
      
end );