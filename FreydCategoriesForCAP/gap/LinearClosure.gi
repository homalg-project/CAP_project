#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#############################################################################

####################################
##
## Constructors
##
####################################

## sorting_function:
## compares two morphisms alpha: a -> b, beta: a -> b
## such that, if we take the quotient by IsCongruentForMorphisms, we get a total ordering on morphisms
InstallMethod( LinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction ],
               
  function( ring, underlying_category, sorting_function )
    local category, is_finite;
    
    if not ( HasIsCommutative( ring ) and IsCommutative( ring ) ) then
        
        Error( "only commutative rings are supported" );
        
    fi;
    
    category := CreateCapCategory( Concatenation( "LinearClosure( ", Name( underlying_category )," )" ) : overhead := false );
    
    category!.sorting_function := sorting_function;
    
    SetIsLinearCategoryOverCommutativeRing( category, true );
    
    SetIsAbCategory( category, true );
    
    SetCommutativeRingOfLinearCategory( category, ring );
    
    SetFilterObj( category, IsLinearClosure );
    
    SetUnderlyingRing( category, ring );
    
    SetUnderlyingCategory( category, underlying_category );
    
    AddObjectRepresentation( category, IsLinearClosureObject and HasUnderlyingOriginalObject );
    
    AddMorphismRepresentation( category, IsLinearClosureMorphism and HasCoefficientsList and HasSupportMorphisms );
    
    INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( LinearClosureObjectOp,
               [ IsLinearClosure, IsCapCategoryObject ],
               
  function( category, object )
    local linear_closure_object;
    
    linear_closure_object := rec( );
    
    ObjectifyObjectForCAPWithAttributes( linear_closure_object, 
                                         category,
                                         UnderlyingOriginalObject, object
    );
    
    return linear_closure_object;
    
end );

##
InstallOtherMethod( LinearClosureObject,
                    [ IsCapCategoryObject, IsLinearClosure ],
               
  function( object, category )
    
    return LinearClosureObject( category, object );
    
end );

