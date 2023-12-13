gap> START_TEST( "CapJitDroppedHandledEdgeCases" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := function( x )
>   local inner_func1, inner_func2;
>     
>     inner_func1 := function( y )
>         
>         if y < 1 or y > 10 then
>             
>             return 1;
>             
>         elif y > 10 then
>             
>             return 2;
>             
>         else
>             
>             return 3;
>             
>         fi;
>         
>     end;
>     
>     inner_func2 := function( y )
>         
>         if y < 1 then
>             
>             return 5;
>             
>         elif y > 10 then
>             
>             return 6;
>             
>         elif y < 1 or y > 10 then
>             
>             return 7;
>             
>         else
>             
>             return 8;
>             
>         fi;
>         
>     end;
>     
>     if IdFunc( false ) then
>         
>         return 0;
>         
>     elif x < 1 or x > 10 then
>         
>         return inner_func1( x );
>         
>     elif IdFunc( false ) then
>         
>         return 4;
>         
>     else
>         
>         return inner_func2( x );
>         
>     fi;
>     
> end;;

#
gap> compiled_func := CapJitCompiledFunction( func );;
gap> Display( compiled_func );
function ( x_1 )
    if x_1 < 1 or x_1 > 10 then
        return 1;
    else
        return 8;
    fi;
    return;
end

# symmetry of equality
gap> func := function( x, y )
>   
>   if x = y then
>       
>       return 1;
>       
>   elif y = x then
>       
>       return 2;
>       
>   else
>       
>       return 1;
>       
>   fi;
>   
> end;;

#
gap> compiled_func := CapJitCompiledFunction( func );;
gap> Display( compiled_func );
function ( x_1, y_1 )
    return 1;
end

#
gap> STOP_TEST( "CapJitDroppedHandledEdgeCases" );
