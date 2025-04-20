# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallMethod( SetTensorProductToDirectProduct,
        [ IsCapCategory and IsCartesianCategory ],
        
  function( cat )
    
    Assert( 0, not IsFinalized( cat ) );
    
    SetIsSymmetricMonoidalCategory( cat, true );
    
    ##
    AddTensorUnit( cat,
      function( cat )
        
        return TerminalObject( cat );
        
    end );
    
    ##
    AddTensorProductOnObjects( cat,
      function( cat, a, b )
        
        return DirectProduct( cat, [ a, b ] );
        
    end );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
      function( cat, source, mor1, mor2, target )
        
        return DirectProductOnMorphismsWithGivenDirectProducts( cat, source, mor1, mor2, target );
        
    end );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CartesianLeftUnitorWithGivenDirectProduct( cat, a, source );
        
    end );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CartesianLeftUnitorInverseWithGivenDirectProduct( cat, a, target );
        
    end );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CartesianRightUnitorWithGivenDirectProduct( cat, a, source );
        
    end );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CartesianRightUnitorInverseWithGivenDirectProduct( cat, a, target );
        
    end );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CartesianAssociatorLeftToRightWithGivenDirectProducts( cat, source, a, b, c, target );
        
    end );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CartesianAssociatorRightToLeftWithGivenDirectProducts( cat, source, a, b, c, target );
        
    end );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CartesianBraidingWithGivenDirectProducts( cat, source, a, b, target );
        
    end );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CartesianBraidingInverseWithGivenDirectProducts( cat, source, a, b, target );
        
    end );
    
end );
