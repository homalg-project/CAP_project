# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

##
InstallGlobalFunction( FREYD_CATEGORIES_GENERATORS_OF_FREYD_OBJECT_OVER_ROWS,
  function( freyd_obj )
    local rows, range, nr_gen, L, x;
    
    rows := UnderlyingCategory( CapCategory( freyd_obj ) );
    
    range := Range( RelationMorphism( freyd_obj ) );
    
    nr_gen := RankOfObject( range );
    
    L := [];
    
    for x in [ 1 .. nr_gen ] do
        
        Add( L, 
            FreydCategoryMorphism( 
                AsFreydCategoryObject( 1/rows ),
                StandardRowMorphism( range, x ),
                freyd_obj
            )
        );
        
    od;
    
    return L;
    
end );

##
InstallGlobalFunction( FREYD_CATEGORIES_REFINEMENT_FOR_SERRE_SUBCATEGORIES,
  function( L )
    local newL, i, j, hom, simplify_mor, gens, mor, int, mono, epi;
    
    newL := ShallowCopy( L );
    
    for i in [ 1 .. Length( L ) ] do
        
        for j in [ 1 .. Length( L ) ] do
            
            hom := HomomorphismStructureOnObjects( L[i], L[j] );
            
            if not IsZeroForObjects( hom ) then
                
                simplify_mor := SimplifyObject_IsoToInputObject( hom, infinity );
                
                ## loop over uncanonical generators
                
                gens := FREYD_CATEGORIES_GENERATORS_OF_FREYD_OBJECT_OVER_ROWS( Source( simplify_mor ) );
                
                for mor in gens do
                    
                    int := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(  
                        L[i], L[j], 
                        PreCompose( mor, simplify_mor ) 
                    );
                    
                    mono := IsMonomorphism( int );
                    
                    epi := IsEpimorphism( int );
                    
                    if not mono then
                        
                        Add( newL, KernelObject( int ) );
                        
                    fi;
                    
                    if not epi then
                        
                        Add( newL, CokernelObject( int ) );
                        
                    fi;
                    
                    if not (mono and epi) then
                        
                        Add( newL, ImageObject( int ) );
                        
                    fi;
                    
                od;
                
            fi;
            
        od;
        
    od;
    
    return newL;
    
end );

##
InstallGlobalFunction( FREYD_CATEGORIES_CHOP_ABOVE_SERRE_SUBCATEGORIES,
  function( K, L )
    local hom, l, first_gen, int, new_K, hit, enlarged_L, simplify_mor;
    
    hit := fail;
    
    for l in L do
        
        hom := HomomorphismStructureOnObjects( K, l );
        
        if not IsZeroForObjects( hom ) then
            
            hit := l;
            
            break;
            
        fi;
        
    od;
    
    if hit = fail then
        
        return fail;
        
    fi;
    
    simplify_mor := SimplifyObject_IsoToInputObject( hom, infinity );
    
    first_gen := FREYD_CATEGORIES_GENERATORS_OF_FREYD_OBJECT_OVER_ROWS( Source( simplify_mor ) )[1];
    
    int := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( K, hit, PreCompose( first_gen, simplify_mor ) );
    
    new_K := KernelObject( int );
    
    if IsZero( new_K ) then
        return true;
    fi;
    
    enlarged_L := ShallowCopy( L );
    
    if not IsEpimorphism( int ) then
        
        Add( enlarged_L, CokernelObject( int ) );
        
        Add( enlarged_L, ImageObject( int ) );
        
    fi;
    
    return [ new_K, enlarged_L ];
    
end );

##
InstallGlobalFunction( FREYD_CATEGORIES_CHOP_BELOW_SERRE_SUBCATEGORIES,
  function( K, L )
    local hom, l, first_gen, int, new_K, hit, enlarged_L, simplify_mor;
    
    hit := fail;
    
    for l in L do
        
        hom := HomomorphismStructureOnObjects( l, K );
        
        if not IsZeroForObjects( hom ) then
            
            hit := l;
            
            break;
            
        fi;
        
    od;
    
    if hit = fail then
        
        return fail;
        
    fi;
    
    simplify_mor := SimplifyObject_IsoToInputObject( hom, infinity );
    
    first_gen := FREYD_CATEGORIES_GENERATORS_OF_FREYD_OBJECT_OVER_ROWS( Source( simplify_mor ) )[1];
    
    int := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( hit, K, PreCompose( first_gen, simplify_mor ) );
    
    new_K := CokernelObject( int );
    
    if IsZero( new_K ) then
        return true;
    fi;
    
    enlarged_L := ShallowCopy( L );
    
    if not IsMonomorphism( int ) then
        
        Add( enlarged_L, KernelObject( int ) );
        
        Add( enlarged_L, ImageObject( int ) );
        
    fi;
    
    return [ new_K, enlarged_L ];
    
end );


##
InstallMethod( MembershipFunctionSerreSubcategoryGeneratedByObjects,
               [ IsList, IsCapCategory ],
               
  function( list_of_objects, category )
    
    return MembershipFunctionSerreSubcategoryGeneratedByObjects( list_of_objects, 1, category );
    
end );

##
InstallMethod( MembershipFunctionSerreSubcategoryGeneratedByObjects,
               [ IsList, IsInt, IsCapCategory ],
               
  function( list_of_objects, nr_of_refinements, category )
    local range_cat, L, k, membership_func, ABORT_CONST;
    ## test the range category (TODO: allow more generic cases)
    
    range_cat := RangeCategoryOfHomomorphismStructure( category );
    
    if not IsFreydCategory( range_cat ) then
        
        Error( "the range of the homomorphism structure must be a Freyd category" );
        
    fi;
    
    if not IsCategoryOfRows( UnderlyingCategory( range_cat ) ) then
        
        Error( "the range of the homomorphism structure must be a Freyd category with a category of rows as its underlying category" );
        
    fi;
    
    # 1.step: refine the list
    
    L := ShallowCopy( list_of_objects );
    
    for k in [ 1 .. nr_of_refinements ] do
        
        L := FREYD_CATEGORIES_REFINEMENT_FOR_SERRE_SUBCATEGORIES( L );
        
    od;
    
    # 2.step: chopping
    
    ABORT_CONST := 5;
    
    membership_func := function( test_obj )
        local K, chop_above, chop_below, counter;
        
        K := test_obj;
        
        counter := 0;
        
        while counter < ABORT_CONST do
            
            chop_above := FREYD_CATEGORIES_CHOP_ABOVE_SERRE_SUBCATEGORIES( K, L );
            
            if chop_above = fail then
                break;
            fi;
            
            if chop_above = true then
                return true;
            fi;
            
            K := chop_above[1];
            
            L := chop_above[2];
            
        od;
        
        counter := 0;
        
        while counter < ABORT_CONST do
            
            chop_below := FREYD_CATEGORIES_CHOP_BELOW_SERRE_SUBCATEGORIES( K, L );
            
            if chop_below = fail then
                break;
            fi;
            
            if chop_below = true then
                return true;
            fi;
            
            K := chop_below[1];
            
            L := chop_below[2];
            
        od;
        
        return fail;
        
    end;
    
    Print( "Warning: the provided function returns either true or fail!\n" );
    
    return membership_func;

end );
