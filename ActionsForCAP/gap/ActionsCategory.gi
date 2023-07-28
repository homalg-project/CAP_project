# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Implementations
#
#! @Chapter Actions

####################################
##
## Constructors
##
####################################

##
InstallMethod( LeftActionsCategory,
               [ IsCapCategoryObject ],
               
  function( acting_object )
    local name;
      
      name := Concatenation( "Category of left actions of <", String( acting_object ), ">" );
      
      return LeftActionsCategory( acting_object, name, [ IsObject, IsObject, IsObject ] );
      
end );

## context_filter_list = [ Category_Filter, Object_Filter, Morphism_Filter ]
##
InstallMethod( LeftActionsCategory,
               [ IsCapCategoryObject, IsString, IsList ],
               
  function( acting_object, name, context_filter_list )
    local underlying_monoidal_category, preconditions, category_weight_list, i,
          structure_record, object_constructor, morphism_constructor, 
          left_actions_category, identity_of_acting_object, tensor_preserves_epis;
    
    underlying_monoidal_category := CapCategory( acting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
        
        Error( "the underlying category must be finalized" );
    
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    elif not IsAdditiveCategory( underlying_monoidal_category ) then
      
      ## TODO: support the general case
      Error( "only additive categories are supported yet" );
      
    fi;
    
    left_actions_category := CreateCapCategory( name );
    
    left_actions_category!.category_as_first_argument := false;
    
    ## WARNING: This should be adjusted
    if HasIsAbelianCategory( underlying_monoidal_category )
       and IsAbelianCategory( underlying_monoidal_category )
       and HasIsRigidSymmetricClosedMonoidalCategory( underlying_monoidal_category )
       and IsRigidSymmetricClosedMonoidalCategory( underlying_monoidal_category ) then
        
        SetIsAbelianCategory( left_actions_category, true );
        
    fi;
    
    SetFilterObj( left_actions_category, context_filter_list[1] );
    
    SetUnderlyingActingObject( left_actions_category, acting_object );
    
    structure_record := rec(
      underlying_category := underlying_monoidal_category,
      category_with_attributes := left_actions_category
    );
    
    ## Constructors
    object_constructor := CreateObjectConstructorForCategoryWithAttributes(
                            underlying_monoidal_category, left_actions_category, TheTypeOfLeftActionObjects );
    
    structure_record.ObjectConstructor := function( object, attributes )
        local return_object;
        
        return_object := object_constructor( object, attributes );
        
        SetStructureMorphism( return_object, attributes[1] );
        
        SetUnderlyingActingObject( return_object, acting_object );
        
        SetActionDomain( return_object, Range( attributes[1] ) );
        
        SetFilterObj( return_object, context_filter_list[2] );
        
        return return_object;
        
    end;
    
    morphism_constructor := CreateMorphismConstructorForCategoryWithAttributes(
                              underlying_monoidal_category, left_actions_category, TheTypeOfLeftActionMorphisms );
    
    structure_record.MorphismConstructor := function( source, morphism, range )
        local return_morphism;
        
        return_morphism := morphism_constructor( source, morphism, range );
        
        SetUnderlyingActingObject( return_morphism, acting_object );
        
        SetUnderlyingMorphism( return_morphism, morphism );
        
        SetFilterObj( return_morphism, context_filter_list[3] );
        
        return return_morphism;
        
    end;
    
    ##
    category_weight_list := underlying_monoidal_category!.derivations_weight_list;
    
    ## Left action for ZeroObject
    preconditions := [ "UniversalMorphismIntoZeroObject",
                       "TensorProductOnObjects" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.ZeroObject :=
          function( underlying_zero_object )
              
              return [ UniversalMorphismIntoZeroObject( TensorProductOnObjects( acting_object, underlying_zero_object ) ) ];
              
          end;
    fi;
    
    ## Left action for DirectSum
    preconditions := [ "LeftDistributivityExpandingWithGivenObjects",
                       "DirectSum", #belongs to LeftDistributivityExpandingWithGivenObjects
                       "DirectSumFunctorialWithGivenDirectSums",
                       "PreCompose" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
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
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "LiftAlongMonomorphism" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
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
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                     ];
    
    tensor_preserves_epis := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "TensorPreservesEpis", false );
    if tensor_preserves_epis then
        Add( preconditions, "ColiftAlongEpimorphism" );
    else
        # we cannot use ColiftAlongEpimorphism if the tensor does not preserve epis
        Add( preconditions, "Colift" );
    fi;
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_acting_object := IdentityMorphism( acting_object );
        
        if tensor_preserves_epis then
            structure_record.Colift :=
              function( epi, source )
                local action_source, to_be_colifted;
                
                action_source := ObjectAttributesAsList( source )[1];
                
                to_be_colifted := PreCompose( action_source, epi );
                
                return [ ColiftAlongEpimorphism( TensorProductOnMorphisms( identity_of_acting_object, epi ), to_be_colifted ) ];
                
              end;
        else
            structure_record.Colift :=
              function( epi, source )
                local action_source, to_be_colifted;
                
                action_source := ObjectAttributesAsList( source )[1];
                
                to_be_colifted := PreCompose( action_source, epi );
                
                return [ Colift( TensorProductOnMorphisms( identity_of_acting_object, epi ), to_be_colifted ) ];
                
              end;
        fi;
        
    fi;
    
    structure_record.NoInstallList := [ "Lift", "ProjectiveLift", "Colift", "InjectiveColift" ];
    
    structure_record.InstallList := [ "LiftAlongMonomorphism", "ColiftAlongEpimorphism" ];
    
    EnhancementWithAttributes( structure_record );
    
    ##
    InstallMethod( LeftActionObject,
                   [ IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ), 
                     IsCapCategory and CategoryFilter( left_actions_category ) ],
                   
      function( structure_morphism, attribute_category )
        
        return structure_record.ObjectConstructor( Range( structure_morphism ), [ structure_morphism ] );
        
    end );
    
    ##
    InstallMethod( LeftActionMorphism,
                   [ IsLeftActionObject and ObjectFilter( left_actions_category ),
                     IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ),
                     IsLeftActionObject and ObjectFilter( left_actions_category ) ],
                   
      function( source, underlying_morphism, range )
        
        return structure_record.MorphismConstructor( source, underlying_morphism, range );
        
    end );
    
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
    local name;
      
      name := Concatenation( "Category of right actions of <", String( acting_object ), ">" );
      
      return RightActionsCategory( acting_object, name, [ IsObject, IsObject, IsObject ] );
      
