# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Universal Objects

####################################
##
## Kernel
##
####################################

####################################
## Functorial operations
####################################

##
InstallMethod( KernelObjectFunctorial,
               [ IsList ],
                                  
  function( morphism_of_morphisms )
    
    Print(
      Concatenation(
      "WARNING: KernelObjectFunctorial( IsList ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use KernelObjectFunctorial( IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ) instead.\n"
      )
    );
    
    return KernelObjectFunctorialWithGivenKernelObjects(
             KernelObject( morphism_of_morphisms[1] ),
             morphism_of_morphisms[1], morphism_of_morphisms[2][1], morphism_of_morphisms[3],
             KernelObject( morphism_of_morphisms[3] ) );
    
end );

##
InstallMethod( KernelObjectFunctorialWithGivenKernelObjects,
               [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism,
                 IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
                                  
  function( s, alpha, mu, nu, alpha_prime, r )
    
    Print(
      Concatenation(
      "WARNING: KernelObjectFunctorialWithGivenKernelObjects( IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, ",
      "IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use KernelObjectFunctorialWithGivenKernelObjects( IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, ",
      "IsCapCategoryMorphism, IsCapCategoryObject ) instead.\n"
      )
    );
    
    return KernelObjectFunctorialWithGivenKernelObjects(
             s, alpha, mu, alpha_prime, r );
    
end );

####################################
##
## Cokernel
##
####################################

####################################
## Functorial operations
####################################

##
InstallMethod( CokernelObjectFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
    
    Print(
      Concatenation(
      "WARNING: CokernelObjectFunctorial( IsList ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use CokernelObjectFunctorial( IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ) instead.\n"
      )
    );
    
    return CokernelObjectFunctorialWithGivenCokernelObjects( 
           CokernelObject( morphism_of_morphisms[1] ),
           morphism_of_morphisms[1], morphism_of_morphisms[2][2], morphism_of_morphisms[3],
           CokernelObject( morphism_of_morphisms[3] ) );
    
end );

##
InstallMethod( CokernelObjectFunctorialWithGivenCokernelObjects,
               [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism,
                 IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( s, alpha, mu, nu, alpha_prime, r )
    
    Print(
      Concatenation(
      "WARNING: CokernelObjectFunctorialWithGivenCokernelObjects( IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, ",
      "IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use CokernelObjectFunctorialWithGivenCokernelObjects( IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, ",
      "IsCapCategoryMorphism, IsCapCategoryObject ) instead.\n"
      )
    );
    
    return CokernelObjectFunctorialWithGivenCokernelObjects(
             s, alpha, nu, alpha_prime, r );
    
end );

####################################
##
## Coproduct and Pushout
##
####################################

####################################
##
## Coproduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( Coproduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return Coproduct( CapCategory( object_1 ), [ object_1, object_2 ] );
    
end );

##
InstallMethod( Coproduct,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return Coproduct( CapCategory( object_1 ), [ object_1, object_2, object_3 ] );
    
end );

####################################
##
## Direct Product and FiberProduct
##
####################################

####################################
## Convenience methods
####################################


####################################
##
## Direct Product
##
####################################

####################################
## Convenience methods
####################################

##
# compatibility with GAP's DirectProduct function
InstallMethod( DirectProductOp,
               [ IsList, IsCapCategoryObject ],
               
  function( diagram, object )
    
    return DirectProductOp( CapCategory( object ), diagram );
    
end );

##
# compatibility with GAP's DirectProduct function
InstallMethod( DirectProductOp,
               [ IsList, IsCapCategory ],
               
  function( category_and_diagram, category )
    local diagram;
    
    diagram := category_and_diagram[2];
    
    return DirectProductOp( category, diagram );
    
end );

####################################
##
## Direct sum
##
####################################

####################################
## Technical methods
####################################

####################################
## Convenience methods
####################################

##
# compatibility with GAP's DirectSum function
InstallMethod( DirectSumOp,
               [ IsList, IsCapCategoryObject ],
               
  function( diagram, object )
    
    return DirectSumOp( CapCategory( object ), diagram );
    
end );

##
# compatibility with GAP's DirectSum function
InstallMethod( DirectSumOp,
               [ IsList, IsCapCategory ],
               
  function( category_and_diagram, category )
    local diagram;
    
    diagram := category_and_diagram[2];
    
    if not ( IsBound( category!.supports_empty_limits ) and category!.supports_empty_limits = true ) and diagram = [ ] then
        return ZeroObject( category );
    fi;
    
    return DirectSumOp( category, diagram );
    
end );

####################################
## Add methods
####################################


####################################
## Categorical methods
####################################

# convenience
##
InstallMethod( MorphismBetweenDirectSums,
               [ IsList ],
               
  function( morphism_matrix )
    local nr_rows, nr_cols;
    
    nr_rows := Size( morphism_matrix );
    
    if nr_rows = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    nr_cols := Size( morphism_matrix[1] );
    
    if nr_cols = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    return MorphismBetweenDirectSums( CapCategory( morphism_matrix[1,1] ),
             List( morphism_matrix, row -> Source( row[1] ) ),
             morphism_matrix,
             List( morphism_matrix[1], col -> Range( col ) )
           );
end );

# explicit error for backwards incompatibility
##
InstallOtherMethod( MorphismBetweenDirectSums,
               [ IsCapCategoryObject, IsList, IsCapCategoryObject ],
               
  function( S, morphism_matrix, T )
    
    Error(
      Concatenation(
      "MorphismBetweenDirectSums( IsCapCategoryObject, IsList, IsCapCategoryObject ) is not supported anymore. ",
      "Please use MorphismBetweenDirectSumsWithGivenDirectSums instead.\n"
      )
    );
    
end );

##
InstallMethod( MorphismBetweenDirectSums,
                                  [ IsList, IsInt, IsInt ],
                                  
  function( morphism_matrix_listlist, rows, cols )
    local morphism_matrix, i, diagram_direct_sum_source, diagram_direct_sum_range, test_diagram_product, test_diagram_coproduct, morphism_into_product;
    
    Print(
      Concatenation(
      "WARNING: MorphismBetweenDirectSums( IsList, IsInt, IsInt ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use MorphismBetweenDirectSums( IsList ) instead.\n"
      )
    );
    
    morphism_matrix := [ ];
    
    for i in [ 1 .. rows ] do
      
      Add( morphism_matrix, morphism_matrix_listlist{[(i-1)*cols + 1 .. i*cols]} );
      
    od;
    
    return MorphismBetweenDirectSums( morphism_matrix );
    
end );

####################################
##
## Zero Object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( ZeroObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    Print(
      Concatenation(
      "WARNING: ZeroObject( IsCapCategoryCell ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use ZeroObject( IsCapCategory ) instead.\n"
      )
    );
    
    return ZeroObject( CapCategory( cell ) );
    
