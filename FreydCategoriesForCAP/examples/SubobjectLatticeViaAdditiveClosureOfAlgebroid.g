#! @Chapter Examples and Tests

#! @Section Subobject lattice

#! @Example

#! #@if IsPackageMarkedForLoading( "QPA", ">= 2.0" )

LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "Algebroids", false );
#! true

ReadPackage( "FreydCategoriesForCAP", "examples/SubobjectLatticeFunctions.g" );
#! true

quiver := RightQuiver( "Q(5)[a:1->2,b:2->3,c:1->4,d:4->5]" );;
QQ := HomalgFieldOfRationals();;
B := PathAlgebra( QQ, quiver );;

aoid := Algebroid( B, true : overhead := false );;
RowsB := AdditiveClosure( aoid : overhead := false );;
Adel := AdelmanCategory( RowsB : overhead := false );;

QuiverRowsB := QuiverRowsDescentToZDefinedByBasisPaths( B : overhead := false );;
QuiverAdel := AdelmanCategory( QuiverRowsB : overhead := false );;

a := B.a/aoid/RowsB/Adel;;
b := B.b/aoid/RowsB/Adel;;
c := B.c/aoid/RowsB/Adel;;
d := B.d/aoid/RowsB/Adel;;
x := KernelEmbedding( a );;
y := KernelEmbedding( PreCompose( a, b ) );;
z := KernelEmbedding( c );;
w := KernelEmbedding(  PreCompose( c, d ) );;
gens := [ x, y, z, w ];;
start := Runtime( );;
Display( Size( GenerateSubobjects( gens ) ) );
#! 18
runtime := Runtime( ) - start;;

a := B.a/QuiverRowsB/QuiverAdel;;
b := B.b/QuiverRowsB/QuiverAdel;;
c := B.c/QuiverRowsB/QuiverAdel;;
d := B.d/QuiverRowsB/QuiverAdel;;
x := KernelEmbedding( a );;
y := KernelEmbedding( PreCompose( a, b ) );;
z := KernelEmbedding( c );;
w := KernelEmbedding(  PreCompose( c, d ) );;
gens := [ x, y, z, w ];;
start := Runtime( );;
Display( Size( GenerateSubobjects( gens ) ) );
#! 18
runtime_quiver := Runtime( ) - start;;

Display( runtime >= runtime_quiver * 6 / 10 );
#! true
Display( runtime <= runtime_quiver * 7 / 10 );
#! true

#! #@fi
#! @EndExample
