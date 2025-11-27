gap> START_TEST( "AdditiveClosure_has_direct_sums" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "AdditiveClosuresForCAP", false );
true

#
gap> dummy := DummyCategory( rec(
>     name := "a preadditive category",
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "PreCompose",
>         "IdentityMorphism",
>         "SumOfMorphisms",
>         "ZeroMorphism",
>         "AdditionForMorphisms",
>         "AdditiveInverseForMorphisms",
>     ],
>     properties := [
>         "IsAbCategory",
>     ],
> ) );;
gap> cat := AdditiveClosure( dummy );;

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> CapJitEnableProofAssistantMode( );
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> StateProposition( cat, "has_direct_sums" );
Proposition:
AdditiveClosure( a preadditive category ) has direct sums.

# DirectSum well-defined
gap> StateNextLemma( );


Lemma 1:
In AdditiveClosure( a preadditive category ), direct sum objects are objects:
For a list of objects D we have
function ( cat, D )
    return IsWellDefinedForObjects( cat, DirectSum( cat, D ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, D_1 )
    if not IsList( Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                     return ObjectList( D_1[i_2] );
                 end ) ) ) then
        return false;
    elif not ForAll( Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                     return ObjectList( D_1[i_2] );
                 end ) ), function ( obj_2 )
                 return IsWellDefinedForObjects( UnderlyingCategory( cat_1 ), obj_2 );
             end ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# ProjectionInFactorOfDirectSum well-defined
gap> StateNextLemma( );


Lemma 2:
In AdditiveClosure( a preadditive category ), projections in factors of direct sums define morphisms:
For a list of objects D and an integer i such that
• 1 <= i,
• i <= Length( D ),
we have
function ( cat, D, i )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, DirectSum( cat, D ), ProjectionInFactorOfDirectSum( cat, D, i ), D[i] );
end
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, i_1 )
    if not (IsList( UnionOfRowsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                       if i_2 = i_1 then
                           return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_3 )
                                   return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_4 )
                                           if i_3 = j_4 then
                                               return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3] );
                                           else
                                               return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3], ObjectList( D_1[i_1] )[j_4] );
                                           fi;
                                           return;
                                       end );
                               end );
                       else
                           return List( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( i_3 )
                                   return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_4 )
                                           return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], ObjectList( D_1[i_1] )[j_4] );
                                       end );
                               end );
                       fi;
                       return;
                   end ) ) ) and Length( UnionOfRowsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                         if (i_2 = i_1) then
                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_3 )
                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_4 )
                                             if (i_3 = j_4) then
                                                 return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3] );
                                             else
                                                 return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3], ObjectList( D_1[i_1] )[j_4] );
                                             fi;
                                             return;
                                         end );
                                 end );
                         else
                             return List( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( i_3 )
                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_4 )
                                             return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], ObjectList( D_1[i_1] )[j_4] );
                                         end );
                                 end );
                         fi;
                         return;
                     end ) ) ) = Sum( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                       return Length( ObjectList( D_1[i_2] ) );
                   end ) )) then
        return false;
    elif not ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                         return Length( ObjectList( D_1[i_2] ) );
                     end ) ) ], function ( i_2 )
                 return (IsList( UnionOfRowsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                                 if i_3 = i_1 then
                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_4 )
                                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_5 )
                                                     if i_4 = j_5 then
                                                         return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4] );
                                                     else
                                                         return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4], ObjectList( D_1[i_1] )[j_5] );
                                                     fi;
                                                     return;
                                                 end );
                                         end );
                                 else
                                     return List( [ 1 .. Length( ObjectList( D_1[i_3] ) ) ], function ( i_4 )
                                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_5 )
                                                     return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_3] )[i_4], ObjectList( D_1[i_1] )[j_5] );
                                                 end );
                                         end );
                                 fi;
                                 return;
                             end ) )[i_2] ) and Length( UnionOfRowsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                                   if (i_3 = i_1) then
                                       return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_4 )
                                               return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_5 )
                                                       if (i_4 = j_5) then
                                                           return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4] );
                                                       else
                                                           return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4], ObjectList( D_1[i_1] )[j_5] );
                                                       fi;
                                                       return;
                                                   end );
                                           end );
                                   else
                                       return List( [ 1 .. Length( ObjectList( D_1[i_3] ) ) ], function ( i_4 )
                                               return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_5 )
                                                       return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_3] )[i_4], ObjectList( D_1[i_1] )[j_5] );
                                                   end );
                                           end );
                                   fi;
                                   return;
                               end ) )[i_2] ) = Length( ObjectList( D_1[i_1] ) ));
             end ) then
        return false;
    elif not ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                         return Length( ObjectList( D_1[i_2] ) );
                     end ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_4 )
                                       return ObjectList( D_1[i_4] );
                                   end ) )[i_2], UnionOfRowsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_4 )
                                         if i_4 = i_1 then
                                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_6 )
                                                             if i_5 = j_6 then
                                                                 return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5] );
                                                             else
                                                                 return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[i_1] )[j_6] );
                                                             fi;
                                                             return;
                                                         end );
                                                 end );
                                         else
                                             return List( [ 1 .. Length( ObjectList( D_1[i_4] ) ) ], function ( i_5 )
                                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_6 )
                                                             return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_4] )[i_5], ObjectList( D_1[i_1] )[j_6] );
                                                         end );
                                                 end );
                                         fi;
                                         return;
                                     end ) )[i_2][j_3], ObjectList( D_1[i_1] )[j_3] );
                     end );
             end ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> # Length( UnionOfRowsListList( ... ) [i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "list_of_matrices", "i" ],
>         variable_filters := [ IsInt, IsList, IsInt ],
>         src_template := "Length( UnionOfRowsListList( nr_cols, list_of_matrices ) [i] )",
>         dst_template := "nr_cols",
>     )
> );
gap> # Length( UnionOfRowsListList )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_of_matrices", "nr_cols" ],
>         variable_filters := [ IsList, IsInt ],
>         src_template := "Length( UnionOfRowsListList( nr_cols, list_of_matrices ) )",
>         dst_template := "Sum( List( list_of_matrices, Length ) )",
>     )
> );
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # func( Concatenation( ... )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "func", "list_of_lists", "i" ],
>         variable_filters := [ IsFunction, IsList, IsInt ],
>         src_template := "func( Concatenation( list_of_lists )[i] )",
>         dst_template := "Concatenation( List( list_of_lists, list -> List( list, func ) ) )[i]",
>         new_funcs := [ [ "list" ] ],
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # List( [ 1 .. Length( list ) ], i -> list[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list" ],
>         variable_filters := [ IsList ],
>         src_template := "List( [ 1 .. Length( list ) ], i -> list[i] )",
>         dst_template := "list",
>     )
> );
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # func( Concatenation( ... )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "func", "list_of_lists", "i" ],
>         variable_filters := [ IsFunction, IsList, IsInt ],
>         src_template := "func( Concatenation( list_of_lists )[i] )",
>         dst_template := "Concatenation( List( list_of_lists, list -> List( list, func ) ) )[i]",
>         new_funcs := [ [ "list" ] ],
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # List( list, i -> constant )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "constant" ],
>         variable_filters := [ IsList, IsObject ],
>         src_template := "List( list, i -> constant )",
>         dst_template := "ListWithIdenticalEntries( Length( list ), constant )",
>     )
> );
gap> # Concatenation( ListWithIdenticalEntries )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "nr", "value", "i" ],
>         variable_filters := [ IsList, IsInt, IsObject, IsInt ],
>         src_template := "Concatenation( List( list, j -> ListWithIdenticalEntries( nr, value ) ) )[i]",
>         dst_template := "value",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InjectionOfCofactorOfDirectSum well-defined
gap> StateNextLemma( );


