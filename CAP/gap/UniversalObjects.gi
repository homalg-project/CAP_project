#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Universal Objects
##
#############################################################################


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
    
    return KernelObjectFunctorialWithGivenKernelObjects(
             KernelObject( morphism_of_morphisms[1] ),
             morphism_of_morphisms[1], morphism_of_morphisms[2][1], morphism_of_morphisms[3],
             KernelObject( morphism_of_morphisms[3] ) );
    
end );

##
InstallMethod( KernelObjectFunctorial,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( alpha, mu, alpha_prime )
    
    return KernelObjectFunctorialWithGivenKernelObjects( KernelObject( alpha ), alpha, mu, alpha_prime, KernelObject( alpha_prime ) );
    
end );

##
InstallMethod( KernelObjectFunctorialWithGivenKernelObjects,
               [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism,
                 IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
                                  
  function( s, alpha, mu, nu, alpha_prime, r )
    
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
    
    return CokernelObjectFunctorialWithGivenCokernelObjects( 
           CokernelObject( morphism_of_morphisms[1] ),
           morphism_of_morphisms[1], morphism_of_morphisms[2][2], morphism_of_morphisms[3],
           CokernelObject( morphism_of_morphisms[3] ) );
    
end );

##
InstallMethod( CokernelObjectFunctorial,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( alpha, nu, alpha_prime )
    
    return CokernelObjectFunctorialWithGivenCokernelObjects( CokernelObject( alpha ), alpha, nu, alpha_prime, CokernelObject( alpha_prime ) );
    
end );

##
InstallMethod( CokernelObjectFunctorialWithGivenCokernelObjects,
               [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism,
                 IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
               
  function( s, alpha, mu, nu, alpha_prime, r )
    
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
               [ IsList ],
               
  function( diagram )
    
    return CoproductOp( diagram, diagram[1] );
    
end );

##
InstallMethod( Coproduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CoproductOp( [ object_1, object_2 ], object_1 );
    
end );

##
InstallMethod( Coproduct,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CoproductOp( [ object_1, object_2, object_3 ], object_1 );
    
end );


##
InstallGlobalFunction( UniversalMorphismFromCoproduct,

  function( arg )
    local diagram;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromCoproductOp( arg[1], arg[2], arg[1][1] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    diagram := List( arg, Source );
    
    return UniversalMorphismFromCoproductOp( diagram, arg, diagram[1] );
  
end );

####################################
## Categorical methods
####################################

##
InstallMethod( InjectionOfCofactorOfCoproduct,
               [ IsList, IsInt ],
               
  function( object_product_list, injection_number )
    
    return InjectionOfCofactorOfCoproductOp( object_product_list, injection_number, object_product_list[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( CoproductFunctorial,
               [ IsList ],
               
  function( morphism_list )
    
    return CoproductFunctorialWithGivenCoproducts(
             Coproduct( List( morphism_list, Source ) ),
             morphism_list,
             Coproduct( List( morphism_list, Range ) )
           );
    
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
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoDirectProductOp( arg[1], arg[2], arg[1][1] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    ##convenience: UniversalMorphismIntoDirectProduct( test_projection_1, ..., test_projection_k )
    diagram := List( arg, Range );
    
    return UniversalMorphismIntoDirectProductOp( diagram, arg, diagram[1] );
  
end );

####################################
## Categorical methods
####################################

##
InstallMethod( ProjectionInFactorOfDirectProduct,
               [ IsList, IsInt ],
               
  function( object_product_list, projection_number )
    
    return ProjectionInFactorOfDirectProductOp( object_product_list, projection_number, object_product_list[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( DirectProductFunctorial,
               [ IsList ],
                         
  function( morphism_list )
    
    return DirectProductFunctorialWithGivenDirectProducts(
             DirectProduct( List( morphism_list, Source ) ),
             morphism_list,
             DirectProduct( List( morphism_list, Range ) ) );
    
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
InstallMethod( ProjectionInFactorOfDirectSum,
               [ IsList, IsInt ],
               
  function( diagram, projection_number )
    
    return ProjectionInFactorOfDirectSumOp( diagram, projection_number, diagram[1] );
    
end );

##
InstallMethod( InjectionOfCofactorOfDirectSum,
               [ IsList, IsInt ],
               
  function( diagram, injection_number )
    
    return InjectionOfCofactorOfDirectSumOp( diagram, injection_number, diagram[1] );
    
end );

##
InstallGlobalFunction( UniversalMorphismFromDirectSum,

  function( arg )
    local diagram;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromDirectSumOp( arg[1], arg[2], arg[1][1] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    diagram := List( arg, Source );
    
    return UniversalMorphismFromDirectSumOp( diagram, arg, diagram[1] );
  
end );

##
InstallGlobalFunction( UniversalMorphismIntoDirectSum,
               
  function( arg )
    local diagram;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoDirectSumOp( arg[1], arg[2], arg[1][1] );
       
    elif Length( arg ) = 1 and IsList( arg[ 1 ] ) then
        arg := arg[ 1 ];
    fi;
    
    ##convenience: UniversalMorphismIntoDirectSum( test_projection_1, ..., test_projection_k )
    diagram := List( arg, Range );
    
    return UniversalMorphismIntoDirectSumOp( diagram, arg, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromDirectProductToDirectSum,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromDirectProductToDirectSumOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromDirectSumToDirectProduct,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromDirectSumToDirectProductOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromCoproductToDirectSum,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromCoproductToDirectSumOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromDirectSumToCoproduct,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromDirectSumToCoproductOp( diagram, diagram[1] );
    
end );

##
InstallMethod( DirectSumOp,
               [ IsList, IsCapCategory ],
               
  function( category_and_diagram, category )
    local diagram;
    
    diagram := category_and_diagram[2];
    
    if diagram = [ ] then
        return ZeroObject( category );
    fi;
    
    return DirectSumOp( diagram, diagram[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( DirectSumFunctorial,
               [ IsList ],
               
  function( diagram )
    
    return DirectSumFunctorialWithGivenDirectSums(
             DirectSum( List( diagram, Source ) ), diagram, DirectSum( List( diagram, Range ) )
           );
    
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
    
    nr_rows := Size( morphism_matrix );
    
    if nr_rows = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    nr_cols := Size( morphism_matrix[1] );
    
    if nr_cols = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    return MorphismBetweenDirectSums(
             DirectSum( List( morphism_matrix, row -> Source( row[1] ) ) ),
             morphism_matrix,
             DirectSum( List( morphism_matrix[1], col -> Range( col ) ) )
           );
    
end );

## TODO: is this deprecated?
##
InstallMethodWithCacheFromObject( MorphismBetweenDirectSumsOp,
                                  [ IsList, IsInt, IsInt, IsCapCategoryMorphism ],
                                  
  function( morphism_matrix_listlist, rows, cols, caching_object )
    local morphism_matrix, i, diagram_direct_sum_source, diagram_direct_sum_range, test_diagram_product, test_diagram_coproduct, morphism_into_product;
    
    morphism_matrix := [ ];
    
    for i in [ 1 .. rows ] do
      
      Add( morphism_matrix, morphism_matrix_listlist{[(i-1)*cols + 1 .. i*cols]} );
      
    od;
    
    return MorphismBetweenDirectSums( morphism_matrix );
    
end: ArgumentNumber := 4 );

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
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return EqualizerOp( arg[1], arg[1][1] );
       
     fi;
    
    return EqualizerOp( arg, arg[ 1 ] );
    
end );

##
InstallMethod( EmbeddingOfEqualizer,
               [ IsList ],
               
  function( diagram )
    
    return EmbeddingOfEqualizerOp( diagram, diagram[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( EqualizerFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return EqualizerFunctorialWithGivenEqualizers(
               Equalizer( morphism_of_morphisms[1] ),
               morphism_of_morphisms,
               Equalizer( morphism_of_morphisms[3] )
             );
      
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
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return FiberProductOp( arg[1], arg[1][1] );
       
     fi;
    
    return FiberProductOp( arg, arg[ 1 ] );
    
end );

##
InstallMethod( ProjectionInFactorOfFiberProduct,
               [ IsList, IsInt ],
               
  function( diagram, projection_number )
    
    return ProjectionInFactorOfFiberProductOp( diagram, projection_number, diagram[1] );
    
end );

##
InstallGlobalFunction( UniversalMorphismIntoFiberProduct,

  function( arg )
    local diagram, source;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismIntoFiberProductOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    diagram := arg[ 1 ];
    
    source := arg{[ 2 .. Length( arg ) ]};
    
    return UniversalMorphismIntoFiberProductOp( diagram, source, diagram[1] );
    
end );

##
InstallMethod( DirectSumDiagonalDifference,
               [ IsList ],
               
  function( diagram )
    
    return DirectSumDiagonalDifferenceOp( diagram, diagram[1] );
    
end );

##
InstallMethod( FiberProductEmbeddingInDirectSum,
               [ IsList ],
               
  function( diagram )
    
    return FiberProductEmbeddingInDirectSumOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromFiberProductToKernelOfDiagonalDifference,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromFiberProductToKernelOfDiagonalDifferenceOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromKernelOfDiagonalDifferenceToFiberProductOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromFiberProductToEqualizerOfDirectProductDiagramOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromEqualizerOfDirectProductDiagramToFiberProductOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromPushoutToCokernelOfDiagonalDifference,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromPushoutToCokernelOfDiagonalDifferenceOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromCokernelOfDiagonalDifferenceToPushout,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromCokernelOfDiagonalDifferenceToPushoutOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromPushoutToCoequalizerOfCoproductDiagramOp( diagram, diagram[1] );
    
end );

##
InstallMethod( IsomorphismFromCoequalizerOfCoproductDiagramToPushout,
               [ IsList ],
               
  function( diagram )
    
    return IsomorphismFromCoequalizerOfCoproductDiagramToPushoutOp( diagram, diagram[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( FiberProductFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return FiberProductFunctorialWithGivenFiberProducts(
               FiberProduct( List( morphism_of_morphisms, elem -> elem[1] ) ),
               morphism_of_morphisms,
               FiberProduct( List( morphism_of_morphisms, elem -> elem[3] ) )
             );
      
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
    
    if Length( arg ) = 1
       and IsList( arg[1] )
       and ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return CoequalizerOp( arg[1], arg[1][1] );
       
     fi;
    
    return CoequalizerOp( arg, arg[ 1 ] );
    
end );

##
InstallMethod( ProjectionOntoCoequalizer,
               [ IsList ],
               
  function( diagram )
    
    return ProjectionOntoCoequalizerOp( diagram, diagram[1] );
    
end );

####################################
## Functorial operations
####################################

##
InstallMethod( CoequalizerFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return CoequalizerFunctorialWithGivenCoequalizers(
               Coequalizer( morphism_of_morphisms[1] ),
               morphism_of_morphisms,
               Coequalizer( morphism_of_morphisms[3] )
             );
      
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
               [ IsList ],
                
  function( diagram )
    
    return PushoutOp( diagram, diagram[1] );
    
end );

##
InstallMethod( Pushout,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( mor1, mor2 )
    
    return PushoutOp( [ mor1, mor2 ], mor1 );
    
end );

##
InstallMethod( InjectionOfCofactorOfPushout,
               [ IsList, IsInt ],
               
  function( diagram, injection_number )
    
    return InjectionOfCofactorOfPushoutOp( diagram, injection_number, diagram[1] );
    
end );

##
InstallGlobalFunction( UniversalMorphismFromPushout,

  function( arg )
    local diagram, sink;
    
    if Length( arg ) = 2
       and IsList( arg[1] )
       and IsList( arg[2] ) then
       
       return UniversalMorphismFromPushoutOp( arg[1], arg[2], arg[1][1] );
       
    fi;
    
    diagram := arg[ 1 ];
    
    sink := arg{[ 2 .. Length( arg ) ]};
    
    return UniversalMorphismFromPushoutOp( diagram, sink, diagram[1] );
    
end );

##
InstallMethod( DirectSumCodiagonalDifference,
               [ IsList ],
               
  function( diagram )
    
    return DirectSumCodiagonalDifferenceOp( diagram, diagram[1] );
    
end );

##
InstallMethod( DirectSumProjectionInPushout,
               [ IsList ],
               
  function( diagram )
    
    return DirectSumProjectionInPushoutOp( diagram, diagram[1] );
    
end );


####################################
## Functorial operations
####################################

##
InstallMethod( PushoutFunctorial,
               [ IsList ],
               
  function( morphism_of_morphisms )
      
      return PushoutFunctorialWithGivenPushouts( 
               Pushout( List( morphism_of_morphisms, elem -> elem[1] ) ),
               morphism_of_morphisms,
               Pushout( List( morphism_of_morphisms, elem -> elem[3] ) )
             );
      
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

####################################
## Subobject Classifier
####################################

##
InstallMethod( SubobjectClassifier,
               [ IsCapCategoryCell ],
               
  function( cell )
    
    return SubobjectClassifier( CapCategory( cell ) );
    
end );

##
InstallMethod( TruthMorphismIntoSubobjectClassifier,
               [ IsCapCategory ],
  function( category )
      
      return TruthMorphismIntoSubobjectClassifierWithGivenObjects(
               TerminalObject(category),
               SubobjectClassifier(category)
             );
      
end );

##
InstallMethod( TruthMorphismIntoSubobjectClassifier,
               [ IsCapCategoryCell ],
  function( cell )
    
    return TruthMorphismIntoSubobjectClassifier( CapCategory( cell ) );
    
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

