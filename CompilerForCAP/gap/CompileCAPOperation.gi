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

InstallGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree", function ( cat, operation_name )
  local index, function_to_compile, info, filter_list, return_type, obj, mor, example_input, without_given_name, without_given_rec, with_given_object_position, source, range;
    
    # find the last added function with no additional filters
    index := Last( PositionsProperty( cat!.added_functions.(operation_name), f -> Length( f[2] ) = 0 ) );
    
    if index = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "All added functions for <operation_name> in <cat> have additional filters. Cannot continue with compilation." );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name)[index] ) then
        
        if not (IsBound( cat!.category_as_first_argument ) and cat!.category_as_first_argument = true) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "only CAP operations of categories with `cat!.category_as_first_argument = true` can be compiled" );
            
        fi;
        
        function_to_compile := cat!.added_functions.(operation_name)[index][1];
        
        if IsOperation( function_to_compile ) or IsKernelFunction( function_to_compile ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "compiling operations or kernel functions is not supported." );
            
        fi;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
        
        filter_list := info.filter_list;
        return_type := info.return_type;
        
        if IsString( return_type ) and EndsWith( return_type, "fail" ) then
            
            Display( Concatenation(
                "WARNING: Compiling CAP operation ", operation_name, " with return_type ", return_type, ". ",
                "Operations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed even if the corresponding condition does not hold. ",
                "This might cause errors."
            ) );
            
        fi;
        
        # construct example input if possible
        if operation_name in CAP_JIT_INTERNAL_SAFE_OPERATIONS and CanCompute( cat, "ZeroObject" ) and CanCompute( cat, "ZeroMorphism" ) then
            
            obj := ZeroObject( cat );
            mor := ZeroMorphism( cat, obj, obj );
            
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
            
            if info.is_with_given then
                
                without_given_name := info.with_given_without_given_name_pair[1];
                
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
                Error( "cannot generate example input for the operation ", operation_name );
                
            fi;
            
        else
            
            Assert( 0, filter_list[1] = "category" );
            
            example_input := [ cat ];
            
        fi;
        
        # catch errors in the code before compilation by first executing the function as is
        if Length( example_input ) = Length( filter_list ) then
            
            CallFuncList( function_to_compile, example_input );
            
        fi;
        
        cat!.compiled_functions_trees.(operation_name)[index] := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, example_input );
        
    fi;
    
    return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_trees.(operation_name)[index] );
    
end );
