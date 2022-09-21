gap> START_TEST( "CapJitDeduplicatedExpressions" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

##
# duplicate code inside a function
gap> func := function( x ) return List( [ 1 .. 9 ], y -> (y + (x + 1)) + (y + (x + 1)) ); end;;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitDeduplicatedExpressions( tree );;
gap> compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( compiled_func );
function ( x_1 )
    return List( [ 1 .. 9 ], function ( y_2 )
            local deduped_1_2;
            deduped_1_2 := y_2 + (x_1 + 1);
            return deduped_1_2 + deduped_1_2;
        end );
end

##
# duplicate code inside duplicate code
gap> func := function( x, y ) return (y + (x + 1) + (x + 1)) + (y + (x + 1) + (x + 1)); end;;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitDeduplicatedExpressions( tree );;
gap> compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( compiled_func );
function ( x_1, y_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := x_1 + 1;
    deduped_1_1 := y_1 + deduped_2_1 + deduped_2_1;
    return deduped_1_1 + deduped_1_1;
end

##
# don't deduplicate code accross functions
gap> func := function( ) return [ [ x -> (x + 1) + 2 ], [ x -> (x + 1) + 3 ] ]; end;;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitDeduplicatedExpressions( tree );;
gap> compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( compiled_func );
function (  )
    return [ [ function ( x_2 )
                  return x_2 + 1 + 2;
              end ], [ function ( x_2 )
                  return x_2 + 1 + 3;
              end ] ];
end

##
# duplicate code inside duplicate code at different function levels
gap> func := {} -> y -> [ [ y, x -> (x + 1) + (x + 1) ], [ y, x -> (x + 1) + (x + 1) ] ];;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitDeduplicatedExpressions( tree );;
gap> compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( compiled_func );
function (  )
    return function ( y_2 )
          local deduped_1_2;
          deduped_1_2 := [ y_2, function ( x_3 )
                    local deduped_1_3;
                    deduped_1_3 := x_3 + 1;
                    return deduped_1_3 + deduped_1_3;
                end ];
          return [ deduped_1_2, deduped_1_2 ];
      end;
end

##
# deduplication after hoisting in duplicated code
gap> func := { f, L } -> [ f( y -> List( L, l -> y + y ) ), f( y -> List( L, l -> y + y ) ) ];;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitHoistedExpressions( tree );;
gap> tree := CapJitDeduplicatedExpressions( tree );;
gap> compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( compiled_func );
function ( f_1, L_1 )
    local deduped_1_1;
    deduped_1_1 := f_1( function ( y_2 )
            local hoisted_1_2;
            hoisted_1_2 := y_2 + y_2;
            return List( L_1, function ( l_3 )
                    return hoisted_1_2;
                end );
        end );
    return [ deduped_1_1, deduped_1_1 ];
end

##
# make sure that ignoring paths in replaced paths works as expected
gap> func := {} -> [ [ [ [ 1 ] ], [ [ 1 ] ] ], [ [ [ 1 ] ], [ [ 1 ] ] ] ];;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitDeduplicatedExpressions( tree );;
gap> compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( compiled_func );
function (  )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := [ [ 1 ] ];
    deduped_1_1 := [ deduped_2_1, deduped_2_1 ];
    return [ deduped_1_1, deduped_1_1 ];
end

#
gap> STOP_TEST( "CapJitDeduplicatedExpressions" );
