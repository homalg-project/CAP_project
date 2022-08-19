#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ModulePresentationsForCAP", false );
#! true
LoadPackage( "HomologicalAlgebraForCAP", false );
#! true
LoadPackage( "RingsForHomalg", false );
#! true
LoadPackage( "IO_ForHomalg", false );
#! true
LoadPackage( "ActionsForCAP", false );
#! true

HOMALG_IO.show_banners := false;;

##
## Category and Type of Objects
##
DeclareCategory( "IsModuleWithAttribute",
                 IsCategoryWithAttributesObject );;

DeclareRepresentation( "IsModuleWithAttributeRep",
                       IsModuleWithAttribute and IsAttributeStoringRep,
                       [ ] );;

BindGlobal( "TheFamilyOfModulesWithAttribute",
            NewFamily( "TheFamilyOfModulesWithAttribute" ) );;

BindGlobal( "TheTypeOfModulesWithAttribute",
            NewType( TheFamilyOfModulesWithAttribute,
                     IsModuleWithAttributeRep ) );;

## Category and Type of Morphisms
##
DeclareCategory( "IsModuleMorphismWithAttribute",
                 IsCategoryWithAttributesMorphism );;

DeclareRepresentation( "IsModuleMorphismWithAttributeRep",
                       IsModuleMorphismWithAttribute and IsAttributeStoringRep,
                       [ ] );;

BindGlobal( "TheFamilyOfModuleMorphismsWithAttribute",
            NewFamily( "TheFamilyOfModuleMorphismsWithAttribute" ) );;

BindGlobal( "TheTypeOfModuleMorphismsWithAttribute",
            NewType( TheFamilyOfModuleMorphismsWithAttribute,
                     IsModuleMorphismWithAttributeRep ) );;
##



QQ := HomalgFieldOfRationalsInSingular( );;
R := QQ * "x,y";
#! Q[x,y]
SetRecursionTrapInterval( 10000 );;
category := LeftPresentations( R );;

category_with_attributes_record := rec(
  underlying_category := category,
  object_type := TheTypeOfModulesWithAttribute,
  morphism_type := TheTypeOfModuleMorphismsWithAttribute,
  
  ZeroObject :=
    { zero_object } -> [ "a string for indirection" ],
  
  DirectSum :=
    { obj_list, underlying_direct_sum } -> [ "a string for indirection" ],
  
  KernelObject := 
    { diagram, underlying_kernel_object } -> [ "a string for indirection" ],
      
  ImageObject := 
    { diagram, underlying_image_object } -> [ "a string for indirection" ],
      
  FiberProduct := 
    { diagram, underlying_fiber_product } -> [ "a string for indirection" ],
      
  CokernelObject := 
    { diagram, underlying_cokernel_object } -> [ "a string for indirection" ],
  
  CoimageObject := 
    { diagram, underlying_coimage_object } -> [ "a string for indirection" ],
  
  Pushout := 
    { diagram, underlying_pushout_object } -> [ "a string for indirection" ],
);;
triple := EnhancementWithAttributes( category_with_attributes_record );;
indirection_category := triple[1];;
SetIsAbelianCategory( indirection_category, true );;
AddIsEqualForCacheForObjects( indirection_category, IsIdenticalObj );;
AddIsEqualForObjects( indirection_category, function( obj1, obj2 ) return UnderlyingCell( obj1 ) = UnderlyingCell( obj2 ); end );;
AddIsEqualForCacheForMorphisms( indirection_category, IsIdenticalObj );;
AddIsEqualForMorphisms( indirection_category, IsIdenticalObj );;
AddIsCongruentForMorphisms( indirection_category, function( mor1, mor2 ) return UnderlyingCell( mor1 ) = UnderlyingCell( mor2 ); end );;
Finalize( indirection_category );;
Object_Constructor := triple[2];;
Morphism_Constructor := triple[3];;