Lemma 3:
In AdditiveClosure( a preadditive category ), injections in cofactors of direct sums define morphisms:
For a list of objects D and an integer i such that
• 1 <= i,
• i <= Length( D ),
we have
function ( cat, D, i )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, D[i], InjectionOfCofactorOfDirectSum( cat, D, i ), DirectSum( cat, D ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, i_1 )
    if not (IsList( UnionOfColumnsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                       if i_2 = i_1 then
                           return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_3 )
                                   return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_4 )
                                           if i_3 = j_4 then
                                               return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3] );
                                           else
                                               return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3], ObjectList( D_1[i_1] )[j_4] );
                                           fi;
                                           return;
                                       end );
                               end );
                       else
                           return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_3 )
                                   return List( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( j_4 )
                                           return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3], ObjectList( D_1[i_2] )[j_4] );
                                       end );
                               end );
                       fi;
                       return;
                   end ) ) ) and Length( UnionOfColumnsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                         if (i_2 = i_1) then
                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_3 )
                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_4 )
                                             if (i_3 = j_4) then
                                                 return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3] );
                                             else
                                                 return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3], ObjectList( D_1[i_1] )[j_4] );
                                             fi;
                                             return;
                                         end );
                                 end );
                         else
                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_3 )
                                     return List( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( j_4 )
                                             return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_3], ObjectList( D_1[i_2] )[j_4] );
                                         end );
                                 end );
                         fi;
                         return;
                     end ) ) ) = Length( ObjectList( D_1[i_1] ) )) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_2 )
                 return (IsList( UnionOfColumnsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                                 if i_3 = i_1 then
                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_4 )
                                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_5 )
                                                     if i_4 = j_5 then
                                                         return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4] );
                                                     else
                                                         return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4], ObjectList( D_1[i_1] )[j_5] );
                                                     fi;
                                                     return;
                                                 end );
                                         end );
                                 else
                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_4 )
                                             return List( [ 1 .. Length( ObjectList( D_1[i_3] ) ) ], function ( j_5 )
                                                     return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4], ObjectList( D_1[i_3] )[j_5] );
                                                 end );
                                         end );
                                 fi;
                                 return;
                             end ) )[i_2] ) and Length( UnionOfColumnsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                                   if (i_3 = i_1) then
                                       return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_4 )
                                               return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_5 )
                                                       if (i_4 = j_5) then
                                                           return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4] );
                                                       else
                                                           return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4], ObjectList( D_1[i_1] )[j_5] );
                                                       fi;
                                                       return;
                                                   end );
                                           end );
                                   else
                                       return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_4 )
                                               return List( [ 1 .. Length( ObjectList( D_1[i_3] ) ) ], function ( j_5 )
                                                       return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_4], ObjectList( D_1[i_3] )[j_5] );
                                                   end );
                                           end );
                                   fi;
                                   return;
                               end ) )[i_2] ) = Sum( List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                               return Length( ObjectList( D_1[i_3] ) );
                           end ) ));
             end ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                                 return Length( ObjectList( D_1[i_3] ) );
                             end ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2], UnionOfColumnsListList( Length( ObjectList( D_1[i_1] ) ), List( [ 1 .. Length( D_1 ) ], function ( i_4 )
                                         if i_4 = i_1 then
                                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                     return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_6 )
                                                             if i_5 = j_6 then
                                                                 return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5] );
                                                             else
                                                                 return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[i_1] )[j_6] );
                                                             fi;
                                                             return;
                                                         end );
                                                 end );
                                         else
                                             return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                     return List( [ 1 .. Length( ObjectList( D_1[i_4] ) ) ], function ( j_6 )
                                                             return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[i_4] )[j_6] );
                                                         end );
                                                 end );
                                         fi;
                                         return;
                                     end ) )[i_2][j_3], Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_4 )
                                       return ObjectList( D_1[i_4] );
                                   end ) )[j_3] );
                     end );
             end ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> # Length( UnionOfColumnsListList )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "list_of_matrices" ],
>         variable_filters := [ IsInt, IsList ],
>         src_template := "Length( UnionOfColumnsListList( nr_rows, list_of_matrices ) )",
>         dst_template := "nr_rows",
>     )
> );
gap> # Length( UnionOfColumnsListList( ... )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_of_matrices", "nr_rows", "i" ],
>         variable_filters := [ IsList, IsInt, IsInt ],
>         src_template := "Length( UnionOfColumnsListList( nr_rows, list_of_matrices )[i] )",
>         dst_template := "Sum( List( list_of_matrices, M -> Length( M[i] ) ) )",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # func( Concatenation( ... )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "func", "list_of_lists", "i" ],
>         variable_filters := [ IsFunction, IsList, IsInt ],
>         src_template := "func( Concatenation( list_of_lists )[i] )",
>         dst_template := "Concatenation( List( list_of_lists, list -> List( list, func ) ) )[i]",
>         new_funcs := [ [ "list" ] ],
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # List( list, i -> constant )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "constant" ],
>         variable_filters := [ IsList, IsObject ],
>         src_template := "List( list, i -> constant )",
>         dst_template := "ListWithIdenticalEntries( Length( list ), constant )",
>     )
> );
gap> # Concatenation( ListWithIdenticalEntries )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "nr", "value", "i" ],
>         variable_filters := [ IsList, IsInt, IsObject, IsInt ],
>         src_template := "Concatenation( List( list, j -> ListWithIdenticalEntries( nr, value ) ) )[i]",
>         dst_template := "value",
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # func( Concatenation( ... )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "func", "list_of_lists", "i" ],
>         variable_filters := [ IsFunction, IsList, IsInt ],
>         src_template := "func( Concatenation( list_of_lists )[i] )",
>         dst_template := "Concatenation( List( list_of_lists, list -> List( list, func ) ) )[i]",
>         new_funcs := [ [ "list" ] ],
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # List( [ 1 .. Length( list ) ], i -> list[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list" ],
>         variable_filters := [ IsList ],
>         src_template := "List( [ 1 .. Length( list ) ], i -> list[i] )",
>         dst_template := "list",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# IdentityMorphism as sum of proj * inj
gap> StateNextLemma( );


