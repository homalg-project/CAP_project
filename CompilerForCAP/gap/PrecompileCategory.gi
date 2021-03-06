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
    #"HomomorphismStructureOnMorphismsWithGivenObjects",
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
  local cat1, cat2, cat, obj, mor, operations, diff, output_string, package_info, parameters_string, current_string, object_name, example_input, index, compiled_func, function_string, filter_list, function_name, current_rec;
    
    if IsOperation( category_constructor ) or IsKernelFunction( category_constructor ) then
        
        Error( "category_constructor must be a regular function, i.e. not an operation or a kernel function" );
        
    fi;
    
    # check if category_constructor returns a new instance of the category every time
    cat1 := CallFuncList( category_constructor, given_arguments );
    cat2 := CallFuncList( category_constructor, given_arguments );
    
    if IsIdenticalObj( cat1, cat2 ) then
        
        Error( "the category constructor must not return the same instance of the category if called twice" );
        
    fi;
    
    # check that category_constructor supports `FinalizeCategory` and `enable_compilation`
    cat := CallFuncList( category_constructor, given_arguments : FinalizeCategory := false, enable_compilation := true );
    
    if HasIsFinalized( cat ) then
        
        Error( "the category constructor must support the option `FinalizeCategory`" );
        
    fi;
    
    Finalize( cat );
    
    if cat!.enable_compilation <> true then
        
        Error( "the category constructor must support the option `enable_compilation`" );
        
    fi;
    
    if CanCompute( cat, "ZeroObject" ) and CanCompute( cat, "ZeroMorphism" ) then
        
        obj := ZeroObject( cat );
        mor := ZeroMorphism( obj, obj );
        
    else
        
        obj := fail;
        mor := fail;
        
    fi;
    
    if ValueOption( "operations" ) = fail then
        
        operations := Intersection( ListInstalledOperationsOfCategory( cat ) );
        
    else
        
        operations := ValueOption( "operations" );
        
    fi;
    
    diff := Difference( operations, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) );
    
    if Length( diff ) > 0 then
        
        Error( "The following strings are no CAP operations and can thus not be compiled: ", diff );
        
    fi;
    
    diff := Difference( operations, ListInstalledOperationsOfCategory( cat ) );
    
    if Length( diff ) > 0 then
        
        Error( "The following operations you want to have compiled are not computable in the given category: ", diff );
        
    fi;
    
    output_string := "";
    
    package_info := First( PackageInfo( package_name ) );
    
    if package_info = fail then
        
        Error( "could not find package info" );
        
    fi;
    
    parameters_string := JoinStringsWithSeparator( NamesLocalVariablesFunction( category_constructor ){[ 1 .. NumberArgumentsFunction( category_constructor ) ]}, ", " );
    
    current_string := Concatenation(
        "# SPDX-License-Identifier: GPL-2.0-or-later\n",
        "# ", package_name, ": ", package_info.Subtitle, "\n",
        "#\n",
        "# Implementations\n",
        "#\n",
        "BindGlobal( \"", compiled_category_name, "\", function ( ", parameters_string, " )\n",
        "  local category_constructor, cat;\n",
        "    \n",
        "    category_constructor := \n",
        "        \n",
        "        \n",
        "        ", CapJitPrettyPrintFunction( category_constructor ), ";\n",
        "        \n",
        "        \n",
        "    \n",
        "    cat := category_constructor( ", parameters_string, " : FinalizeCategory := false );\n"
    );
    output_string := Concatenation( output_string, current_string );
    
    for function_name in operations do
        
        current_rec := CAP_INTERNAL_METHOD_NAME_RECORD.(function_name);
        
        filter_list := current_rec.filter_list;
        
        if not filter_list[1] = "category" then
            
            Error( function_name, " does not get the category as the first argument. This is not supported when precompiling categories." );
            
        fi;
        
        # construct example input if possible
        if function_name in CAP_JIT_INTERNAL_SAFE_OPERATIONS and obj <> fail and mor <> fail then
            
            # check if we can construct an example input
            if not ForAll( filter_list, f -> f in [ "category", "object", "morphism", "list_of_objects", "list_of_morphisms", IsInt ] ) then
                
                Error( "cannot generate example input for the operation ", function_name );
                
            fi;
            
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
                    
                    Error( "this should never happen" );
                    
                fi;
                
            end );
            
            if current_rec.is_with_given then
                
                # try to use object as last argument
                
                object_name := current_rec.with_given_object_name;
                
                if CanCompute( cat, object_name ) then
                    
                    example_input[Length( example_input )] := CallFuncList( ValueGlobal( object_name ), example_input{CAP_INTERNAL_METHOD_NAME_RECORD.(current_rec.with_given_without_given_name_pair[1]).object_arguments_positions} );
                    
                else
                    
                    Error( "The category cannot compute the object operation of a WithGiven operation. This is not supported." );
                    
                fi;
                
            fi;
            
        else
            
            example_input := [ cat ];
            
        fi;
        
        # find the last added function with no additional filters
        index := Last( PositionsProperty( cat!.added_functions.(function_name), f -> Length( f[2] ) = 0 ) );
        
        if index = fail then
            
            Error( "All added functions for <function_name> in <cat> have additional filters. Cannot continue with compilation." );
            
        fi;
        
        if IsBound( cat!.compiled_functions.(function_name)[index] ) then
            
            compiled_func := cat!.compiled_functions.(function_name)[index];
            
        else
            
            compiled_func := CapJitCompiledFunction( cat!.added_functions.(function_name)[index][1], example_input );
            
            cat!.compiled_functions.(function_name)[index] := compiled_func;
            
        fi;
        
        function_string := CapJitPrettyPrintFunction( compiled_func );
        
        if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
            
            Error( "Could not get rid of all global functions. You should use category_hints.category_attribute_names." );
            
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
            "    );\n"
        );
        output_string := Concatenation( output_string, current_string );
        
    od;
    
    current_string := Concatenation(
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
