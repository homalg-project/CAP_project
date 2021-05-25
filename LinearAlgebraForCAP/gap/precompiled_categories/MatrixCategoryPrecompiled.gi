# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "MatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return MATRIX_CATEGORY( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false );
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat, morphism_1, morphism_2 )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( morphism_1 ), Range, Range( morphism_2 ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat, morphism )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( morphism ), Range, Range( morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, -1 * UnderlyingMatrix( morphism ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat, S, T )
    return List( [ 1 .. Dimension( S ) * Dimension( T ) ], function ( logic_new_func_991_x )
            return VectorSpaceMorphism( S, ConvertRowToMatrix( CertainRows( HomalgIdentityMatrix( Dimension( S ) * Dimension( T ), UnderlyingFieldForHomalg( S ) ), [ logic_new_func_991_x ] ), Dimension( S ), Dimension( T ) ), T );
        end );
end
########
        
    );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat, mor, test_object, test_morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( mor ) ), UnderlyingMatrix( test_morphism ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Range( test_morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat, mor, test_object, test_morphism, cokernel )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( mor ) ), UnderlyingMatrix( test_morphism ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Range( test_morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat, morphism )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Dimension, NumberColumns( UnderlyingMatrix( morphism ) ) - RowRankOfMatrix( UnderlyingMatrix( morphism ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat, morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( morphism ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat, alpha, P )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfColumns( UnderlyingMatrix( alpha ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat, alpha, beta )
    if LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) = fail then
        return fail;
    else
        return ObjectifyWithAttributes( rec(
               ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, Range( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, Range( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat, object_list )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Dimension, Sum( List( object_list, function ( object )
                return Dimension( object );
            end ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
end
########
        
    );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat, obj )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, obj, Range, obj, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( obj ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat, A, P )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, A, Range, A, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat, object_1, object_2 )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Dimension, Dimension( object_1 ) * Dimension( object_2 ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat, object )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, object, Range, object, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( object ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat, objects, k )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := UnionOfColumns( HomalgZeroMatrix( Dimension( objects[k] ), Sum( objects{[ 1 .. k - 1 ]}, function ( c )
                return Dimension( c );
            end ), UnderlyingRing( cat ) ), HomalgIdentityMatrix( Dimension( objects[k] ), UnderlyingRing( cat ) ), HomalgZeroMatrix( Dimension( objects[k] ), Sum( objects{[ k + 1 .. Length( objects ) ]}, function ( c )
                return Dimension( c );
            end ), UnderlyingRing( cat ) ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, objects[k], Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, object_list, injection_number, coproduct )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, object_list[injection_number], Range, coproduct, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( Dimension( object_list[injection_number] ), Sum( object_list{[ 1 .. injection_number - 1 ]}, function ( c )
                  return Dimension( c );
              end ), UnderlyingRing( cat ) ), HomalgIdentityMatrix( Dimension( object_list[injection_number] ), UnderlyingRing( cat ) ), HomalgZeroMatrix( Dimension( object_list[injection_number] ), Sum( object_list{[ injection_number + 1 .. Length( object_list ) ]}, function ( c )
                  return Dimension( c );
              end ), UnderlyingRing( cat ) ) ) );
end
########
        
    );
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, Range( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat, alpha )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := ConvertMatrixToRow( UnderlyingMatrix( alpha ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat, mor )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Range( mor ), Range, Source( mor ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( Range( mor ) ), UnderlyingRing( cat ) ), UnderlyingMatrix( mor ) ) );
end
########
        
    );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat, morphism )
    return Dimension( Source( morphism ) ) = Dimension( Range( morphism ) ) and (Dimension( Range( morphism ) ) = Dimension( Source( morphism ) ) and ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) ));
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat, alpha, beta )
    if LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) = fail then
        return IsCapCategoryMorphism( fail );
    else
        return IsCapCategoryMorphism( ObjectifyWithAttributes( rec(
                 ), MorphismType( cat ), CapCategory, cat, Source, Range( alpha ), Range, Range( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsColiftableAlongEpimorphism( cat,
        
########
function ( cat, epsilon, tau )
    if LeftDivide( UnderlyingMatrix( epsilon ), UnderlyingMatrix( tau ) ) = fail then
        return IsCapCategoryMorphism( fail );
    else
        return IsCapCategoryMorphism( ObjectifyWithAttributes( rec(
                 ), MorphismType( cat ), CapCategory, cat, Source, Range( epsilon ), Range, Range( tau ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( epsilon ), UnderlyingMatrix( tau ) ) ) );
    fi;
    return;
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
    AddIsEndomorphism( cat,
        
########
function ( cat, morphism )
    return Dimension( Source( morphism ) ) = Dimension( Range( morphism ) );
end
########
        
    );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat, morphism )
    return ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForMorphisms( cat,
        
########
function ( cat, mor1, mor2 )
    return IS_IDENTICAL_OBJ( mor1, mor2 );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForObjects( cat,
        
########
function ( cat, obj1, obj2 )
    return IS_IDENTICAL_OBJ( obj1, obj2 );
end
########
        
    );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat, mor1, mor2 )
    return UnderlyingMatrix( mor1 ) = UnderlyingMatrix( mor2 );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat, object_1, object_2 )
    return Dimension( object_1 ) = Dimension( object_2 );
end
########
        
    );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat, morphism )
    return UnderlyingMatrix( morphism ) * UnderlyingMatrix( morphism ) = UnderlyingMatrix( morphism );