Lemma 4:
In AdditiveClosure( a preadditive category ), the identity on a direct sum can be written as a sum of projections followed by injections:
For a list of objects D we have
function ( cat, D )
    return IsCongruentForMorphisms( cat, SumOfMorphisms( cat, DirectSum( cat, D ), List( [ 1 .. Length( D ) ], function ( i )
                return PreCompose( cat, ProjectionInFactorOfDirectSum( cat, D, i ), InjectionOfCofactorOfDirectSum( cat, D, i ) );
            end ), DirectSum( cat, D ) ), IdentityMorphism( cat, DirectSum( cat, D ) ) );
end
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # pull common List out of CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "i", "j", "list", "func1", "func2" ],
>         variable_filters := [ IsInt, IsInt, IsList, IsFunction, IsFunction ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( j = i, List( [ 1 .. Length( ObjectList( list[i] ) ) ], func1 ), true, List( [ 1 .. Length( ObjectList( list[j] ) ) ], func2 ) )",
>         dst_template := "List( [ 1 .. Length( ObjectList( list[j] ) ) ], x -> CAP_JIT_INTERNAL_EXPR_CASE( j = i, func1( x ), true, func2( x ) ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # flatten CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "P", "Q", "if_if_value", "if_else_value", "else_else_value" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, CAP_JIT_INTERNAL_EXPR_CASE( Q, if_if_value, true, if_else_value ), true, else_else_value )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, if_if_value, P, if_else_value, true, else_else_value )",
>     )
> );
gap> # decompose ForAll over a concatenation of lists
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "func" ],
>         variable_filters := [ IsList, IsFunction ],
>         src_template := "ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) ], func )",
>         dst_template := "ForAll( [ 1 .. Length( D_1 ) ], i_major -> ForAll( [ 1 .. Length( ObjectList( D_1[i_major] ) ) ], i_minor -> func( Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor ) ) )",
>         new_funcs := [ [ "i_major" ], [ "i_minor" ] ],
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "func" ],
>         variable_filters := [ IsList, IsFunction ],
>         src_template := "ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], i_4 -> Length( ObjectList( D_1[i_4] ) ) ) ) ], func )",
>         dst_template := "ForAll( [ 1 .. Length( D_1 ) ], j_major -> ForAll( [ 1 .. Length( ObjectList( D_1[j_major] ) ) ], j_minor -> func( Sum( List( [ 1 .. j_major - 1 ], i_4 -> Length( ObjectList( D_1[i_4] ) ) ) ) + j_minor ) ) )",
>         new_funcs := [ [ "j_major" ], [ "j_minor" ] ],
>     )
> );
gap> # Concatenation[i_major * ... + i_minor]
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "value" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_6 -> List( [ 1 .. Length( ObjectList( D_1[i_6] ) ) ], x_7 -> value ) ) )[Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor]",
>         dst_template := "(i_6 -> (x_7 -> value)(i_minor))(i_major)",
>     )
> );
gap> # composition of identites and zero morphisms
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "P", "Q", "obj1", "obj2", "obj3", "obj4" ],
>         src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ), CAP_JIT_INTERNAL_EXPR_CASE( Q, IdentityMorphism( cat, obj3 ), true, ZeroMorphism( cat, obj3, obj4 ) ) )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, IdentityMorphism( cat, obj2 ), true, ZeroMorphism( cat, obj2, obj4 ) )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_2] ) ) ], function ( logic_new_func_i_minor_3 )
                    return ForAll( [ 1 .. Length( D_1 ) ], function ( logic_new_func_j_major_4 )
                            return ForAll( [ 1 .. Length( ObjectList( D_1[logic_new_func_j_major_4] ) ) ], function ( logic_new_func_j_minor_5 )
                                    return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_6 )
                                                    return ObjectList( D_1[i_6] );
                                                end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_6 )
                                                     return Length( ObjectList( D_1[i_6] ) );
                                                 end ) ) + logic_new_func_i_minor_3], List( [ 1 .. Length( D_1 ) ], function ( i_6 )
                                                return SumOfMorphisms( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                              return ObjectList( D_1[i_7] );
                                                          end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                               return Length( ObjectList( D_1[i_7] ) );
                                                           end ) ) + logic_new_func_i_minor_3], List( [ 1 .. Length( ObjectList( D_1[i_6] ) ) ], function ( k_7 )
                                                          if logic_new_func_i_major_2 = i_6 and logic_new_func_i_minor_3 = k_7 and (logic_new_func_j_major_4 = i_6 and k_7 = logic_new_func_j_minor_5) then
                                                              return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3] );
                                                          else
                                                              return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3], ObjectList( D_1[logic_new_func_j_major_4] )[logic_new_func_j_minor_5] );
                                                          fi;
                                                          return;
                                                      end ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                              return ObjectList( D_1[i_7] );
                                                          end ) )[Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_7 )
                                                               return Length( ObjectList( D_1[i_7] ) );
                                                           end ) ) + logic_new_func_j_minor_5] );
                                            end ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_6 )
                                                    return ObjectList( D_1[i_6] );
                                                end ) )[Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_6 )
                                                     return Length( ObjectList( D_1[i_6] ) );
                                                 end ) ) + logic_new_func_j_minor_5] ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                if Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                return Length( ObjectList( D_1[i_7] ) );
                                                            end ) ) + logic_new_func_i_minor_3 = Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_7 )
                                                                return Length( ObjectList( D_1[i_7] ) );
                                                            end ) ) + logic_new_func_j_minor_5 then
                                                    return IdentityMorphism( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                                  return ObjectList( D_1[i_7] );
                                                              end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                   return Length( ObjectList( D_1[i_7] ) );
                                                               end ) ) + logic_new_func_i_minor_3] );
                                                else
                                                    return ZeroMorphism( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                                  return ObjectList( D_1[i_7] );
                                                              end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                   return Length( ObjectList( D_1[i_7] ) );
                                                               end ) ) + logic_new_func_i_minor_3], Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                                  return ObjectList( D_1[i_7] );
                                                              end ) )[Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_7 )
                                                                   return Length( ObjectList( D_1[i_7] ) );
                                                               end ) ) + logic_new_func_j_minor_5] );
                                                fi;
                                                return;
                                            end )(  ) );
                                end );
                        end );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_minor = k_7 = j_minor`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "i_major", "i_minor", "i_6", "j_major", "j_minor", "obj1", "obj2", "obj3" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, k_7 -> CAP_JIT_INTERNAL_EXPR_CASE( (i_major = i_6 and i_minor = k_7) and (j_major = i_6 and k_7 = j_minor), IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ) ), target )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_6 and j_major = i_6 and i_minor = j_minor, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_2] ) ) ], function ( logic_new_func_i_minor_3 )
                    return ForAll( [ 1 .. Length( D_1 ) ], function ( logic_new_func_j_major_4 )
                            return ForAll( [ 1 .. Length( ObjectList( D_1[logic_new_func_j_major_4] ) ) ], function ( logic_new_func_j_minor_5 )
                                    return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_6 )
                                                    return ObjectList( D_1[i_6] );
                                                end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_6 )
                                                     return Length( ObjectList( D_1[i_6] ) );
                                                 end ) ) + logic_new_func_i_minor_3], List( [ 1 .. Length( D_1 ) ], function ( i_6 )
                                                if logic_new_func_i_major_2 = i_6 and logic_new_func_j_major_4 = i_6 and logic_new_func_i_minor_3 = logic_new_func_j_minor_5 then
                                                    return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3] );
                                                else
                                                    return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3], ObjectList( D_1[logic_new_func_j_major_4] )[logic_new_func_j_minor_5] );
                                                fi;
                                                return;
                                            end ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_6 )
                                                    return ObjectList( D_1[i_6] );
                                                end ) )[Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_6 )
                                                     return Length( ObjectList( D_1[i_6] ) );
                                                 end ) ) + logic_new_func_j_minor_5] ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                if Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                return Length( ObjectList( D_1[i_7] ) );
                                                            end ) ) + logic_new_func_i_minor_3 = Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_7 )
                                                                return Length( ObjectList( D_1[i_7] ) );
                                                            end ) ) + logic_new_func_j_minor_5 then
                                                    return IdentityMorphism( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                                  return ObjectList( D_1[i_7] );
                                                              end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                   return Length( ObjectList( D_1[i_7] ) );
                                                               end ) ) + logic_new_func_i_minor_3] );
                                                else
                                                    return ZeroMorphism( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                                  return ObjectList( D_1[i_7] );
                                                              end ) )[Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                   return Length( ObjectList( D_1[i_7] ) );
                                                               end ) ) + logic_new_func_i_minor_3], Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_7 )
                                                                  return ObjectList( D_1[i_7] );
                                                              end ) )[Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_7 )
                                                                   return Length( ObjectList( D_1[i_7] ) );
                                                               end ) ) + logic_new_func_j_minor_5] );
                                                fi;
                                                return;
                                            end )(  ) );
                                end );
                        end );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_major = i_6 and j_major = i_6 and i_minor = j_minor`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "i_major", "i_minor", "j_major", "j_minor", "obj1", "obj2", "obj3" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_6 -> CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_6 and j_major = i_6 and i_minor = j_minor, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ) ), target )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i_major = j_major and i_minor = j_minor, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) )",
