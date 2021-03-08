
LoadPackage( "CAP" );

DeclareRepresentation( "IsHomalgIntegerRep",
                       IsCapCategoryObjectRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgIntegers",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomalgIntegerRep ) );

DeclareRepresentation( "IsHomalgIntegerMorphismRep",
                       IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgIntegerMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsHomalgIntegerMorphismRep ) );

############################
##
## Attributes
##
############################

DeclareAttribute( "AsInteger",
                  IsHomalgIntegerRep );

############################
##
## Category
##
############################

integer_category := CreateCapCategory( "Integers" );

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
    local homalg_integer;
    
    homalg_integer := ObjectifyWithAttributes( rec( ), TheTypeOfHomalgIntegers,
                                               AsInteger, integer );
    
    Add( integer_category, homalg_integer );
    
    return homalg_integer;
    
end );

DeclareOperation( "HomalgIntegerMorphism",
                  [ IsInt, IsInt ] );

##
InstallMethod( HomalgIntegerMorphism,
               [ IsInt, IsInt ],
               
  function( source, range )
    
    if range < source then
        
        Error( "such a morphism does not exist" );
        
    fi;
    
    return HomalgIntegerMorphism( HomalgInteger( source ), HomalgInteger( range ) );
    
end );

DeclareOperation( "HomalgIntegerMorphism",
                  [ IsHomalgIntegerRep, IsHomalgIntegerRep ] );

##
InstallMethodWithCache( HomalgIntegerMorphism,
                        [ IsHomalgIntegerRep, IsHomalgIntegerRep ],
                        
  function( source, range )
    local morphism;
    
    if AsInteger( range ) < AsInteger( source ) then
        
        Error( "such a morphism does not exist" );
        
    fi;
    
    morphism := ObjectifyWithAttributes( rec( ), TheTypeOfHomalgIntegerMorphism,
                                         Source, source,
                                         Range, range );
    
    Add( integer_category, morphism );
    
    return morphism;
    
end );

##
AddIsCongruentForMorphisms( integer_category,
                         
  ReturnTrue );

##
AddIsZeroForMorphisms( integer_category,
                       
  function( a )
    
    return true;
    
end );

##
AddAdditionForMorphisms( integer_category,
                         
  function( a, b )
    
    return a;
    
end );

##
AddAdditiveInverseForMorphisms( integer_category,
                                
  IdFunc );

##
AddZeroMorphism( integer_category,
                 
  function( a, b )
    
    return HomalgIntegerMorphism( a, b );
    
end );

##
AddIdentityMorphism( integer_category,
                     
  function( obj )
    
    return HomalgIntegerMorphism( obj, obj );
    
end );

##
AddPreCompose( integer_category,
               
  function( mor1, mor2 )
    
    return HomalgIntegerMorphism( Source( mor1 ), Range( mor2 ) );
    
end );

#
AddFiberProduct( integer_category,
             
  function( product_mor )
    local pullback;
    
    pullback := Gcd( List( product_mor, i -> AsInteger( Source( i ) ) ) );
    
    return HomalgInteger( pullback );
    
end );

##
AddProjectionInFactorOfFiberProductWithGivenFiberProduct( integer_category,
                                 
  function( product_morx, coordinate, pullback )
    local range;
    
    range := Source( product_mor[ coordinate ] );
    
    return HomalgIntegerMorphism( pullback, range );
    
end );


##
AddPushout( integer_category,
            
  function( product_mor )
    local pushout;
    
    pushout := Lcm( List( product_mor, i -> AsInteger( Range( i ) ) ) );
    
    return HomalgInteger( pushout );
    
end );

##
AddInjectionOfCofactorOfPushoutWithGivenPushout( integer_category,
                                 
  function( product_mor, coordinate, pushout )
    local source;
    
    source := Range( product_mor[ coordinate ] );
    
    return HomalgIntegerMorphism( source, pushout );
    
end );

##
AddLiftAlongMonomorphism( integer_category,
                     
  function( monomorphism, test_morphism )
    
    return HomalgIntegerMorphism( Source( test_morphism ), Source( monomorphism ) );
    
end );

##


###################################
##
## View
##
###################################

##
InstallMethod( ViewObj,
               [ IsHomalgIntegerRep ],
               
  function( integer_obj )
    
    Print( "<The integer object representing " );
    
    Print( String( AsInteger( integer_obj ) ) );
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
               [ IsHomalgIntegerMorphismRep ],
               
  function( integer_mor )
    
    Print( "<" );
    
    Print( String( AsInteger( Source( integer_mor ) ) ) );
    
    Print( " -> " );
    
    Print( String( AsInteger( Range( integer_mor ) ) ) );
    
    Print( ">" );
    
end );
