# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallGlobalFunction( CAP_INTERNAL_FUNC_FOR_LEFT_COCLOSED_MONOIDAL_STRUCTURES,
  function( key_val_rec, package_name )
    local L, name;
    
    L := [ "IsMonoidalCategory",
           "IsStrictMonoidalCategory",
           "IsBraidedMonoidalCategory",
           "IsSymmetricMonoidalCategory",
           "IsLeftCoclosedMonoidalCategory",
           "IsSymmetricCoclosedMonoidalCategory",
           "AdditiveMonoidal",
           "TensorProductOnObjects",
           "TensorProduct",
           "TensorUnit",
           "Associator",
           "LeftUnitor",
           "RightUnitor",
           "Distributivity",
           "Braiding",
           "LeftCoclosedMonoidalLambda",
           "LeftCoclosedMonoidalEvaluation",
           "LeftCoclosedMonoidalCoevaluation",
           "LeftInternalCoHom",
           "LeftCoDual",
           "LeftCoBidual",
           "LeftCoclosedMonoidalCategories",
           "LEFT_COCLOSED_MONOIDAL",
           "LeftCoclosedMonoidal",
           "MONOIDAL",
           "Monoidal",
           "monoidal",
           "tensor_object",
           "tensored",
           "otimes",
           "tensor_product",
           "tensorSproduct",
           "cohom_tensor",
           "coHom",
           "CoclosedSMonoidal",
           "TensorProductOnObjectsBCcat",
           "CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE",
           ];
    
    for name in L do
        if not IsBound( key_val_rec.(name) ) then
            Error( "the component with the name ", name, " is missing in the given key_value_record record\n" );
        fi;
    od;
    
    L := List( L{[ 1 .. Length( L ) - 5 ]}, name -> [ name, key_val_rec.(name) ] );
    
    L := Concatenation(
                 [ [ "\"MonoidalCategories\",", Concatenation( "\"", package_name, "\"," ) ],
                   [ Concatenation( PackageInfo( "MonoidalCategories" )[1].PackageName, ": ", PackageInfo( "MonoidalCategories" )[1].Subtitle ),
                     Concatenation( PackageInfo( package_name )[1].PackageName, ": ", PackageInfo( package_name )[1].Subtitle ) ],
                   [ "Left Coclosed Monoidal", key_val_rec.CoclosedSMonoidal ],
                   [ "TensorProductOnObjects( cat,", key_val_rec.TensorProductOnObjectsBCcat ],
                   [ "METHOD_NAME_RECORD, \"MonoidalCategories\"", key_val_rec.CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE ],
                   ], L );
    
    Add( L, [ "tensor product", key_val_rec.tensorSproduct ] );
    Add( L, [ "cohom tensor", key_val_rec.cohom_tensor ] );
    Add( L, [ "\\underline{coHom}_\\ell", key_val_rec.coHom ] );
    
    if IsBound( key_val_rec.replace ) then
        Append( L, key_val_rec.replace );
    fi;
    
    if IsBound( key_val_rec.safe_replace ) then
        L := Concatenation(
                     List( key_val_rec.safe_replace, r -> [ r[1], ShaSum( r[1] ) ] ), ## detect at the very beginning and replace by sha's (order is important!)
                     L,
                     List( key_val_rec.safe_replace, r -> [ ShaSum( r[1] ), r[2] ] ) ); ## safely replace the sha's at the very end
    fi;
    
    return L;
    
end );

##
InstallGlobalFunction( WriteFileForLeftCoclosedMonoidalStructure,
  function( key_val_rec, package_name, files_rec )
    local dir, L, files, header, file, source, target;
    
    L := CAP_INTERNAL_FUNC_FOR_LEFT_COCLOSED_MONOIDAL_STRUCTURES( key_val_rec, package_name );
    
    dir := Concatenation( PackageInfo( "MonoidalCategories" )[1].InstallationPath, "/gap/" );
    
    files := [ "LeftCoclosedMonoidalCategories_gd",
               "LeftCoclosedMonoidalCategoriesTest_gd",
               "RigidSymmetricCoclosedMonoidalCategories_gd",
               "RigidSymmetricCoclosedMonoidalCategoriesTest_gd",
               "LeftCoclosedMonoidalCategoriesProperties_gi",
               "LeftCoclosedMonoidalCategoriesMethodRecord_gi",
               "LeftCoclosedMonoidalCategories_gi",
               "LeftCoclosedMonoidalCategoriesTest_gi",
               "SymmetricCoclosedMonoidalCategoriesProperties_gi",
               "RigidSymmetricCoclosedMonoidalCategoriesProperties_gi",
               "RigidSymmetricCoclosedMonoidalCategoriesMethodRecord_gi",
               "RigidSymmetricCoclosedMonoidalCategories_gi",
               "RigidSymmetricCoclosedMonoidalCategoriesTest_gi",
               "LeftCoclosedMonoidalCategoriesDerivedMethods_gi",
               "SymmetricCoclosedMonoidalCategoriesDerivedMethods_gi",
               "RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods_gi",
               ];
    
    header := Concatenation(
                      "# THIS FILE WAS AUTOMATICALLY GENERATED",
                      "\n\n" );
    
    for file in files do
        if not IsBound( files_rec.(file) ) then
            Info( InfoWarning, 1, "the component ", file, " is not bound in the record 'files_rec'" );
        elif IsString( files_rec.(file) ) then
            source := Concatenation( dir, ReplacedString( file, "_", "." ) );
            target := Concatenation( PackageInfo( package_name )[1].InstallationPath, "/gap/", files_rec.(file) );
            WriteReplacedFileForHomalg( source, L, target : header := header );
        fi;
    od;
    
end );
