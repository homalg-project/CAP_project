#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

## transformation_inverse * matrix * transformation = smaller_matrix
InstallMethod( LessGeneratorsTransformationTriple,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local transformation, transformation_inverse, smaller_matrix;
    
    transformation := HomalgVoidMatrix( HomalgRing( matrix ) );
    
    transformation_inverse := HomalgVoidMatrix( HomalgRing( matrix ) );
    
    smaller_matrix := SimplerEquivalentMatrix( matrix, transformation, transformation_inverse, "", "" );
    
    return [ smaller_matrix, transformation, transformation_inverse ];
    
end );
