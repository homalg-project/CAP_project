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
    
    if not IsFinalized( underlying_monoidal_category ) then
        
        Error( "the underlying category must be finalized" );
    
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
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
    
    if not IsFinalized( underlying_monoidal_category ) then
      
      Error( "the underlying category must be finalized" );
      
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
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
    
    ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_ACTIONS_CATEGORY( left_actions_category );
    
    ADD_FUNCTIONS_FOR_ONLY_LEFT_ACTIONS_CATEGORY( left_actions_category );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_ACTIONS_CATEGORY,
  
  function( right_actions_category )
    
    ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_ACTIONS_CATEGORY( right_actions_category );
    
    ADD_FUNCTIONS_FOR_ONLY_RIGHT_ACTIONS_CATEGORY( right_actions_category );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_ACTIONS_CATEGORY,
  
  function( category )
    local category_weight_list, needed_basic_operations;
    
    category_weight_list := CapCategory( category!.acting_object )!.derivations_weight_list;
    
    ##
    AddIsEqualForObjects( category,
      function( action_object_1, action_object_2 )
        
        return IsEqualForObjects( ActionDomain( action_object_1 ), ActionDomain( action_object_2 ) )
               and
               IsCongruentForMorphisms( StructureMorphism( action_object_1 ), StructureMorphism( action_object_2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsCongruentForMorphisms( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) );
        
    end );
    
    ##
    needed_basic_operations := [ "IdentityMorphism" ];
    
    if ForAll( needed_basic_operations,
               basic_operation -> CurrentOperationWeight( category_weight_list, basic_operation ) < infinity ) then
      
      AddIdentityMorphism( category,
        function( action_object )
          
          return ActionMorphism( action_object,
                                 IdentityMorphism( ActionDomain( action_object ) ),
                                 action_object );
          
      end );
    
    fi;
    
    ##
    needed_basic_operations := [ "PreCompose" ];
    
    if ForAll( needed_basic_operations,
               basic_operation -> CurrentOperationWeight( category_weight_list, basic_operation ) < infinity ) then
      
      AddPreCompose( category,
        function( morphism_1, morphism_2 )
          
          return ActionMorphism( Source( morphism_1 ),
                                 PreCompose( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) ),
                                 Range( morphism_2 ) );
          
      end );
      
    fi;
    
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_LEFT_ACTIONS_CATEGORY,
  
  function( left_actions_category )
    
    ##
    AddDirectProduct( left_actions_category,
      function( diagram )
        local underlying_objects_diagram, direct_product_underlying_object_projections,
              length, identity_of_acting_object, structure_morphism;
        
        underlying_objects_diagram :=
          List( diagram, ActionDomain );
        
        length := Length( diagram );
        
        direct_product_underlying_object_projections :=
          List( [ 1 .. length ],
                i -> ProjectionInFactorOfDirectProduct(
                       underlying_objects_diagram,
                       i ) );
        
        identity_of_acting_object := IdentityMorphism( left_actions_category!.acting_object );
        
        structure_morphism :=
          UniversalMorphismIntoDirectProduct(
            underlying_objects_diagram,
            List( [ 1 .. length ],
                  i -> PreCompose(
                         TensorProductOnMorphisms( identity_of_acting_object, 
                                                   direct_product_underlying_object_projections[i] ),
                         StructureMorphism( diagram[i] )
                       )
            )
        );
        
        return LeftActionObject( structure_morphism, left_actions_category!.acting_object );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( left_actions_category,
      function( diagram, projection_number, direct_product )
        local underlying_projection;
        
        underlying_projection := ProjectionInFactorOfDirectProduct(
                                   List( diagram, ActionDomain ), projection_number );
        
        return ActionMorphism( direct_product,
                               underlying_projection,
                               diagram[ projection_number ] );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( left_actions_category,
      function( diagram, test_source, direct_product )
        local underlying_universal_morphism;
        
        underlying_universal_morphism := UniversalMorphismIntoDirectProduct(
                                           List( diagram, ActionDomain ),
                                           List( test_source, UnderlyingMorphism ) );
        
        return ActionMorphism( Source( test_source[1] ),
                               underlying_universal_morphism,
                               direct_product );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_RIGHT_ACTIONS_CATEGORY,
  
  function( right_actions_category )
  
end );
