#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function( x )
  local inner_func@
    
    inner_func := function( y )
        
        if y < 1 then
            
            return 2@
            
        elif y > 10 then
            
            return 3@
            
        else
            
            return 4@
            
        fi@
        
    end@
    
    if x < 1 or x > 10 then
        
        return 0@
        
    elif x = 3 then
        
        return 1@
        
    else
        
        return inner_func( x )@
        
    fi@
    
end""", "@", ";" ) );;

compiled_func := CapJitCompiledFunction( func );;
Display( compiled_func );
#! function ( x_1 )
#!     if x_1 < 1 or x_1 > 10 then
#!         return 0;
#!     elif x_1 = 3 then
#!         return 1;
#!     else
#!         return 4;
#!     fi;
#!     return;
#! end

#! @EndExample
