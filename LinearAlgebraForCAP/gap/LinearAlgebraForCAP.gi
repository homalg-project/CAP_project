#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Linear Algebra
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( MatrixCategory,
               [ IsFieldForHomalg ],
               
  function( homalg_field )
    local category;
    
    category := CreateCapCategory( Concatenation( "Category of matrices over ", RingName( homalg_field ) ) );
    
    category!.field_for_matrix_category := homalg_field;
    
    SetIsAbelianCategory( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY( category );
    
    ## TODO: Logic for MatrixCategory
    
    Finalize( category );
    
    return category;
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY,
  
  function( category )
    
    
    
end );