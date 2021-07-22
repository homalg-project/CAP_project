# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "OppositeOfCategoryOfRowsOfFieldPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return CategoryOfColumnsAsOppositeOfCategoryOfRows( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false );
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat, a, b )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( a ), Range, Range( a ), UnderlyingMatrix, UnderlyingMatrix( a ) + UnderlyingMatrix( b ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat, a )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( a ), Range, Range( a ), UnderlyingMatrix, - UnderlyingMatrix( a ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat, arg2, arg3 )
    return List( [ 1 .. RankOfObject( arg3 ) * RankOfObject( arg2 ) ], function ( logic_new_func_30687_x )
            return ObjectifyWithAttributes( rec(
                   ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
                     ), ObjectType( cat ), CapCategory, cat, RankOfObject, RankOfObject( arg2 ) ), Range, ObjectifyWithAttributes( rec(
                     ), ObjectType( cat ), CapCategory, cat, RankOfObject, RankOfObject( arg3 ) ), UnderlyingMatrix, ConvertRowToMatrix( CertainRows( HomalgIdentityMatrix( RankOfObject( arg3 ) * RankOfObject( arg2 ), UnderlyingRing( cat ) ), [ logic_new_func_30687_x ] ), RankOfObject( arg3 ), RankOfObject( arg2 ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, RankOfObject, NumberRows( UnderlyingMatrix( arg2 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2 ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat, alpha )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfRows( UnderlyingMatrix( alpha ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, RankOfObject, NrRows( cap_jit_morphism_attribute ) ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, Range( beta ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, RankOfObject, Sum( List( arg2, function ( logic_new_func_31066_x )
                return RankOfObject( logic_new_func_31066_x );
            end ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat, a )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, a, Range, a, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat, arg2, arg3 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3 ), UnderlyingMatrix( arg2 ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat, arg2, arg3 )
    return UnderlyingMatrix( arg2 ) = UnderlyingMatrix( arg3 );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat, arg2, arg3 )
    return RankOfObject( arg2 ) = RankOfObject( arg3 );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat, arg2, arg3 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2 ), UnderlyingMatrix( arg3 ) ) );
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat, arg2 )
    return function (  )
            if not true then
                return false;
            elif NumberRows( UnderlyingMatrix( arg2 ) ) <> RankOfObject( Range( arg2 ) ) then
                return false;
            elif NumberColumns( UnderlyingMatrix( arg2 ) ) <> RankOfObject( Source( arg2 ) ) then
                return false;
            else
                return true;
            fi;
            return;
        end(  );
end
########
        
    );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat, arg2 )
    return function (  )
            if not true then
                return false;
            elif RankOfObject( arg2 ) < 0 then
                return false;
            else
                return true;
            fi;
            return;
        end(  );
end
########
        
    );
    
    ##
    AddIsZeroForMorphisms( cat,
        
########
function ( cat, arg2 )
    return IsZero( UnderlyingMatrix( arg2 ) );
end
########
        
    );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat, arg2 )
    return RankOfObject( arg2 ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat, alpha )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfColumns( UnderlyingMatrix( alpha ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, RankOfObject, NrColumns( cap_jit_morphism_attribute ) ), Range, Source( alpha ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, RankOfObject, NumberColumns( UnderlyingMatrix( arg2 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2 ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Source( beta ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Range( beta ), UnderlyingMatrix, UnderlyingMatrix( beta ) * UnderlyingMatrix( alpha ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, T, tau, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, P, Range, T, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat ), RankOfObject( T ), List( tau, function ( logic_new_func_32163_x )
                return UnderlyingMatrix( logic_new_func_32163_x );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, T, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, P, Range, T, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( T ), 0, UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, T, tau, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, T, Range, P, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat ), RankOfObject( T ), List( tau, function ( logic_new_func_32335_x )
                return UnderlyingMatrix( logic_new_func_32335_x );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, T, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, T, Range, P, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( T ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat, a, b )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, a, Range, b, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( b ), RankOfObject( a ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, RankOfObject, 0 );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
