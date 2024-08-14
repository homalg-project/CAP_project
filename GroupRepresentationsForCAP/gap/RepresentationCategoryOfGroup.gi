# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Implementations
#
#! @Chapter Representation Category of Groups

####################################
##
## Constructors
##
####################################

InstallMethod( RepresentationCategory,
               [ IsInt, IsInt ],
               
  function( order, group_nr )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data, group;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "GroupRepresentationsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := Concatenation( String( order ), ",", String( group_nr ) );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Print( "Warning: The associator of ", group_string, " has not been computed yet\n" );
        
        group_data := [];
        
    fi;
    
    group := SmallGroup( order, group_nr );
    
    return RepresentationCategory( group, group_data );
    
end );

InstallMethod( RepresentationCategory,
               [ IsGroup ],
               
  function( group )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "GroupRepresentationsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    if HasIsTrivial( group ) and IsTrivial( group ) then
        
        group_string := "TrivialGroup( )";
        
    else
        
        group_string := String( group );
        
    fi;
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Print( "Warning: The associator of ", group_string, " has not been computed yet\n" );
        
        group_data := [];
        
    fi;
    
    return RepresentationCategory( group, group_data );
    
end );

## Rep( G )
##
InstallMethod( RepresentationCategory,
               [ IsGroup, IsList ],
               
  function( group, group_data )
    local group_string, name,
          irr, conductor, unit_number, e,
          field, membership_function, tensor_unit, associator_filename, is_complete_data,
          category;
    
    group_string := String( group );
    
    name := Concatenation( "The representation category of ", group_string );
    
    irr := Irr( group );
    
    if group_data <> [] then
        
        conductor := group_data[2];
        
        unit_number := group_data[3];
        
        associator_filename := group_data[4];
        
        is_complete_data := group_data[5];
      
    else
        
        conductor := 1;
        
        unit_number := PositionProperty( irr, IsOne );
        
        associator_filename := "";
        
        is_complete_data := false;
      
    fi;
    
    membership_function := object -> IsGIrreducibleObject( object ) and IsIdenticalObj( UnderlyingGroup( object ), group );
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
    fi;
    
    SetConductor( field, conductor );
    
    tensor_unit := GIrreducibleObject( irr[ unit_number ] );
    
    category := SemisimpleCategory( field, membership_function, tensor_unit, associator_filename, is_complete_data,
                  [ IsRepresentationCategory, IsRepresentationCategoryObject, 
                    IsRepresentationCategoryMorphism, name ] );
    
    SetUnderlyingGroupForRepresentationCategory( category, group );
    
    SetIsSkeletalCategory( category, true );
    
    DeactivateCachingOfCategory( category );
    
    CapCategorySwitchLogicOff( category );
    
    return category;
    
end );

##
InstallMethod( RepresentationCategoryObject,
               [ IsList, IsCapCategory ],
               
  function( object_list, category )
    
    object_list := List( object_list, elem -> [ elem[1], GIrreducibleObject( elem[2] ) ] );
    
    return SemisimpleCategoryObject( object_list, category );
    
end );

##
InstallMethod( RepresentationCategoryObject,
               [ IsCharacter, IsCapCategory ],
               
  function( character, category )
    
    return RepresentationCategoryObject( [ [ 1, character ] ], category );
    
end );

##
InstallMethod( RepresentationCategoryObject,
        "for a character, a CAP category, and a string",
        [ IsCharacter, IsCapCategory, IsString ],
        
  function ( character, category, str )
    
    SetString( GIrreducibleObject( character ), str );
    
    return RepresentationCategoryObject( character, category );
    
end );

