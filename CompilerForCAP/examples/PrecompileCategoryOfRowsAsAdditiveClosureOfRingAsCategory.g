#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true
ReadPackage( "FreydCategoriesForCAP",
    "gap/CategoryOfRowsAsAdditiveClosureOfRingAsCategory_CompilerLogic.gi");
#! true

# We only compile one very special case:
# The homomorphism structure for homalg exterior rings over fields.

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EEE := KoszulDualRing( QQxy );;

# We need special JIT arguments, so we have to compile manually and
# hack the result into the category_constructor.

rows := CategoryOfRowsAsAdditiveClosureOfRingAsCategory( EEE );;

dist_object := DistinguishedObjectOfHomomorphismStructure( rows );;
o := CategoryOfRowsObject( rows, 1 );;
id_o := IdentityMorphism( o );;
H_o_o := HomomorphismStructureOnObjects( o, o );;
nu_id_o :=
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure(
    id_o
);;

function_name1 := "HomomorphismStructureOnMorphismsWithGivenObjects";;
Length( rows!.added_functions.(function_name1) );
#! 1
compiled_tree1 := CapJitCompiledFunctionAsEnhancedSyntaxTree(
    rows!.added_functions.(function_name1)[1][1],
    [ rows, H_o_o, id_o, id_o, H_o_o ]
);;

function_name2 := Concatenation(
    "InterpretMorphismAsMorphismFromDistinguishedObject",
    "ToHomomorphismStructureWithGivenObjects"
);;
Length( rows!.added_functions.(function_name2) );
#! 1
compiled_tree2 := CapJitCompiledFunctionAsEnhancedSyntaxTree(
    rows!.added_functions.(function_name2)[1][1],
    [ rows, dist_object, id_o, H_o_o ]
);;

function_name3 :=
  "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism";;
Length( rows!.added_functions.(function_name3) );
#! 1
compiled_tree3 := CapJitCompiledFunctionAsEnhancedSyntaxTree(
    rows!.added_functions.(function_name3)[1][1],
    [ rows, o, o, nu_id_o ]
);;

function_names := [ function_name1, function_name2, function_name3 ];;
compiled_trees := [ compiled_tree1, compiled_tree2, compiled_tree3 ];;

CATEGORY_OF_ROWS_HACKY_EXTENDER := function ( rows )
    Perform( [ 1 .. Length( function_names ) ], function( i )
        rows!.compiled_functions_trees.(function_names[i])[1] :=
            compiled_trees[i]; end ); end;;

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
category_constructor := EvalString( ReplacedString( """function( homalg_ring )
  local rows@
    
    rows := CategoryOfRowsAsAdditiveClosureOfRingAsCategory( homalg_ring )@
    
    if IsBoundGlobal( "CATEGORY_OF_ROWS_HACKY_EXTENDER" ) then
        
        ValueGlobal( "CATEGORY_OF_ROWS_HACKY_EXTENDER" )( rows )@
        
    fi@
    
    return rows@
    
end""", "@", ";" ) );;

given_arguments := [ EEE ];;
package_name := "FreydCategoriesForCAP";;
compiled_category_name := Concatenation(
    "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOf",
    "HomalgExteriorRingOverFieldPrecompiled"
);;
operations := [
    "DistinguishedObjectOfHomomorphismStructure",
    "HomomorphismStructureOnObjects",
    function_name1,
    function_name2,
    function_name3,
];;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);

#! @EndExample
