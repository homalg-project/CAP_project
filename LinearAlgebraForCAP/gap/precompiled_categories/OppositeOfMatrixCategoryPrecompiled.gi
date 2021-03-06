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
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( a ), Range, Range( a ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Source( Opposite( a ) ), Range, Range( Opposite( b ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnderlyingMatrix( Opposite( a ) ) + UnderlyingMatrix( Opposite( b ) ) ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat, a )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( a ), Range, Range( a ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Source( Opposite( a ) ), Range, Range( Opposite( a ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, -1 * UnderlyingMatrix( Opposite( a ) ) ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat, arg2, arg3 )
    return List( [ 1 .. Dimension( Opposite( arg3 ) ) * Dimension( Opposite( arg2 ) ) ], function ( logic_new_func_40439_x )
            return ObjectifyWithAttributes( rec(
                   ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
                     ), ObjectType( cat ), CapCategory, cat, Opposite, Opposite( arg2 ) ), Range, ObjectifyWithAttributes( rec(
                     ), ObjectType( cat ), CapCategory, cat, Opposite, Opposite( arg3 ) ), Opposite, ObjectifyWithAttributes( rec(
                     ), MorphismType( CapCategory( Opposite( arg3 ) ) ), CapCategory, CapCategory( Opposite( arg3 ) ), Source, Opposite( arg3 ), Range, Opposite( arg2 ), UnderlyingFieldForHomalg, CapCategory( Opposite( arg3 ) )!.field_for_matrix_category, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( HomalgIdentityMatrix( Dimension( Opposite( arg3 ) ) * Dimension( Opposite( arg2 ) ), UnderlyingFieldForHomalg( Opposite( arg3 ) ) ), [ logic_new_func_40439_x ] ), Dimension( Opposite( arg3 ) ), Dimension( Opposite( arg2 ) ) ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Opposite, ObjectifyWithAttributes( rec(
             ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberRows( UnderlyingMatrix( Opposite( arg2 ) ) ) - RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat, alpha )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Opposite, ObjectifyWithAttributes( rec(
               ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberRows( SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, ObjectifyWithAttributes( rec(
               ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberRows( SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), Range, Source( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, Range( beta ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Source( Opposite( beta ) ), Range, Source( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( Opposite( beta ) ), UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Opposite, ObjectifyWithAttributes( rec(
             ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, Sum( List( arg2, function ( logic_new_func_40772_x )
                  return Dimension( Opposite( logic_new_func_40772_x ) );
              end ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat )
    return ID_FUNC( ObjectifyWithAttributes( rec(
             ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat, A )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Opposite, Opposite( A ) ), Range, A, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( A ), Range, Opposite( A ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( A ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat, arg2, arg3 )
    return ID_FUNC( ObjectifyWithAttributes( rec(
             ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, Dimension( Opposite( arg3 ) ) * Dimension( Opposite( arg2 ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat, a )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, a, Range, a, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( a ), Range, Opposite( a ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( a ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, k, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, objects[k], Range, P, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( P ), Range, Opposite( objects[k] ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( List( objects, function ( x )
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
    return ID_FUNC( ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, ObjectifyWithAttributes( rec(
               ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), Range, ObjectifyWithAttributes( rec(
               ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberColumns( ConvertMatrixToRow( UnderlyingMatrix( Opposite( arg2 ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, ConvertMatrixToRow( UnderlyingMatrix( Opposite( arg2 ) ) ) ) );
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
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Opposite, ObjectifyWithAttributes( rec(
               ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberColumns( SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) ), Range, Source( alpha ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Range( Opposite( alpha ) ), Range, ObjectifyWithAttributes( rec(
               ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberColumns( SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha ) ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Opposite, ObjectifyWithAttributes( rec(
             ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, NumberColumns( UnderlyingMatrix( Opposite( arg2 ) ) ) - RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2 ) ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Source( beta ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Range( Opposite( beta ) ), Range, Range( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( Opposite( beta ) ), UnderlyingMatrix( Opposite( alpha ) ) ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat, A )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, A, Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Opposite, Opposite( A ) ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( A ), Range, Opposite( A ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( A ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Range( beta ), Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Source( Opposite( beta ) ), Range, Range( Opposite( alpha ) ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnderlyingMatrix( Opposite( beta ) ) * UnderlyingMatrix( Opposite( alpha ) ) ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, k, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, P, Range, objects[k], Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( objects[k] ), Range, Opposite( P ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( Dimension( Opposite( objects[k] ) ), Sum( List( objects, function ( x )
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
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Opposite, Opposite( arg2 ) );
end
########
        
    );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat, arg2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Opposite, Opposite( arg2 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, T, tau, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, P, Range, T, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( T ), Range, Opposite( P ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( Opposite( cat ) ), Dimension( Opposite( T ) ), List( tau, function ( logic_new_func_42538_x )
                  return UnderlyingMatrix( Opposite( logic_new_func_42538_x ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, T, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, P, Range, T, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( T ), Range, Opposite( P ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( Opposite( T ) ), 0, UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, objects, T, tau, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, T, Range, P, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( P ), Range, Opposite( T ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, UnionOfRows( UnderlyingRing( Opposite( cat ) ), Dimension( Opposite( T ) ), List( tau, function ( logic_new_func_42701_x )
                  return UnderlyingMatrix( Opposite( logic_new_func_42701_x ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, T, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, T, Range, P, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( P ), Range, Opposite( T ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( Opposite( T ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat, a, b )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, a, Range, b, Opposite, ObjectifyWithAttributes( rec(
             ), MorphismType( Opposite( cat ) ), CapCategory, Opposite( cat ), Source, Opposite( b ), Range, Opposite( a ), UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( Opposite( b ) ), Dimension( Opposite( a ) ), UnderlyingRing( Opposite( cat ) ) ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Opposite, ObjectifyWithAttributes( rec(
             ), ObjectType( Opposite( cat ) ), CapCategory, Opposite( cat ), Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( Opposite( cat ) ) ) );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
