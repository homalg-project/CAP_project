# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "OppositeOfMatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return Opposite( MATRIX_CATEGORY( field : FinalizeCategory := true,
          enable_compilation := false ) );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false );
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat, a, b )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( a ), Range( a ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Source( Opposite( a ) ), Range( Opposite( b ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnderlyingMatrix( Opposite( a ) ) + UnderlyingMatrix( Opposite( b ) ) ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat, a )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( a ), Range( a ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Source( Opposite( a ) ), Range( Opposite( a ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, -1 * UnderlyingMatrix( Opposite( a ) ) ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat, arg2, arg3 )
    return List( [ 1 .. Dimension( Opposite( arg3 ) ) * Dimension( Opposite( arg2 ) ) ], function ( logic_new_func_40513_x )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat, Opposite, Opposite( arg2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat, Opposite, Opposite( arg3 ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), Opposite( cat ), Opposite( arg3 ), Opposite( arg2 ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, ConvertRowToMatrix( CertainRows( HomalgIdentityMatrix( Dimension( Opposite( arg3 ) ) * Dimension( Opposite( arg2 ) ), UnderlyingFieldForHomalg( Opposite( arg3 ) ) ), [ logic_new_func_40513_x ] ), Dimension( Opposite( arg3 ) ), Dimension( Opposite( arg2 ) ) ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), Opposite( cat ), Dimension, NumberRows( UnderlyingMatrix( Opposite( arg2 ) ) ) - RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat, alpha )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Range( alpha ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), Opposite( cat ), Dimension, NumberRows( SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), ObjectifyObjectForCAPWithAttributes( rec(
               ), Opposite( cat ), Dimension, NumberRows( SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), Source( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Range( alpha ), Range( beta ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Source( Opposite( beta ) ), Source( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( Opposite( beta ) ), UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat, arg2 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), Opposite( cat ), Dimension, Sum( List( arg2, function ( logic_new_func_40868_x )
                  return Dimension( Opposite( logic_new_func_40868_x ) );
              end ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), Opposite( cat ), Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat, A )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat, Opposite, Opposite( A ) ), A, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( A ), Opposite( A ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( A ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat, arg2, arg3 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), Opposite( cat ), Dimension, Dimension( Opposite( arg3 ) ) * Dimension( Opposite( arg2 ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat, a )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, a, a, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( a ), Opposite( a ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( a ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, k, P )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, objects[k], P, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( P ), Opposite( objects[k] ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( List( objects, function ( x )
                        return Opposite( x );
                    end ){[ 1 .. k - 1 ]}, function ( c )
                    return Dimension( c );
                end ), Dimension( Opposite( objects[k] ) ), UnderlyingRing( Opposite( cat ) ) ), HomalgIdentityMatrix( Dimension( Opposite( objects[k] ) ), UnderlyingRing( Opposite( cat ) ) ), HomalgZeroMatrix( Sum( List( objects, function ( x )
                        return Opposite( x );
                    end ){[ k + 1 .. Length( List( objects, function ( x )
                             return Opposite( x );
                         end ) ) ]}, function ( c )
                    return Dimension( c );
                end ), Dimension( Opposite( objects[k] ) ), UnderlyingRing( Opposite( cat ) ) ) ) ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat, arg2 )
    return ID_FUNC( ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), ObjectifyObjectForCAPWithAttributes( rec(
               ), Opposite( cat ), Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), ObjectifyObjectForCAPWithAttributes( rec(
               ), Opposite( cat ), Dimension, NumberColumns( ConvertMatrixToRow( UnderlyingMatrix( Opposite( arg2 ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, ConvertMatrixToRow( UnderlyingMatrix( Opposite( arg2 ) ) ) ) );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat, arg2, arg3 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( Opposite( arg3 ) ), UnderlyingMatrix( Opposite( arg2 ) ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat, arg2, arg3 )
    return UnderlyingMatrix( Opposite( arg2 ) ) = UnderlyingMatrix( Opposite( arg3 ) );
end
########
        
    );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat, arg2 )
    return RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ) = Dimension( Source( Opposite( arg2 ) ) );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForMorphisms( cat,
        
########
function ( cat, arg2, arg3 )
    return IS_IDENTICAL_OBJ( Opposite( arg2 ), Opposite( arg3 ) );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForObjects( cat,
        
########
function ( cat, arg2, arg3 )
    return IS_IDENTICAL_OBJ( Opposite( arg2 ), Opposite( arg3 ) );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat, arg2, arg3 )
    return Dimension( Opposite( arg2 ) ) = Dimension( Opposite( arg3 ) );
end
########
        
    );
    
    ##
    AddIsInjective( cat,
        
########
function ( cat, arg2 )
    return true;
end
########
        
    );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat, arg2 )
    return Dimension( Range( Opposite( arg2 ) ) ) = Dimension( Source( Opposite( arg2 ) ) ) and ColumnRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ) = Dimension( Range( Opposite( arg2 ) ) );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat, arg2, arg3 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( Opposite( arg2 ) ), UnderlyingMatrix( Opposite( arg3 ) ) ) );
end
########
        
    );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat, arg2 )
    return ColumnRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ) = Dimension( Range( Opposite( arg2 ) ) );
end
########
        
    );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat, arg2 )
    return true;
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
            elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Source( Opposite( arg2 ) ) ), UnderlyingRing( Opposite( cat ) ) ) then
                return false;
            elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Opposite( arg2 ) ), UnderlyingRing( Opposite( cat ) ) ) then
                return false;
            elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Range( Opposite( arg2 ) ) ), UnderlyingRing( Opposite( cat ) ) ) then
                return false;
            elif NumberRows( UnderlyingMatrix( Opposite( arg2 ) ) ) <> Dimension( Source( Opposite( arg2 ) ) ) then
                return false;
            elif NumberColumns( UnderlyingMatrix( Opposite( arg2 ) ) ) <> Dimension( Range( Opposite( arg2 ) ) ) then
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
            elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Opposite( arg2 ) ), UnderlyingRing( Opposite( cat ) ) ) then
                return false;
            elif Dimension( Opposite( arg2 ) ) < 0 then
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
    return IsZero( UnderlyingMatrix( Opposite( arg2 ) ) );
