#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
##
#############################################################################

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