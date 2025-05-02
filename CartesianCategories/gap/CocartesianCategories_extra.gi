# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallMethod( SetTensorProductToCoproduct,
        [ IsCapCategory ],
        
  function( cat )
    
    Assert( 0, IsCocartesianCategory( cat ) );
    
    Assert( 0, not IsFinalized( cat ) );
    
    SetIsSymmetricMonoidalCategory( cat, true );
    
    ##
    AddTensorUnit( cat,
      function( cat )
        
        return InitialObject( cat );
        
    end );
    
    ##
    AddTensorProductOnObjects( cat,
      function( cat, a, b )
        
        return Coproduct( cat, [ a, b ] );
        
    end );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
      function( cat, source, mor1, mor2, target )
        
        return CoproductOnMorphismsWithGivenCoproducts( cat, source, mor1, mor2, target );
        
    end );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CocartesianLeftUnitorWithGivenCoproduct( cat, a, source );
        
    end );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CocartesianLeftUnitorInverseWithGivenCoproduct( cat, a, target );
        
    end );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CocartesianRightUnitorWithGivenCoproduct( cat, a, source );
        
    end );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CocartesianRightUnitorInverseWithGivenCoproduct( cat, a, target );
        
    end );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CocartesianAssociatorLeftToRightWithGivenCoproducts( cat, source, a, b, c, target );
        
    end );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CocartesianAssociatorRightToLeftWithGivenCoproducts( cat, source, a, b, c, target );
        
    end );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CocartesianBraidingWithGivenCoproducts( cat, source, a, b, target );
        
    end );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CocartesianBraidingInverseWithGivenCoproducts( cat, source, a, b, target );
        
    end );
    
end );