end );

####################################
##
## Terminal Object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( TerminalObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    Print(
      Concatenation(
      "WARNING: TerminalObject( IsCapCategoryCell ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use TerminalObject( IsCapCategory ) instead.\n"
      )
    );
    
    return TerminalObject( CapCategory( cell ) );
    
end );

####################################
##
## Initial Object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( InitialObject,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    Print(
      Concatenation(
      "WARNING: InitialObject( IsCapCategoryCell ) is deprecated and will not be supported after 2022.03.18. ",
      "Please use InitialObject( IsCapCategory ) instead.\n"
      )
    );
    
    return InitialObject( CapCategory( cell ) );
    
end );

####################################
##
## Equalizer
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( Equalizer,
  
  function( arg )
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( EqualizerOp, arg );
        
    fi;
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return EqualizerOp( CapCategory( arg[1][1] ), arg[1] );
       
     fi;
    
    return EqualizerOp( CapCategory( arg[ 1 ] ), arg );
    
end );

####################################
##
## FiberProduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( FiberProduct,
  
  function( arg )
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( FiberProductOp, arg );
        
    fi;
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return FiberProductOp( CapCategory( arg[1][1] ), arg[1] );
       
     fi;
    
    return FiberProductOp( CapCategory( arg[ 1 ] ), arg );
    
end );

