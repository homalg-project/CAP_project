gap> START_TEST( "CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL" );

#
gap> LoadPackage( "LinearAlgebraForCAP", false );
true

#
gap> Q := HomalgFieldOfRationals();;
gap> rows := MatrixCategory( Q );;

#
gap> MyKernelLift := function( cat, mor, test_mor )
>     #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
>     return LiftOrFail( cat, test_mor, KernelEmbedding( cat, mor ) ); end;;

#
gap> compiled_func := CapJitCompiledFunction( MyKernelLift, rows );;
WARNING: Compiling CAP operation LiftOrFail with return_type morphism_or_fail.\
 Operations returning fail usually do not fulfill the requirements that all br\
anches of an if statement can be executed even if the corresponding condition \
does not hold. This might cause errors.
gap> Display( compiled_func );
function ( cat_1, mor_1, test_mor_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SafeRightDivide( AsHomalgMatrix( test_mor_1 ), 
       SyzygiesOfRows( AsHomalgMatrix( mor_1 ) ) );
    return AsCapCategoryMorphism( cat_1, Source( test_mor_1 ), 
       morphism_attr_1_1, 
       AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end

#
gap> func1 := function( x )
>     #% CAP_JIT_RESOLVE_FUNCTION
>     if x = 1 then return fail; fi; return 1; end;;

#
gap> func2 := function( x )
>     #% CAP_JIT_RESOLVE_FUNCTION
>     if x = 1 then return fail; else return 1; fi; end;;

#
gap> call_func1 := function( x )
>     #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
>     return func1( x ); end;;

#
gap> call_func2 := function( x )
>     #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
>     return func2( x ); end;;

#
gap> Display( CapJitCompiledFunction( call_func1 ) );
function ( x_1 )
    return 1;
end
gap> Display( CapJitCompiledFunction( call_func2 ) );
function ( x_1 )
    return 1;
end

#
gap> call_func := function( x )
>   local value;
>   
>   #% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
>   value := func2( x );
>   
>   return value;
> end;;

#
gap> Display( CapJitCompiledFunction( call_func ) );
function ( x_1 )
    return 1;
end

#
gap> STOP_TEST( "CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL" );