S := Object_Constructor( FreeLeftPresentation( 1, R ), [ "a string for indirection" ] );
#! <An object in Category with attributes of Category of left presentations of Q[x,y]>
object_func := function( i ) return S; end;
#! function( i ) ... end
morphism_func := function( i ) return IdentityMorphism( S ); end;
#! function( i ) ... end
C0 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, indirection_category, 0, 4 );
#! <An object in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
S2 := Object_Constructor( FreeLeftPresentation( 2, R ), [ "a string for indirection" ] );
#! <An object in Category with attributes of Category of left presentations of Q[x,y]>
C1 := ZFunctorObjectFromMorphismList( [ InjectionOfCofactorOfDirectSum( [ S2, S ], 1 ) ], 2 );
#! <An object in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
C1 := ZFunctorObjectExtendedByInitialAndIdentity( C1, 2, 3 );
#! <An object in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
C2 := ZFunctorObjectFromMorphismList( [ InjectionOfCofactorOfDirectSum( [ S, S ], 1 ) ], 3 );
#! <An object in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
C2 := ZFunctorObjectExtendedByInitialAndIdentity( C2, 3, 4 );
#! <An object in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
delta_1_3 := PresentationMorphism( UnderlyingCell( C1[3] ), HomalgMatrix( [ [ "x^2" ], [ "xy" ], [ "y^3"] ], 3, 1, R ), UnderlyingCell( C0[3] ) );
#! <A morphism in Category of left presentations of Q[x,y]>
delta_1_3 := Morphism_Constructor( C1[3], delta_1_3, C0[3] );
#! <A morphism in Category with attributes of Category of left presentations of Q[x,y]>
delta_1_2 := PresentationMorphism( UnderlyingCell( C1[2] ), HomalgMatrix( [ [ "x^2" ], [ "xy" ] ], 2, 1, R ), UnderlyingCell( C0[2] ) );
#! <A morphism in Category of left presentations of Q[x,y]>
delta_1_2 := Morphism_Constructor( C1[2], delta_1_2, C0[2] );
#! <A morphism in Category with attributes of Category of left presentations of Q[x,y]>
delta1 := ZFunctorMorphism( C1, [ UniversalMorphismFromInitialObject( C0[1] ), UniversalMorphismFromInitialObject( C0[1] ), delta_1_2, delta_1_3 ], 0, C0 );
#! <A morphism in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
delta1 := ZFunctorMorphismExtendedByInitialAndIdentity( delta1, 0, 3 );
#! <A morphism in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
delta1 := AsAscendingFilteredMorphism( delta1 );
#! <A morphism in Ascending filtered object category of Category with attributes of Category of left presentations of Q[x,y]>
delta_2_3 := PresentationMorphism( UnderlyingCell( C2[3] ), HomalgMatrix( [ [ "y", "-x", "0" ] ], 1, 3, R ), UnderlyingCell( C1[3] ) );
#! <A morphism in Category of left presentations of Q[x,y]>
delta_2_3 := Morphism_Constructor( C2[3], delta_2_3, C1[3] );
#! <A morphism in Category with attributes of Category of left presentations of Q[x,y]>
delta_2_4 := PresentationMorphism( UnderlyingCell( C2[4] ), HomalgMatrix( [ [ "y", "-x", "0" ], [ "0", "y^2", "-x" ] ], 2, 3, R ), UnderlyingCell( C1[4] ) );
#! <A morphism in Category of left presentations of Q[x,y]>
delta_2_4 := Morphism_Constructor( C2[4], delta_2_4, C1[4] );
#! <A morphism in Category with attributes of Category of left presentations of Q[x,y]>
delta2 := ZFunctorMorphism( C2, [  UniversalMorphismFromInitialObject( C1[2] ), delta_2_3, delta_2_4 ], 2, C1 );
#! <A morphism in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
delta2 := ZFunctorMorphismExtendedByInitialAndIdentity( delta2, 2, 4 );
#! <A morphism in Functors from integers into Category with attributes of Category of left presentations of Q[x,y]>
delta2 := AsAscendingFilteredMorphism( delta2 );
#! <A morphism in Ascending filtered object category of Category with attributes of Category of left presentations of Q[x,y]>
SetIsAdditiveCategory( CategoryOfAscendingFilteredObjects( indirection_category ), true );
complex := ZFunctorObjectFromMorphismList( [ delta2, delta1 ], -2 );
#! <An object in Functors from integers into Ascending filtered object category of Category with attributes of Category of left presentations of Q[x,y]>
complex := AsComplex( complex );
#! <An object in Complex category of Ascending filtered object category of Category with attributes of Category of left presentations of Q[x,y]>
LessGenFunctor := FunctorLessGeneratorsLeft( R );
#! Less generators for Category of left presentations of Q[x,y]


# ProfileFunctionsInGlobalVariables( true );
# ProfileOperationsAndMethods( true );
# ProfileGlobalFunctions( true );
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 0, 0, 0 );
# ProfileFunctionsInGlobalVariables( false );
# ProfileOperationsAndMethods( false );
# ProfileGlobalFunctions( false );
# 
# DisplayProfile();
# 
# 
# ProfileFunctionsInGlobalVariables( true );
# ProfileOperationsAndMethods( true );
# ProfileGlobalFunctions( true );
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 1, 0, 0 );
# ProfileFunctionsInGlobalVariables( false );
# ProfileOperationsAndMethods( false );
# ProfileGlobalFunctions( false );
# 
# DisplayProfile();
# time;
# # <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
# # Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
# # # (an empty 0 x 1 matrix)
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 1, 0, 0 );
# time;
# # # <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
# # Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
# # # (an empty 0 x 1 matrix)
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 2, 0, 0 );
# time;
# # # <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
# # Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
# # # (an empty 0 x 1 matrix)
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 3, 0, 0 );
# time;
# # # <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
# # Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
# # # x*y,
# # # x^2
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 4, 0, 0 );
# time;
# # # <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
# # Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
# # # x*y,
# # # x^2,
# # # y^3
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 5, 0, 0 );
# time;
# # # <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
# # Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
# # # x*y,
# # # x^2,
# # # y^3
# s := SpectralSequenceDifferentialOfAscendingFilteredComplex( complex, 3, 3, -2 );
# time;
# # <A morphism in Category of left presentations of Q[x,y]>
# Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, s ) ) );
# # y^3

#! @EndExample
