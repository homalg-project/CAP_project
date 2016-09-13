#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallMethod( LessGeneratorsTransformationTripleLeft,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local R, transformation, transformation_inverse, smaller_matrix;
    
    R := HomalgRing( matrix );
    
    transformation := HomalgVoidMatrix( R );
    
    transformation_inverse := HomalgVoidMatrix( R );
    
    smaller_matrix := SimplerEquivalentMatrix( matrix, transformation, transformation_inverse, "", "" );
    
    return [ smaller_matrix, transformation, transformation_inverse ];
    
end );

##
InstallMethod( LessGeneratorsTransformationTripleRight,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local R, transformation, transformation_inverse, smaller_matrix;
    
    R := HomalgRing( matrix );
    
    transformation := HomalgVoidMatrix( R );
    
    transformation_inverse := HomalgVoidMatrix( R );
    
    smaller_matrix := SimplerEquivalentMatrix( matrix, transformation, transformation_inverse, "", "", "" );
    
    return [ smaller_matrix, transformation, transformation_inverse ];
    
end );