>     )
> );
gap> # Concatenation[i_major * ... + i_minor]
> ApplyLogicTemplateNTimes( 3,
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_7 -> ObjectList( D_1[i_7] ) ) )[Sum( List( [ 1 .. i_major - 1 ], i_7 -> Length( ObjectList( D_1[i_7] ) ) ) ) + i_minor]",
>         dst_template := "D_1[i_major][i_minor]",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_2] ) ) ], function ( logic_new_func_i_minor_3 )
                    return ForAll( [ 1 .. Length( D_1 ) ], function ( logic_new_func_j_major_4 )
                            return ForAll( [ 1 .. Length( ObjectList( D_1[logic_new_func_j_major_4] ) ) ], function ( logic_new_func_j_minor_5 )
                                    return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                if logic_new_func_i_major_2 = logic_new_func_j_major_4 and logic_new_func_i_minor_3 = logic_new_func_j_minor_5 then
                                                    return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3] );
                                                else
                                                    return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3], ObjectList( D_1[logic_new_func_j_major_4] )[logic_new_func_j_minor_5] );
                                                fi;
                                                return;
                                            end )(  ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                if Sum( List( [ 1 .. logic_new_func_i_major_2 - 1 ], function ( i_7 )
                                                                return Length( ObjectList( D_1[i_7] ) );
                                                            end ) ) + logic_new_func_i_minor_3 = Sum( List( [ 1 .. logic_new_func_j_major_4 - 1 ], function ( i_7 )
                                                                return Length( ObjectList( D_1[i_7] ) );
                                                            end ) ) + logic_new_func_j_minor_5 then
                                                    return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3] );
                                                else
                                                    return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_2] )[logic_new_func_i_minor_3], D_1[logic_new_func_j_major_4][logic_new_func_j_minor_5] );
                                                fi;
                                                return;
                                            end )(  ) );
                                end );
                        end );
                end );
        end );
end
gap> # i_major * ... + i_minor = j_major * ... + j_minor
> # CONDITION: the major and minor variables actually come from a decomposition of the object lists
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "j_major", "j_minor" ],
>         src_template := "Sum( List( [ 1 .. i_major - 1 ], i_7 -> Length( ObjectList( D_1[i_7] ) ) ) ) + i_minor = Sum( List( [ 1 .. j_major - 1 ], i_7 -> Length( ObjectList( D_1[i_7] ) ) ) ) + j_minor",
>         dst_template := "i_major = j_major and i_minor = j_minor",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# injection * projection is zero or identity
gap> StateNextLemma( );


Lemma 5:
In AdditiveClosure( a preadditive category ), injections in cofactors of direct sums followed by projections are zeros or identities:
For a list of objects D and two integers i and j such that
• 1 <= i,
• i <= Length( D ),
• 1 <= j,
• j <= Length( D ),
we have
function ( cat, D, i, j )
    return IsCongruentForMorphisms( cat, PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, D, i ), ProjectionInFactorOfDirectSum( cat, D, j ) ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, D[i] ), true, ZeroMorphism( cat, D[i], D[j] ) ) );
