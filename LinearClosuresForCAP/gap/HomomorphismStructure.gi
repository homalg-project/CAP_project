# SPDX-License-Identifier: GPL-2.0-or-later
# LinearClosuresForCAP: Linear closures
#
# Implementations
#

has_prerequisites_for_hom_structure :=
    function( underlying_category )
    
      return IsSkeletalCategoryOfFiniteSets( RangeCategoryOfHomomorphismStructure( underlying_category ) ) and
             ForAll( [ "DistinguishedObjectOfHomomorphismStructure",
                       "HomomorphismStructureOnObjects",
                       "HomomorphismStructureOnMorphismsWithGivenObjects",
                       "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                       "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ],
             f -> CanCompute( underlying_category, f ) );

end;

InstallGlobalFunction( HOM_STRUCTURE_BASED_SORTING_FUNCTION_OR_FAIL_FOR_LINEAR_CLOSURE,
  
  function( underlying_category )
    
    if IsSkeletalCategoryOfFiniteSets( RangeCategoryOfHomomorphismStructure( underlying_category ) ) then
          
          return function( alpha_1, alpha_2 )
                   local index_1, index_2;
                   index_1 := AsList( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha_1 ) )[1];
                   index_2 := AsList( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha_2 ) )[1];
                   return index_1 < index_2;
                end;
                
    else
          
          return fail;
          
    fi;

end );

InstallGlobalFunction( SET_HOMOMORPHISM_STRUCTURE_ATTRIBUTES_FOR_LINEAR_CLOSURE,
  
  function( category, rows )
    local underlying_category;
    
    underlying_category := UnderlyingCategory( category );
    
    if has_prerequisites_for_hom_structure( underlying_category ) then
        
        SetRangeCategoryOfHomomorphismStructure( category, rows );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        if HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( rows ) and
           IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( rows )
        then
            
            SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category, true );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( INSTALL_HOMOMORPHISM_STRUCTURE_FOR_LINEAR_CLOSURE,
  
  function( category, rows )
      local ring, underlying_category, t_obj, finsets, t_finsets, FunctorObj, FunctorMor;
    
    ring := UnderlyingRing( rows );
    
    underlying_category := UnderlyingCategory( category );
    
    if has_prerequisites_for_hom_structure( underlying_category ) then
        
        t_obj := CategoryOfRowsObject( rows, 1 );
        
        finsets := RangeCategoryOfHomomorphismStructure( underlying_category );
        
        t_finsets := TerminalObject( finsets );
        
        FunctorObj := function( set )
            #% CAP_JIT_RESOLVE_FUNCTION
            return CategoryOfRowsObject( rows, Int( Length( set ) ) );
        end;
        
        FunctorMor := function( mor )
            local range, id;
            #% CAP_JIT_RESOLVE_FUNCTION
            
            range := Range( mor );
            
            id := HomalgIdentityMatrix( Length( range ), ring );
            
            return CategoryOfRowsMorphism( rows,
                FunctorObj( Source( mor ) ),
                CertainRows( id, 1 + AsList( mor ) ),
                FunctorObj( range )
            );
            
        end;
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
        function( cat )
            
            return t_obj;
            
        end );
        
        ##
        AddHomomorphismStructureOnObjects( category,
          function( cat, a, b )
            
            return FunctorObj( HomomorphismStructureOnObjects( UnderlyingCategory( cat ), UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) ) );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( cat, source, alpha, beta, range )
            local coeffs_a, size_a, coeffs_b, size_b, supp_a, supp_b;
            
            coeffs_a := CoefficientsList( alpha );
            
            size_a := Length( coeffs_a );
            
            coeffs_b := CoefficientsList( beta );
            
            size_b := Length( coeffs_b );
            
            if size_a = 0 or size_b = 0 then
                
                return ZeroMorphism( rows, source, range );
                
            fi;
            
            supp_a := SupportMorphisms( alpha );
            
            supp_b := SupportMorphisms( beta );
            
            return Iterated(
                    List(
                        [ 1 .. size_a ],
                        i -> Iterated(
                            List(
                                [ 1 .. size_b ],
                                j ->  MultiplyWithElementOfCommutativeRingForMorphisms( rows, coeffs_a[i] * coeffs_b[j], FunctorMor( HomomorphismStructureOnMorphisms( UnderlyingCategory( cat ),  supp_a[i], supp_b[j] ) ) )
                            ),
                            { mor1, mor2 } -> AdditionForMorphisms( rows, mor1, mor2 )
                        )
                    ),
                    { mor1, mor2 } -> AdditionForMorphisms( rows, mor1, mor2 )
                );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
            function( cat, alpha )
                local coeffs, supp;
                
                coeffs := CoefficientsList( alpha );
                
                if IsEmpty( coeffs ) then
                    
                    return ZeroMorphism( t_obj, HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) ) );
                    
                fi;
                
                supp := SupportMorphisms( alpha );
                
                return Sum( List( [ 1 .. Length( coeffs ) ],
                    i -> coeffs[i] * FunctorMor( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( supp[i] ) ) ) );
                
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, a, b, mor )
            local size, a_und, b_und, range_finset;
            
            size := RankOfObject( Range( mor ) );
            
            a_und := UnderlyingOriginalObject( a );
            
            b_und := UnderlyingOriginalObject( b );
            
            range_finset := FinSet( finsets, BigInt( size ) );
            
            return MorphismConstructor( cat,
                           a,
                           Pair( EntriesOfHomalgMatrix( UnderlyingMatrix( mor ) ),
                                 List( [ 0 .. size - 1 ], i ->
                                       InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                                               a_und,
                                               b_und,
                                               MapOfFinSets( t_finsets, [ i ], range_finset ) ) ) ),
                           b );
            
        end );
        
    fi;
    
end );