end );


##
InstallMethod( RightActionsCategory,
               [ IsCapCategoryObject, IsString, IsList ],
               
  function( acting_object, name, context_filter_list )
    local underlying_monoidal_category, preconditions, category_weight_list, i,
          structure_record, object_constructor, morphism_constructor, 
          right_actions_category, identity_of_acting_object, tensor_preserves_epis;
    
    underlying_monoidal_category := CapCategory( acting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
        
        Error( "the underlying category must be finalized" );
    
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    elif not IsAdditiveCategory( underlying_monoidal_category ) then
      
      ## TODO: support the general case
      Error( "only additive categories are supported yet" );
      
    fi;
    
    right_actions_category := CreateCapCategory( name );
    
    right_actions_category!.category_as_first_argument := false;
    
    ## WARNING: This should be adjusted
    if HasIsAbelianCategory( underlying_monoidal_category )
       and IsAbelianCategory( underlying_monoidal_category )
       and HasIsRigidSymmetricClosedMonoidalCategory( underlying_monoidal_category )
       and IsRigidSymmetricClosedMonoidalCategory( underlying_monoidal_category ) then
        
        SetIsAbelianCategory( right_actions_category, true );
        
    fi;
    
    SetFilterObj( right_actions_category, context_filter_list[1] );
    
    SetUnderlyingActingObject( right_actions_category, acting_object );
    
    structure_record := rec(
      underlying_category := underlying_monoidal_category,
      category_with_attributes := right_actions_category
    );
    
    ## Constructors
    object_constructor := CreateObjectConstructorForCategoryWithAttributes(
                            underlying_monoidal_category, right_actions_category, TheTypeOfRightActionObjects );
    
    structure_record.ObjectConstructor := function( object, attributes )
        local return_object;
        
        return_object := object_constructor( object, attributes );
        
        SetStructureMorphism( return_object, attributes[1] );
        
        SetUnderlyingActingObject( return_object, acting_object );
        
        SetActionDomain( return_object, Range( attributes[1] ) );
        
        SetFilterObj( return_object, context_filter_list[2] );
        
        return return_object;
        
    end;
    
    morphism_constructor := CreateMorphismConstructorForCategoryWithAttributes(
                              underlying_monoidal_category, right_actions_category, TheTypeOfRightActionMorphisms );
    
    structure_record.MorphismConstructor := function( source, morphism, range )
        local return_morphism;
        
        return_morphism := morphism_constructor( source, morphism, range );
        
        SetUnderlyingActingObject( return_morphism, acting_object );
        
        SetUnderlyingMorphism( return_morphism, morphism );
        
        SetFilterObj( return_morphism, context_filter_list[3] );
        
        return return_morphism;
        
    end;
    
    ##
    category_weight_list := underlying_monoidal_category!.derivations_weight_list;
    
    ## Right action for ZeroObject
    preconditions := [ "UniversalMorphismIntoZeroObject",
                       "TensorProductOnObjects" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.ZeroObject :=
          function( underlying_zero_object )
              
              return [ UniversalMorphismIntoZeroObject( TensorProductOnObjects( underlying_zero_object, acting_object ) ) ];
              
          end;
    fi;
    
    ## Right action for DirectSum
    preconditions := [ "RightDistributivityExpandingWithGivenObjects",
                       "DirectSum", #belongs to RightDistributivityExpandingWithGivenObjects
                       "DirectSumFunctorialWithGivenDirectSums",
                       "PreCompose" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.DirectSum :=
          function( obj_list, underlying_direct_sum )
            local right_action_list, underlying_obj_list, structure_morphism;
            
            right_action_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
            
            underlying_obj_list := List( obj_list, UnderlyingCell );
            
            structure_morphism := 
              PreCompose( RightDistributivityExpanding( underlying_obj_list, acting_object ), DirectSumFunctorial( right_action_list ) );
            
            return [ structure_morphism ];
            
          end;
        
    fi;
    
    ## Lift right action along monomorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "LiftAlongMonomorphism" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_acting_object := IdentityMorphism( acting_object );
        
        structure_record.Lift :=
          function( mono, range )
            local action_range, to_be_lifted;
            
            action_range := ObjectAttributesAsList( range )[1];
            
            to_be_lifted := PreCompose( TensorProductOnMorphisms( mono, identity_of_acting_object ), action_range );
            
            return [ LiftAlongMonomorphism( mono, to_be_lifted ) ];
            
          end;
        
    fi;
    
    ## Colift right action along epimorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                     ];
    
    tensor_preserves_epis := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "TensorPreservesEpis", false );
    if tensor_preserves_epis then
        Add( preconditions, "ColiftAlongEpimorphism" );
    else
        # we cannot use ColiftAlongEpimorphism if the tensor does not preserve epis
        Add( preconditions, "Colift" );
    fi;
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_acting_object := IdentityMorphism( acting_object );
        
        if tensor_preserves_epis then
            structure_record.Colift :=
              function( epi, source )
                local action_source, to_be_colifted;
                
                action_source := ObjectAttributesAsList( source )[1];
                
                to_be_colifted := PreCompose( action_source, epi );
                
                return [ ColiftAlongEpimorphism( TensorProductOnMorphisms( epi, identity_of_acting_object ), to_be_colifted ) ];
                
              end;
        else
            structure_record.Colift :=
              function( epi, source )
                local action_source, to_be_colifted;
                
                action_source := ObjectAttributesAsList( source )[1];
                
                to_be_colifted := PreCompose( action_source, epi );
                
                return [ Colift( TensorProductOnMorphisms( epi, identity_of_acting_object ), to_be_colifted ) ];
                
              end;
        fi;
        
    fi;
    
    structure_record.NoInstallList := [ "Lift", "Colift" ];
    
    structure_record.InstallList := [ "LiftAlongMonomorphism", "ColiftAlongEpimorphism" ];
    
    EnhancementWithAttributes( structure_record );
    
    ##
    InstallMethod( RightActionObject,
                   [ IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ), 
                     IsCapCategory and CategoryFilter( right_actions_category ) ],
                   
      function( structure_morphism, attribute_category )
        
        return structure_record.ObjectConstructor( Range( structure_morphism ), [ structure_morphism ] );
        
    end );
    
    ##
    InstallMethod( RightActionMorphism,
                   [ IsRightActionObject and ObjectFilter( right_actions_category ),
                     IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ),
                     IsRightActionObject and ObjectFilter( right_actions_category ) ],
                   
      function( source, underlying_morphism, range )
        
        return structure_record.MorphismConstructor( source, underlying_morphism, range );
        
    end );
    
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
    local underlying_category;
    
    underlying_category := UnderlyingCategory( category );
    
    if CanCompute( underlying_category, "IsCongruentForMorphisms" ) then
    
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
        
        return IsEqualForMorphisms( UnderlyingCell( morphism_1 ), UnderlyingCell( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsCongruentForMorphisms( UnderlyingCell( morphism_1 ), UnderlyingCell( morphism_2 ) );
        
    end );
    
    else
        
        SetCachingOfCategoryCrisp( category );
        
        ##
        AddIsEqualForObjects( category, IsIdenticalObj );
        
        ##
        AddIsEqualForMorphisms( category, IsIdenticalObj );
        
        ## cannot AddIsCongruentForMorphisms
        category!.is_computable := false;
        
    fi;
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_LEFT_ACTIONS_CATEGORY,
  
  function( left_actions_category )
    local v;
    
    v := UnderlyingActingObject( left_actions_category );
    
    if CanCompute( UnderlyingCategory( left_actions_category ), "IsWellDefinedForMorphisms" ) then
    
    ##
    AddIsWellDefinedForObjects( left_actions_category,
      function( object )
        local underlying_category, action_domain, structure_morphism;
        
        underlying_category := UnderlyingCategory( object );
        
        structure_morphism := StructureMorphism( object );
        
        action_domain := ActionDomain( object );
        
        return IsIdenticalObj( underlying_category, CapCategory( structure_morphism ) )
               and IsIdenticalObj( underlying_category, CapCategory( action_domain ) )
               and IsWellDefined( structure_morphism )
               and IsEqualForObjects( Source( structure_morphism ),
                                      TensorProductOnObjects( UnderlyingActingObject( object ), action_domain ) )
               and IsEqualForObjects( Range( structure_morphism ), action_domain );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( left_actions_category,
      function( morphism )
        local underlying_morphism, source, range;
        
        underlying_morphism := UnderlyingMorphism( morphism );
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        return IsWellDefinedForMorphisms( underlying_morphism )
               and IsEqualForObjects( Source( underlying_morphism ), ActionDomain( source ) )
               and IsEqualForObjects( Range( underlying_morphism ), ActionDomain( range ) )
               and IsCongruentForMorphisms(
                     PreCompose( StructureMorphism( source ), underlying_morphism ),
                     PreCompose( TensorProductOnMorphisms( IdentityMorphism( v ), underlying_morphism ), StructureMorphism( range ) )
                   );
        
    end );
    
    fi;
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_RIGHT_ACTIONS_CATEGORY,
  
  function( right_actions_category )
    local v;
    
    v := UnderlyingActingObject( right_actions_category );
    
    if CanCompute( UnderlyingCategory( right_actions_category ), "IsWellDefinedForMorphisms" ) then
    
    ##
    AddIsWellDefinedForObjects( right_actions_category,
      function( object )
        local underlying_category, action_domain, structure_morphism;
        
        underlying_category := UnderlyingCategory( object );
        
        structure_morphism := StructureMorphism( object );
        
        action_domain := ActionDomain( object );
        
        return IsIdenticalObj( underlying_category, CapCategory( structure_morphism ) )
               and IsIdenticalObj( underlying_category, CapCategory( action_domain ) )
               and IsWellDefined( structure_morphism )
               and IsEqualForObjects( Source( structure_morphism ),
                                      TensorProductOnObjects( action_domain, UnderlyingActingObject( object ) ) )
               and IsEqualForObjects( Range( structure_morphism ), action_domain );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( right_actions_category,
      function( morphism )
        local underlying_morphism, source, range;
        
        underlying_morphism := UnderlyingMorphism( morphism );
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        return IsWellDefinedForMorphisms( underlying_morphism )
               and IsEqualForObjects( Source( underlying_morphism ), ActionDomain( source ) )
               and IsEqualForObjects( Range( underlying_morphism ), ActionDomain( range ) )
               and IsCongruentForMorphisms(
                     PreCompose( StructureMorphism( source ), underlying_morphism ),
                     PreCompose( TensorProductOnMorphisms( underlying_morphism, IdentityMorphism( v ) ), StructureMorphism( range ) )
                   );
        
    end );
    
    fi;
    
end );
