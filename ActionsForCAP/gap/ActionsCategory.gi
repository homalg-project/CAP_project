#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Actions
##
#############################################################################

####################################
##
## Constructors
##
####################################

##
InstallMethod( LeftActionsCategory,
               [ IsCapCategoryObject ],
               
  function( acting_object )
    local underlying_monoidal_category, left_actions_category;
    
    underlying_monoidal_category := CapCategory( acting_object );
    
    if not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    fi;
    
    left_actions_category := CreateCapCategory( Concatenation( "Category of left actions of <",
                                                               String( acting_object ),
                                                               ">" ) );
    
    left_actions_category!.acting_object := acting_object;
    
    ## TODO: Set properties of left_actions_category
    
    ADD_FUNCTIONS_FOR_LEFT_ACTIONS_CATEGORY( left_actions_category );
    
    ## TODO: Logic for left_actions_category
     
    Finalize( left_actions_category );
    
    return left_actions_category;
    
end );

##
InstallMethod( RightActionsCategory,
               [ IsCapCategoryObject ],
               
  function( acting_object )
    local underlying_monoidal_category, right_actions_category;
    
    underlying_monoidal_category := CapCategory( acting_object );

    if not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    fi;
    
    right_actions_category := CreateCapCategory( Concatenation( "Category of right actions of <",
                                                                String( acting_object ),
                                                                ">" ) );
    
    right_actions_category!.acting_object := acting_object;
    
    ## TODO: Set properties of right_actions_category
    
    ADD_FUNCTIONS_FOR_RIGHT_ACTIONS_CATEGORY( right_actions_category );
    
    ## TODO: Logic for right_actions_category
     
    Finalize( right_actions_category );
    
    return right_actions_category;
    
end );

####################################
##
## Basic operations
##
####################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_ACTIONS_CATEGORY,
  
  function( left_actions_category )
  
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_ACTIONS_CATEGORY,
  
  function( right_actions_category )
  
end );