end
########
        
    );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat, object )
    return Dimension( object ) = 0;
end
########
        
    );
    
    ##
    AddIsInjective( cat,
        
########
function ( cat, obj )
    return true;
end
########
        
    );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat, morphism )
    return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) ) and ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat, alpha, beta )
    if RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) = fail then
        return IsCapCategoryMorphism( fail );
    else
        return IsCapCategoryMorphism( ObjectifyWithAttributes( rec(
                 ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Source( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsLiftableAlongMonomorphism( cat,
        
########
function ( cat, iota, tau )
    if RightDivide( UnderlyingMatrix( tau ), UnderlyingMatrix( iota ) ) = fail then
        return IsCapCategoryMorphism( fail );
    else
        return IsCapCategoryMorphism( ObjectifyWithAttributes( rec(
                 ), MorphismType( cat ), CapCategory, cat, Source, Source( tau ), Range, Source( iota ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau ), UnderlyingMatrix( iota ) ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat, morphism )
    return RowRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Source( morphism ) );
end
########
        
    );
    
    ##
    AddIsOne( cat,
        
########
function ( cat, morphism )
    return HomalgIdentityMatrix( Dimension( Source( morphism ) ), UnderlyingRing( cat ) ) = UnderlyingMatrix( morphism );
end
########
        
    );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat, obj )
    return true;
end
########
        
    );
    
    ##
    AddIsSplitEpimorphism( cat,
        
########
function ( cat, morphism )
    if RightDivide( HomalgIdentityMatrix( Dimension( Range( morphism ) ), UnderlyingRing( cat ) ), UnderlyingMatrix( morphism ) ) = fail then
        return false;
    else
        return IsCapCategoryMorphism( ObjectifyWithAttributes( rec(
                 ), MorphismType( cat ), CapCategory, cat, Source, Range( morphism ), Range, Source( morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( Range( morphism ) ), UnderlyingRing( cat ) ), UnderlyingMatrix( morphism ) ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat, morphism )
    if LeftDivide( UnderlyingMatrix( morphism ), HomalgIdentityMatrix( Dimension( Source( morphism ) ), UnderlyingRing( cat ) ) ) = fail then
        return false;
    else
        return IsCapCategoryMorphism( ObjectifyWithAttributes( rec(
                 ), MorphismType( cat ), CapCategory, cat, Source, Range( morphism ), Range, Source( morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( morphism ), HomalgIdentityMatrix( Dimension( Source( morphism ) ), UnderlyingRing( cat ) ) ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat, object )
    return Dimension( object ) = 0;
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat, morphism )
    if not true then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Source( morphism ) ), UnderlyingRing( cat ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( morphism ), UnderlyingRing( cat ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Range( morphism ) ), UnderlyingRing( cat ) ) then
        return false;
    elif NumberRows( UnderlyingMatrix( morphism ) ) <> Dimension( Source( morphism ) ) then
        return false;
    elif NumberColumns( UnderlyingMatrix( morphism ) ) <> Dimension( Range( morphism ) ) then
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
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( object ), UnderlyingRing( cat ) ) then
        return false;
    elif Dimension( object ) < 0 then
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
    return Dimension( object ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat, morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Source( morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat, alpha, P )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfRows( UnderlyingMatrix( alpha ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Source( alpha ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat, mor, test_object, test_morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := RightDivide( UnderlyingMatrix( test_morphism ), SyzygiesOfRows( UnderlyingMatrix( mor ) ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( test_morphism ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat, mor, test_object, test_morphism, kernel )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := RightDivide( UnderlyingMatrix( test_morphism ), SyzygiesOfRows( UnderlyingMatrix( mor ) ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( test_morphism ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat, morphism )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Dimension, NumberRows( UnderlyingMatrix( morphism ) ) - RowRankOfMatrix( UnderlyingMatrix( morphism ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat, alpha, beta )
    if RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) = fail then
        return fail;
    else
        return ObjectifyWithAttributes( rec(
               ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Source( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( beta ), Range, Source( alpha ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat, obj )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, obj, Range, obj, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( obj ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat, A, I )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, A, Range, A, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat, alpha )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgZeroMatrix( NumberRows( UnderlyingMatrix( alpha ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha ) ), Dimension( Range( alpha ) ), UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Range( alpha ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat, alpha, P )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgZeroMatrix( NumberRows( UnderlyingMatrix( alpha ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha ) ), Dimension( Range( alpha ) ), UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Range( alpha ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat, alpha )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgZeroMatrix( Dimension( Source( alpha ) ), NumberColumns( UnderlyingMatrix( alpha ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha ) ), UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat, alpha, P )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgZeroMatrix( Dimension( Source( alpha ) ), NumberColumns( UnderlyingMatrix( alpha ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha ) ), UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat, right_mor, left_mor )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( left_mor ), Range, Range( right_mor ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnderlyingMatrix( left_mor ) * UnderlyingMatrix( right_mor ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat, morphism_1, morphism_2 )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( morphism_1 ), Range, Range( morphism_2 ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnderlyingMatrix( morphism_1 ) * UnderlyingMatrix( morphism_2 ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat, objects, k )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := UnionOfRows( HomalgZeroMatrix( Sum( objects{[ 1 .. k - 1 ]}, function ( c )
                return Dimension( c );
            end ), Dimension( objects[k] ), UnderlyingRing( cat ) ), HomalgIdentityMatrix( Dimension( objects[k] ), UnderlyingRing( cat ) ), HomalgZeroMatrix( Sum( objects{[ k + 1 .. Length( objects ) ]}, function ( c )
                return Dimension( c );
            end ), Dimension( objects[k] ), UnderlyingRing( cat ) ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, objects[k], UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, object_list, projection_number, direct_sum_object )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, direct_sum_object, Range, object_list[projection_number], UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( object_list{[ 1 .. projection_number - 1 ]}, function ( c )
                  return Dimension( c );
              end ), Dimension( object_list[projection_number] ), UnderlyingRing( cat ) ), HomalgIdentityMatrix( Dimension( object_list[projection_number] ), UnderlyingRing( cat ) ), HomalgZeroMatrix( Sum( object_list{[ projection_number + 1 .. Length( object_list ) ]}, function ( c )
                  return Dimension( c );
              end ), Dimension( object_list[projection_number] ), UnderlyingRing( cat ) ) ) );
end
########
        
    );
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat, alpha, beta )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( alpha ), Range, Source( beta ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
end
########
        
    );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat, obj )
    return obj;
end
########
        
    );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat, obj )
    return obj;
end
########
        
    );
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat, mor1, mor2 )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( mor1 ), Range, Range( mor2 ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnderlyingMatrix( mor1 ) + -1 * UnderlyingMatrix( mor2 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat, objects, T, tau )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := UnionOfRows( UnderlyingRing( cat ), Dimension( T ), List( tau, function ( s )
              return UnderlyingMatrix( s );
          end ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, T, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, diagram, test_object, sink, coproduct )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, coproduct, Range, test_object, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat ), Dimension( test_object ), List( sink, function ( s )
                return UnderlyingMatrix( s );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat, test_sink )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgZeroMatrix( 0, Dimension( test_sink ), UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, test_sink, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, source, zero_object )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, zero_object, Range, source, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( source ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat, objects, T, tau )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := UnionOfColumns( UnderlyingRing( cat ), Dimension( T ), List( tau, function ( s )
              return UnderlyingMatrix( s );
          end ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, T, Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrColumns( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat, diagram, test_object, sink, direct_sum )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, test_object, Range, direct_sum, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat ), Dimension( test_object ), List( sink, function ( s )
                return UnderlyingMatrix( s );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat, test_source )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgZeroMatrix( Dimension( test_source ), 0, UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, test_source, Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat, sink, zero_object )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, sink, Range, zero_object, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( sink ), 0, UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat, source, range )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, source, Range, range, UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( source ), Dimension( range ), UnderlyingRing( cat ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat )
    return ObjectifyWithAttributes( rec(
           ), ObjectType( cat ), CapCategory, cat, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
end
########
        
    );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := HomalgIdentityMatrix( 0, UnderlyingRing( cat ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