end
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # List( if-else, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "func" ],
>         variable_filters := [ IsBool, IsList, IsList, IsFunction ],
>         src_template := "List( CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 ), func )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, List( value1, func ), true, List( value2, func ) )",
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # pull common List out of CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "i", "j", "list", "func1", "func2" ],
>         variable_filters := [ IsInt, IsInt, IsList, IsFunction, IsFunction ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( j = i, List( [ 1 .. Length( ObjectList( list[i] ) ) ], func1 ), true, List( [ 1 .. Length( ObjectList( list[j] ) ) ], func2 ) )",
>         dst_template := "List( [ 1 .. Length( ObjectList( list[j] ) ) ], x -> CAP_JIT_INTERNAL_EXPR_CASE( j = i, func1( x ), true, func2( x ) ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # flatten CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "P", "Q", "if_if_value", "if_else_value", "else_else_value" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, CAP_JIT_INTERNAL_EXPR_CASE( Q, if_if_value, true, if_else_value ), true, else_else_value )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, if_if_value, P, if_else_value, true, else_else_value )",
>     )
> );
gap> # decompose SumOfMorphisms over a concatenation of lists
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "D_1", "func" ],
>         src_template := "SumOfMorphisms( cat, source, List( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) ], func ), target )",
>         dst_template := "SumOfMorphisms( cat, source, List( [ 1 .. Length( D_1 ) ], i_major -> SumOfMorphisms( cat, source, List( [ 1 .. Length( ObjectList( D_1[i_major] ) ) ], i_minor -> func( Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor ) ), target ) ), target )",
>         new_funcs := [ [ "i_major" ], [ "i_minor" ] ],
>     )
> );
gap> # Concatenation[i_major * ... + i_minor]
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "value" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_6 -> List( [ 1 .. Length( ObjectList( D_1[i_6] ) ) ], x_7 -> value ) ) )[Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor]",
>         dst_template := "(i_6 -> (x_7 -> value)(i_minor))(i_major)",
>     )
> );
gap> # composition of identites and zero morphisms
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "P", "Q", "obj1", "obj2", "obj3", "obj4" ],
>         src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj1, obj2 ) ), CAP_JIT_INTERNAL_EXPR_CASE( Q, IdentityMorphism( cat, obj3 ), true, ZeroMorphism( cat, obj2, obj4 ) ) )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj1, obj4 ) )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, i_1, j_1 )
    return ForAll( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[j_1] ) ) ], function ( j_3 )
                    return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_4 )
                                return SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2], List( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_4] ) ) ], function ( logic_new_func_i_minor_5 )
                                          if logic_new_func_i_major_4 = i_1 and i_2 = logic_new_func_i_minor_5 and (logic_new_func_i_major_4 = j_1 and logic_new_func_i_minor_5 = j_3) then
                                              return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2] );
                                          else
                                              return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2], ObjectList( D_1[j_1] )[j_3] );
                                          fi;
                                          return;
                                      end ), ObjectList( D_1[j_1] )[j_3] );
                            end ), ObjectList( D_1[j_1] )[j_3] ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                    if i_1 = j_1 then
                                        return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_6 )
                                                        if i_5 = j_6 then
                                                            return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5] );
                                                        else
                                                            return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[i_1] )[j_6] );
                                                        fi;
                                                        return;
                                                    end );
                                            end );
                                    else
                                        return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                return List( [ 1 .. Length( ObjectList( D_1[j_1] ) ) ], function ( j_6 )
                                                        return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[j_1] )[j_6] );
                                                    end );
                                            end );
                                    fi;
                                    return;
                                end )(  )[i_2][j_3] );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_2 = i_minor = j_3`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "i_major", "i_1", "i_2", "j_1", "j_3", "obj1", "obj2", "obj3" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_minor -> CAP_JIT_INTERNAL_EXPR_CASE( (i_major = i_1 and i_2 = i_minor) and (i_major = j_1 and i_minor = j_3), IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ) ), target )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_1 and i_major = j_1 and i_2 = j_3, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, i_1, j_1 )
    return ForAll( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[j_1] ) ) ], function ( j_3 )
                    return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_4 )
                                if logic_new_func_i_major_4 = i_1 and logic_new_func_i_major_4 = j_1 and i_2 = j_3 then
                                    return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2] );
                                else
                                    return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_2], ObjectList( D_1[j_1] )[j_3] );
                                fi;
                                return;
                            end ), ObjectList( D_1[j_1] )[j_3] ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                    if i_1 = j_1 then
                                        return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( j_6 )
                                                        if i_5 = j_6 then
                                                            return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5] );
                                                        else
                                                            return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[i_1] )[j_6] );
                                                        fi;
                                                        return;
                                                    end );
                                            end );
                                    else
                                        return List( [ 1 .. Length( ObjectList( D_1[i_1] ) ) ], function ( i_5 )
                                                return List( [ 1 .. Length( ObjectList( D_1[j_1] ) ) ], function ( j_6 )
                                                        return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_1] )[i_5], ObjectList( D_1[j_1] )[j_6] );
                                                    end );
                                            end );
                                    fi;
                                    return;
                                end )(  )[i_2][j_3] );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_major = i_1 and i_major = j_1 and i_2 = j_3`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "i_1", "i_2", "j_1", "j_3", "obj1", "obj2", "obj3" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_major -> CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_1 and i_major = j_1 and i_2 = j_3, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ) ), target )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i_1 = j_1 and i_2 = j_3, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) )",
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # flatten CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "Q", "if_if_value", "if_else_value", "else_else_value" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, CAP_JIT_INTERNAL_EXPR_CASE( Q, if_if_value, true, if_else_value ), true, else_else_value )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, if_if_value, P, if_else_value, true, else_else_value )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# UniversalMorphismIntoDirectSum well-defined
gap> StateNextLemma( );


Lemma 6:
In AdditiveClosure( a preadditive category ), universal morphisms into direct sums define morphisms:
For a list of objects D, an object T, and a list of morphisms tau such that
• Length( tau ) = Length( D ),
• Source( tau[i] ) = T,
• Range( tau[i] ) = D[i],
we have
function ( cat, D, T, tau )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, T, UniversalMorphismIntoDirectSum( cat, D, T, tau ), DirectSum( cat, D ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    if not (IsList( UnionOfColumnsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) ) ) and Length( UnionOfColumnsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) ) ) = Length( ObjectList( T_1 ) )) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( i_2 )
                 return (IsList( UnionOfColumnsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) )[i_2] ) and Length( UnionOfColumnsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) )[i_2] ) = Sum( List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                               return Length( ObjectList( D_1[i_3] ) );
                           end ) ));
             end ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], function ( i_3 )
                                 return Length( ObjectList( D_1[i_3] ) );
                             end ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_2], UnionOfColumnsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) )[i_2][j_3], Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_4 )
                                       return ObjectList( D_1[i_4] );
                                   end ) )[j_3] );
                     end );
             end ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> # normalize List( tau, func )
> ApplyLogicTemplateNTimes( 4,
>     rec(
>         variable_names := [ "tau", "func" ],
>         variable_filters := [ CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ), IsFunction ],
>         src_template := "List( tau, func )",
>         dst_template := "List( [ 1 .. Length( tau ) ], i -> func( tau[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # Length( UnionOfColumnsListList )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "list_of_matrices" ],
>         variable_filters := [ IsInt, IsList ],
>         src_template := "Length( UnionOfColumnsListList( nr_rows, list_of_matrices ) )",
>         dst_template := "nr_rows",
>     )
> );
gap> # Length( UnionOfColumnsListList( ... )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_of_matrices", "nr_rows", "i" ],
>         variable_filters := [ IsList, IsInt, IsInt ],
>         src_template := "Length( UnionOfColumnsListList( nr_rows, list_of_matrices )[i] )",
>         dst_template := "Sum( List( list_of_matrices, M -> Length( M[i] ) ) )",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # Length( MorphismMatrix( additive_closure_morphism )[i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt ],
>         src_template := "Length( MorphismMatrix( additive_closure_morphism )[i] )",
>         dst_template := "NrCols( additive_closure_morphism )",
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # func( Concatenation( ... )[i] )
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "func", "list_of_lists", "i" ],
>         variable_filters := [ IsFunction, IsList, IsInt ],
>         src_template := "func( Concatenation( list_of_lists )[i] )",
>         dst_template := "Concatenation( List( list_of_lists, list -> List( list, func ) ) )[i]",
>         new_funcs := [ [ "list" ] ],
>     )
> );
gap> # List( MorphismMatrix( additive_closure_morphism )[i], Source )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt ],
>         src_template := "List( MorphismMatrix( additive_closure_morphism )[i], Source )",
>         dst_template := "ListWithIdenticalEntries( NrCols( additive_closure_morphism ), ObjectList( Source( additive_closure_morphism ) )[i] )",
>     )
> );
gap> # List( MorphismMatrix( additive_closure_morphism )[i], Range )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt ],
>         src_template := "List( MorphismMatrix( additive_closure_morphism )[i], Range )",
>         dst_template := "ObjectList( Range( additive_closure_morphism ) )",
>     )
> );
gap> # Concatenation( ListWithIdenticalEntries )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "nr", "value", "i" ],
>         variable_filters := [ IsList, IsInt, IsObject, IsInt ],
>         src_template := "Concatenation( List( list, j -> ListWithIdenticalEntries( nr, value ) ) )[i]",
>         dst_template := "value",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# UniversalMorphismIntoDirectSum * ProjectionInFactorOfDirectSum gives a component
gap> StateNextLemma( );


