
LoadPackage( "CAP" );

DeclareCategory( "IsCategoryOfHomalgIntegers",
                 IsCapCategory );

DeclareCategory( "IsObjectInCategoryOfHomalgIntegers",
                 IsCapCategoryObject );

DeclareCategory( "IsMorphismInCategoryOfHomalgIntegers",
                 IsCapCategoryMorphism );

############################
##
## Attributes
##
############################

DeclareAttribute( "UnderlyingInteger",
                  IsObjectInCategoryOfHomalgIntegers );

############################
##
## Category
##
############################

integer_category := CreateCapCategory( "HomalgIntegers",
                                       IsCategoryOfHomalgIntegers,
                                       IsObjectInCategoryOfHomalgIntegers,
                                       IsMorphismInCategoryOfHomalgIntegers,
                                       IsCapCategoryTwoCell );

#############################
##
## Constructors
##
#############################

DeclareOperation( "HomalgInteger",
                  [ IsInt ] );

##
InstallMethodWithCache( HomalgInteger,
                        [ IsInt ],
                        
  function( integer )
    
    return CreateCapCategoryObjectWithAttributes( integer_category,
                                                  UnderlyingInteger, integer );
    
end );

DeclareOperation( "HomalgIntegerMorphism",
                  [ IsInt, IsInt ] );

##
InstallMethod( HomalgIntegerMorphism,
               [ IsInt, IsInt ],
               
  function( source, range )
    
    return HomalgIntegerMorphism( HomalgInteger( source ), HomalgInteger( range ) );
    
end );

DeclareOperation( "HomalgIntegerMorphism",
                  [ IsObjectInCategoryOfHomalgIntegers, IsObjectInCategoryOfHomalgIntegers ] );

##
InstallMethodWithCache( HomalgIntegerMorphism,
                        [ IsObjectInCategoryOfHomalgIntegers, IsObjectInCategoryOfHomalgIntegers ],
                        
  function( source, range )
    
    if UnderlyingInteger( range ) < UnderlyingInteger( source ) then
        
        Error( "such a morphism does not exist" );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( integer_category,
                                                    source,
                                                    range );
    
end );

##
AddIsCongruentForMorphisms( integer_category,
                         
  function( cat, mor1, mor2 )
      
      return true;
      
end );

##
AddIsZeroForMorphisms( integer_category,
                       
  function( cat, a )
    
    return true;
    
end );

##
AddAdditionForMorphisms( integer_category,
                         
  function( cat, a, b )
    
    return a;
    
end );

##
AddAdditiveInverseForMorphisms( integer_category,
                                
  function( cat, mor )

    return mor;
  
end );

##
AddZeroMorphism( integer_category,
                 
  function( cat, a, b )
    
    return HomalgIntegerMorphism( a, b );
    
end );

##
AddIdentityMorphism( integer_category,
                     
  function( cat, obj )
    
    return HomalgIntegerMorphism( obj, obj );
    
end );

##
AddPreCompose( integer_category,
               
  function( cat, mor1, mor2 )
    
    return HomalgIntegerMorphism( Source( mor1 ), Range( mor2 ) );
    
end );

#
AddFiberProduct( integer_category,
             
  function( cat, product_mor )
    local pullback;
    
    pullback := Gcd( List( product_mor, i -> UnderlyingInteger( Source( i ) ) ) );
    
    return HomalgInteger( pullback );
    
end );

##
AddProjectionInFactorOfFiberProductWithGivenFiberProduct( integer_category,
                                 
  function( cat, product_morx, coordinate, pullback )
    local range;
    
    range := Source( product_morx[ coordinate ] );
    
    return HomalgIntegerMorphism( pullback, range );
    
end );

##
AddPushout( integer_category,
            
  function( cat, product_mor )
    local pushout;
    
    pushout := Lcm( List( product_mor, i -> UnderlyingInteger( Range( i ) ) ) );
    
    return HomalgInteger( pushout );
    
end );

##
AddInjectionOfCofactorOfPushoutWithGivenPushout( integer_category,
                                 
  function( cat, product_mor, coordinate, pushout )
    local source;
    
    source := Range( product_mor[ coordinate ] );
    
    return HomalgIntegerMorphism( source, pushout );
    
end );

##
AddLiftAlongMonomorphism( integer_category,
                     
  function( cat, monomorphism, test_morphism )
    
    return HomalgIntegerMorphism( Source( test_morphism ), Source( monomorphism ) );
    
end );

###################################
##
## View
##
###################################

##
InstallMethod( ViewString,
               [ IsObjectInCategoryOfHomalgIntegers ],
               
  function( integer_obj )
    
    return Concatenation( "<The integer object representing ", String( UnderlyingInteger( integer_obj ) ), ">" );
    
end );

##
InstallMethod( ViewString,
               [ IsMorphismInCategoryOfHomalgIntegers ],
               
  function( integer_mor )
    
    return Concatenation( "<", String( UnderlyingInteger( Source( integer_mor ) ) ), " -> ", String( UnderlyingInteger( Range( integer_mor ) ) ), ">" );
    
end );

