LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

QQ := HomalgFieldOfRationalsInSingular( );

R := QQ * "x,y";

## Construction of the ascending filtered complex

#C_0
category := LeftPresentations( R );

S := FreeLeftPresentation( 1, R );

object_func := function( i ) return S; end;

morphism_func := function( i ) return IdentityMorphism( S ); end;

C0 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, category, 0, 4 );

C0 := AsAscendingFilteredObject( C0 );


#C_1
S2 := FreeLeftPresentation( 2, R );

object_func := function( i )
  if i <= 2 then
    
    return S2;
    
  else
    
    return DirectSum( S2, S );
  
  fi;
end;

morphism_func := function( i )
  if i = 2 then
    
    return InjectionOfCofactor( DirectSum( S2, S ), 1 );
  
  elif i > 2 then
    
    return IdentityMorphism( DirectSum( S2, S ) ); #would be nice if this was unnecessary
    
  fi;
end;

C1 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, category, 2, 3 );

C1 := AsAscendingFilteredObject( C1 );

#C_3
object_func := function( i )
  if i = 3 then
    
    return S;
    
  elif i > 3 then
    
    return DirectSum( S, S );
    
  fi;
end;

morphism_func := function( i )
  if i = 3 then
    
    return InjectionOfCofactor( DirectSum( S, S ), 1 );
    
  elif i > 3 then
    
    return IdentityMorphism( DirectSum( S, S ) ); #would be nice if this was unnecessary
    
  fi;
end;

C2 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, category, 3, 4 );

C2 := AsAscendingFilteredObject( C2 );

#delta1: C0 <-- C1

delta_1_3 := PresentationMorphism( C1[3], HomalgMatrix( [ [ "x^2" ], [ "xy" ], [ "y^3"] ], 3, 1, R ), C0[3] );

delta_1_2 := PresentationMorphism( C1[2], HomalgMatrix( [ [ "x^2" ], [ "xy" ] ], 2, 1, R ), C0[2] );

morph_func := function( i )
  if i >= 3 then
    
    return delta_1_3;
    
  elif i = 2 then
    
    return delta_1_2;
    
  elif i >= 0 then
    
    return UniversalMorphismFromInitialObject( C0[1] );
    
  else
    
    return UniversalMorphismFromInitialObject( InitialObject( category ) );
    
  fi;
end;

delta1 := AscendingFilteredMorphism( C1, morph_func, C0 );

#delta2: C2 --> C1

delta_2_3 := PresentationMorphism( C2[3], HomalgMatrix( [ [ "y", "-x", "0" ] ], 1, 3, R ), C1[3] );

delta_2_4 := PresentationMorphism( C2[4], HomalgMatrix( [ [ "y", "-x", "0" ], [ "0", "y^2", "-x" ] ], 2, 3, R ), C1[4] );

morph_func := function( i )
  if i >= 4 then
    
    return delta_2_4;
    
  elif i = 3 then
    
    return delta_2_3;
    
  elif i = 2 then
    
    return UniversalMorphismFromInitialObject( C1[2] );
    
  else
    
    return UniversalMorphismFromInitialObject( InitialObject( category ) );
    
  fi;
end;

delta2 := AscendingFilteredMorphism( C2, morph_func, C1 );

#the complex

zero_object := ZeroObject( CategoryOfAscendingFilteredObjects( category ) );

object_func := function( i )
  if i > 0 or i < -2 then 
    
    return zero_object; #would be nice if this was unnecessary
    
  elif i = 0 then
    
    return C0;
    
  elif i = -1 then
    
    return C1;
    
  elif i = -2 then
    
    return C2;
    
  fi;
end;

morph_func := function( i )
  if i >= 0 then
    
    return UniversalMorphismIntoTerminalObject( C0 );
    
  elif i = -3 then
    
    return UniversalMorphismFromInitialObject( C2 );
    
  elif i < -3 then
    
    UniversalMorphismFromInitialObject( zero_object );
    
  elif i = -1 then
    
    return delta1;
    
  elif i = -2 then
    
    return delta2;
    
  fi;
end;

SetIsAdditiveCategory( CategoryOfAscendingFilteredObjects( category ), true );

complex := ZFunctorObject( object_func, morph_func, CategoryOfAscendingFilteredObjects( category ) );

complex := AsComplex( complex );

F := FunctorLessGeneratorsLeft( R );

# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 0, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 1, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 2, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 3, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 4, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 5, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );

s := SpectralSequenceDifferentialOfAscendingFilteredComplex( complex, 3, 3, -2 );

Display( UnderlyingMatrix( ApplyFunctor( F, s ) ) );