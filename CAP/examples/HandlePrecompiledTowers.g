#! @Chapter Examples and Tests

#! @Section HandlePrecompiledTowers

#! @Example

LoadPackage( "CAP", false );
#! true

dummy1 := CreateCapCategory( );;
dummy2 := CreateCapCategory( );;
dummy3 := CreateCapCategory( );;

DisplayAndReturn := function ( string )
    Display( string ); return string; end;;

dummy1!.compiler_hints := rec( );;
dummy1!.compiler_hints.precompiled_towers := [
  rec(
    remaining_constructors_in_tower := [ "Constructor1" ],
    precompiled_functions_adder := cat ->
      DisplayAndReturn( "Adding precompiled operations for Constructor1" ),
  ),
  rec(
    remaining_constructors_in_tower := [ "Constructor1", "Constructor2" ],
    precompiled_functions_adder := cat ->
      DisplayAndReturn( "Adding precompiled operations for Constructor2" ),
  ),
];;

HandlePrecompiledTowers( dummy2, dummy1, "Constructor1" );
#! Adding precompiled operations for Constructor1
HandlePrecompiledTowers( dummy3, dummy2, "Constructor2" );
#! Adding precompiled operations for Constructor2

#! @EndExample
