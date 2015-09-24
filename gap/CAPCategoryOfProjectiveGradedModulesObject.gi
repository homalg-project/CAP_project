#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       IPT Heidelberg
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsCAPCategoryOfProjectiveGradedLeftModulesObjectRep",
                       IsCAPCategoryOfProjectiveGradedLeftModulesObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPCategoryOfProjectiveGradedLeftModulesObjects",
        NewFamily( "TheFamilyOfCAPCategoryOfProjectiveGradedLeftModulesObjects" ) );

BindGlobal( "TheTypeOfCAPCategoryOfProjectiveGradedLeftModulesObjects",
        NewType( TheFamilyOfCAPCategoryOfProjectiveGradedLeftModulesObjects,
                IsCAPCategoryOfProjectiveGradedLeftModulesObjectRep ) );

DeclareRepresentation( "IsCAPCategoryOfProjectiveGradedRightModulesObjectRep",
                       IsCAPCategoryOfProjectiveGradedRightModulesObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPCategoryOfProjectiveGradedRightModulesObjects",
        NewFamily( "TheFamilyOfCAPCategoryOfProjectiveGradedRightModulesObjects" ) );

BindGlobal( "TheTypeOfCAPCategoryOfProjectiveGradedRightModulesObjects",
        NewType( TheFamilyOfCAPCategoryOfProjectiveGradedRightModulesObjects,
                IsCAPCategoryOfProjectiveGradedRightModulesObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( CAPCategoryOfProjectiveGradedLeftOrRightModulesObject,
               
  function( degree_list, homalg_graded_ring, left )
    local A, nrGenerators, i, buffer, buffer_homalg_module_element, category, category_of_projective_graded_modules_object, 
         rank, type;
        
    # extract the degree group of the ring and its number of generators
    A := DegreeGroup( homalg_graded_ring );
    nrGenerators := NrGenerators( A );    
    
    # next check that the degrees lie in the degree group
    for i in [ 1 .. Length( degree_list ) ] do
    
      if not Length( degree_list[ i ] ) = 2 then
      
        Error( "The entries of the degree list have to consist of two entries - the degree and its multiplicity. \n" );
        return false;
      
      fi;
      
      if not IsHomalgModuleElement( degree_list[ i ][ 1 ] ) then
      
        # try to turn the first entry into a homalg module element
        buffer := ShallowCopy( degree_list[ i ][ 1 ] );        
        if not Length( buffer ) = nrGenerators then
        
          Error( Concatenation( "Entry 1 of the ", String( i ), 
                 "-th list in degree_list cannot be interpreted as element of the degree group of the graded ring. \n" ) );
          return false;
                
        fi;
        buffer_homalg_module_element := HomalgModuleElement( HomalgMatrix( [ buffer ], HOMALG_MATRICES.ZZ ), A );
        
        # and replace the original entry
        degree_list[ i ][ 1 ] := buffer_homalg_module_element;
      
      fi;
      
      if not SuperObject( degree_list[ i ][ 1 ] ) = A then
      
        Error( Concatenation( "Entry 1 of the ", String( i )
                             ,"th list in degree_list is not an element of the degree group of the homalg graded ring. \n" ) );
        return false;
      
      fi;
      
      if ( not IsInt( degree_list[ i ][ 2 ] ) ) or ( degree_list[ i ][ 2 ] < 0 ) then
      
        Error( Concatenation( "Entry 2 of the ", String( i ), 
                                                        "-th list in degree_list has to be a non-negative integer. \n" ) );
        return false;
      
      fi;
    
    od;
    
    # the entered degree_list has passed all consistency checks
    # no sort this data (unless it is trivial)
    if Length( degree_list ) > 1 then
    
      degree_list := CAP_CATEGORY_OF_PROJECTIVE_GRADED_MODULES_INTERNAL_SIMPLIFY_DATA_STRUCTURE( degree_list );
    
    fi;

    # now construct the correct category and type for the object
    if left = true then
        type := TheTypeOfCAPCategoryOfProjectiveGradedLeftModulesObjects;
        category := CAPCategoryOfProjectiveGradedLeftModules( homalg_graded_ring );
    else
        type := TheTypeOfCAPCategoryOfProjectiveGradedRightModulesObjects;
        category := CAPCategoryOfProjectiveGradedRightModules( homalg_graded_ring );
    fi;
        
    # now construct the object
    category_of_projective_graded_modules_object := rec( );
    rank := Sum( List( degree_list, x -> x[ 2 ] ) );    
    ObjectifyWithAttributes( category_of_projective_graded_modules_object, type,
                             DegreeList, degree_list,
                             RankOfObject, rank,
                             UnderlyingHomalgGradedRing, homalg_graded_ring
    );

    # add the object to the category
    Add( category, category_of_projective_graded_modules_object );
    
    # and return the object
    return category_of_projective_graded_modules_object;
    
end );

InstallMethod( CAPCategoryOfProjectiveGradedLeftModulesObject,
               [ IsList, IsHomalgGradedRing ],
  function( degree_list, homalg_graded_ring )
  
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesObject( degree_list, homalg_graded_ring, true );

end );

InstallMethod( CAPCategoryOfProjectiveGradedRightModulesObject,
               [ IsList, IsHomalgGradedRing ],
  function( degree_list, homalg_graded_ring )
  
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesObject( degree_list, homalg_graded_ring, false );

end );

####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],
              
  function( category_of_projective_graded_modules_object )
    
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( category_of_projective_graded_modules_object ) then
        
       return Concatenation( "A projective graded left module of rank ", 
                              String( RankOfObject( category_of_projective_graded_modules_object ) )
                            );

    else
    
       return Concatenation( "A projective graded right module of rank ", 
                              String( RankOfObject( category_of_projective_graded_modules_object ) )
                            );
    
    fi;
                            
end );


####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],
               
  function( category_of_projective_graded_modules_object )

    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( category_of_projective_graded_modules_object ) then
          
      Print( Concatenation( "A projective graded left module over ",
                            RingName( UnderlyingHomalgGradedRing( category_of_projective_graded_modules_object ) ),
                            " of rank ", String( RankOfObject( category_of_projective_graded_modules_object ) ),
                            " and degrees: \n" ) 
                            );
    
      ViewObj( DegreeList( category_of_projective_graded_modules_object ) );
    
    else
    
      Print( Concatenation( "A projective graded right module over ",
                            RingName( UnderlyingHomalgGradedRing( category_of_projective_graded_modules_object ) ),
                            " of rank ", String( RankOfObject( category_of_projective_graded_modules_object ) ),
                            " and degrees: \n" ) 
                            );
    
      ViewObj( DegreeList( category_of_projective_graded_modules_object ) );

    fi;
   
end );


