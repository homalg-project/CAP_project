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

##
InstallGlobalFunction( UniversalMorphismFromCoproduct,

  function( arg )
    local diagram;
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( UniversalMorphismFromCoproductOp, arg );
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromCoproductOp( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    diagram := List( arg, Source );
    
    return UniversalMorphismFromCoproductOp( CapCategory( diagram[1] ), diagram, arg );
  
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
InstallGlobalFunction( UniversalMorphismIntoDirectProduct,

  function( arg )
    local diagram;
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( UniversalMorphismIntoDirectProductOp, arg );
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoDirectProductOp( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    ##convenience: UniversalMorphismIntoDirectProduct( test_projection_1, ..., test_projection_k )
    diagram := List( arg, Range );
    
    return UniversalMorphismIntoDirectProductOp( CapCategory( diagram[1] ), diagram, arg );
  
end );

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
InstallGlobalFunction( UniversalMorphismFromDirectSum,

  function( arg )
    local diagram;
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( UniversalMorphismFromDirectSumOp, arg );
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromDirectSumOp( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    diagram := List( arg, Source );
    
    return UniversalMorphismFromDirectSumOp( CapCategory( diagram[1] ), diagram, arg );
  
end );

##
InstallGlobalFunction( UniversalMorphismIntoDirectSum,
               
  function( arg )
    local diagram;
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( UniversalMorphismIntoDirectSumOp, arg );
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoDirectSumOp( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    ##convenience: UniversalMorphismIntoDirectSum( test_projection_1, ..., test_projection_k )
    diagram := List( arg, Range );
    
    return UniversalMorphismIntoDirectSumOp( CapCategory( diagram[1] ), diagram, arg );
    
end );

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
    
    if diagram = [ ] then
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

##
InstallMethod( MorphismBetweenDirectSums,
               [ IsList ],
               
  function( morphism_matrix )
    local nr_rows, nr_cols;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    nr_rows := Size( morphism_matrix );
    
    if nr_rows = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    nr_cols := Size( morphism_matrix[1] );
    
    if nr_cols = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    return MorphismBetweenDirectSums( CapCategory( morphism_matrix[1,1] ), morphism_matrix );
    
end );

##
InstallOtherMethod( MorphismBetweenDirectSums,
               [ IsCapCategory, IsList ],
               
  function( cat, morphism_matrix )
    local nr_rows, nr_cols;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    nr_rows := Size( morphism_matrix );
    
    if nr_rows = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    nr_cols := Size( morphism_matrix[1] );
    
    if nr_cols = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    return MorphismBetweenDirectSums( cat,
             DirectSum( List( morphism_matrix, row -> Source( row[1] ) ) ),
             morphism_matrix,
             DirectSum( List( morphism_matrix[1], col -> Range( col ) ) )
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

##
InstallMethod( MorphismFromZeroObject,
               [ IsCapCategoryObject ],
               
   function( obj )
   
     return UniversalMorphismFromZeroObject( obj );
   
end );

##
InstallMethod( MorphismIntoZeroObject,
               [ IsCapCategoryObject ],
               
   function( obj )
   
     return UniversalMorphismIntoZeroObject( obj );
   
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
        
        return CallFuncList( UniversalMorphismIntoFiberProductOp, arg );
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoFiberProductOp( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    fi;
    
    diagram := arg[ 1 ];
    
    source := arg{[ 2 .. Length( arg ) ]};
    
    return UniversalMorphismIntoFiberProductOp( CapCategory( diagram[1] ), diagram, source );
    
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
        
        return CallFuncList( UniversalMorphismFromPushoutOp, arg );
        
    fi;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromPushoutOp( CapCategory( arg[1][1] ), arg[1], arg[2] );
       
    fi;
    
    diagram := arg[ 1 ];
    
    sink := arg{[ 2 .. Length( arg ) ]};
    
    return UniversalMorphismFromPushoutOp( CapCategory( diagram[1] ), diagram, sink );
    
end );

####################################
##
## Coimage
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( MorphismFromCoimageToImage,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return MorphismFromCoimageToImageWithGivenObjects( Coimage( morphism ), morphism, ImageObject( morphism ) );
    
end );

##
InstallMethod( InverseMorphismFromCoimageToImage,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return InverseMorphismFromCoimageToImageWithGivenObjects( Coimage( morphism ), morphism, ImageObject( morphism ) );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    MorphismFromCoimageToImage :=
      [ [ "MorphismFromCoimageToImageWithGivenObjects", 1 ],
        [ "Coimage", 1 ],
        [ "ImageObject", 1 ] ],
    InverseMorphismFromCoimageToImage :=
      [ [ "InverseMorphismFromCoimageToImageWithGivenObjects", 1 ],
        [ "Coimage", 1 ],
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

