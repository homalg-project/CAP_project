#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function( x )
  local inner_func1, inner_func2@
    
    inner_func1 := function( y )
        
        if y < 1 or y > 10 then
            
            return 1@
            
        elif y > 10 then
            
            return 2@
            
        else
            
            return 3@
            
        fi@
        
    end@
    
    inner_func2 := function( y )
        
        if y < 1 then
            
            return 5@
            
        elif y > 10 then
            
            return 6@
            
        elif y < 1 or y > 10 then
            
            return 7@
            
        else
            
            return 8@
            
        fi@
        
    end@
    
    if x < 1 or x > 10 then
        
        return inner_func1( x )@
        
    elif IdFunc( false ) then
        
        return 4@
        
    else
        
        return inner_func2( x )@
        
    fi@
    
end""", "@", ";" ) );;

compiled_func := CapJitCompiledFunction( func );;
Display( compiled_func );
#! function ( x_1 )
#!     if x_1 < 1 or x_1 > 10 then
#!         return 1;
#!     else
#!         return 8;
#!     fi;
#!     return;
#! end

#! @EndExample
