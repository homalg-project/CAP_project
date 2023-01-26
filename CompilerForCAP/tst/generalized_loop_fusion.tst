gap> START_TEST( "generalized_loop_fusion" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# case: no enclosing domain
gap> func := function ( L, func, index )
>   
>   return List( L, func )[index];
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( L_1, func_1, index_1 )
    return func_1( CAP_JIT_INCOMPLETE_LOGIC( L_1[index_1] ) );
end

# case: enclosing domain with unkown size
gap> func := function ( L1, L2, func )
>   
>   return List( L1, l ->
>       List( L2, func )[l]
>   );
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( L1_1, L2_1, func_1 )
    local hoisted_1_1;
    hoisted_1_1 := List( L2_1, func_1 );
    return List( L1_1, function ( l_2 )
            return hoisted_1_1[l_2];
        end );
end

# case: enclosing domain equal to domain
gap> func := function ( L, func )
>   
>   return List( L, l ->
>       List( L, func )[l]
>   );
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( L_1, func_1 )
    return List( L_1, function ( l_2 )
            return func_1( CAP_JIT_INCOMPLETE_LOGIC( L_1[l_2] ) );
        end );
end

# case: enclosing domain equal to domain, Filtered instead of List
gap> func := function ( L, func )
>   
>   return Filtered( L, l ->
>       List( L, func )[l]
>   );
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( L_1, func_1 )
    return Filtered( L_1, function ( l_2 )
            return func_1( CAP_JIT_INCOMPLETE_LOGIC( L_1[l_2] ) );
        end );
end

# case: enclosing domain constructed from filtered domain
gap> func := function ( L, filter_func, func )
>   local sublist;
>   
>   sublist := Filtered( L, filter_func );
>   
>   return List( [ 0 .. Length( sublist ) - 1 ], l ->
>       List( L, func )[l]
>   );
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( L_1, filter_func_1, func_1 )
    return List( [ 0 .. Length( Filtered( L_1, filter_func_1 ) ) - 1 ], 
       function ( l_2 )
            return func_1( CAP_JIT_INCOMPLETE_LOGIC( L_1[l_2] ) );
        end );
end

# simplify [ 1 .. last ][x]
gap> func := function ( last, func, index )
>   
>   return List( [ 1 .. last ], func )[index];
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( last_1, func_1, index_1 )
    return func_1( CAP_JIT_INCOMPLETE_LOGIC( index_1 ) );
end

# simplify [ 0 .. last ][1 + x]
gap> func := function ( last, func, index )
>   
>   return List( [ 0 .. last ], func )[1 + index];
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( last_1, func_1, index_1 )
    return func_1( CAP_JIT_INCOMPLETE_LOGIC( index_1 ) );
end

# simplify nested CAP_JIT_INCOMPLETE_LOGIC
gap> func := function ( last, func, index )
>   
>   return List( [ 1 .. last ], x -> List( [ 1 .. last ], func )[x] )[index];
>   
> end;;
gap> Display( CapJitCompiledFunction( func ) );
function ( last_1, func_1, index_1 )
    return func_1( CAP_JIT_INCOMPLETE_LOGIC( index_1 ) );
end

#
gap> STOP_TEST( "generalized_loop_fusion" );