####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],

  function( category_of_projective_graded_modules_object )

    Print( Concatenation( "<", String( category_of_projective_graded_modules_object ), ">" ) );

end );

##################################################
##
## Convenience method to access "Rank" more easily
##
##################################################

InstallMethod( Rank,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],

  RankOfObject );
  
##################################################
##
## Attributes
##
##################################################

InstallMethod( CAP_CATEGORY_OF_PROJECTIVE_GRADED_MODULES_INTERNAL_SIMPLIFY_DATA_STRUCTURE,
               [ IsList ],
  function( unsorted_degree_list )
    local i, old_degree_list, new_degree_list, counter, comparer;
  
    # run once accross the degree list and add successive equal degrees
    # example:
    # [[ a, 1 ], [ a,1 ], [ b, 1 ], [a,2]] -> [[ a,2 ], [b,1 ], [ a,2]]
    # BUT this gets not simplified to say [[ a,4 ], [ b, 1 ]]
    
    # here is the algorithm
    new_degree_list := [];
    counter := unsorted_degree_list[ 1 ][ 2 ];
    comparer := unsorted_degree_list[ 1 ][ 1 ];
    for i in [ 2 .. Length( unsorted_degree_list ) ] do
    
      # compare with the next element
      if unsorted_degree_list[ i ][ 1 ] <> comparer then
      
        Add( new_degree_list, [ comparer, counter ] );
        comparer := unsorted_degree_list[ i ][ 1 ];
        counter := unsorted_degree_list[ i ][ 2 ];
      
      else
      
        counter := counter + unsorted_degree_list[ i ][ 2 ];
      
      fi;
    
      # and now react to reaching the end of the list
      if i = Length( unsorted_degree_list ) then
      
        Add( new_degree_list, [ comparer, counter ] );
      
      fi;
    
    od;
    
    # return new_degree_list
    return new_degree_list;
    
end );