Lemma 7:
In AdditiveClosure( a preadditive category ), composing a universal morphism into a direct sum with a projection gives a component:
For a list of objects D, an object T, and a list of morphisms tau such that
• Length( tau ) = Length( D ),
• Source( tau[i] ) = T,
• Range( tau[i] ) = D[i],
we have
function ( cat, D, T, tau )
    return ForAll( [ 1 .. Length( D ) ], function ( i )
            return IsCongruentForMorphisms( cat, PreCompose( cat, UniversalMorphismIntoDirectSum( cat, D, T, tau ), ProjectionInFactorOfDirectSum( cat, D, i ) ), tau[i] );
        end );
end
gap> # normalize List( tau, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "tau", "func" ],
>         variable_filters := [ CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ), IsFunction ],
>         src_template := "List( tau, func )",
>         dst_template := "List( [ 1 .. Length( tau ) ], i -> func( tau[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # pull common List out of CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "i", "j", "list", "func1", "func2" ],
>         variable_filters := [ IsInt, IsInt, IsList, IsFunction, IsFunction ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( j = i, List( [ 1 .. Length( ObjectList( list[i] ) ) ], func1 ), true, List( [ 1 .. Length( ObjectList( list[j] ) ) ], func2 ) )",
>         dst_template := "List( [ 1 .. Length( ObjectList( list[j] ) ) ], x -> CAP_JIT_INTERNAL_EXPR_CASE( j = i, func1( x ), true, func2( x ) ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # CAP_JIT_INTERNAL_EXPR_CASE( ... )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "value1", "value2", "i" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1, true, value2 )[i]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, value1[i], true, value2[i] )",
>     )
> );
gap> # decompose SumOfMorphisms over a concatenation of lists
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "D_1", "func" ],
>         src_template := "SumOfMorphisms( cat, source, List( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) ], func ), target )",
>         dst_template := "SumOfMorphisms( cat, source, List( [ 1 .. Length( D_1 ) ], i_major -> SumOfMorphisms( cat, source, List( [ 1 .. Length( ObjectList( D_1[i_major] ) ) ], i_minor -> func( Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor ) ), target ) ), target )",
>         new_funcs := [ [ "i_major" ], [ "i_minor" ] ],
>     )
> );
gap> # Concatenation[i_major * ... + i_minor]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "value" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_6 -> List( [ 1 .. Length( ObjectList( D_1[i_6] ) ) ], x_7 -> value ) ) )[Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor]",
>         dst_template := "(i_6 -> (x_7 -> value)(i_minor))(i_major)",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( i_3 )
                    return ForAll( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( j_4 )
                            return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_5 )
                                        return SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], List( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_5] ) ) ], function ( logic_new_func_i_minor_6 )
                                                  return PreCompose( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_7 )
                                                                return MorphismMatrix( tau_1[logic_new_func_i_7] )[i_3];
                                                            end ) )[Sum( List( [ 1 .. logic_new_func_i_major_5 - 1 ], function ( i_7 )
                                                                 return Length( ObjectList( D_1[i_7] ) );
                                                             end ) ) + logic_new_func_i_minor_6], CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                              if logic_new_func_i_major_5 = i_2 then
                                                                  return CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                                            if logic_new_func_i_minor_6 = j_4 then
                                                                                return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[logic_new_func_i_minor_6] );
                                                                            else
                                                                                return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[logic_new_func_i_minor_6], ObjectList( D_1[i_2] )[j_4] );
                                                                            fi;
                                                                            return;
                                                                        end )(  );
                                                              else
                                                                  return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[logic_new_func_i_major_5] )[logic_new_func_i_minor_6], ObjectList( D_1[i_2] )[j_4] );
                                                              fi;
                                                              return;
                                                          end )(  ) );
                                              end ), ObjectList( D_1[i_2] )[j_4] );
                                    end ), ObjectList( D_1[i_2] )[j_4] ), MorphismMatrix( tau_1[i_2] )[i_3][j_4] );
                        end );
                end );
        end );
end
gap> # Concatenation[i_major * ... + i_minor]
> # CONDITION: `value` has length `Length( ObjectList( D_1[i_6] ) )`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "value" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_6 -> value ) )[Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor]",
>         dst_template := "(i_6 -> value[i_minor])(i_major)",
>     )
> );
gap> # flatten CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "Q", "if_if_value", "if_else_value", "else_else_value" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, CAP_JIT_INTERNAL_EXPR_CASE( Q, if_if_value, true, if_else_value ), true, else_else_value )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, if_if_value, P, if_else_value, true, else_else_value )",
>     )
> );
gap> # composition of identites and zero morphisms
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "tau", "P", "obj1", "obj2", "obj3" ],
>         src_template := "PreCompose( cat, tau, CAP_JIT_INTERNAL_EXPR_CASE( P, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ) )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, tau, true, ZeroMorphism( cat, Source( tau ), obj3 ) )",
>     )
> );
gap> # Source( MorphismMatrix )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( i_3 )
                    return ForAll( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( j_4 )
                            return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_5 )
                                        return SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], List( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_5] ) ) ], function ( logic_new_func_i_minor_6 )
                                                  if logic_new_func_i_major_5 = i_2 and logic_new_func_i_minor_6 = j_4 then
                                                      return MorphismMatrix( tau_1[logic_new_func_i_major_5] )[i_3][logic_new_func_i_minor_6];
                                                  else
                                                      return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], ObjectList( D_1[i_2] )[j_4] );
                                                  fi;
                                                  return;
                                              end ), ObjectList( D_1[i_2] )[j_4] );
                                    end ), ObjectList( D_1[i_2] )[j_4] ), MorphismMatrix( tau_1[i_2] )[i_3][j_4] );
                        end );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_minor = j_4`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "list2", "i_major", "i_2", "j_4" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_minor -> CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_2 and i_minor = j_4, list2[i_minor], true, ZeroMorphism( cat, source, target ) ) ), target )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_2, list2[j_4], true, ZeroMorphism( cat, source, target ) )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( i_3 )
                    return ForAll( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( j_4 )
                            return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_5 )
                                        if logic_new_func_i_major_5 = i_2 then
                                            return MorphismMatrix( tau_1[logic_new_func_i_major_5] )[i_3][j_4];
                                        else
                                            return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( T_1 )[i_3], ObjectList( D_1[i_2] )[j_4] );
                                        fi;
                                        return;
                                    end ), ObjectList( D_1[i_2] )[j_4] ), MorphismMatrix( tau_1[i_2] )[i_3][j_4] );
                        end );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_major = i_2`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "tau", "i_2", "i_3", "j_4" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_major -> CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_2, MorphismMatrix( tau[i_major] )[i_3][j_4], true, ZeroMorphism( cat, source, target ) ) ), target )",
