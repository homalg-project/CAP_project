# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
# operations for which our example input constructed below is a valid input
BindGlobal( "CAP_JIT_INTERNAL_SAFE_OPERATIONS", [
    "AdditionForMorphisms",
    "AdditiveInverseForMorphisms",
    "AstrictionToCoimage",
    "AstrictionToCoimageWithGivenCoimage",
    "BasisOfExternalHom",
    "CanonicalIdentificationFromCoimageToImageObject",
    "CanonicalIdentificationFromImageObjectToCoimage",
    "CoastrictionToImage",
    "CoastrictionToImageWithGivenImageObject",
    #"CoefficientsOfMorphismWithGivenBasisOfExternalHom",
    "Coequalizer",
    #"CoequalizerFunctorialWithGivenCoequalizers",
    "Coimage",
    "CoimageProjection",
    "CoimageProjectionWithGivenCoimage",
    "CokernelColift",
    "CokernelColiftWithGivenCokernelObject",
    "CokernelObject",
    #"CokernelObjectFunctorialWithGivenCokernelObjects",
    "CokernelProjection",
    "CokernelProjectionWithGivenCokernelObject",
    "Colift",
    "ColiftAlongEpimorphism",
    "ColiftOrFail",
    #"ComponentOfMorphismFromDirectSum",
    #"ComponentOfMorphismIntoDirectSum",
    "Coproduct",
    #"CoproductFunctorialWithGivenCoproducts",
    "DirectProduct",
    #"DirectProductFunctorialWithGivenDirectProducts",
    "DirectSum",
    "DirectSumCodiagonalDifference",
    "DirectSumDiagonalDifference",
    #"DirectSumFunctorialWithGivenDirectSums",
    "DirectSumProjectionInPushout",
    "DistinguishedObjectOfHomomorphismStructure",
    "EmbeddingOfEqualizer",
    "EmbeddingOfEqualizerWithGivenEqualizer",
    "EpimorphismFromSomeProjectiveObject",
    "EpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
    "Equalizer",
    #"EqualizerFunctorialWithGivenEqualizers",
    "FiberProduct",
    "FiberProductEmbeddingInDirectSum",
    #"FiberProductFunctorialWithGivenFiberProducts",
    "HomologyObject",
    #"HomologyObjectFunctorialWithGivenHomologyObjects",
    "HomomorphismStructureOnMorphisms",
    "HomomorphismStructureOnMorphismsWithGivenObjects",
    "HomomorphismStructureOnObjects",
    #"HorizontalPostCompose",
    #"HorizontalPreCompose",
    "IdentityMorphism",
    #"IdentityTwoCell",
    "ImageEmbedding",
    "ImageEmbeddingWithGivenImageObject",
    "ImageObject",
    "InitialObject",
    "InitialObjectFunctorial",
    "InjectionOfCofactorOfCoproduct",
    "InjectionOfCofactorOfCoproductWithGivenCoproduct",
    "InjectionOfCofactorOfDirectSum",
    "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
    "InjectionOfCofactorOfPushout",
    "InjectionOfCofactorOfPushoutWithGivenPushout",
    "InjectiveColift",
    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
    #"InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
    "InverseForMorphisms",
    #"InverseMorphismFromCoimageToImageWithGivenObjects",
    "IsAutomorphism",
    #"IsCodominating",
    "IsColiftable",
    "IsColiftableAlongEpimorphism",
    "IsCongruentForMorphisms",
    #"IsDominating",
    "IsEndomorphism",
    "IsEpimorphism",
    #"IsEqualAsFactorobjects",
    #"IsEqualAsSubobjects",
    "IsEqualForCacheForMorphisms",
    "IsEqualForCacheForObjects",
    "IsEqualForMorphisms",
    "IsEqualForMorphismsOnMor",
    "IsEqualForObjects",
    "IsHomSetInhabited",
    "IsIdempotent",
    "IsIdenticalToIdentityMorphism",
    "IsIdenticalToZeroMorphism",
    "IsInitial",
    "IsInjective",
    "IsIsomorphism",
    "IsLiftable",
    "IsLiftableAlongMonomorphism",
    "IsMonomorphism",
    "IsOne",
    "IsProjective",
    "IsSplitEpimorphism",
    "IsSplitMonomorphism",
    "IsTerminal",
    "IsWellDefinedForMorphisms",
    "IsWellDefinedForObjects",
    #"IsWellDefinedForTwoCells",
    "IsZeroForMorphisms",
    "IsZeroForObjects",
    "IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
    "IsomorphismFromCoimageToCokernelOfKernel",
    "IsomorphismFromCokernelOfDiagonalDifferenceToPushout",
    "IsomorphismFromCokernelOfKernelToCoimage",
    "IsomorphismFromCoproductToDirectSum",
    "IsomorphismFromDirectProductToDirectSum",
    "IsomorphismFromDirectSumToCoproduct",
    "IsomorphismFromDirectSumToDirectProduct",
    "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
    "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
    "IsomorphismFromFiberProductToKernelOfDiagonalDifference",
    "IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject",
    "IsomorphismFromImageObjectToKernelOfCokernel",
    "IsomorphismFromInitialObjectToZeroObject",
    "IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject",
    "IsomorphismFromKernelOfCokernelToImageObject",
    "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
    "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
    "IsomorphismFromPushoutToCokernelOfDiagonalDifference",
    "IsomorphismFromTerminalObjectToZeroObject",
    "IsomorphismFromZeroObjectToInitialObject",
    "IsomorphismFromZeroObjectToTerminalObject",
    "KernelEmbedding",
    "KernelEmbeddingWithGivenKernelObject",
    "KernelLift",
    "KernelLiftWithGivenKernelObject",
    "KernelObject",
    #"KernelObjectFunctorialWithGivenKernelObjects",
    "Lift",
    "LiftAlongMonomorphism",
    "LiftOrFail",
    #"MereExistenceOfSolutionOfLinearSystemInAbCategory",
    "MonomorphismIntoSomeInjectiveObject",
    "MonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
    #"MorphismBetweenDirectSumsWithGivenDirectSums",
    #"MorphismFromCoimageToImageWithGivenObjects",
    "MorphismFromEqualizerToSink",
    "MorphismFromEqualizerToSinkWithGivenEqualizer",
    "MorphismFromFiberProductToSink",
    "MorphismFromFiberProductToSinkWithGivenFiberProduct",
    "MorphismFromKernelObjectToSink",
    "MorphismFromKernelObjectToSinkWithGivenKernelObject",
    "MorphismFromSourceToCoequalizer",
    "MorphismFromSourceToCoequalizerWithGivenCoequalizer",
    "MorphismFromSourceToCokernelObject",
    "MorphismFromSourceToCokernelObjectWithGivenCokernelObject",
    "MorphismFromSourceToPushout",
    "MorphismFromSourceToPushoutWithGivenPushout",
    #"MultiplyWithElementOfCommutativeRingForMorphisms",
    "PostCompose",
    "PreCompose",
    "ProjectionInFactorOfDirectProduct",
    "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
    "ProjectionInFactorOfDirectSum",
    "ProjectionInFactorOfDirectSumWithGivenDirectSum",
    "ProjectionInFactorOfFiberProduct",
    "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
    "ProjectionOntoCoequalizer",
    "ProjectionOntoCoequalizerWithGivenCoequalizer",
    "ProjectiveLift",
    "Pushout",
    #"PushoutFunctorialWithGivenPushouts",
    #"RandomMorphismByInteger",
    #"RandomMorphismByList",
    #"RandomMorphismWithFixedRangeByInteger",
    #"RandomMorphismWithFixedRangeByList",
    #"RandomMorphismWithFixedSourceAndRangeByInteger",
    #"RandomMorphismWithFixedSourceAndRangeByList",
    #"RandomMorphismWithFixedSourceByInteger",
    #"RandomMorphismWithFixedSourceByList",
    #"RandomObjectByInteger",
    #"RandomObjectByList",
    #"SimplifyEndo",
    #"SimplifyEndo_IsoFromInputObject",
    #"SimplifyEndo_IsoToInputObject",
    #"SimplifyMorphism",
    #"SimplifyObject",
    #"SimplifyObject_IsoFromInputObject",
    #"SimplifyObject_IsoToInputObject",
    #"SimplifyRange",
    #"SimplifyRange_IsoFromInputObject",
    #"SimplifyRange_IsoToInputObject",
    #"SimplifySource",
    #"SimplifySourceAndRange",
    #"SimplifySourceAndRange_IsoFromInputRange",
    #"SimplifySourceAndRange_IsoFromInputSource",
    #"SimplifySourceAndRange_IsoToInputRange",
    #"SimplifySourceAndRange_IsoToInputSource",
    #"SimplifySource_IsoFromInputObject",
    #"SimplifySource_IsoToInputObject",
    #"SolveLinearSystemInAbCategory",
    "SomeInjectiveObject",
    "SomeProjectiveObject",
    #"SomeReductionBySplitEpiSummand",
    #"SomeReductionBySplitEpiSummand_MorphismFromInputRange",
    #"SomeReductionBySplitEpiSummand_MorphismToInputRange",
    "SubtractionForMorphisms",
    "TerminalObject",
    "TerminalObjectFunctorial",
    "UniversalMorphismFromCoequalizer",
    "UniversalMorphismFromCoequalizerWithGivenCoequalizer",
    "UniversalMorphismFromCoproduct",
    "UniversalMorphismFromCoproductWithGivenCoproduct",
    "UniversalMorphismFromDirectSum",
    "UniversalMorphismFromDirectSumWithGivenDirectSum",
    #"UniversalMorphismFromImage",
    #"UniversalMorphismFromImageWithGivenImageObject",
    "UniversalMorphismFromInitialObject",
    "UniversalMorphismFromInitialObjectWithGivenInitialObject",
    "UniversalMorphismFromPushout",
    "UniversalMorphismFromPushoutWithGivenPushout",
    "UniversalMorphismFromZeroObject",
    "UniversalMorphismFromZeroObjectWithGivenZeroObject",
    #"UniversalMorphismIntoCoimage",
    #"UniversalMorphismIntoCoimageWithGivenCoimage",
    "UniversalMorphismIntoDirectProduct",
    "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
    "UniversalMorphismIntoDirectSum",
    "UniversalMorphismIntoDirectSumWithGivenDirectSum",
    "UniversalMorphismIntoEqualizer",
    "UniversalMorphismIntoEqualizerWithGivenEqualizer",
    "UniversalMorphismIntoFiberProduct",
    "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
    "UniversalMorphismIntoTerminalObject",
    "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
    "UniversalMorphismIntoZeroObject",
    "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
    #"VerticalPostCompose",
    #"VerticalPreCompose",
    "ZeroMorphism",
    "ZeroObject",
    "ZeroObjectFunctorial",
] );

