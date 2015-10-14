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
    local underlying_monoidal_category, preconditions, category_weight_list, i,
          structure_record, left_actions_category, identity_of_acting_object;
    
    underlying_monoidal_category := CapCategory( acting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
        
        Error( "the underlying category must be finalized" );
    
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    elif not IsAdditiveCategory( underlying_monoidal_category ) then
      
      ## TODO: support the general case
      Error( "only additive categories are supported yet" );
      
    fi;
    
    structure_record := rec(
      underlying_category := underlying_monoidal_category,
      object_type := TheTypeOfLeftActionObjects,
      morphism_type := TheTypeOfLeftActionMorphisms,
      category_name := Concatenation( "Category of left actions of <", String( acting_object ), ">" ) 
    );
    
    category_weight_list := underlying_monoidal_category!.derivations_weight_list;
    
    ## Left action for ZeroObject
    preconditions := [ "UniversalMorphismIntoZeroObject",
                       "TensorProductOnObjects" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, i ) < infinity ) then
        
        structure_record.ZeroObject :=
          function( underlying_zero_object )
              
              return [ UniversalMorphismIntoZeroObject( TensorProductOnObjects( acting_object, underlying_zero_object ) ) ];
              
          end;
    fi;
    
    ## Left action for DirectSum
    preconditions := [ "LeftDistributivityExpanding",
                       "DirectSum", #belongs to LeftDistributivityExpanding
                       "DirectSumFunctorial",
                       "PreCompose" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, i ) < infinity ) then
        
        structure_record.DirectSum :=
          function( obj_list, underlying_direct_sum )
            local left_action_list, underlying_obj_list, structure_morphism;
            
            left_action_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
            
            underlying_obj_list := List( obj_list, UnderlyingCell );
            
            structure_morphism := 
              PreCompose( LeftDistributivityExpanding( acting_object, underlying_obj_list ), DirectSumFunctorial( left_action_list ) );
            
            return [ structure_morphism ];
            
          end;
        
    fi;
    
    ## Lift left action along monomorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphisms",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "LiftAlongMonomorphism" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, i ) < infinity ) then
        
        identity_of_acting_object := IdentityMorphism( acting_object );
        
        structure_record.Lift :=
          function( mono, range )
            local action_range, to_be_lifted;
            
            action_range := ObjectAttributesAsList( range )[1];
            
            to_be_lifted := PreCompose( TensorProductOnMorphisms( identity_of_acting_object, mono ), action_range );
            
            return [ LiftAlongMonomorphism( mono, to_be_lifted ) ];
            
          end;
        
    fi;
    
    ## Colift left action along epimorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphisms",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "ColiftAlongEpimorphism" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, i ) < infinity ) then
        
        identity_of_acting_object := IdentityMorphism( acting_object );
        
        structure_record.Colift :=
          function( epi, source )
            local action_source, to_be_colifted;
            
            action_source := ObjectAttributesAsList( source )[1];
            
            to_be_colifted := PreCompose( action_source, TensorProductOnMorphisms( identity_of_acting_object, epi ) );
            
            return [ ColiftAlongEpimorphism( epi, to_be_colifted ) ];
            
          end;
        
    fi;
    
    left_actions_category := CreateCategoryWithAttributes( structure_record );
    
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
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_LEFT_ACTIONS_CATEGORY,
  
  function( left_actions_category )
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_RIGHT_ACTIONS_CATEGORY,
  
  function( right_actions_category )
  
end );
