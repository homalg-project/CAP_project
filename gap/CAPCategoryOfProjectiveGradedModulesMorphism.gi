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

DeclareRepresentation( "IsCAPCategoryOfProjectiveGradedModulesMorphismRep",
                       IsCAPCategoryOfProjectiveGradedModulesMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPCategoryOfProjectiveGradedModulesMorphisms",
        NewFamily( "TheFamilyOfCAPCategoryOfProjectiveGradedModulesMorphisms" ) );

BindGlobal( "TheTypeOfCAPCategoryOfProjectiveGradedModulesMorphisms",
        NewType( TheFamilyOfCAPCategoryOfProjectiveGradedModulesMorphisms,
                IsCAPCategoryOfProjectiveGradedModulesMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( CAPCategoryOfProjectiveGradedModulesMorphism,
               [ IsCAPCategoryOfProjectiveGradedModulesObject, IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedModulesObject ],
               
  function( source, homalg_matrix, range )
    local cap_category_of_projective_graded_modules_morphism, homalg_graded_ring, category;
    
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
    
    if NrRows( homalg_matrix ) <> RankOfObject( source ) then
      
      return Error( "the number of rows has to be equal to the rank of the source" );
      
    fi;
    
    if NrColumns( homalg_matrix ) <> RankOfObject( range ) then
      
      return Error( "the number of columns has to be equal to the rank of the range" );
      
    fi;
    
    # now create the morphism
    cap_category_of_projective_graded_modules_morphism := rec( );
    
    ObjectifyWithAttributes( cap_category_of_projective_graded_modules_morphism, 
                                                                         TheTypeOfCAPCategoryOfProjectiveGradedModulesMorphisms,
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, homalg_graded_ring,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    # add the morphism to the category
    Add( category, cap_category_of_projective_graded_modules_morphism );
    
    return cap_category_of_projective_graded_modules_morphism;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
               [ IsCAPCategoryOfProjectiveGradedModulesMorphism ], 999, # FIX ME FIX ME FIX ME!!!               
               
  function( cap_category_of_projective_graded_modules_morphism )

    Print( "A morphism in the category of projective graded modules over ", 
    RingName( UnderlyingHomalgGradedRing( cap_category_of_projective_graded_modules_morphism ) ),
    " with matrix: \n" );
    
    Display( UnderlyingHomalgMatrix( cap_category_of_projective_graded_modules_morphism ) );
    
end );