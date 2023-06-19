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
gap> DeclareOperation( "MyOperation", [ IsInt, IsString ] );;
gap> CapJitAddTypeSignature( "MyOperation", [ IsInt, IsString ], IsInt );
gap> DeclareOperation( "MyOperation", [ IsInt, IsInt ] );;
gap> CapJitAddTypeSignature( "MyOperation", [ IsInt, IsInt ], IsInt );

#
gap> InstallMethodForCompilerForCAP( MyOperation, [ IsMyCat1 ], cat -> 1 );
gap> InstallMethodForCompilerForCAP( MyOperation, [ IsMyCat2 ], cat -> 2 );
gap> InstallOtherMethodForCompilerForCAP(
>     MyOperation,
>     [ IsMyCat2, IsInt ],
>     { cat, int } -> 3
> );
gap> InstallMethodForCompilerForCAP( MyOperation, [ IsInt, IsString ], { int, string } -> 4 );
gap> InstallMethod( MyOperation, [ IsInt, IsInt ], { int, int2 } -> 5 );

#
gap> cat1 := CreateCapCategory( "cat1" );;
gap> cat2 := CreateCapCategory( "cat2" );;
gap> cat3 := CreateCapCategory( "cat3" );;

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
gap> Display( CapJitCompiledFunction( cat -> MyOperation( cat ), cat3 ) );
function ( cat_1 )
    return MyOperation( cat_1 );
end

#
gap> StopCompilationAtCategory( cat1 );
gap> Display( CapJitCompiledFunction( cat -> MyOperation( cat ), cat1 ) );
function ( cat_1 )
    return MyOperation( cat_1 );
end
gap> ContinueCompilationAtCategory( cat1 );

#
gap> Display( CapJitCompiledFunction( {} -> MyOperation( 1, "1" ), [ [ ], fail ] ) );
function (  )
    return 4;
end

#
gap> Display( CapJitCompiledFunction( {} -> MyOperation( 1, 1 ), [ [ ], fail ] ) );
function (  )
    return MyOperation( 1, 1 );
end

#
gap> STOP_TEST( "CapJitAddKnownMethod" );
