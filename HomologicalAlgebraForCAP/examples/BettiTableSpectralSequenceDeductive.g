LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "HomologicalAlgebraForCAP" );

LoadPackage( "RingsForHomalg" );

QQ := HomalgFieldOfRationalsInSingular( );

R := QQ * "x,y";

SetRecursionTrapInterval( 500 );

## Construction of the ascending filtered complex

#C_0
category := LeftPresentations( R );

SetIsAbelianCategory( DeductiveSystem( category ), true );

S := FreeLeftPresentation( 1, R );

Sd := InDeductiveSystem( S );

identity := IdentityMorphism( S );

identityd := InDeductiveSystem( identity );

object_func := function( i ) return Sd; end;

morphism_func := function( i ) return identityd; end;

C0 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, DeductiveSystem( category ), 0, 4 );

C0 := AsAscendingFilteredObject( C0 );

#C_1
S2 := FreeLeftPresentation( 2, R );

S2d := InDeductiveSystem( S2 );

S3 := FreeLeftPresentation( 3, R );

S3d := InDeductiveSystem( S3 );

object_func := function( i )
  if i <= 2 then
    
    return S2d;
    
  else
    
    return S3d;
  
  fi;
end;

injection2_3 :=
  PresentationMorphism( S2, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], 2, 3, R ), S3 );

injection2_3d :=
  InDeductiveSystem( injection2_3 );

identity3 := IdentityMorphism( S3 );

identity3d :=
  InDeductiveSystem( identity3 );

morphism_func := function( i )
  if i = 2 then
    
    return injection2_3d;
  
  elif i > 2 then
    
    return identity3d; #would be nice if this was unnecessary
    
  fi;
end;

C1 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, DeductiveSystem( category ), 2, 3 );

C1 := AsAscendingFilteredObject( C1 );

#C_3
object_func := function( i )
  if i = 3 then
    
    return Sd;
    
  elif i > 3 then
    
    return S2d;
    
  fi;
end;

injection1_2 :=
  PresentationMorphism( S, HomalgMatrix( [ [ 1, 0 ] ], 1, 2, R ), S2 );

injection1_2d :=
  InDeductiveSystem( injection1_2 );

identity2 :=
  IdentityMorphism( S2 );

identity2d :=
  InDeductiveSystem( identity2 );

morphism_func := function( i )
  if i = 3 then
    
    return injection1_2d;
    
  elif i > 3 then
    
    return identity2d; #would be nice if this was unnecessary
    
  fi;
end;

C2 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, DeductiveSystem( category ), 3, 4 );

C2 := AsAscendingFilteredObject( C2 );

#delta1: C0 <-- C1

delta_1_3 := PresentationMorphism( S3, HomalgMatrix( [ [ "x^2" ], [ "xy" ], [ "y^3"] ], 3, 1, R ), S );

delta_1_3d := InDeductiveSystem( delta_1_3 );

delta_1_2 := PresentationMorphism( S2, HomalgMatrix( [ [ "x^2" ], [ "xy" ] ], 2, 1, R ), S );

delta_1_2d := InDeductiveSystem( delta_1_2 );

initial_object := InitialObject( category );

initial_objectd := InDeductiveSystem( initial_object );

morph_func := function( i )
  if i >= 3 then
    
    return delta_1_3d;
    
  elif i = 2 then
    
    return delta_1_2d;
    
  elif i >= 0 then
    
    return UniversalMorphismFromInitialObject( Sd );
    
  else
    
    return UniversalMorphismFromInitialObject( initial_objectd );
    
  fi;
end;

delta1 := AscendingFilteredMorphism( C1, morph_func, C0 );

#delta2: C2 --> C1

delta_2_3 := PresentationMorphism( S, HomalgMatrix( [ [ "y", "-x", "0" ] ], 1, 3, R ), S3 );
delta_2_3d := InDeductiveSystem( delta_2_3 );


delta_2_4 := PresentationMorphism( S2, HomalgMatrix( [ [ "y", "-x", "0" ], [ "0", "y^2", "-x" ] ], 2, 3, R ), S3 );
delta_2_4d := InDeductiveSystem( delta_2_4 );


morph_func := function( i )
  if i >= 4 then
    
    return delta_2_4d;
    
  elif i = 3 then
    
    return delta_2_3d;
    
  elif i = 2 then
    
    return UniversalMorphismFromInitialObject( S2d );
    
  else
    
    return UniversalMorphismFromInitialObject( initial_objectd );
    
  fi;
end;

delta2 := AscendingFilteredMorphism( C2, morph_func, C1 );

#the complex

zero_object := ZeroObject( CategoryOfAscendingFilteredObjects( DeductiveSystem( category ) ) );

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

SetIsAdditiveCategory( CategoryOfAscendingFilteredObjects( DeductiveSystem( category ) ), true );

complex := ZFunctorObject( object_func, morph_func, CategoryOfAscendingFilteredObjects( DeductiveSystem( category ) ) );

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
# 
# Display( UnderlyingMatrix( ApplyFunctor( F, s ) ) );
