############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
#! @Chapter Internal Exterior Algebra Modules
##
#############################################################################

####################################
##
## Constructors
##
####################################

## category constructors
##
InstallMethod( EModuleActionCategory,
               [ IsCapCategoryObject ],
               
  function( object )
    local name, category;
    
    name := Concatenation( "Module category of the internal exterior algebra modeled via actions of ", String( object ) );
    
    category := RightActionsCategory( object, name,
                  [ IsEModuleActionCategory, IsEModuleActionCategoryObject, IsEModuleActionCategoryMorphism ] );
    
    return category;
    
end );

##
InstallMethod( EModuleCoactionCategory,
               [ IsCapCategoryObject ],
               
  function( object )
    local name, w, category;
    
    w := DualOnObjects( object );
    
    name := Concatenation( "Module category of the internal exterior algebra modeled via coactions of ", String( w ) );
    
    category := LeftCoactionsCategory( w, name,
                  [ IsEModuleCoactionCategory, IsEModuleCoactionCategoryObject, IsEModuleCoactionCategoryMorphism ] );
    
    return category;
    
end );

## object constructors
##
InstallMethod( EModuleActionCategoryObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( structure_morphism, object )
    local result_object;
    
    return EModuleActionCategoryObject( structure_morphism, EModuleActionCategory( object ) );
    
end );

##
InstallMethod( EModuleActionCategoryObject,
               [ IsCapCategoryMorphism, IsCapCategory ],
               
  function( structure_morphism, category )
    
    return RightActionObject( structure_morphism, category );
    
end );


