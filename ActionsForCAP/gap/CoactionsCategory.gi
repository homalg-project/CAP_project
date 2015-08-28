#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## Constructors
##
####################################

##
InstallMethod( LeftCoactionsCategory,
               [ IsCapCategoryObject ],
               
  function( acting_object )
    local underlying_monoidal_category, left_coactions_category;
    
    underlying_monoidal_category := CapCategory( acting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
      
      Error( "the underlying category must be finalized" );
      
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    fi;
    
    left_coactions_category := CreateCapCategory( Concatenation( "Category of left coactions of <",
                                                               String( acting_object ),
                                                               ">" ) );
    
    left_coactions_category!.acting_object := acting_object;
    
    ## TODO: Set properties of left_coactions_category
    
    ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY( left_coactions_category );
    
    ## TODO: Logic for left_coactions_category
     
    Finalize( left_coactions_category );
    
    return left_coactions_category;
    
end );

##
InstallMethod( RightCoactionsCategory,
               [ IsCapCategoryObject ],
               
  function( acting_object )
    local underlying_monoidal_category, right_coactions_category;
    
    underlying_monoidal_category := CapCategory( acting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
      
      Error( "the underlying category must be finalized" );
      
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    fi;
    
    right_coactions_category := CreateCapCategory( Concatenation( "Category of right coactions of <",
                                                                String( acting_object ),
                                                                ">" ) );
    
    right_coactions_category!.acting_object := acting_object;
    
    ## TODO: Set properties of right_coactions_category
    
    ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY( right_coactions_category );
    
    ## TODO: Logic for right_coactions_category
     
    Finalize( right_coactions_category );
    
    return right_coactions_category;
    
end );

####################################
##
## Basic operations
##
####################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY,
  
  function( left_actions_category )
  
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY,
  
  function( right_actions_category )
  
end );
