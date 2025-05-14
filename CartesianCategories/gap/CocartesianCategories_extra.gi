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
        
    end, OperationWeight( cat, "InitialObject" ) );
    
    ##
    AddTensorProductOnObjects( cat,
      function( cat, a, b )
        
        return Coproduct( cat, [ a, b ] );
        
    end, OperationWeight( cat, "Coproduct" ) );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
      function( cat, source, mor1, mor2, target )
        
        return CoproductOnMorphismsWithGivenCoproducts( cat, source, mor1, mor2, target );
        
    end, OperationWeight( cat, "CoproductOnMorphismsWithGivenCoproducts" ) );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CocartesianLeftUnitorWithGivenCoproduct( cat, a, source );
        
    end, OperationWeight( cat, "CocartesianLeftUnitorWithGivenCoproduct" ) );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CocartesianLeftUnitorInverseWithGivenCoproduct( cat, a, target );
        
    end, OperationWeight( cat, "CocartesianLeftUnitorInverseWithGivenCoproduct" ) );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
      function( cat, a, source )
        
        return CocartesianRightUnitorWithGivenCoproduct( cat, a, source );
        
    end, OperationWeight( cat, "CocartesianRightUnitorWithGivenCoproduct" ) );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
      function( cat, a, target )
        
        return CocartesianRightUnitorInverseWithGivenCoproduct( cat, a, target );
        
    end, OperationWeight( cat, "CocartesianRightUnitorInverseWithGivenCoproduct" ) );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CocartesianAssociatorLeftToRightWithGivenCoproducts( cat, source, a, b, c, target );
        
    end, OperationWeight( cat, "CocartesianAssociatorLeftToRightWithGivenCoproducts" ) );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
      function( cat, source, a, b, c, target )
        
        return CocartesianAssociatorRightToLeftWithGivenCoproducts( cat, source, a, b, c, target );
        
    end, OperationWeight( cat, "CocartesianAssociatorRightToLeftWithGivenCoproducts" ) );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CocartesianBraidingWithGivenCoproducts( cat, source, a, b, target );
        
    end, OperationWeight( cat, "CocartesianBraidingWithGivenCoproducts" ) );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
      function( cat, source, a, b, target )
        
        return CocartesianBraidingInverseWithGivenCoproducts( cat, source, a, b, target );
        
    end, OperationWeight( cat, "CocartesianBraidingInverseWithGivenCoproducts" ) );
    
end );
