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
    
    AddIsZeroForObjects( serre_category,
                         
      function( obj )
        
        return test_function( UnderlyingHonestObject( obj ) );
        
    end );
    
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
    
    SetSourceAid( serre_morphism, SourceAid( gen_morphism ) );
    
    SetRangeAid( serre_morphism, RangeAid( gen_morphism ) );
    
    SetMorphismAid( serre_morphism, MorphismAid( gen_morphism ) );
    
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
