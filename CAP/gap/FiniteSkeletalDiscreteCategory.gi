# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

InstallTrueMethod( IsDiscreteCategory, IsTerminalCategory );

####################################
#
# Constructor
#
####################################

##
InstallGlobalFunction( FiniteSkeletalDiscreteCategory,
                       
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, list_of_gap_objects )
    local name, D;
    
    name := Concatenation( "FiniteSkeletalDiscreteCategory( ", String( list_of_gap_objects ), " )" );
    
    D := CreateCapCategoryWithDataTypes( name,
                                         IsFiniteSkeletalDiscreteCategory,
                                         IsObjectInFiniteSkeletalDiscreteCategory,
                                         IsMorphismInFiniteSkeletalDiscreteCategory,
                                         IsCapCategoryTwoCell,
                                         rec( category := false,
                                              filter := IsObject ),
                                         fail,
                                         fail );
    
    D!.compiler_hints := rec( category_attribute_names := [ "UnderlyingListOfGAPObjects" ] );
    
    SetUnderlyingListOfGAPObjects( D, list_of_gap_objects );
    
    SetIsFiniteCategory( D, true );
    
    SetIsDiscreteCategory( D, true );
    
    SetIsSkeletalCategory( D, true );
    
    ####################################
    #
    # Primitive operations
    #
    ####################################
    
    ##
    AddObjectConstructor( D,
      function( D, gap_object )
        
        if not gap_object in UnderlyingListOfGAPObjects( D ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<gap_object> does not belong to the underlying list of objects\n" );
            
        fi;
        
        return CreateCapCategoryObjectWithAttributes( D,
                                                      UnderlyingGAPObject, gap_object );
        
    end );
    
    ##
    AddObjectDatum( D,
      function( D, object )
        
        return UnderlyingGAPObject( object );
        
    end );
    
    ##
    AddMorphismConstructor( D,
      function( D, source, m, target )
        
        if not IsEqualForObjects( D, source, target ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<source> and <target> must be equal\n" );
            
        fi;
        
        return CreateCapCategoryMorphismWithAttributes( D, source, target );
        
    end );
    
    ##
    AddMorphismDatum( D, { D, morphism } -> fail );
    
    ##
    AddIsWellDefinedForObjects( D,
        { D, object } -> UnderlyingGAPObject( object ) in UnderlyingListOfGAPObjects( D ) );
    
    ##
    AddIsWellDefinedForMorphisms( D,
      function( D, morphism )
        
        return IsEndomorphism( D, morphism ) and IsOne( D, morphism );
        
    end );
    
    AddIsEqualForObjects( D,
      function( D, object_1, object_2 )
        
        return UnderlyingGAPObject( object_1 ) = UnderlyingGAPObject( object_2 );
        
    end );
    
    ##
    AddIsEqualForMorphisms( D,
      function( D, morphism_1, morphism_2 )
        
        return true;
        
    end );
    
    ##
    AddIdentityMorphism( D,
      function( D, object )
        
        return MorphismConstructor( D, object, fail, object );
        
    end );
    
    ##
    AddPreCompose( D,
      function( D, morphism_1, morphism_2 )
        
        return morphism_1;
        
    end );
    
    ##
    AddSetOfObjectsOfCategory( D,
      function( D )
        
        return List( UnderlyingListOfGAPObjects( D ), obj -> ObjectConstructor( D, obj ) );
        
    end );
    
    ##
    AddSetOfMorphismsOfFiniteCategory( D,
      function( D )
        
        return List( SetOfObjectsOfCategory( D ), obj -> IdentityMorphism( D, obj ) );
        
    end );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( D );
        
    fi;
    
    return D;
    
end ) );

#################################
#
# View & Display
#
#################################

##
InstallMethod( DisplayString,
        [ IsObjectInFiniteSkeletalDiscreteCategory ],

  function( object )
    
    return Concatenation( String( UnderlyingGAPObject( object ) ), "\n" );
    
end );

##
InstallMethod( DisplayString,
        [ IsMorphismInFiniteSkeletalDiscreteCategory ],

  function( morphism )
    
    return Concatenation( DisplayString( Source( morphism ) ),
                          "|\n| ",
                          String( morphism ),
                          "\nv\n",
                          DisplayString( Target( morphism ) ) );
    
end );