## Data structure for morphisms:
## list of morphisms in underlying category: [ alpha_1, alpha_2, ..., alpha_n ],
## pairwise not congruent, and sorted w.r.t. sorting_function in increasing order.
##
## list of coefficients, same length as list of morphisms: [ c_1, ..., c_n ].
## non of the c_i must be zero.
##
## Interpreation: formal linear combination Sum_{i = 1}^n c_i * alpha_i
##
## Reason for sorting:
## this gives a normal form, which makes the congruence decision possible
##
InstallMethod( LinearClosureMorphism,
               [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( source, coefficients, support_morphisms, range )
    local sorting_function, coefficients_copy, support_morphisms_copy, 
          coefficients_NF, support_morphisms_NF, m, c, i, m_compare;
    
    if IsEmpty( coefficients ) then
        
        return LinearClosureMorphismNC( source, coefficients, support_morphisms, range );
        
    fi;
    
    ## create normal form (NF)
    sorting_function := CapCategory( source )!.sorting_function;
    
    coefficients_copy := ShallowCopy( coefficients );
    
    support_morphisms_copy := ShallowCopy( support_morphisms );
    
    SortParallel( support_morphisms_copy, coefficients_copy, sorting_function );
    
    coefficients_NF := [];
    
    support_morphisms_NF := [];
    
    m := support_morphisms_copy[1];
    
    c := coefficients_copy[1];
    
    for i in [ 2 .. Size( support_morphisms_copy ) ] do
        
        m_compare := support_morphisms_copy[i];
        
        if IsCongruentForMorphisms( m, m_compare ) then
            
            c := c + coefficients_copy[i];
            
        else
            
            if not IsZero( c ) then
                
                Add( support_morphisms_NF, m );
                
                Add( coefficients_NF, c );
                
            fi;
            
            m := m_compare;
            
            c := coefficients_copy[i];
            
        fi;
        
    od;
    
    if not IsZero( c ) then
        
        Add( support_morphisms_NF, m );
                
        Add( coefficients_NF, c );
        
    fi;
    
    return LinearClosureMorphismNC( source, coefficients_NF, support_morphisms_NF, range );
    
end );

##
InstallMethod( LinearClosureMorphismNC,
               [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( source, coefficients, support_morphisms, range )
    local morphism, category;
    
    morphism := rec();
    
    category := CapCategory( source );
    
    ## this is a "compiled" version of ObjectifyMorphismForCAPWithAttributes
    ObjectifyWithAttributes( morphism, category!.morphism_type,
        Source, source,
        Range, range,
        CoefficientsList, coefficients,
        SupportMorphisms, support_morphisms,
        CapCategory, category );
    
    return morphism;
    
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE,
    function( category )
        local ring, underlying_category, sorting_function, mul_coeffs, mul_supp, one, zero, minus_one,
              equality_func, finsets, rows, t_obj, t_finsets, FunctorMor, FunctorObj;
        
        ring := UnderlyingRing( category );
        
        underlying_category := UnderlyingCategory( category );
        
        sorting_function := category!.sorting_function;
        
        one := One( ring );
        
        zero := Zero( ring );
        
        minus_one := MinusOne( ring );
        
    ##
    AddIsEqualForObjects( category, {a, b} -> IsEqualForObjects( UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) ) );
    
    equality_func := function( alpha, beta, equal_or_cong )
        local coeffs_a, coeffs_b, supp_a, supp_b, size;
        
        coeffs_a := CoefficientsList( alpha );
        
        coeffs_b := CoefficientsList( beta );
        
        size := Length( coeffs_a );
        
        if size <> Length( coeffs_b ) then 
            return false; 
        fi;
        
        return ForAll( [ 1 .. size ], i -> equal_or_cong( SupportMorphisms( alpha )[i], SupportMorphisms( beta )[i] ) ) 
                and 
                coeffs_a = coeffs_b;
        
    end;
    
    ##
    AddIsEqualForMorphisms( category, {alpha, beta} -> equality_func( alpha, beta, IsEqualForMorphisms ) );
    
    ##
    AddIsCongruentForMorphisms( category, {alpha, beta} -> equality_func( alpha, beta, IsCongruentForMorphisms ) );
    
    ##
    AddIsWellDefinedForObjects( category, x -> IsIdenticalObj( underlying_category, CapCategory( UnderlyingOriginalObject( x ) ) ) );
    
    ##
    AddIsWellDefinedForMorphisms( category, 
      function( alpha ) 
        local coeffs, supp, size, s, i;
        
        coeffs := CoefficientsList( alpha );
        
        supp := SupportMorphisms( alpha );
        
        if IsEmpty( coeffs ) then
            if IsEmpty( supp ) then
                return true;
            else
                return false;
            fi;
        fi;
        
        size := Size( coeffs );
        
        if size <> Size( supp ) then 
            return false; 
        fi;
        
        if not ForAll( coeffs, c -> c in ring ) then
            return false;
        fi;
        
        if ForAny( coeffs, c -> IsZero( c ) ) then
            return false;
        fi;
        
        s := supp[1];
        
        for i in [ 2 .. size ] do
            
            if not sorting_function( s, supp[i] ) then
                return false;
            fi;
            
            s := supp[i];
            
        od;
        
        return true;
        
    end );
    
    mul_coeffs := {a,b} -> a * b;
    
    mul_supp := {alpha, beta} -> PreCompose( alpha, beta );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        local coeffs, supp;
        
        coeffs := ListX( CoefficientsList( alpha ), CoefficientsList( beta ), mul_coeffs );
        
        supp := ListX( SupportMorphisms( alpha ), SupportMorphisms( beta ), mul_supp );
        
        return LinearClosureMorphism( Source( alpha ), coeffs, supp, Range( beta ) );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( object )
        
        return LinearClosureMorphismNC( object, [ one ], [ IdentityMorphism( UnderlyingOriginalObject( object ) ) ], object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( a, b )
        
        return LinearClosureMorphismNC( a, [ ], [ ], b );
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( alpha )
        
        return IsEmpty( CoefficientsList( alpha ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( alpha, beta )
        return LinearClosureMorphism( 
            Source( alpha ),
            Concatenation( CoefficientsList( alpha ), CoefficientsList( beta ) ),
            Concatenation( SupportMorphisms( alpha ), SupportMorphisms( beta ) ),
            Range( alpha )
        );
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( alpha )
        return LinearClosureMorphism( 
            Source( alpha ),
            List( CoefficientsList( alpha ), c -> minus_one * c ),
            SupportMorphisms( alpha ),
            Range( alpha )
        );
    end );
    
    ##
    AddSubtractionForMorphisms( category,
      function( alpha, beta )
        return LinearClosureMorphism( 
            Source( alpha ),
            Concatenation( CoefficientsList( alpha ), List( CoefficientsList( beta ), c -> minus_one * c ) ),
            Concatenation( SupportMorphisms( alpha ), SupportMorphisms( beta ) ),
            Range( alpha )
        );
    end );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
        function( r, alpha ) 
            return LinearClosureMorphism( 
                Source( alpha ),
                List( CoefficientsList( alpha ), c -> r * c ),
                SupportMorphisms( alpha ),
                Range( alpha )
        );
    end );
    
    ## Homomorphism structure
    
    if ForAll( 
        [ "DistinguishedObjectOfHomomorphismStructure", 
         "HomomorphismStructureOnObjects",
         "HomomorphismStructureOnMorphismsWithGivenObjects",
         "InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure",
         "InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism" ],
         f -> CanCompute( underlying_category, f ) )
         and 
         IsCategoryOfSkeletalFinSets( RangeCategoryOfHomomorphismStructure( underlying_category ) ) then
            
        finsets := RangeCategoryOfHomomorphismStructure( underlying_category );
            
        rows := CategoryOfRows( ring : overhead := false );
            
        SetRangeCategoryOfHomomorphismStructure( category, rows );
        
        t_obj := TensorUnit( rows );
        
        t_finsets := TerminalObject( finsets );
        
        FunctorObj := function( set )
            return CategoryOfRowsObject( rows, Length( set ) );
        end;
        
        FunctorMor := function( mor )
            local range, id;
            
            range := Range( mor );
            
            id := HomalgIdentityMatrix( Length( range ), ring );
            
            return CategoryOfRowsMorphism(
                FunctorObj( Source( mor ) ),
                CertainRows( id, AsList( mor ) ),
                FunctorObj( range )
            );
            
        end;
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
        function()
            
            return t_obj;
            
        end );
        
        ##
        AddHomomorphismStructureOnObjects( category,
          function( a, b )
            
            return FunctorObj( HomomorphismStructureOnObjects( UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) ) );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( source, alpha, beta, range )
            local coeffs_a, size_a, coeffs_b, size_b, supp_a, supp_b;
            
            coeffs_a := CoefficientsList( alpha );
            
            size_a := Size( coeffs_a );
            
            coeffs_b := CoefficientsList( beta );
            
            size_b := Size( coeffs_b );
            
            if size_a = 0 or size_b = 0 then
                
                return ZeroMorphism( source, range );
                
            fi;
            
            supp_a := SupportMorphisms( alpha );
            
            supp_b := SupportMorphisms( beta );
            
            return
                Sum( List( [ 1 .. size_a ], 
                    i -> Sum( List( [ 1 .. size_b ], 
                        j -> coeffs_a[i] * coeffs_b[j] * FunctorMor( HomomorphismStructureOnMorphisms( supp_a[i], supp_b[j] ) ) ) ) ) );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( category,
            function( alpha )
                local coeffs, supp;
                
                coeffs := CoefficientsList( alpha );
                
                if Size( coeffs ) = 0 then
                    
                    return ZeroMorphism( t_obj, HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) ) );
                    
                fi;
                
                supp := SupportMorphisms( alpha );
                
                return
                    Sum( List( [ 1 .. Size( coeffs ) ], 
                    i -> 
                    coeffs[i] * FunctorMor( InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( supp[i] ) ) ) );
                
        end );
        
        ##
        AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( a, b, mor )
            local size, a_und, b_und, range_finset;
            
            size := RankOfObject( Range( mor ) );
            
            a_und := UnderlyingOriginalObject( a );
            
            b_und := UnderlyingOriginalObject( b );
            
            range_finset := FinSet( finsets, size );
            
            return
                LinearClosureMorphism(
                    a,
                    EntriesOfHomalgMatrix( UnderlyingMatrix( mor ) ),
                    List( [ 1 .. size ], i -> 
                        InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism(
                            a_und, b_und, MapOfFinSets( t_finsets, [ i ], range_finset )
                        )
                    ),
                    b
                );
            
        end );
        
    fi;
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
               [ IsLinearClosureMorphism ],
    
    function( alpha )
        local coeffs, support, list;
        
        coeffs := CoefficientsList( alpha );
        
        if IsEmpty( coeffs ) then
            
            return "0";
            
        fi;
        
        support := SupportMorphisms( alpha );
        
        list := List( [ 1 .. Size( coeffs ) ], i -> Concatenation( "(", ViewString( coeffs[i] ), "*", ViewString( support[i] ), ")" ) );
        
        return JoinStringsWithSeparator( list, " + " );
        
end );

##
InstallMethod( ViewString,
               [ IsLinearClosureObject ],

  function( obj )
    
    return Concatenation( "LinearClosure(", ViewString( UnderlyingOriginalObject( obj ) ), ")" );
    
end );

##
InstallMethod( ViewObj,
               [ IsLinearClosureMorphism ],
               
    function( alpha )
        
        Print( ViewString( alpha ) );
        
end );

##
InstallMethod( ViewObj,
               [ IsLinearClosureObject ],
               
    function( obj )
        
        Print( ViewString( obj ) );
        
end );

####################################
##
## Convenience
##
####################################

InstallMethod( \*,
               [ IsLinearClosureMorphism, IsLinearClosureMorphism ],
               PreCompose );

InstallMethod( \=,
               [ IsLinearClosureMorphism, IsLinearClosureMorphism ],
               IsCongruentForMorphisms );

InstallMethod( \/,
               [ IsCapCategoryMorphism, IsLinearClosure ],
               
    function( mor, cat ) 
        
        return LinearClosureMorphismNC(
            LinearClosureObject( Source( mor ), cat ),
            [ One( UnderlyingRing( cat ) ) ],
            [ mor ],
            LinearClosureObject( Range( mor ), cat )
        );
        
end );
