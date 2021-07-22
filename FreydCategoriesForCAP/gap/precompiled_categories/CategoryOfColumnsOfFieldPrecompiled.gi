# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "CategoryOfColumnsOfFieldPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return CategoryOfColumns( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false );
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, morphism_1_1, morphism_2_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( morphism_1_1 ), Range( morphism_2_1 ), UnderlyingMatrix, UnderlyingMatrix( morphism_1_1 ) + UnderlyingMatrix( morphism_2_1 ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, morphism_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( morphism_1 ), Range( morphism_1 ), UnderlyingMatrix, - UnderlyingMatrix( morphism_1 ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, S_1, T_1 )
    return List( [ 1 .. RankOfObject( S_1 ) * RankOfObject( T_1 ) ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, S_1, T_1, UnderlyingMatrix, ConvertColumnToMatrix( CertainColumns( HomalgIdentityMatrix( RankOfObject( S_1 ) * RankOfObject( T_1 ), UnderlyingRing( cat_1 ) ), [ logic_new_func_x_2 ] ), RankOfObject( T_1 ), RankOfObject( S_1 ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, morphism_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberRows( UnderlyingMatrix( morphism_1 ) ) - ColumnRankOfMatrix( UnderlyingMatrix( morphism_1 ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, morphism_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfRows( UnderlyingMatrix( morphism_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( morphism_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, object_list_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, Sum( List( object_list_1, function ( object_2 )
                return RankOfObject( object_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, object_1, object_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( object_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, morphism_1_1, morphism_2_1 )
    return UnderlyingMatrix( morphism_1_1 ) = UnderlyingMatrix( morphism_2_1 );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, object_1_1, object_2_1 )
    return RankOfObject( object_1_1 ) = RankOfObject( object_2_1 );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, morphism_1 )
    if not true then
        return false;
    elif NumberColumns( UnderlyingMatrix( morphism_1 ) ) <> RankOfObject( Source( morphism_1 ) ) then
        return false;
    elif NumberRows( UnderlyingMatrix( morphism_1 ) ) <> RankOfObject( Range( morphism_1 ) ) then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, object_1 )
    if not true then
        return false;
    elif RankOfObject( object_1 ) < 0 then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsZeroForMorphisms( cat,
        
########
function ( cat_1, morphism_1 )
    return IsZero( UnderlyingMatrix( morphism_1 ) );
end
########
        
    );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, object_1 )
    return RankOfObject( object_1 ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, morphism_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfColumns( UnderlyingMatrix( morphism_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1 ) ), Source( morphism_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, morphism_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberColumns( UnderlyingMatrix( morphism_1 ) ) - ColumnRankOfMatrix( UnderlyingMatrix( morphism_1 ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, morphism_1_1, morphism_2_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( morphism_1_1 ), Range( morphism_2_1 ), UnderlyingMatrix, UnderlyingMatrix( morphism_2_1 ) * UnderlyingMatrix( morphism_1_1 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, diagram_1, test_object_1, sink_1, coproduct_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, coproduct_1, test_object_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), RankOfObject( test_object_1 ), List( sink_1, UnderlyingMatrix ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, source_1, zero_object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, zero_object_1, source_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( source_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, diagram_1, test_object_1, sink_1, direct_sum_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, test_object_1, direct_sum_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), RankOfObject( test_object_1 ), List( sink_1, UnderlyingMatrix ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, sink_1, zero_object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, sink_1, zero_object_1, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( sink_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, source_1, range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, source_1, range_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( range_1 ), RankOfObject( source_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, 0 );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