InstallGlobalFunction( "CapJitPrecompileCategory", function ( category_constructor, given_arguments, package_name, compiled_category_name )
  local cat1, cat2, cat, obj, mor, operations, diff, output_string, package_info, parameters_string, current_string, object_name, example_input, without_given_name, without_given_rec, with_given_object_position, source, range, index, function_to_compile, compiled_tree, compiled_func, function_string, weight, IsPrecompiledDerivation_string, filter_list, function_name, current_rec;
    
    if IsOperation( category_constructor ) or IsKernelFunction( category_constructor ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "category_constructor must be a regular function, i.e. not an operation or a kernel function" );
        
    fi;
    
    # check if category_constructor returns a new instance of the category every time
    cat1 := CallFuncList( category_constructor, given_arguments : no_precompiled_code := true );
    cat2 := CallFuncList( category_constructor, given_arguments : no_precompiled_code := true );
    
    if IsIdenticalObj( cat1, cat2 ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the category constructor must not return the same instance of the category if called twice" );
        
    fi;
    
    # check that category_constructor supports `FinalizeCategory`
    cat := CallFuncList( category_constructor, given_arguments : FinalizeCategory := false, no_precompiled_code := true );
    
    if IsFinalized( cat ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the category constructor must support the option `FinalizeCategory`" );
        
    fi;
    
    Finalize( cat );
    
    if CanCompute( cat, "ZeroObject" ) and CanCompute( cat, "ZeroMorphism" ) then
        
        obj := ZeroObject( cat );
        mor := ZeroMorphism( cat, obj, obj );
        
    else
        
        obj := fail;
        mor := fail;
        
    fi;
    
    if ValueOption( "operations" ) = fail then
        
        operations := ListInstalledOperationsOfCategory( cat );
        
    elif ValueOption( "operations" ) = "primitive" then
        
        operations := ListPrimitivelyInstalledOperationsOfCategory( cat );
        
    elif IsString( ValueOption( "operations" ) ) then
        
        operations := [ ValueOption( "operations" ) ];
        
    else
        
        operations := ValueOption( "operations" );
        
    fi;
    
    diff := Difference( operations, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) );
    
    if Length( diff ) > 0 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "The following strings are no CAP operations and can thus not be compiled: ", diff );
        
    fi;
    
    diff := Difference( operations, ListInstalledOperationsOfCategory( cat ) );
    
    if Length( diff ) > 0 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "The following operations you want to have compiled are not computable in the given category: ", diff );
        
    fi;
    
    output_string := "";
    
    package_info := First( PackageInfo( package_name ) );
    
    if package_info = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "could not find package info" );
        
    fi;
    
    parameters_string := JoinStringsWithSeparator( NamesLocalVariablesFunction( category_constructor ){[ 1 .. NumberArgumentsFunction( category_constructor ) ]}, ", " );
    
    current_string := Concatenation(
        "# SPDX-License-Identifier: GPL-2.0-or-later\n",
        "# ", package_name, ": ", package_info.Subtitle, "\n",
        "#\n",
        "# Implementations\n",
        "#\n",
        "BindGlobal( \"ADD_FUNCTIONS_FOR_", compiled_category_name, "\", function ( cat )\n"
    );
    output_string := Concatenation( output_string, current_string );
    
    for function_name in operations do
        
        current_rec := CAP_INTERNAL_METHOD_NAME_RECORD.(function_name);
        
        # operations/derivations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed
        # even if the corresponding condition does not hold
        if IsString( current_rec.return_type ) and EndsWith( current_rec.return_type, "fail" ) then
            
            continue;
            
        fi;
        
        filter_list := current_rec.filter_list;
        
        if not filter_list[1] = "category" then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( function_name, " does not get the category as the first argument. This is not supported when precompiling categories." );
            
        fi;
        
        # construct example input if possible
        if function_name in CAP_JIT_INTERNAL_SAFE_OPERATIONS and obj <> fail and mor <> fail then
            
            example_input := List( filter_list, function ( filter )
                
                if filter = "category" then
                    
                    return cat;
                    
                elif filter = "object" then
                    
                    return obj;
                    
                elif filter = "morphism" then
                    
                    return mor;
                    
                elif filter = "list_of_objects" then
                    
                    return [ obj ];
                    
                elif filter = "list_of_morphisms" then
                    
                    return [ mor ];
                    
                elif filter = IsInt then
                    
                    return 1;
                    
                else
                    
                    return fail;
                    
                fi;
                
            end );
            
            if current_rec.is_with_given then
                
                without_given_name := current_rec.with_given_without_given_name_pair[1];
                
                without_given_rec := CAP_INTERNAL_METHOD_NAME_RECORD.(without_given_name);
                
                if CanCompute( cat, without_given_name ) then
                    
                    with_given_object_position := without_given_rec.with_given_object_position;
                    
                    if with_given_object_position = "Source" then
                        
                        # replace last element of example_input
                        Remove( example_input );
                        Add( example_input, CallFuncList( without_given_rec.output_source_getter, example_input ) );
                        
                    elif with_given_object_position = "Range" then
                        
                        # replace last element of example_input
                        Remove( example_input );
                        Add( example_input, CallFuncList( without_given_rec.output_range_getter, example_input ) );
                        
                    elif with_given_object_position = "both" then
                        
                        # replace second and last element of example_input
                        Remove( example_input, 2 );
                        Remove( example_input );
                        
                        source := CallFuncList( without_given_rec.output_source_getter, example_input );
                        range := CallFuncList( without_given_rec.output_range_getter, example_input );
                        
                        Add( example_input, source, 2 );
                        Add( example_input, range );
                       
                    else
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "this should never happen" );
                        
                    fi;
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "The category cannot compute the WithoutGiven operation of a WithGiven pair. This is not supported." );
                    
                fi;
                
            fi;
            
            # check if we have been able to construct an example input
            if fail in example_input then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "cannot generate example input for the operation ", function_name );
                
            fi;
            
        else
            
            example_input := [ cat ];
            
        fi;
        
        # find the last added function with no additional filters
        index := Last( PositionsProperty( cat!.added_functions.(function_name), f -> Length( f[2] ) = 0 ) );
        
        if index = fail then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "All added functions for <function_name> in <cat> have additional filters. Cannot continue with compilation." );
            
        fi;
        
        function_to_compile := cat!.added_functions.(function_name)[index][1];
        
        if IsOperation( function_to_compile ) or IsKernelFunction( function_to_compile ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "Precompiling operations or kernel functions is not supported." );
            
        fi;
        
        # catch errors in the code before compilation by first executing the function as is
        if Length( example_input ) = Length( filter_list ) then
            
            CallFuncList( function_to_compile, example_input );
            
        fi;
        
        if not IsBound( cat!.compiled_functions_trees.(function_name)[index] ) then
            
            cat!.compiled_functions_trees.(function_name)[index] := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, example_input );
            
        fi;
        
        compiled_tree := cat!.compiled_functions_trees.(function_name)[index];
        
        # change names of arguments
        compiled_tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID(
            compiled_tree,
            compiled_tree.id,
            Concatenation( current_rec.input_arguments_names, compiled_tree.nams{[ compiled_tree.narg + 1 .. Length( compiled_tree.nams ) ]} )
        );
        
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( compiled_tree );
        
        function_string := CapJitPrettyPrintFunction( compiled_func );
        
        if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "Could not get rid of all global variables, see <function_string>. You should use category_hints.category_attribute_names." );
            
        fi;
        
        if not IsEmpty(
                CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION(
                    compiled_func,
                    RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ),
                    2,
                    CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS
                )
            ) then
            
            Display( Concatenation( "WARNING: Could not resolve all CAP operations while precompiling ", function_name, "." ) );
            
        fi;
        
        # Taking the original weight is not optimal because the compilation might have simplified things drastically.
        # However, this is still better than just setting everything to the default weight.
        weight := CurrentOperationWeight( cat!.derivations_weight_list, function_name );
        
        Assert( 0, weight < infinity );
        
        if IsBound( cat!.primitive_operations.(function_name) ) and cat!.primitive_operations.(function_name) = true then
            
            IsPrecompiledDerivation_string := "";
            
        else
            
            IsPrecompiledDerivation_string := " : IsPrecompiledDerivation := true";
            
        fi;
        
        current_string := Concatenation(
            "    \n",
            "    ##\n",
            "    Add", function_name, "( cat,\n",
            "        \n",
            "########\n",
            function_string, "\n",
            "########\n",
            "        \n",
            "    , ", String( weight ), IsPrecompiledDerivation_string, " );\n"
        );
        output_string := Concatenation( output_string, current_string );
        
    od;
    
    current_string := Concatenation(
        "    \n",
        "end );\n",
        "\n",
        "BindGlobal( \"", compiled_category_name, "\", function ( ", parameters_string, " )\n",
        "  local category_constructor, cat;\n",
        "    \n",
        "    category_constructor :=\n",
        "        \n",
        "        \n",
        "        ", CapJitPrettyPrintFunction( category_constructor ), ";\n",
        "        \n",
        "        \n",
        "    \n",
        "    cat := category_constructor( ", parameters_string, " : FinalizeCategory := false, no_precompiled_code := true );\n",
        "    \n",
        "    ADD_FUNCTIONS_FOR_", compiled_category_name, "( cat );\n",
        "    \n",
        "    Finalize( cat );\n",
        "    \n",
        "    return cat;\n",
        "    \n",
        "end );\n"
    );
    output_string := Concatenation( output_string, current_string );
    
    WriteFileInPackageForHomalg( package_name, Concatenation( "precompiled_categories/", compiled_category_name, ".gi" ), output_string );
    
end );

InstallGlobalFunction( "CapJitPrecompileCategoryAndCompareResult", function ( category_constructor, given_arguments, package_name, compiled_category_name )
  local filepath, old_file_content, new_file_content;
    
    filepath := Concatenation( "precompiled_categories/", compiled_category_name, ".gi" );
    
    if IsExistingFileInPackageForHomalg( package_name, filepath ) then
        
        old_file_content := ReadFileFromPackageForHomalg( package_name, filepath );
        
    else
        
        # this should never happen in tests
        # COVERAGE_IGNORE_NEXT_LINE
        old_file_content := "";
        
    fi;
    
    CapJitPrecompileCategory(
        category_constructor,
        given_arguments,
        package_name,
        compiled_category_name
    );
    
    new_file_content := ReadFileFromPackageForHomalg( package_name, filepath );
    
    if old_file_content <> new_file_content then
        
        # this should never happen in tests
        # COVERAGE_IGNORE_NEXT_LINE
        Display( "WARNING: old and new file contents differ" );
        
    fi;
    
end );