##
InstallMethod( RepresentationCategoryMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local underlying_category, new_morphism_list, elem, vector_space_morphism;
    
    underlying_category := UnderlyingCategoryForSemisimpleCategory( CapCategory( source ) );
    
    new_morphism_list := [ ];
    
    for elem in morphism_list do
        
        vector_space_morphism := 
          VectorSpaceMorphism( MatrixCategoryObject( underlying_category, NrRows( elem[1] ) ),
                               elem[1], 
                               MatrixCategoryObject( underlying_category, NrColumns( elem[1] ) ) );
        
        Add( new_morphism_list, [ vector_space_morphism, GIrreducibleObject( elem[2] ) ] );
        
    od;
    
    return SemisimpleCategoryMorphism( source, new_morphism_list, range );
    
end );

## Rep( Z x G )
##
InstallMethod( RepresentationCategoryZGraded,
               [ IsInt, IsInt ],
               
  function( order, group_nr )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data, group;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "GroupRepresentationsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := Concatenation( String( order ), ",", String( group_nr ) );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Print( "Warning: The associator of ", group_string, " has not been computed yet\n" );
        
        group_data := [];
        
    fi;
    
    group := SmallGroup( order, group_nr );
    
    return RepresentationCategoryZGraded( group, group_data );
    
end );

InstallMethod( RepresentationCategoryZGraded,
               [ IsGroup ],
               
  function( group )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "GroupRepresentationsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := String( group );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Print( "Warning: The associator of ", group_string, " has not been computed yet\n" );
        
        group_data := [];
        
    fi;
    
    return RepresentationCategoryZGraded( group, group_data );
    
end );

InstallMethod( RepresentationCategoryZGraded,
               [ IsGroup, IsList ],
               
  function( group, group_data )
    local group_string, name,
          irr, conductor, unit_number, e,
          field, membership_function, tensor_unit, associator_filename, is_complete_data,
          category;
    
    group_string := String( group );
    
    name := Concatenation( "The skeletal Z-graded representation category of ", group_string );
    
    irr := Irr( group );
    
    if group_data <> [] then
        
        conductor := group_data[2];
        
        unit_number := group_data[3];
        
        associator_filename := group_data[4];
        
        is_complete_data := group_data[5];
      
    else
        
        conductor := 1;
        
        unit_number := PositionProperty( irr, IsOne );
        
        associator_filename := "";
        
        is_complete_data := false;
      
    fi;
    
    membership_function := object -> IsGZGradedIrreducibleObject( object ) and IsIdenticalObj( UnderlyingGroup( object ), group );
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
    fi;
    
    SetConductor( field, conductor );
    
    tensor_unit := GZGradedIrreducibleObject( 0, irr[ unit_number ] );
    
    category := SemisimpleCategory( field, membership_function, tensor_unit, associator_filename, is_complete_data,
                  [ IsRepresentationCategory, IsRepresentationCategoryZGradedObject, 
                    IsRepresentationCategoryZGradedMorphism, name ] );
    
    SetUnderlyingGroupForRepresentationCategory( category, group );
    
    SetIsSkeletalCategory( category, true );
    
    ## side effect: this computes the multiplicity array of group which can thus be accessed without the getter
    MultiplicityArray( group );
    
    ## side effect: this computes the multiplicity array of group which can thus be accessed without the getter
    MultiplicityTripleArray( group );
    
    DeactivateCachingOfCategory( category );
    
    CapCategorySwitchLogicOff( category );
    
    return category;
    
end );

##
InstallMethod( RepresentationCategoryZGradedObject,
               [ IsList, IsCapCategory ],
               
  function( object_list, category )
    
    object_list := List( object_list, elem -> [ elem[1], GZGradedIrreducibleObject( elem[2], elem[3] ) ] );
    
    return SemisimpleCategoryObject( object_list, category );
    
end );

##
InstallMethod( RepresentationCategoryZGradedObject,
               [ IsInt, IsCharacter, IsCapCategory ],
               
  function( degree, character, category )
    
    return RepresentationCategoryZGradedObject( [ [ 1, degree, character ] ], category );
    
end );

##
InstallMethod( RepresentationCategoryZGradedObject,
               [ IsCharacter, IsCapCategory ],
               
  function( character, category )
    
    return RepresentationCategoryZGradedObject( [ [ 1, 0, character ] ], category );
    
end );


