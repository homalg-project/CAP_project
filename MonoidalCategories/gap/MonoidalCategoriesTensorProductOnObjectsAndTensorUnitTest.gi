# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest",
    
    function( cat, opposite, a, b )
        
        local verbose,
              
              u, u_op,
              a_op, b_op,
              
              a_tensor_b, a_tensor_b_op,
              b_tensor_a, b_tensor_a_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "TensorUnit" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorUnit' ..." );
                
            fi;
            
            u := TensorUnit( cat );
            u_op := TensorUnit( opposite );
            
            Assert( 0, IsEqualForObjects( u_op, Opposite( opposite, u ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductOnObjects' ..." );
                
            fi;
            
            a_tensor_b := TensorProductOnObjects( cat, a, b );
            b_tensor_a := TensorProductOnObjects( cat, b, a );
            
            a_tensor_b_op := TensorProductOnObjects( opposite, a_op, b_op );
            b_tensor_a_op := TensorProductOnObjects( opposite, b_op, a_op );
            
            Assert( 0, IsEqualForObjects( a_tensor_b_op, Opposite( opposite, a_tensor_b ) ) );
            Assert( 0, IsEqualForObjects( b_tensor_a_op, Opposite( opposite, b_tensor_a ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsEqualForObjects( a_tensor_b_op, TensorProductOnObjects( opposite, a_op, b_op ) ) );
            Assert( 0, IsEqualForObjects( b_tensor_a_op, TensorProductOnObjects( opposite, b_op, a_op ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsEqualForObjects( a_tensor_b, Opposite( a_tensor_b_op ) ) );
            Assert( 0, IsEqualForObjects( b_tensor_a, Opposite( b_tensor_a_op ) ) );
            
        fi;

end );
