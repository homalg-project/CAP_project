# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#

BindGlobal( "INSTALL_GET_RID_OF_ZERO_GENERATORS_TRANSFORMATION_TRIPLE_METHOD",
            
  function( get_rid_of_zero_generators_transformation_triple,
          nr_generators, basis_of_module, decide_zero, nonzero_generators, certain_generators, certain_relations )
    
    InstallMethod( get_rid_of_zero_generators_transformation_triple,
            "for a homalg matrix",
            [ IsHomalgMatrix ],
            
      function( matrix )
        local ng, id, nz, T, TI;
        
        ng := nr_generators( matrix );
        
        id := HomalgIdentityMatrix( ng, HomalgRing( matrix ) );
        
        nz := nonzero_generators( decide_zero( id, basis_of_module( matrix ) ) );
        
        if Length( nz ) = ng then
            return [ matrix, id, id ];
        fi;
        
        matrix := certain_generators( matrix, nz );
        matrix := certain_relations( matrix, nonzero_generators( matrix ) );
        
        T := certain_generators( id, nz );
        TI := certain_relations( id, nz );
        
        return [ matrix, T, TI ];
            
    end );
    
end );

BindGlobal( "INSTALL_GET_RID_OF_ZERO_GENERATORS_TRANSFORMATION_TRIPLE",
            
  function( )
    
    INSTALL_GET_RID_OF_ZERO_GENERATORS_TRANSFORMATION_TRIPLE_METHOD(
            NonZeroGeneratorsTransformationTripleLeft,
            NrColumns,           # nr_generators
            BasisOfRowModule,    # basis_of_module
            DecideZeroRows,      # decide_zero
            NonZeroRows,         # nonzero_generators
            CertainColumns,      # certain_generators
            CertainRows          # certain_relations
            );
    
    INSTALL_GET_RID_OF_ZERO_GENERATORS_TRANSFORMATION_TRIPLE_METHOD(
            NonZeroGeneratorsTransformationTripleRight,
            NrRows,              # nr_generators
            BasisOfColumnModule, # basis_of_module
            DecideZeroColumns,   # decide_zero
            NonZeroColumns,      # nonzero_generators
            CertainRows,         # certain_generators
            CertainColumns       # certain_relations
            );
    
end );

##
#= comment for Julia
INSTALL_GET_RID_OF_ZERO_GENERATORS_TRANSFORMATION_TRIPLE( );
# =#

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