##
InstallMethod( RepresentationCategoryZGradedMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local underlying_category, new_morphism_list, elem, vector_space_morphism;
    
    underlying_category := UnderlyingCategoryForSemisimpleCategory( CapCategory( source ) );
    
    new_morphism_list := [ ];
    
    for elem in morphism_list do
        
        vector_space_morphism :=
          VectorSpaceMorphism( MatrixCategoryObject( underlying_category, NrRows( elem[1] ) ),
                               elem[1], 
                               MatrixCategoryObject( underlying_category, NrColumns( elem[1] ) ) );
        
        Add( new_morphism_list, [ vector_space_morphism, GZGradedIrreducibleObject( elem[2], elem[3] ) ] );
        
    od;
    
    return SemisimpleCategoryMorphism( source, new_morphism_list, range );
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( DegreeDecomposition,
               [ IsRepresentationCategoryZGradedObject ],
               
  function( object )
    local object_list, current_degree, new_list, new_list_entry, i, elem;
    
    object_list := SemisimpleCategoryObjectList( object );
    
    if IsEmpty( object_list ) then
        
        return object_list;
        
    fi;
    
    current_degree := object_list[1][2]!.UnderlyingDegree;
    
    new_list := [ ];
    
    new_list_entry := [ object_list[1] ];
    
    for i in [ 2 .. Size( object_list ) ] do
        
        elem := object_list[i];
        
        if elem[2]!.UnderlyingDegree = current_degree then
            
            Add( new_list_entry, elem );
            
        else
            
            Add( new_list, new_list_entry );
            
            current_degree := elem[2]!.UnderlyingDegree;
            
            new_list_entry := [ elem ];
            
        fi;
        
    od;
    
    Add( new_list, new_list_entry );
    
    return List( new_list, entry -> [ entry[1][2]!.UnderlyingDegree ,SemisimpleCategoryObject( entry , CapCategory( object ) ) ] );
    
end );

##
InstallMethod( HilbertSeries,
               [ IsRepresentationCategoryZGradedObject ],
               
  function( object )
    local t;
    
    t := Indeterminate( Rationals, "t" );
    
    return Sum( DegreeDecomposition( object ), pair -> Dimension( pair[2] ) * t^pair[1] );
    
end );

##
InstallMethod( DegreeDecompositionSplitOp,
               [ IsRepresentationCategoryZGradedObject, IsInt ],
               
  function( object, split )
    local degree_decomposition, object1, object2;
    
    degree_decomposition := DegreeDecomposition( object );
    
    object1 := List( Filtered( degree_decomposition, elem -> elem[1] >= split ), pair -> pair[2] );
    
    object2 := List( Filtered( degree_decomposition, elem -> elem[1] < split ), pair -> pair[2] );
    
    if IsEmpty( object1 ) then
        
        object1 := ZeroObject( CapCategory( object ) );
        
        object2 := object;
        
    elif IsEmpty( object2 ) then
        
        object1 := object;
        
        object2 := ZeroObject( CapCategory( object ) );
        
    else
        
        object1 := DirectSum( object1 );
        
        object2 := DirectSum( object2 );
        
    fi;
    
    return [ object1, object2 ]; ##[ >=p, <p ]
    
end );

##
InstallMethod( DegreePartOp,
               [ IsRepresentationCategoryZGradedObject, IsInt ],
               
  function( object, p )
    local degree_part;
    
    degree_part := First( DegreeDecomposition( object ), elem -> elem[1] = p );
    
    if degree_part = fail then
        
        return fail;
        
    fi;
    
    return degree_part[2];
    
end );

##
InstallMethod( DegreeDescendingFiltration,
               [ IsRepresentationCategoryZGradedObject ],
               
  function( object )
    local descending_decomposition, size, descending_filtration, i, p, q, distance, id, j,
          last_range, injection;
    
    descending_decomposition := Reversed( DegreeDecomposition( object ) );
    
    size := Size( descending_decomposition );
    
    if size < 2 then
        
        return descending_decomposition;
        
    fi;
    
    descending_filtration := [ ];
    
    last_range := descending_decomposition[1][2];
    
    for i in [ 1 .. size - 1 ] do
        
        p := descending_decomposition[i][1];
        
        q := descending_decomposition[i + 1][1];
        
        distance :=  p - q;
        
        if distance > 1 then
            
            id := IdentityMorphism( last_range );
            
            for j in [ 0 .. distance - 2 ] do
                
                Add( descending_filtration, [ p - j, id ] );
                
            od;
            
        fi;
        
        injection := InjectionOfCofactorOfDirectSum( [ last_range, descending_decomposition[i + 1][2] ], 1 );
        
        Add( descending_filtration, [ q + 1, injection ] );
        
        last_range := Range( injection );
        
    od;
    
    return descending_filtration;
    
end );


####################################
##
## Operations
##
####################################


##
InstallMethod( InductionFunctorForRepresentationCategoriesOfGroups,
               [ IsGroup, IsGroup ],
               
  function( group, super_group )
    local rep_group, rep_super_group, function_on_irreducibles, irr_super_group;
    
    rep_super_group := RepresentationCategory( super_group );
    
    irr_super_group := Irr( super_group );
    
    function_on_irreducibles := function( irr )
      local induced_class_function, list, chi, scalar_product;
      
      induced_class_function := 
        InducedClassFunction( UnderlyingCharacter( irr ), super_group );
      
      list := [];
      
      for chi in irr_super_group do
          
          scalar_product := ScalarProduct( chi, induced_class_function );
          
          if scalar_product > 0 then
              
              Add( list, [ scalar_product, chi ] );
              
          fi;
          
      od;
      
      return RepresentationCategoryObject( list, rep_super_group );
      
    end;
    
    return
      FunctorByUniversalPropertyOfSemisimpleCategory(
        RepresentationCategory( group ), function_on_irreducibles, rep_super_group );
    
end );

##
InstallMethod( RestrictionFunctorForRepresentationCategoriesOfGroups,
               [ IsGroup, IsGroup ],
               
  function( group, sub_group )
    local rep_group, rep_sub_group, function_on_irreducibles, irr_sub_group;
    
    rep_sub_group := RepresentationCategory( sub_group );
    
    irr_sub_group := Irr( sub_group );
    
    function_on_irreducibles := function( irr )
      local restriced_class_function, list, chi, scalar_product;
      
      restriced_class_function := 
        RestrictedClassFunction( UnderlyingCharacter( irr ), sub_group );
      
      list := [];
      
      for chi in irr_sub_group do
          
          scalar_product := ScalarProduct( chi, restriced_class_function );
          
          if scalar_product > 0 then
              
              Add( list, [ scalar_product, chi ] );
              
          fi;
          
      od;
      
      return RepresentationCategoryObject( list, rep_sub_group );
      
    end;
    
    return
      FunctorByUniversalPropertyOfSemisimpleCategory(
        RepresentationCategory( group ), function_on_irreducibles, rep_sub_group );
    
end );

##
InstallMethod( MultiplicityArray,
               [ IsRepresentationCategoryZGradedObject ],
               
  function( object )
    local object_list, multiplicity_array, elem, z, deg, entry;
    
    object_list := SemisimpleCategoryObjectList( object );
    
    multiplicity_array := [ ];
    
    for elem in object_list do
        
        z := elem[2]!.UnderlyingDegree;
        
        if z > 0 then
            
            deg := 2*z;
          
        else
            
            deg := -2*z + 1;
          
        fi;
        
        if not IsBound( multiplicity_array[ deg ] ) then
            
            entry := [ ];
            
            entry[ elem[2]!.UnderlyingCharacterNumber ] := elem[1];
            
            multiplicity_array[ deg ] := entry;
            
        else
            
            multiplicity_array[ deg ][ elem[2]!.UnderlyingCharacterNumber ] := elem[1];
        
        fi;
        
    od;
    
    return multiplicity_array;
    
end );
