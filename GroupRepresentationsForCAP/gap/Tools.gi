# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Implementations
#

##
InstallMethod( MultiplicityArray,
               [ IsGroup ],
               
  function( group )
    local irr, index_list;
    
    irr := Irr( group );
    
    index_list := [ 1 .. Size( irr ) ];
    
    return
      List( index_list, i ->
        List( index_list, j ->
          List( index_list, k -> ScalarProduct( irr[i], irr[j] * irr[k] ) )
        )
      );
    
end );

##
InstallMethod( MultiplicityTripleArray,
               [ IsGroup ],
               
  function( group )
    local irr, index_list;
    
    irr := Irr( group );
    
    index_list := [ 1 .. Size( irr ) ];
    
    return
      List( index_list, i ->
        List( index_list, j ->
          List( index_list, k -> 
            List( index_list, l -> ScalarProduct( irr[i], irr[j] * irr[k] * irr[l] ) )
          )
        )
      );
    
end );

##
InstallGlobalFunction( LaTeXStringOfSemisimpleCategoryObjectList,
  function ( object_list )
    local size, parts;
    
    size := Size( object_list );
    
    if size = 0 then
        
        return "0";
        
    fi;
    
    parts := List( object_list, function ( l )
      local mult, irr, string;
        
        mult := l[1];
        irr := l[2];
        
        if mult = 1 then
            
            string := "";
            
        else
            
            string := Concatenation( String( mult ), " \\cdot " );
            
        fi;
        
        if IsShowable( "text/latex", irr ) then
            
            Append( string, LaTeXOutput( irr ) );
            
        else
            
            Append( string, String( irr ) );
            
        fi;
        
        return string;
        
    end );
    
    return JoinStringsWithSeparator( parts, " \\oplus " );
    
end );