end
########
        
    );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat, arg2 )
    return Dimension( Opposite( arg2 ) ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat, alpha )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), Opposite( cat ), Dimension, NumberColumns( SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) ), Source( alpha ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Range( Opposite( alpha ) ), ObjectifyObjectForCAPWithAttributes( rec(
               ), Opposite( cat ), Dimension, NumberColumns( SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), Opposite( cat ), Dimension, NumberColumns( UnderlyingMatrix( Opposite( arg2 ) ) ) - RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( alpha ), Source( beta ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Range( Opposite( beta ) ), Range( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( Opposite( beta ) ), UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat, A )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, A, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat, Opposite, Opposite( A ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( A ), Opposite( A ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( A ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, Source( alpha ), Range( beta ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Source( Opposite( beta ) ), Range( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnderlyingMatrix( Opposite( beta ) ) * UnderlyingMatrix( Opposite( alpha ) ) ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, k, P )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, P, objects[k], Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( objects[k] ), Opposite( P ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( Dimension( Opposite( objects[k] ) ), Sum( List( objects, function ( x )
                        return Opposite( x );
                    end ){[ 1 .. k - 1 ]}, function ( c )
                    return Dimension( c );
                end ), UnderlyingRing( Opposite( cat ) ) ), HomalgIdentityMatrix( Dimension( Opposite( objects[k] ) ), UnderlyingRing( Opposite( cat ) ) ), HomalgZeroMatrix( Dimension( Opposite( objects[k] ) ), Sum( List( objects, function ( x )
                        return Opposite( x );
                    end ){[ k + 1 .. Length( List( objects, function ( x )
                             return Opposite( x );
                         end ) ) ]}, function ( c )
                    return Dimension( c );
                end ), UnderlyingRing( Opposite( cat ) ) ) ) ) );
end
########
        
    );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, Opposite, Opposite( arg2 ) );
end
########
        
    );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, Opposite, Opposite( arg2 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, T, tau, P )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, P, T, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( T ), Opposite( P ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( Opposite( cat ) ), Dimension( Opposite( T ) ), List( tau, function ( logic_new_func_42873_x )
                  return UnderlyingMatrix( Opposite( logic_new_func_42873_x ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, T, P )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, P, T, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( T ), Opposite( P ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( Opposite( T ) ), 0, UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, T, tau, P )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, T, P, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( P ), Opposite( T ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfRows( UnderlyingRing( Opposite( cat ) ), Dimension( Opposite( T ) ), List( tau, function ( logic_new_func_43037_x )
                  return UnderlyingMatrix( Opposite( logic_new_func_43037_x ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, T, P )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, T, P, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( P ), Opposite( T ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( Opposite( T ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat, a, b )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat, a, b, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), Opposite( cat ), Opposite( b ), Opposite( a ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( Opposite( b ) ), Dimension( Opposite( a ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), Opposite( cat ), Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
