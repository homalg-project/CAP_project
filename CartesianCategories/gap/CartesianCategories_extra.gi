# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallMethod( SetTensorProductToDirectProduct,
        [ IsCapCategory ],
        
  function( cat )
    
    Assert( 0, IsCartesianCategory( cat ) );
    
    Assert( 0, not IsFinalized( cat ) );
    
    SetIsSymmetricMonoidalCategory( cat, true );
    
    ##
    AddTensorUnit( cat,
      function( cat )
        
        return TerminalObject( cat );
        
    end, OperationWeight( cat, "TerminalObject" ) );
    
    ##
    AddTensorProductOnObjects( cat,
      function( cat, a, b )
        
        return DirectProduct( cat, [ a, b ] );
        
    end, OperationWeight( cat, "DirectProduct" ) );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
      function( cat, source, mor1, mor2, target )
        
        return DirectProductOnMorphismsWithGivenDirectProducts( cat, source, mor1, mor2, target );
        
    end, OperationWeight( cat, "DirectProductOnMorphismsWithGivenDirectProducts" ) );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CartesianLeftUnitorWithGivenDirectProduct( cat, a, source );
        
    end, OperationWeight( cat, "CartesianLeftUnitorWithGivenDirectProduct" ) );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CartesianLeftUnitorInverseWithGivenDirectProduct( cat, a, target );
        
    end, OperationWeight( cat, "CartesianLeftUnitorInverseWithGivenDirectProduct" ) );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CartesianRightUnitorWithGivenDirectProduct( cat, a, source );
        
    end, OperationWeight( cat, "CartesianRightUnitorWithGivenDirectProduct" ) );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CartesianRightUnitorInverseWithGivenDirectProduct( cat, a, target );
        
    end, OperationWeight( cat, "CartesianRightUnitorInverseWithGivenDirectProduct" ) );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CartesianAssociatorLeftToRightWithGivenDirectProducts( cat, source, a, b, c, target );
        
    end, OperationWeight( cat, "CartesianAssociatorLeftToRightWithGivenDirectProducts" ) );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CartesianAssociatorRightToLeftWithGivenDirectProducts( cat, source, a, b, c, target );
        
    end, OperationWeight( cat, "CartesianAssociatorRightToLeftWithGivenDirectProducts" ) );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CartesianBraidingWithGivenDirectProducts( cat, source, a, b, target );
        
    end, OperationWeight( cat, "CartesianBraidingWithGivenDirectProducts" ) );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CartesianBraidingInverseWithGivenDirectProducts( cat, source, a, b, target );
        
    end, OperationWeight( cat, "CartesianBraidingInverseWithGivenDirectProducts" ) );
    
end );