>         dst_template := "MorphismMatrix( tau[i_2] )[i_3][j_4]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# UniversalMorphismFromDirectSum well-defined
gap> StateNextLemma( );


Lemma 8:
In AdditiveClosure( a preadditive category ), universal morphisms from direct sums define morphisms:
For a list of objects D, an object T, and a list of morphisms tau such that
• Length( tau ) = Length( D ),
• Source( tau[i] ) = D[i],
• Range( tau[i] ) = T,
we have
function ( cat, D, T, tau )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, DirectSum( cat, D ), UniversalMorphismFromDirectSum( cat, D, T, tau ), T );
end
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    if not (IsList( UnionOfRowsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) ) ) and Length( UnionOfRowsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) ) ) = Sum( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                       return Length( ObjectList( D_1[i_2] ) );
                   end ) )) then
        return false;
    elif not ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                         return Length( ObjectList( D_1[i_2] ) );
                     end ) ) ], function ( i_2 )
                 return (IsList( UnionOfRowsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) )[i_2] ) and Length( UnionOfRowsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) )[i_2] ) = Length( ObjectList( T_1 ) ));
             end ) then
        return false;
    elif not ForAll( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], function ( i_2 )
                         return Length( ObjectList( D_1[i_2] ) );
                     end ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( i_4 )
                                       return ObjectList( D_1[i_4] );
                                   end ) )[i_2], UnionOfRowsListList( Length( ObjectList( T_1 ) ), List( tau_1, MorphismMatrix ) )[i_2][j_3], ObjectList( T_1 )[j_3] );
                     end );
             end ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> # normalize List( tau, func )
> ApplyLogicTemplateNTimes( 4,
>     rec(
>         variable_names := [ "tau", "func" ],
>         variable_filters := [ CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ), IsFunction ],
>         src_template := "List( tau, func )",
>         dst_template := "List( [ 1 .. Length( tau ) ], i -> func( tau[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # Length( UnionOfRowsListList( ... ) [i] )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "list_of_matrices", "i" ],
>         variable_filters := [ IsInt, IsList, IsInt ],
>         src_template := "Length( UnionOfRowsListList( nr_cols, list_of_matrices ) [i] )",
>         dst_template := "nr_cols",
>     )
> );
gap> # Length( UnionOfRowsListList )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_of_matrices", "nr_cols" ],
>         variable_filters := [ IsList, IsInt ],
>         src_template := "Length( UnionOfRowsListList( nr_cols, list_of_matrices ) )",
>         dst_template := "Sum( List( list_of_matrices, Length ) )",
>     )
> );
gap> # Length( MorphismMatrix( additive_closure_morphism ) )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism" ],
>         variable_filters := [ IsAdditiveClosureMorphism ],
>         src_template := "Length( MorphismMatrix( additive_closure_morphism ) )",
>         dst_template := "NrRows( additive_closure_morphism )",
>     )
> );
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # func( Concatenation( ... )[i] )
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "func", "list_of_lists", "i" ],
>         variable_filters := [ IsFunction, IsList, IsInt ],
>         src_template := "func( Concatenation( list_of_lists )[i] )",
>         dst_template := "Concatenation( List( list_of_lists, list -> List( list, func ) ) )[i]",
>         new_funcs := [ [ "list" ] ],
>     )
> );
gap> # List( MorphismMatrix( additive_closure_morphism ), Source( ... ) )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt ],
>         src_template := "List( MorphismMatrix( additive_closure_morphism ), row -> Source( row[j] ) )",
>         dst_template := "ObjectList( Source( additive_closure_morphism ) )",
>     )
> );
gap> # List( MorphismMatrix( additive_closure_morphism ), Range( ... ) )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt ],
>         src_template := "List( MorphismMatrix( additive_closure_morphism ), row -> Range( row[j] ) )",
>         dst_template := "ListWithIdenticalEntries( NrRows( additive_closure_morphism ), ObjectList( Range( additive_closure_morphism ) )[j] )",
>     )
> );
gap> # Concatenation( ListWithIdenticalEntries )[i]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "nr", "value", "i" ],
>         variable_filters := [ IsList, IsInt, IsObject, IsInt ],
>         src_template := "Concatenation( List( list, j -> ListWithIdenticalEntries( nr, value ) ) )[i]",
>         dst_template := "value",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InjectionOfCofactorOfDirectSum * UniversalMorphismFromDirectSum gives a component
gap> StateNextLemma( );


Lemma 9:
In AdditiveClosure( a preadditive category ), composing an injection of a cofactor of a direct sum with a universal morphism from a direct sum gives a component:
For a list of objects D, an object T, and a list of morphisms tau such that
• Length( tau ) = Length( D ),
• Source( tau[i] ) = D[i],
• Range( tau[i] ) = T,
we have
function ( cat, D, T, tau )
    return ForAll( [ 1 .. Length( D ) ], function ( i )
            return IsCongruentForMorphisms( cat, PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, D, i ), UniversalMorphismFromDirectSum( cat, D, T, tau ) ), tau[i] );
        end );