##
InstallMethod( EModuleCoactionCategoryObject,
               [ IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( structure_morphism, object )
    local result_object;
    
    return EModuleCoactionCategoryObject( structure_morphism, EModuleCoactionCategory( object ) );
    
end );

##
InstallMethod( EModuleCoactionCategoryObject,
               [ IsCapCategoryMorphism, IsCapCategory ],
               
  function( structure_morphism, category )
    
    return LeftCoactionObject( structure_morphism, category );
    
end );

## morphism constructors
##
InstallMethod( EModuleCategoryMorphism,
               [ IsEModuleActionCategoryObject,
                 IsCapCategoryMorphism,
                 IsEModuleActionCategoryObject ],
                    
    function( source, morphism, range )
      local result_morphism;
      
      return RightActionMorphism( source, morphism, range );
      
end );

##
InstallMethod( EModuleCategoryMorphism,
               [ IsEModuleCoactionCategoryObject,
                 IsCapCategoryMorphism,
                 IsEModuleCoactionCategoryObject ],
                    
    function( source, morphism, range )
      local result_morphism;
      
      return LeftCoactionMorphism( source, morphism, range );
      
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( ExteriorAlgebraAsModule,
               [ IsEModuleActionCategory ],
               
  function( category )
    local exterior_algebra_multiplication_list, object_list;
    
    exterior_algebra_multiplication_list := ExteriorAlgebraAsModuleMultiplicationList( category );
    
    object_list := List( exterior_algebra_multiplication_list, Range );
    
    return EModuleActionCategoryObject(
             PreCompose(
               RightDistributivityExpanding( object_list, UnderlyingActingObject( category ) ),
               DirectSumFunctorial( exterior_algebra_multiplication_list )
             ),
             category
           );
    
end );

##
InstallMethod( ExteriorAlgebraAsModuleMultiplicationList,
               [ IsEModuleActionCategory ],
               
  function( category )
    local v, u, top, exterior_algebra_multiplication_list, id_v, n, morphism_1, n_minus_2_power, morphism_2;
    
    v := UnderlyingActingObject( category );
    
    u := TensorUnit( UnderlyingCategory( category ) );
    
    top := Dimension( v );
    
    exterior_algebra_multiplication_list := [ UniversalMorphismFromZeroObject( u ) ];
    
    if top = 0 then
        
        return EModuleActionCategoryObject( exterior_algebra_multiplication_list[1], category );
        
    fi;
    
    Add( exterior_algebra_multiplication_list, LeftUnitor( v ) );
    
    id_v := IdentityMorphism( v );
    
    for n in [ 3 .. top + 1 ] do
        
        morphism_1 := TensorProductOnMorphisms( exterior_algebra_multiplication_list[n - 1], id_v );
        
        n_minus_2_power := Range( exterior_algebra_multiplication_list[n - 2] );
        
        morphism_2 := PreCompose( [
                        AssociatorLeftToRight( n_minus_2_power, v, v ),
                        TensorProductOnMorphisms( IdentityMorphism( n_minus_2_power ), Braiding( v, v ) ),
                        AssociatorRightToLeft( n_minus_2_power, v, v ),
                        morphism_1 ] );
        
        Add( exterior_algebra_multiplication_list, CokernelProjection( morphism_1 + morphism_2 ) );
        
    od;
    
    Add( exterior_algebra_multiplication_list,
         UniversalMorphismIntoZeroObject( TensorProductOnObjects( Range( exterior_algebra_multiplication_list[top + 1] ), v ) ) );
    
    return exterior_algebra_multiplication_list;
    
end );

##
InstallMethod( ExteriorAlgebraDualAsModule,
               [ IsEModuleCoactionCategory ],
               
  function( category )
    local exterior_algebra_dual_comultiplication_list, object_list;
    
    exterior_algebra_dual_comultiplication_list := ExteriorAlgebraDualAsModuleComultiplicationList( category );
    
    object_list := List( exterior_algebra_dual_comultiplication_list, Source );
    
    return EModuleCoactionCategoryObject(
             PreCompose(
               DirectSumFunctorial( exterior_algebra_dual_comultiplication_list ),
               LeftDistributivityFactoring( UnderlyingCoactingObject( category ), object_list )
             ),
             category
           );
    
end );

##
InstallMethod( ExteriorAlgebraDualAsModuleComultiplicationList,
               [ IsEModuleCoactionCategory ],
               
  function( category )
    local w, u, top, exterior_algebra_dual_comultiplication_list, id_w, n, morphism_1, n_minus_2_power, morphism_2;
    
    w := UnderlyingCoactingObject( category );
    
    u := TensorUnit( UnderlyingCategory( category ) );
    
    top := Dimension( w );
    
    exterior_algebra_dual_comultiplication_list := [ UniversalMorphismIntoZeroObject( u ) ];
    
    if top = 0 then
        
        return EModuleCoactionCategoryObject( exterior_algebra_dual_comultiplication_list[1], category );
        
    fi;
    
    Add( exterior_algebra_dual_comultiplication_list, RightUnitorInverse( w ) );
    
    id_w := IdentityMorphism( w );
    
    for n in [ 3 .. top + 1 ] do
        
        morphism_1 := TensorProductOnMorphisms( id_w, exterior_algebra_dual_comultiplication_list[n - 1] );
        
        n_minus_2_power := Source( exterior_algebra_dual_comultiplication_list[n - 2] );
        
        morphism_2 := PreCompose( [
                        morphism_1,
                        AssociatorRightToLeft( w, w, n_minus_2_power ),
                        TensorProductOnMorphisms( Braiding( w, w ), IdentityMorphism( n_minus_2_power ) ),
                        AssociatorLeftToRight( w, w, n_minus_2_power ) ] );
        
        Add( exterior_algebra_dual_comultiplication_list, KernelEmbedding( morphism_1 + morphism_2 ) );
        
    od;
    
    Add( exterior_algebra_dual_comultiplication_list,
         UniversalMorphismFromZeroObject( 
           TensorProductOnObjects( w, Source( exterior_algebra_dual_comultiplication_list[top + 1] ) ) ) 
    );
    
    return exterior_algebra_dual_comultiplication_list;
    
end );

##
InstallMethod( FreeEModule,
               [ IsCapCategoryObject, IsEModuleActionCategory ],
               
  function( l, category )
    local exterior_algebra, v, structure_morphism;
    
    exterior_algebra := ExteriorAlgebraAsModule( category );
    
    v := UnderlyingActingObject( category );
    
    structure_morphism := PreCompose( [
      AssociatorLeftToRight( l, ActionDomain( exterior_algebra ), v ),
      TensorProductOnMorphisms( IdentityMorphism( l ), StructureMorphism( exterior_algebra ) ) ]
    );
    
    return EModuleActionCategoryObject( structure_morphism, category );
    
end );

##
InstallMethod( CofreeEModule,
               [ IsCapCategoryObject, IsEModuleCoactionCategory ],
               
  function( l, category )
    local exterior_algebra_dual, w, structure_morphism;
    
    exterior_algebra_dual := ExteriorAlgebraDualAsModule( category );
    
    w := UnderlyingCoactingObject( category );
    
    structure_morphism := PreCompose( [
      TensorProductOnMorphisms( StructureMorphism( exterior_algebra_dual ), IdentityMorphism( l ) ),
      AssociatorLeftToRight( w, CoactionDomain( exterior_algebra_dual ), l )
       ]
    );
    
    return EModuleCoactionCategoryObject( structure_morphism, category );
    
end );

##
InstallMethod( EModuleActionHigherMultiplications,
               [ IsEModuleActionCategoryObject ],
               
  function( object )
    local m, top, multiplication_list, category, v, id_m, id_v, structure_morphism, n, 
          epimorphism, n_minus_1_power, test_morphism, exterior_algebra_multiplication_list;
    
    m := ActionDomain( object );
    
    category := CapCategory( object );
    
    v := UnderlyingActingObject( category );
    
    top := Dimension( v );
    
    multiplication_list := [ RightUnitor( m ) ];
    
    if top = 0 then
        
        return multiplication_list;
        
    fi;
    
    id_m := IdentityMorphism( m );
    
    id_v := IdentityMorphism( v );
    
    structure_morphism := StructureMorphism( object );
    
    exterior_algebra_multiplication_list := ExteriorAlgebraAsModuleMultiplicationList( category );
    
    for n in [ 1 .. top ] do
        
        epimorphism := TensorProductOnMorphisms( id_m, exterior_algebra_multiplication_list[n + 1] );
        
        n_minus_1_power := Range( exterior_algebra_multiplication_list[n] );
        
        test_morphism := PreCompose( [
          AssociatorRightToLeft( m, n_minus_1_power, v ),
          TensorProductOnMorphisms( multiplication_list[n], id_v ),
          structure_morphism ] );
        
        Add( multiplication_list, ColiftAlongEpimorphism( epimorphism, test_morphism ) );
        
    od;
    
    return multiplication_list;
    
end );

##
InstallMethod( EModuleCoactionHigherComultiplications,
               [ IsEModuleCoactionCategoryObject ],
               
  function( object )
    local m, top, comultiplication_list, category, w, id_m, id_w, structure_morphism, n, 
          monomorphism, n_minus_1_power, test_morphism, exterior_algebra_dual_comultiplication_list;
    
    m := CoactionDomain( object );
    
    category := CapCategory( object );
    
    w := UnderlyingCoactingObject( category );
    
    top := Dimension( w );
    
    comultiplication_list := [ LeftUnitorInverse( m ) ];
    
    if top = 0 then
        
        return comultiplication_list;
        
    fi;
    
    id_m := IdentityMorphism( m );
    
    id_w := IdentityMorphism( w );
    
    structure_morphism := StructureMorphism( object );
    
    exterior_algebra_dual_comultiplication_list := ExteriorAlgebraDualAsModuleComultiplicationList( category );
    
    for n in [ 1 .. top ] do
        
        monomorphism := TensorProductOnMorphisms( exterior_algebra_dual_comultiplication_list[n + 1], id_m );
        
        n_minus_1_power := Source( exterior_algebra_dual_comultiplication_list[n] );
        
        test_morphism := PreCompose( [
          structure_morphism,
          TensorProductOnMorphisms( id_w, comultiplication_list[n] ),
          AssociatorRightToLeft( w, n_minus_1_power, m )
        ] );
        
        Add( comultiplication_list, LiftAlongMonomorphism( monomorphism, test_morphism ) );
        
    od;
    
    return comultiplication_list;
    
end );

##
InstallMethod( UniversalMorphismFromFreeModule,
               [ IsEModuleActionCategoryObject, IsCapCategoryMorphism ],
               
  function( object, test_morphism )
    local category, id_exterior_algebra, exterior_algebra_summands, m, higher_structure_morphism, morphism, source;
    
    category := CapCategory( object );
    
    id_exterior_algebra := IdentityMorphism( ActionDomain( ExteriorAlgebraAsModule( category ) ) );
    
    exterior_algebra_summands := List( ExteriorAlgebraAsModuleMultiplicationList( category ), Range );
    
    m := ActionDomain( object );
    
    higher_structure_morphism := PreCompose(
      LeftDistributivityExpanding( m, exterior_algebra_summands ),
      UniversalMorphismFromDirectSum( EModuleActionHigherMultiplications( object ) )
    );
    
    morphism := PreCompose( TensorProductOnMorphisms( test_morphism, id_exterior_algebra ),
                            higher_structure_morphism );
    
    source := FreeEModule( Source( test_morphism ), category );
    
    return EModuleCategoryMorphism( source, morphism, object );
    
end );

##
InstallMethod( UniversalMorphismToCofreeModule,
               [ IsEModuleCoactionCategoryObject, IsCapCategoryMorphism ],
               
  function( object, test_morphism )
    local category, id_exterior_algebra_dual, exterior_algebra_dual_summands, m, higher_structure_morphism, morphism, range;
    
    category := CapCategory( object );
    
    id_exterior_algebra_dual := IdentityMorphism( CoactionDomain( ExteriorAlgebraDualAsModule( category ) ) );
    
    exterior_algebra_dual_summands := List( ExteriorAlgebraDualAsModuleComultiplicationList( category ), Source );
    
    m := CoactionDomain( object );
    
    higher_structure_morphism := PreCompose(
      UniversalMorphismIntoDirectSum( EModuleCoactionHigherComultiplications( object ) ),
      RightDistributivityFactoring( exterior_algebra_dual_summands, m )
    );
    
    morphism := PreCompose( higher_structure_morphism,
                            TensorProductOnMorphisms( id_exterior_algebra_dual, test_morphism ) );
    
    range := CofreeEModule( Range( test_morphism ), category );
    
    return EModuleCategoryMorphism( object, morphism, range );
    
end );

##
InstallMethod( StepOfMinimalFreeResolutionOfKernel,
               [ IsEModuleActionCategoryMorphism ],
               
  function( morphism )
    local kernel_emb, beta, alpha, split;
    
    kernel_emb := KernelEmbedding( morphism );
    
    beta := ProjectionToHead( Source( kernel_emb ) );
    
    alpha := IdentityMorphism( Range( beta ) );
    
    split := Lift( alpha, beta );
    
    return PreCompose( UniversalMorphismFromFreeModule( Source( kernel_emb ), split ), kernel_emb );
    
end );

##
InstallMethod( StepOfMinimalCofreeResolutionOfCokernel,
               [ IsEModuleCoactionCategoryMorphism ],
               
  function( morphism )
    local cokernel_proj, beta, alpha, split;
    
    cokernel_proj := CokernelProjection( morphism );
    
    alpha := InjectionOfSocle( Range( cokernel_proj ) );
    
    beta := IdentityMorphism( Source( alpha ) );
    
    split := Colift( alpha, beta );
    
    return PreCompose( cokernel_proj, UniversalMorphismToCofreeModule( Range( cokernel_proj ), split ) );
    
end );

##
InstallMethod( ProjectionToHead,
               [ IsEModuleActionCategoryObject ],
               
  function( object )
    
    return CokernelProjection( StructureMorphism ( object ) );
    
end );

##
InstallMethod( Head,
               [ IsEModuleCategoryObject ],
               
  function( object )
    
    return Range( ProjectionToHead( object ) );
    
end );

##
InstallMethod( InjectionOfSocle,
               [ IsEModuleActionCategoryObject ],
               
  function( object )
    local m, v, morphism;
    
    m := ActionDomain( object );
    
    v := UnderlyingActingObject( object );
    
    morphism := PreCompose( Braiding( m, v ), StructureMorphism( object ) );
    
    return KernelEmbedding( TensorProductToInternalHomAdjunctionMap( m, v, morphism ) );
    
end );

##
InstallMethod( InjectionOfSocle,
               [ IsEModuleCoactionCategoryObject ],
               
  function( object )
    
    return KernelEmbedding( StructureMorphism( object ) );
    
end );

##
InstallMethod( Socle,
               [ IsEModuleCategoryObject ],
               
  function( object )
    
    return Source( InjectionOfSocle( object ) );
    
end );