##
InstallGlobalFunction( UniversalMorphismIntoFiberProduct,

  function( arg )
    local diagram, source;
    
    if IsCapCategory( arg[1] ) then
        
        if Length( arg ) = 3 then
            
            return UniversalMorphismIntoFiberProductOp( arg[1], arg[2], Source( arg[3][1] ), arg[3] );
            
        else
            
            return CallFuncList( UniversalMorphismIntoFiberProductOp, arg );
            
        fi;
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoFiberProduct( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    fi;
    
    if Length( arg ) = 3
       and IsList( arg[1] )
       and IsCapCategoryObject( arg[2] )
       and IsList( arg[3] ) then
       
       return UniversalMorphismIntoFiberProduct( CapCategory( arg[1][1] ), arg[1], arg[2], arg[3] );
       
    fi;
    
    Print(
      Concatenation(
      "WARNING: UniversalMorphismIntoFiberProduct( diagram, mor1, mor2, ... ) is deprecated and will not be supported after 2022.04.15. ",
      "Please use UniversalMorphismIntoFiberProduct( diagram, [ mor1, mor2, ... ] ) instead.\n"
      )
    );
    
    diagram := arg[ 1 ];
    
    source := arg{[ 2 .. Length( arg ) ]};
    
    return UniversalMorphismIntoFiberProductOp( CapCategory( diagram[1] ), diagram, Source( source[1] ), source );
    
end );

####################################
##
## Coequalizer
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( Coequalizer,
  
  function( arg )
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( CoequalizerOp, arg );
        
    fi;
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return CoequalizerOp( CapCategory( arg[1][1] ), arg[1] );
       
     fi;
    
    return CoequalizerOp( CapCategory( arg[ 1 ] ), arg );
    
end );

####################################
##
## Pushout
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( Pushout,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( mor1, mor2 )
    
    return Pushout( CapCategory( mor1 ), [ mor1, mor2 ] );
    
end );

##
InstallGlobalFunction( UniversalMorphismFromPushout,

  function( arg )
    local diagram, sink;
    
    if IsCapCategory( arg[1] ) then

        if Length( arg ) = 3 then
            
            return UniversalMorphismFromPushoutOp( arg[1], arg[2], Range( arg[3][1] ), arg[3] );
            
        else
            
            return CallFuncList( UniversalMorphismFromPushoutOp, arg );
            
        fi;
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromPushout( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    fi;
    
    if Length( arg ) = 3
       and IsList( arg[1] )
       and IsCapCategoryObject( arg[2] )
       and IsList( arg[3] ) then
       
       return UniversalMorphismFromPushout( CapCategory( arg[1][1] ), arg[1], arg[2], arg[3] );
       
    fi;
    
    Print(
      Concatenation(
      "WARNING: UniversalMorphismFromPushout( diagram, mor1, mor2, ... ) is deprecated and will not be supported after 2022.04.15. ",
      "Please use UniversalMorphismFromPushout( diagram, [ mor1, mor2, ... ] ) instead.\n"
      )
    );
    
    diagram := arg[ 1 ];
    
    sink := arg{[ 2 .. Length( arg ) ]};
    
    return UniversalMorphismFromPushoutOp( CapCategory( diagram[1] ), diagram, Range( sink[1] ), sink );
    
end );

####################################
##
## Coimage
##
####################################

####################################
## Convenience methods
####################################

# deprecated legacy aliases
InstallDeprecatedAlias( "Coimage", "CoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "CoimageProjectionWithGivenCoimage", "CoimageProjectionWithGivenCoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "AstrictionToCoimageWithGivenCoimage", "AstrictionToCoimageWithGivenCoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "UniversalMorphismIntoCoimageWithGivenCoimage", "UniversalMorphismIntoCoimageWithGivenCoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "AddCoimage", "AddCoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "AddCoimageProjectionWithGivenCoimage", "AddCoimageProjectionWithGivenCoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "AddAstrictionToCoimageWithGivenCoimage", "AddAstrictionToCoimageWithGivenCoimageObject", "2023.03.29" );
InstallDeprecatedAlias( "AddUniversalMorphismIntoCoimageWithGivenCoimage", "AddUniversalMorphismIntoCoimageWithGivenCoimageObject", "2023.03.29" );

##
InstallMethod( MorphismFromCoimageToImage,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return MorphismFromCoimageToImageWithGivenObjects( CoimageObject( morphism ), morphism, ImageObject( morphism ) );
    
end );

##
InstallMethod( InverseMorphismFromCoimageToImage,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return InverseMorphismFromCoimageToImageWithGivenObjects( CoimageObject( morphism ), morphism, ImageObject( morphism ) );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    MorphismFromCoimageToImage :=
      [ [ "MorphismFromCoimageToImageWithGivenObjects", 1 ],
        [ "CoimageObject", 1 ],
        [ "ImageObject", 1 ] ],
    InverseMorphismFromCoimageToImage :=
      [ [ "InverseMorphismFromCoimageToImageWithGivenObjects", 1 ],
        [ "CoimageObject", 1 ],
        [ "ImageObject", 1 ] ],
  )
 );


####################################
##
## Homology object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( HomologyObjectFunctorial,
              [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
              
  function( alpha, beta, epsilon, gamma, delta )
    
    return HomologyObjectFunctorialWithGivenHomologyObjects(
      HomologyObject( alpha, beta ),
      [ alpha, beta, epsilon, gamma, delta ],
      HomologyObject( gamma, delta )
    );
    
end );

####################################
##
## Scheme for Universal Object
##
####################################

####################################
## Add Operations
####################################

####################################
## Attributes
####################################

####################################
## Implied Operations
####################################

