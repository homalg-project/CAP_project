#! @Chapter Examples and Tests

#! @Section Exactness conditions

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
#! #@if IsPackageMarkedForLoading( "QPA", ">= 2.0" )
ReadPackage( "FreydCategoriesForCAP", "examples/SubobjectLatticeFunctions.g" );;
quiver := RightQuiver( "Q(4)[a:1->2,b:2->3,c:3->4]" );;
QQ := HomalgFieldOfRationals();;
A := PathAlgebra( QQ, quiver );;
B := QuotientOfPathAlgebra( A, [ A.ab, A.bc ] );;
RowsB := QuiverRowsDescentToZDefinedByBasisPaths( B : overhead := false );;
Adel := AdelmanCategory( RowsB : overhead := false );;
a := B.a/RowsB/Adel;;
c := B.c/RowsB/Adel;;
F := CokernelObject( a );;
G := KernelObject( c );;
eta := AdelmanCategoryMorphism( F, B.b/RowsB, G );;
C := CokernelObject( eta );;
I := ImageObject( eta );;
K := KernelObject( eta );;
IsImagePreserving( I );
#! true
IsLeftExact( I );
#! false
IsRightExact( I );
#! false
IsMonoPreserving( K );
#! false
IsEpiPreserving( K );
#! false
IsMonoPreserving( C );
#! false
IsEpiPreserving( C );
#! false
#! #@fi
#! @EndExample
