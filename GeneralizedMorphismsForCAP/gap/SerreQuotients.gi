#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsSerreQuotientCategoryObjectRep",
                       IsCapCategoryObjectRep and IsSerreQuotientCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsSerreQuotientCategoryObjectRep ) );

DeclareRepresentation( "IsSerreQuotientCategoryMorphismRep",
                       IsCapCategoryMorphismRep and IsSerreQuotientCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsSerreQuotientCategoryMorphismRep ) );

#############################################
##
## Installation method
##
#############################################

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    AddIsCongruentForMorphisms( category,
      
      function( morphism1, morphism2 )
        local underlying_general, new_morphism_aid new_general, sum_general,
              sum_associated, sum_image;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism2 );
        
        new_morphism_aid := AdditiveInverse( MorphismAid( underlying_general ) );
        
        new_general := GeneralizedMorphism( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        sum_general := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ), new_general );
        
        sum_associated := AssociatedMorphism( sum_general );
        
        sum_image := ImageObject( sum_associated );
        
        return membership_function( sum_image );
        
    end );
    
    AddIsEqualForObjects( category,
      
      function( obj1, obj2 )
        
        return IsEqualForObjects( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
    end );
    
    AddIsZeroForObjects( category,
      
      function( obj )
        
        return membership_function( UnderlyingHonestObject( obj ) );
        
    end );
    
    AddPrecompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( morphism1 ),
                                   UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryMorphism( category, composition );
        
    end );
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ),
                                     UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryMorphism( category, sum );
        
    end );
    
    AddIsZeroForMorphisms( category,
      
      function( morphism )
        local associated, image;
        
        associated := AssociatedMorphism( UnderlyingGeneralizedMorphism( morphism1 ) );
        
        image := ImageObject( associated );
        
        return membership_function( image );
        
    end );
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local underlying_general, new_morphism_aid, new_general;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        new_morphism_aid := AdditiveInverse( MorphismAid( underlying_general ) );
        
        new_general := GeneralizedMorphism( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        return SerreQuotientCategoryMorphism( category, new_general );
        
    end );
    
    AddZeroMorphism( category,
      
      function( source, range )
        local source_aid, range_aid, morphism_aid;
        
        source := UnderlyingHonestObject( source );
        
        range := UnderlyingHonestObject( range );
        
        source_aid := IdentityMorphism( source );
        
        range_aid := IdentityMorphism( range );
        
        morphism_aid := ZeroMorphism( source, range );
        
        return SerreQuotientCategoryMorphism( category, source_aid, morphism_aid, range_aid );
        
    end );
    
    AddZeroObject( category,
      
      function( )
        
        return AsSerreQuotientObject( category, ZeroObject( UnderlyingHonestCategory( category ) ) );
        
    end );
    
    
    

#############################################
##
## Constructor
##
#############################################

InstallMethod( SerreQuotientCategory,
               [ IsCapCategory, IsFunction ],
               
  function( category, test_function )
    local name;
    
    name := NameFunction( test_function );
    
    return SerreQuotientCategory( category, test_function, Concatenation( "test function with name: ", name ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategory,
                                  [ IsCapCategory, IsFunction, IsString ],
                                  
  function( category, test_function, function_name )
    local serre_category, gen_category, name;
    
    name := Name( category );
    
    name := Concatenation( "The Serre quotient category of ", name, " by ", function_name );
    
    serre_category := CreateCapCategory( name );
    
    SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategory );
    
    SetUnderlyingHonestCategory( serre_category, category );
    
    SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategory( category ) );
    
    SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
    return serre_category;
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientObject,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryObject ],
                                  
  function( serre_category, object )
    local honest_category, serre_object;
    
    honest_category := UnderlyingHonestCategory( serre_category );
    
    if not IsIdenticalObj( honest_category, CapCategory( object ) ) then
        
        Error( "object does not belong to underlying honest category of serre quotient" );
        
    fi;
    
    serre_object := rec( );
    
    ObjectifyWithAttributes( serre_object, TheTypeOfSerreQuotientCategoryObject );
    
    SetUnderlyingHonestObject( serre_object, object );
    
    SetUnderlyingGeneralizedObject( serre_object, GeneralizedMorphismObject( object ) );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( serre_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return serre_object;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsGeneralizedMorphism ],
                                  
  function( serre_category, gen_morphism )
    local honest_category, serre_morphism;
    
    if not IsIdenticalObj( UnderlyingGeneralizedMorphismCategory( serre_category ), CapCategory( gen_morphism ) ) then
        
        Error( "generalized morphism has wrong category" );
        
    fi;
    
    serre_morphism := rec( );
    
    ObjectifyWithAttributes( serre_morphism, TheTypeOfSerreQuotientCategoryMorphism,
                             Source, AsSerreQuotientObject( UnderlyingHonestObject( Source( gen_morphism ) ) ),
                             Range, AsSerreQuotientObject( UnderlyingHonestObject( Range( gen_morphism ) ) ) );
    
    SetUnderlyingGeneralizedMorphism( serre_morphism, gen_morphism );
    
    return serre_morphism;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated, range_aid )
    
    return SerreQuotientCategoryMorphism( serre_category, GeneralizedMorphism( source_aid, associated, range_aid ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphismWithSourceAid,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated )
    
    return SerreQuotientCategoryMorphism( serre_category, GeneralizedMorphismWithSourceAid( source_aid, associated ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphismWithRangeAid,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated, range_aid )
    
    return SerreQuotientCategoryMorphism( serre_category, GeneralizedMorphismWithRangeAid( associated, range_aid ) );
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated )
    
    return SerreQuotientCategoryMorphism( serre_category, AsGeneralizedMorphism( associated ) );
    
end );
