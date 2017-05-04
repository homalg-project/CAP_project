#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsSemisimpleCategoryMorphismRep",
                       IsSemisimpleCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemisimpleCategoryMorphisms",
        NewFamily( "TheFamilyOfSemisimpleCategoryMorphisms" ) );

BindGlobal( "TheTypeOfSemisimpleCategoryMorphisms",
        NewType( TheFamilyOfSemisimpleCategoryMorphisms,
                IsSemisimpleCategoryMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategoryMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local category, semisimple_category_morphism, sort_function, field;
    
    category := CapCategory( source );
    
    morphism_list := Filtered( morphism_list,
                       alpha -> NrRows( UnderlyingMatrix( alpha[1] ) ) <> 0 or NrColumns( UnderlyingMatrix( alpha[1] ) ) <> 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( morphism_list, sort_function );
    
    field := UnderlyingFieldForHomalg( source );
    
    semisimple_category_morphism := rec( );
    
    ObjectifyWithAttributes( semisimple_category_morphism, TheTypeOfSemisimpleCategoryMorphisms,
                             Source, source,
                             Range, range,
                             SemisimpleCategoryMorphismList, morphism_list,
                             UnderlyingFieldForHomalg, field
    );
    
    SetFilterObj( semisimple_category_morphism, GivenMorphismFilterForSemisimpleCategory( category ) );
    
    Add( category, semisimple_category_morphism );
    
    return semisimple_category_morphism;
    
end );

##
InstallMethod( SemisimpleCategoryMorphismSparse,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local support, field, chi, pos, source_vector_space, range_vector_space;
    
    morphism_list := Filtered( morphism_list,
                       alpha -> NrRows( UnderlyingMatrix( alpha[1] ) ) <> 0 or NrColumns( UnderlyingMatrix( alpha[1] ) ) <> 0 );
    
    support := Set( Concatenation( Support( source ), Support( range ) ) );
    
    field := UnderlyingFieldForHomalg( source );
    
    for chi in support do
      
      pos := PositionProperty( morphism_list, entry -> chi = entry[2] );
      
      if pos = fail then
          
          source_vector_space := VectorSpaceObject( Multiplicity( source, chi ), field );
          
          range_vector_space := VectorSpaceObject( Multiplicity( range, chi ), field );
          
          Add( morphism_list, [ ZeroMorphism( source_vector_space, range_vector_space ), chi ] );
          
      fi;
      
    od;
    
    return SemisimpleCategoryMorphism( source, morphism_list, range );
    
end );


##
InstallMethod( ComponentInclusionMorphism,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( object, chi )
    local category, support, l, summands;
    
    category := CapCategory( object );
    
    support := Support( object );
    
    l := PositionProperty( support, psi -> psi = chi );
    
    if l = fail then
        
        return UniversalMorphismFromZeroObject( object );
        
    fi;
    
    summands := List( support, psi -> SemisimpleCategoryObject( [ [ Multiplicity( object, psi ), psi ] ], category ) );
    
    return InjectionOfCofactorOfDirectSum( summands, l );
    
end );

##
InstallMethod( ComponentProjectionMorphism,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( object, chi )
    local category, support, l, summands;
    
    category := CapCategory( object );
    
    support := Support( object );
    
    l := PositionProperty( support, psi -> psi = chi );
    
    if l = fail then
        
        return UniversalMorphismIntoZeroObject( object );
        
    fi;
    
    summands := List( support, psi -> SemisimpleCategoryObject( [ [ Multiplicity( object, psi ), psi ] ], category ) );
    
    return ProjectionInFactorOfDirectSum( summands, l );
    
end );

##
InstallMethod( CAP_INTERNAL_Create_Semisimple_Endomorphism_From_Sparse_String_List,
               [ IsSemisimpleCategoryObject, IsList ],
               
  function( object, string_list )
    local morphism_list, object_list, size, field, i, vector_space;
    
    morphism_list := [];
    
    object_list := SemisimpleCategoryObjectList( object );
    
    size := Size( object_list );
    
    field := UnderlyingFieldForHomalg( object );
    
    for i in [ 1 .. size ] do
#         
#         ConvertToStringRep( string_list[i] );
#         
        vector_space := VectorSpaceObject( object_list[i][1], field );
        
        Add( morphism_list, [
          VectorSpaceMorphism(
            vector_space,
            CreateHomalgMatrixFromSparseString( string_list[i], object_list[i][1], object_list[i][1], field ),
            vector_space ),
          object_list[i][2] ] );
        
    od;
    
    return SemisimpleCategoryMorphism( object, morphism_list, object );
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( Component,
               [ IsSemisimpleCategoryMorphism, IsObject ],
               
  function( morphism, irr )
    local coeff;
    
    coeff := First( SemisimpleCategoryMorphismList( morphism ), elem -> elem[2] = irr );
    
    if coeff = fail then
        
        return IdentityMorphism( ZeroObject( UnderlyingCategoryForSemisimpleCategory( CapCategory( morphism ) ) ) );
        
    else
        
        return coeff[1];
        
    fi;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsSemisimpleCategoryMorphism ],
               
  function( morphism )
    local morphism_list, elem;
    
    morphism_list := SemisimpleCategoryMorphismList( morphism );
    
    morphism_list := Filtered( morphism_list, pair -> not( IsZero( Source( pair[1] ) ) or IsZero( Range( pair[1] ) ) ) );
    
    if IsEmpty( morphism_list ) then
        
        Print( "0" );
        
    else
        
        for elem in morphism_list do
            
            Print( Concatenation( "Component: (x_", String( elem[2] ), ")\n" ) );
            
            Print( "\n" );
            
            Display( elem[1] );
            
            Print( "\n------------------------\n" );
            
        od;
      
    fi;
    
end );

