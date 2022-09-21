gap> START_TEST( "CapJitAddKnownMethod" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> DeclareFilter( "IsMyCat1", IsCapCategory );;
gap> DeclareFilter( "IsMyCat2", IsCapCategory );;

#
gap> DeclareOperation( "MyOperation", [ IsMyCat1 ] );;
gap> DeclareOperation( "MyOperation", [ IsMyCat2 ] );;

#
gap> InstallMethodForCompilerForCAP( MyOperation, [ IsMyCat1 ], cat -> 1 );
gap> InstallMethodForCompilerForCAP( MyOperation, [ IsMyCat2 ], cat -> 2 );
gap> InstallOtherMethodForCompilerForCAP(
>     MyOperation,
>     [ IsMyCat2, IsInt ],
>     { cat, int } -> 3
> );

#
gap> cat1 := CreateCapCategory( "cat1" );;
gap> cat2 := CreateCapCategory( "cat2" );;

#
gap> SetFilterObj( cat1, IsMyCat1 );
gap> SetFilterObj( cat2, IsMyCat2 );

#
gap> Display( CapJitCompiledFunction( cat -> MyOperation( cat ), cat1 ) );
function ( cat_1 )
    return 1;
end

#
gap> Display( CapJitCompiledFunction( cat -> MyOperation( cat ), cat2 ) );
function ( cat_1 )
    return 2;
end

#
gap> Display( CapJitCompiledFunction( cat -> MyOperation( cat, 1 ), cat2 ) );
function ( cat_1 )
    return 3;
end

#
gap> STOP_TEST( "CapJitAddKnownMethod" );