end
gap> # normalize List( tau, func )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "tau", "func" ],
>         variable_filters := [ CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ), IsFunction ],
>         src_template := "List( tau, func )",
>         dst_template := "List( [ 1 .. Length( tau ) ], i -> func( tau[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # UnionOfColumnsListList( nr_rows, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_rows", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfColumnsListList( nr_rows, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> M[i] ) )[j]",
>         new_funcs := [ [ "M" ] ],
>     )
> );
gap> # UnionOfRowsListList( nr_cols, L )[i][j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "nr_cols", "matrices", "i", "j" ],
>         variable_filters := [ IsInt, IsList, IsInt, IsInt ],
>         src_template := "UnionOfRowsListList( nr_cols, matrices )[i][j]",
>         dst_template := "Concatenation( List( matrices, M -> List( M, row -> row[j] ) ) )[i]",
>         new_funcs := [ [ "M" ], [ "row" ] ],
>     )
> );
gap> # pull common List out of CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "i", "j", "list", "func1", "func2" ],
>         variable_filters := [ IsInt, IsInt, IsList, IsFunction, IsFunction ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( j = i, List( [ 1 .. Length( ObjectList( list[i] ) ) ], func1 ), true, List( [ 1 .. Length( ObjectList( list[i] ) ) ], func2 ) )",
>         dst_template := "List( [ 1 .. Length( ObjectList( list[i] ) ) ], x -> CAP_JIT_INTERNAL_EXPR_CASE( j = i, func1( x ), true, func2( x ) ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # decompose SumOfMorphisms over a concatenation of lists
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "D_1", "func" ],
>         src_template := "SumOfMorphisms( cat, source, List( [ 1 .. Sum( List( [ 1 .. Length( D_1 ) ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) ], func ), target )",
>         dst_template := "SumOfMorphisms( cat, source, List( [ 1 .. Length( D_1 ) ], i_major -> SumOfMorphisms( cat, source, List( [ 1 .. Length( ObjectList( D_1[i_major] ) ) ], i_minor -> func( Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor ) ), target ) ), target )",
>         new_funcs := [ [ "i_major" ], [ "i_minor" ] ],
>     )
> );
gap> # pull common List out of CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "i", "j", "list", "func1", "func2" ],
>         variable_filters := [ IsInt, IsInt, IsList, IsFunction, IsFunction ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( j = i, List( [ 1 .. Length( ObjectList( list[i] ) ) ], func1 ), true, List( [ 1 .. Length( ObjectList( list[j] ) ) ], func2 ) )",
>         dst_template := "List( [ 1 .. Length( ObjectList( list[j] ) ) ], x -> CAP_JIT_INTERNAL_EXPR_CASE( j = i, func1( x ), true, func2( x ) ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # Concatenation[i_major * ... + i_minor]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "value" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_6 -> List( [ 1 .. Length( ObjectList( D_1[i_6] ) ) ], x_7 -> value ) ) )[Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor]",
>         dst_template := "(i_6 -> (x_7 -> value)(i_minor))(i_major)",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( i_3 )
                    return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( j_4 )
                            return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_5 )
                                        return SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], List( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_5] ) ) ], function ( logic_new_func_i_minor_6 )
                                                  return PreCompose( UnderlyingCategory( cat_1 ), CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                              if logic_new_func_i_major_5 = i_2 then
                                                                  return CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                                                            if i_3 = logic_new_func_i_minor_6 then
                                                                                return IdentityMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3] );
                                                                            else
                                                                                return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], ObjectList( D_1[i_2] )[logic_new_func_i_minor_6] );
                                                                            fi;
                                                                            return;
                                                                        end )(  );
                                                              else
                                                                  return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], ObjectList( D_1[logic_new_func_i_major_5] )[logic_new_func_i_minor_6] );
                                                              fi;
                                                              return;
                                                          end )(  ), Concatenation( List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_7 )
                                                                return List( MorphismMatrix( tau_1[logic_new_func_i_7] ), function ( logic_new_func_row_8 )
                                                                        return logic_new_func_row_8[j_4];
                                                                    end );
                                                            end ) )[Sum( List( [ 1 .. logic_new_func_i_major_5 - 1 ], function ( i_7 )
                                                                 return Length( ObjectList( D_1[i_7] ) );
                                                             end ) ) + logic_new_func_i_minor_6] );
                                              end ), ObjectList( T_1 )[j_4] );
                                    end ), ObjectList( T_1 )[j_4] ), MorphismMatrix( tau_1[i_2] )[i_3][j_4] );
                        end );
                end );
        end );
end
gap> # Concatenation[i_major * ... + i_minor]
> # CONDITION: `value` has length `Length( ObjectList( D_1[i_6] ) )`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "D_1", "i_major", "i_minor", "value" ],
>         src_template := "Concatenation( List( [ 1 .. Length( D_1 ) ], i_6 -> value ) )[Sum( List( [ 1 .. i_major - 1 ], i_2 -> Length( ObjectList( D_1[i_2] ) ) ) ) + i_minor]",
>         dst_template := "(i_6 -> value[i_minor])(i_major)",
>     )
> );
gap> # flatten CAP_JIT_INTERNAL_EXPR_CASE
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "P", "Q", "if_if_value", "if_else_value", "else_else_value" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, CAP_JIT_INTERNAL_EXPR_CASE( Q, if_if_value, true, if_else_value ), true, else_else_value )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P and Q, if_if_value, P, if_else_value, true, else_else_value )",
>     )
> );
gap> # composition of identites and zero morphisms
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "tau", "P", "obj1", "obj2", "obj3" ],
>         src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, IdentityMorphism( cat, obj1 ), true, ZeroMorphism( cat, obj2, obj3 ) ), tau )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, tau, true, ZeroMorphism( cat, obj2, Range( tau ) ) )",
>     )
> );
gap> # Range( MorphismMatrix )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Range( additive_closure_morphism ) )[j]",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( i_3 )
                    return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( j_4 )
                            return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_5 )
                                        return SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], List( [ 1 .. Length( ObjectList( D_1[logic_new_func_i_major_5] ) ) ], function ( logic_new_func_i_minor_6 )
                                                  if logic_new_func_i_major_5 = i_2 and i_3 = logic_new_func_i_minor_6 then
                                                      return MorphismMatrix( tau_1[logic_new_func_i_major_5] )[logic_new_func_i_minor_6][j_4];
                                                  else
                                                      return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], ObjectList( T_1 )[j_4] );
                                                  fi;
                                                  return;
                                              end ), ObjectList( T_1 )[j_4] );
                                    end ), ObjectList( T_1 )[j_4] ), MorphismMatrix( tau_1[i_2] )[i_3][j_4] );
                        end );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_3 = i_minor`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "list2", "i_major", "i_2", "i_3", "j_4" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_minor -> CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_2 and i_3 = i_minor, list2[i_minor][j_4], true, ZeroMorphism( cat, source, target ) ) ), target )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_2, list2[i_3][j_4], true, ZeroMorphism( cat, source, target ) )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, D_1, T_1, tau_1 )
    return ForAll( [ 1 .. Length( D_1 ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1[i_2] ) ) ], function ( i_3 )
                    return ForAll( [ 1 .. Length( ObjectList( T_1 ) ) ], function ( j_4 )
                            return IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], List( [ 1 .. Length( D_1 ) ], function ( logic_new_func_i_major_5 )
                                        if logic_new_func_i_major_5 = i_2 then
                                            return MorphismMatrix( tau_1[logic_new_func_i_major_5] )[i_3][j_4];
                                        else
                                            return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( D_1[i_2] )[i_3], ObjectList( T_1 )[j_4] );
                                        fi;
                                        return;
                                    end ), ObjectList( T_1 )[j_4] ), MorphismMatrix( tau_1[i_2] )[i_3][j_4] );
                        end );
                end );
        end );
end
gap> # drop zeros in sum
> # CONDITION: the if-case occurs exactly once, if `i_major = i_2`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "tau", "i_2", "i_3", "j_4" ],
>         src_template := "SumOfMorphisms( cat, source, List( list, i_major -> CAP_JIT_INTERNAL_EXPR_CASE( i_major = i_2, MorphismMatrix( tau[i_major] )[i_3][j_4], true, ZeroMorphism( cat, source, target ) ) ), target )",
>         dst_template := "MorphismMatrix( tau[i_2] )[i_3][j_4]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> AssertProposition( );


Summing up, we have shown:
AdditiveClosure( a preadditive category ) has direct sums. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "AdditiveClosure_has_direct_sums" );
