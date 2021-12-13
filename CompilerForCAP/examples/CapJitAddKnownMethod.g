#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

DeclareFilter( "IsMyCat1", IsCapCategory );;
DeclareFilter( "IsMyCat2", IsCapCategory );;

DeclareOperation( "MyOperation", [ IsMyCat1 ] );;
DeclareOperation( "MyOperation", [ IsMyCat2 ] );;

InstallMethodForCompilerForCAP( MyOperation, [ IsMyCat1 ], cat -> 1 );
InstallMethodForCompilerForCAP( MyOperation, [ IsMyCat2 ], cat -> 2 );
InstallOtherMethodForCompilerForCAP(
    MyOperation,
    [ IsMyCat2, IsInt ],
    { cat, int } -> 3
);

cat1 := CreateCapCategory( "cat1" );;
cat2 := CreateCapCategory( "cat2" );;

SetFilterObj( cat1, IsMyCat1 );
SetFilterObj( cat2, IsMyCat2 );

Display( CapJitCompiledFunction( cat -> MyOperation( cat ), [ cat1 ] ) );
#! function ( cat_1 )
#!     return 1;
#! end

Display( CapJitCompiledFunction( cat -> MyOperation( cat ), [ cat2 ] ) );
#! function ( cat_1 )
#!     return 2;
#! end

Display( CapJitCompiledFunction( cat -> MyOperation( cat, 1 ), [ cat2 ] ) );
#! function ( cat_1 )
#!     return 3;
#! end

#! @EndExample
