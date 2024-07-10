# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

# read precompiled categories
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfColumns_as_Opposite_CategoryOfRows_Field_precompiled.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfColumns_as_Opposite_CategoryOfRows_CommutativeRing_precompiled.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfColumns_as_Opposite_CategoryOfRows_HomalgExteriorRingOverField_precompiled.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfColumns_as_Opposite_CategoryOfRows_ArbitraryRing_precompiled.gi" );

####################################
##
## Constructors
##
####################################

##
InstallMethod( CategoryOfColumns,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local cat;
    
    cat := CategoryOfColumns_as_Opposite_CategoryOfRows( homalg_ring : FinalizeCategory := false );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
            
            ADD_FUNCTIONS_FOR_CategoryOfColumns_as_Opposite_CategoryOfRows_Field_precompiled( cat );
            
        elif HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
            
            ADD_FUNCTIONS_FOR_CategoryOfColumns_as_Opposite_CategoryOfRows_CommutativeRing_precompiled( cat );
            
        elif HasIsExteriorRing( homalg_ring ) and IsExteriorRing( homalg_ring ) and IsField( BaseRing( homalg_ring ) ) then
            
            ADD_FUNCTIONS_FOR_CategoryOfColumns_as_Opposite_CategoryOfRows_HomalgExteriorRingOverField_precompiled( cat );
            
        else
            
            ADD_FUNCTIONS_FOR_CategoryOfColumns_as_Opposite_CategoryOfRows_ArbitraryRing_precompiled( cat );
            
        fi;
        
    fi;
    
    Finalize( cat );
    
    return cat;
    
end );

##
InstallOtherMethod( CategoryOfColumnsObject,
                    [ IsInt, IsCategoryOfColumns ],
               
  function( rank, category )
    
    return CategoryOfColumnsObject( category, rank );
    
end );

##
InstallMethodForCompilerForCAP( CategoryOfColumnsObjectOp,
                                [ IsCategoryOfColumns, IsInt ],
               
  function( cat, rank )
    
    if not IsInt( rank ) or rank < 0 then
        
        Error( "the object datum must be a non-negative integer" );
        
    fi;
    
    return CreateCapCategoryObjectWithAttributes( cat,
                                                  RankOfObject, rank );
    
end );

##
InstallMethod( AsCategoryOfColumnsMorphism,
               [ IsHomalgMatrix, IsCategoryOfColumns ],
               
  function( homalg_matrix, category )
    
    return AsCategoryOfColumnsMorphism( category, homalg_matrix );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsCategoryOfColumnsMorphism,
               [ IsCategoryOfColumns, IsHomalgMatrix ],
               
  function( category, homalg_matrix )
    local source, range;
    
    source := CategoryOfColumnsObject( category, NrColumns( homalg_matrix ) );
    
    range := CategoryOfColumnsObject( category, NrRows( homalg_matrix ) );
    
    return CategoryOfColumnsMorphism( category, source, homalg_matrix, range );
    
end );

##
InstallMethod( CategoryOfColumnsMorphism,
               [ IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ],
               
  function( source, homalg_matrix, range )
    
    return CategoryOfColumnsMorphism( CapCategory( source ), source, homalg_matrix, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( CategoryOfColumnsMorphism,
                                     [ IsCategoryOfColumns, IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ],
                                     
  function( cat, source, homalg_matrix, range )
    
    if not IsHomalgMatrix( homalg_matrix ) then
        
        Error( "the morphism datum must be a homalg matrix" );
        
    fi;
    
    if not IsIdenticalObj( HomalgRing( homalg_matrix ), UnderlyingRing( cat ) ) then
        
        Error( "the matrix is defined over a different ring than the category" );
        
    fi;
    
    if NrColumns( homalg_matrix ) <> RankOfObject( source ) then
        
        Error( "the number of columns has to be equal to the dimension of the source" );
        
    fi;
    
    if NrRows( homalg_matrix ) <> RankOfObject( range ) then
        
        Error( "the number of rows has to be equal to the dimension of the range" );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( cat,
                                                    source,
                                                    range,
                                                    UnderlyingMatrix, homalg_matrix );
    
end );

####################################
##
## Attributes
##
####################################

## "1 round of ByASmallerPresentation"
##
InstallMethod( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple,
               [ IsCategoryOfColumnsMorphism ],
               
  function( alpha )
    local M, cols, R, T, TI, U, UI, S;
    
    M := UnderlyingMatrix( alpha );
    
    cols := CapCategory( alpha );
    
    R := UnderlyingRing( cols );
    
    ## homalg's recipe:
    ## 1) OnLessGenerators
    ## 2) if no improvement in terms of number of generators, then:
    ##  2.1) BasisOfModule
    ##  2.2) OnLessGenerators
    
    T := HomalgVoidMatrix( R );
    
    TI := HomalgVoidMatrix( R );
    
    S := SimplerEquivalentMatrix( M, T, TI, "", "", "" );
    
    if NrRows( S ) = RankOfObject( Range( alpha ) ) then
      
      S := BasisOfColumnModule( S );
      
      U := HomalgVoidMatrix( R );
    
      UI := HomalgVoidMatrix( R );
      
      S := SimplerEquivalentMatrix( S, U, UI, "", "", "" );
      
      T := U * T;
      
      TI := TI * UI;
      
    fi;
    
    ## add the following line to homalg's recipe in order to minimize the number of relations
    S := ReducedBasisOfColumnModule( S );
    
    return [ S, T, TI ];
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsCategoryOfColumnsMorphism ],
               
  function( category_of_columns_morphism )
    
    # source
    Print( "Source: \n" );
    Display( Source( category_of_columns_morphism ) );
    
    # mapping matrix
    Print( Concatenation( "\n", "Matrix: \n" ) );
    Display( UnderlyingMatrix( category_of_columns_morphism ) );
    
    # range
    Print( Concatenation( "\n", "Range: \n" ) );
    Display( Range( category_of_columns_morphism ) );
    Print( "\n" );
    
    # general information on morphism
    Display( StringMutable( category_of_columns_morphism ) );
    
end );

##
InstallMethod( String,
              [ IsCategoryOfColumnsObject ],
              
  function( category_of_columns_object )
    
    return Concatenation( "A column module over ",
                          RingName( UnderlyingRing( CapCategory( category_of_columns_object ) ) ),
                          " of rank ", String( RankOfObject( category_of_columns_object ) ) );
    
end );
##
InstallMethod( ViewString,
               [ IsCategoryOfColumnsObject ],

  function( category_of_columns_object )

    return Concatenation( "<", String( category_of_columns_object ), ">" );

end );

##
InstallMethod( Display,
               [ IsCategoryOfColumnsObject ],
               
  function( category_of_columns_object )
    
    Display( String( category_of_columns_object ) );
    
end );

####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
               [ IsHomalgMatrix, IsCategoryOfColumns ],
               AsCategoryOfColumnsMorphism
);

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsCategoryOfColumnsObject ],
  function( obj )
    
    return RankOfObject( obj );
    
end );

##
InstallMethod( DownOnlyMorphismData,
               [ IsCategoryOfColumnsMorphism ],
  function( mor )
    
    return UnderlyingMatrix( mor );
    
end );
