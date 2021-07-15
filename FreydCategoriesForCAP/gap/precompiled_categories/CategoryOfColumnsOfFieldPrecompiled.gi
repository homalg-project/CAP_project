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
function ( cat, morphism_1, morphism_2 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( morphism_1 ), Range( morphism_2 ), UnderlyingMatrix, UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat, morphism )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( morphism ), Range( morphism ), UnderlyingMatrix, - UnderlyingMatrix( morphism ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat, S, T )
    return List( [ 1 .. RankOfObject( S ) * RankOfObject( T ) ], function ( logic_new_func_20232_x )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat, S, T, UnderlyingMatrix, ConvertColumnToMatrix( CertainColumns( HomalgIdentityMatrix( RankOfObject( S ) * RankOfObject( T ), UnderlyingRing( cat ) ), [ logic_new_func_20232_x ] ), RankOfObject( T ), RankOfObject( S ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat, morphism )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, RankOfObject, NumberRows( UnderlyingMatrix( morphism ) ) - ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat, morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Range( morphism ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat, RankOfObject, NrRows( cap_jit_morphism_attribute ) ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Range( alpha ), Range( beta ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat, object_list )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, RankOfObject, Sum( List( object_list, function ( object )
                return RankOfObject( object );
            end ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat, object )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, object, object, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( object ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat, alpha, beta )
    return IsZero( DecideZeroRows( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat, morphism_1, morphism_2 )
    return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat, object_1, object_2 )
    return RankOfObject( object_1 ) = RankOfObject( object_2 );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat, alpha, beta )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat, morphism )
    if not true then
        return false;
    elif NumberColumns( UnderlyingMatrix( morphism ) ) <> RankOfObject( Source( morphism ) ) then
        return false;
    elif NumberRows( UnderlyingMatrix( morphism ) ) <> RankOfObject( Range( morphism ) ) then
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
function ( cat, object )
    if not true then
        return false;
    elif RankOfObject( object ) < 0 then
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
function ( cat, morphism )
    return IsZero( UnderlyingMatrix( morphism ) );
end
########
        
    );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat, object )
    return RankOfObject( object ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat, morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat, RankOfObject, NrColumns( cap_jit_morphism_attribute ) ), Source( morphism ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat, morphism )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, RankOfObject, NumberColumns( UnderlyingMatrix( morphism ) ) - ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( alpha ), Source( beta ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat, morphism_1, morphism_2 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( morphism_1 ), Range( morphism_2 ), UnderlyingMatrix, UnderlyingMatrix( morphism_2 ) * UnderlyingMatrix( morphism_1 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, diagram, test_object, sink, coproduct )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, coproduct, test_object, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat ), RankOfObject( test_object ), List( sink, UnderlyingMatrix ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, source, zero_object )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, zero_object, source, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( source ), 0, UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, diagram, test_object, sink, direct_sum )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, test_object, direct_sum, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat ), RankOfObject( test_object ), List( sink, UnderlyingMatrix ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, sink, zero_object )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, sink, zero_object, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( sink ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat, source, range )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, source, range, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( range ), RankOfObject( source ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, RankOfObject, 0 );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
