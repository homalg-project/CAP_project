#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
##
#############################################################################

BindGlobal( "InfoGroupRepresentationsForCAP", NewInfoClass("InfoGroupRepresentationsForCAP") );

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsSemisimpleCategoryObjectRep",
                       IsSemisimpleCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemisimpleCategoryObjects",
        NewFamily( "TheFamilyOfSemisimpleCategoryObjects" ) );

BindGlobal( "TheTypeOfSemisimpleCategoryObjects",
        NewType( TheFamilyOfSemisimpleCategoryObjects,
                IsSemisimpleCategoryObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategoryObject,
               [ IsList, IsCapCategory ],
               
  function( semisimple_object_list, category )
    local semisimple_object_flat_list, size;
    
    size := Size( semisimple_object_list );
    
    semisimple_object_flat_list := List( [ 2 .. 2 * size + 1 ],
      i -> semisimple_object_list[ QuoInt( i, 2 ) ][ RemInt( i, 2 ) + 1 ] );
    
    return SemisimpleCategoryObjectConstructorWithFlatList( semisimple_object_flat_list, category );
    
end );

##
InstallMethodWithCache( SemisimpleCategoryObjectConstructorWithFlatList,
                        [ IsList, IsCapCategory ],
               
  function( semisimple_object_flat_list, category )
    local size, semisimple_object_list, semisimple_category_object, normalized_semisimple_object_list, field;
    
    size := Size( semisimple_object_flat_list );
    
    semisimple_object_list := List( [ 1 .. size/2 ], i ->
      [ semisimple_object_flat_list[ 2*i - 1 ], semisimple_object_flat_list[ 2*i ] ] );
    
    semisimple_category_object := rec( );
    
    normalized_semisimple_object_list := NormalizeSemisimpleCategoryObjectList( semisimple_object_list );
    
    field := UnderlyingCategoryForSemisimpleCategory( category )!.field_for_matrix_category;
    
    ObjectifyWithAttributes( semisimple_category_object, TheTypeOfSemisimpleCategoryObjects,
                             SemisimpleCategoryObjectList, normalized_semisimple_object_list,
                             UnderlyingFieldForHomalg, field
    );
    
    SetFilterObj( semisimple_category_object, GivenObjectFilterForSemisimpleCategory( category ) );
    
    Add( category, semisimple_category_object );
    
    return semisimple_category_object;
    
end );

##
InstallMethod( NormalizeSemisimpleCategoryObjectList,
               [ IsList ],
               
  function( semisimple_object_list )
    local sort_function, result_list, multiplicity, j, irreducible_object, size, i;
    
    semisimple_object_list := Filtered( semisimple_object_list, entry -> entry[1] > 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( semisimple_object_list, sort_function );
    
    size := Size( semisimple_object_list );
    
    result_list := [ ];
    
    i := 1;
    
    while ( i <= size ) do
        
        irreducible_object := semisimple_object_list[i][2];
        
        multiplicity := semisimple_object_list[i][1];
        
        j := i + 1;
        
        while ( j <= size ) and ( semisimple_object_list[j][2] = irreducible_object ) do
            
            multiplicity := multiplicity + semisimple_object_list[j][1];
            
            j := j + 1;
            
        od;
        
        Add( result_list, [ multiplicity, irreducible_object ] );
        
        i := j;
        
    od;
    
    return result_list;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( Support,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return List( SemisimpleCategoryObjectList( object ), elem -> elem[2] );
    
end );

##
InstallMethod( Dimension,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return Sum( List( SemisimpleCategoryObjectList( object ), elem -> elem[1] * Dimension( elem[2] ) ) );
    
end );

##
InstallMethod( SemisimpleCategoryObjectListWithActualObjects,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return List( SemisimpleCategoryObjectList( object ), 
             elem -> [ elem[1], SemisimpleCategoryObject( [ [ 1, elem[2] ] ], category ) ] );
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( Multiplicity,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( semisimple_category_object, irr )
    local coeff;
    
    coeff := First( SemisimpleCategoryObjectList( semisimple_category_object ), elem -> elem[2] = irr );
    
    if coeff = fail then
        
        return 0;
        
    else
        
        return coeff[1];
        
    fi;
    
end );

##
InstallMethod( Component,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( semisimple_category_object, irr )
    local multiplicity;
    
    multiplicity := Multiplicity( semisimple_category_object, irr );
    
    return VectorSpaceObject( multiplicity, UnderlyingFieldForHomalg( semisimple_category_object ) );
    
end );

##
InstallMethod( TestPentagonIdentity,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_a, object_b, object_c, object_d )
    local morphism_1, morphism_2;
    
    morphism_1 :=
      TensorProductOnMorphisms( AssociatorLeftToRight( object_a, object_b, object_c ), IdentityMorphism( object_d ) );
    
    morphism_1 := PreCompose( morphism_1,
      AssociatorLeftToRight( object_a, TensorProductOnObjects( object_b, object_c ), object_d ) );
    
    morphism_1 := PreCompose( morphism_1,
      TensorProductOnMorphisms( IdentityMorphism( object_a ), AssociatorLeftToRight( object_b, object_c, object_d ) ) );
    
    morphism_2 := AssociatorLeftToRight( TensorProductOnObjects( object_a, object_b ), object_c, object_d );
    
    morphism_2 := PreCompose( morphism_2,
      AssociatorLeftToRight( object_a, object_b, TensorProductOnObjects( object_c, object_d ) ) );
    
    return IsCongruentForMorphisms( morphism_1, morphism_2 );
    
end );

##
InstallMethod( TestPentagonIdentityForAllQuadruplesInList,
               [ IsList ],
               
  function( object_list )
    local a, b, c, d, size, list, test, string, all_okay;
    
    size := Size( object_list );
    
    list := [ 1 .. size ];
    
    all_okay := true;

    for a in list do
        
        for b in list do
            
            for c in list do
                
                for d in list do
                    
                    test := TestPentagonIdentity( object_list[a], object_list[b], object_list[c], object_list[d] );
                    
                    string := Concatenation( "(", String( a ), ", ", String( b ), ", ", String( c ), ", ", String( d ), ")" );
                    
                    if not test then
                        
                        Info( InfoGroupRepresentationsForCAP, 2, Concatenation( "The quadruple ", string, " FAILED!" ) );
                        all_okay := false;
                        
                    else
                        
                        Info( InfoGroupRepresentationsForCAP, 2, Concatenation( "The quadruple ", string, " is okay!" ) );
                        
                    fi;
                    
                od;
                
            od;
            
            
        od;
        
    od;
    
    return all_okay;
    
end );

InstallMethod( TestBraidingCompatability,
              [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ],
              
  function( object_a, object_b, object_c )
    local morphism_1, morphism_2;
    
    morphism_1 := Braiding( TensorProductOnObjects( object_a, object_b ), object_c );
    
    morphism_1 := PreCompose( morphism_1, AssociatorRightToLeft( object_c, object_a, object_b ) );
    
    morphism_1 := PreCompose( morphism_1,
                    TensorProductOnMorphisms( Braiding( object_c, object_a ), IdentityMorphism( object_b ) ) );
    
    morphism_2 := AssociatorLeftToRight( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    TensorProductOnMorphisms( IdentityMorphism( object_a ), Braiding( object_b, object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, AssociatorRightToLeft( object_a, object_c, object_b ) );
    
    if not ( morphism_1 = morphism_2 ) then
        
        return false;
        
    fi;
    
    morphism_1 := Braiding( object_a, TensorProductOnObjects( object_b, object_c ) );
    
    morphism_1 := PreCompose( morphism_1, AssociatorLeftToRight( object_b, object_c, object_a ) );
    
    morphism_1 := PreCompose( morphism_1,
                    TensorProductOnMorphisms( IdentityMorphism( object_b ), Braiding( object_c, object_a ) ) );
    
    morphism_2 := AssociatorRightToLeft( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    TensorProductOnMorphisms( Braiding( object_a, object_b ), IdentityMorphism( object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, AssociatorLeftToRight( object_b, object_a, object_c ) );
    
    return morphism_1 = morphism_2;
    
end );

##
InstallMethod( TestBraidingCompatabilityForAllTriplesInList,
               [ IsList ],
               
  function( object_list )
    local a, b, c, size, list, test, string;
    
    size := Size( object_list );
    
    list := [ 1 .. size ];
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                test := TestBraidingCompatability( object_list[a], object_list[b], object_list[c] );
                
                string := Concatenation( "(", String( a ), ", ", String( b ), ", ", String( c ), ")" );
                
                if not test then
                    
                    Print( Concatenation( "The quadruple ", string, " FAILED! \n" ) ); 
                    
                else
                    
                    Print( Concatenation( "The quadruple ", string, " is okay! \n" ) ); 
                    
                fi;
                
            od;
            
        od;
        
    od;
    
end );

##
InstallMethod( TestZigZagIdentitiesForDual,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local id_object, dual_object, id_dual_object, automorphism;
    
    id_object := IdentityMorphism( object );
    
    dual_object := DualOnObjects( object );
    
    id_dual_object := IdentityMorphism( dual_object );
    
    automorphism := PreCompose( [
      LeftUnitorInverse( object ),
      TensorProductOnMorphisms( CoevaluationForDual( object ), id_object ),
      AssociatorLeftToRight( object, dual_object, object ),
      TensorProductOnMorphisms( id_object, EvaluationForDual( object ) ),
      RightUnitor( object ) ] );
    
    if not IsCongruentForMorphisms( automorphism, id_object ) then
        
        return false;
        
    fi;
    
    automorphism := PreCompose( [
      RightUnitorInverse( dual_object ),
      TensorProductOnMorphisms( id_dual_object, CoevaluationForDual( object ) ),
      AssociatorRightToLeft( dual_object, object, dual_object ),
      TensorProductOnMorphisms( EvaluationForDual( object ), id_dual_object ),
      LeftUnitor( dual_object ) ] );
    
    return IsCongruentForMorphisms( automorphism, id_dual_object );
    
end );

##
InstallMethod( TestZigZagIdentitiesForDualForAllObjectsInList, 
              [ IsList ],
              
  function( object_list )
    local elem;
    
    for elem in object_list do
        
        if TestZigZagIdentitiesForDual( elem ) then
            
            Print( Concatenation( String( elem ), " is okay!\n" ) );
            
        else
            
            Print( Concatenation( String( elem ), " FAILED!\n" ) );
            
        fi;
        
    od;
    
end );

####################################
##
## View
##
####################################

InstallMethod( String,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local object_list, string, i, size;
    
    object_list := SemisimpleCategoryObjectList( object );
    
    size := Size( object_list );
    
    if size = 0 then
        
        return "0";
        
    fi;
    
    string := Concatenation( String( object_list[1][1] ), "*(x_", String( object_list[1][2] ), ")" );
    
    for i in [ 2 .. size ] do
        
        Append( string, Concatenation( " + ", String( object_list[i][1] ), "*(x_", String( object_list[i][2] ), ")" ) );
        
    od;
    
    return string;
    
end );

##
InstallMethod( ViewObj,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    Print( String( object ) );
    
end );

##
InstallMethod( Display,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    Print( Concatenation( String( object ), "\n" ) );
    
end );
