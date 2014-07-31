
LoadPackage( "CategoriesForHomalg" );

DeclareRepresentation( "IsHomalgIntegerRep",
                       IsHomalgCategoryObjectRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgIntegers",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgIntegerRep ) );

DeclareRepresentation( "IsHomalgIntegerMorphismRep",
                       IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgIntegerMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
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

integer_category := CreateHomalgCategory( "Integers" );

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
    
    homalg_integer := rec( );
    
    ObjectifyWithAttributes( homalg_integer, TheTypeOfHomalgIntegers,
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
        
        ErrorNoTraceBack( "such a morphism does not exist" );
        
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
        
        ErrorNoTraceBack( "such a morphism does not exist" );
        
    fi;
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgIntegerMorphism,
                             Source, source,
                             Range, range );
    
    Add( integer_category, morphism );
    
    return morphism;
    
end );

##
AddEqualityForMorphisms( integer_category,
                         
  ReturnTrue );

##
AddIsZeroForMorphisms( integer_category,
                       
  ReturnTrue );

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
