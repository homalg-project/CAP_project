LoadPackage( "CAP" );

#############################
##
## Categories
##
#############################

DeclareCategory( "IsStringsAsCategory",
                 IsCapCategory );

DeclareCategory( "IsObjectInStringsAsCategory",
                 IsCapCategoryObject );

DeclareCategory( "IsMorphismInStringsAsCategory",
                 IsCapCategoryMorphism );

#############################
##
## Constructors
##
#############################

DeclareOperation( "StringsAsCategory",
                  [] );

DeclareOperation( "StringsAsCategoryObject",
                  [ IsStringsAsCategory, IsString ] );

DeclareOperation( "StringsAsCategoryMorphism",
                  [ IsStringsAsCategory, IsObjectInStringsAsCategory, IsString, IsObjectInStringsAsCategory ] );

#############################
##
## Attributes
##
#############################

DeclareAttribute( "UnderlyingString",
                  IsObjectInStringsAsCategory );

DeclareAttribute( "UnderlyingString",
                  IsMorphismInStringsAsCategory );

#############################
##
## Constructors
##
#############################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_STRINGS_AS_CATEGORY" );

DeclareGlobalFunction( "RemovedCharacters" );

DeclareGlobalFunction( "DeleteVowels" );

InstallGlobalFunction( RemovedCharacters,
    function( str, chars )
        local copy;
        
        copy := ShallowCopy( str );
        
        RemoveCharacters( copy, chars );
        
        return copy;
        
end );

InstallGlobalFunction( DeleteVowels,
    function( str, n )
        local vowels;
        
        vowels := "aeiou";
        
        return RemovedCharacters( str , vowels{[1.. Minimum( Length( vowels ), n )]} );
        
end );

##
InstallMethod( StringsAsCategory,
               [ ],
               
  function( )
    local category;
    
    category := CreateCapCategoryWithDataTypes( "Category of strings up to vowels",
                                                IsStringsAsCategory,
                                                IsObjectInStringsAsCategory,
                                                IsMorphismInStringsAsCategory,
                                                IsCapCategoryTwoCell,
                                                IsStringRep,
                                                IsStringRep,
                                                fail );
    
    INSTALL_FUNCTIONS_FOR_STRINGS_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( StringsAsCategoryObject,
               [ IsStringsAsCategory, IsString ],
               
  function( cat, string )
    
    return CreateCapCategoryObjectWithAttributes( cat,
                                                  UnderlyingString, string );
    
end );

##
InstallMethod( StringsAsCategoryMorphism,
               [ IsStringsAsCategory, IsObjectInStringsAsCategory, IsString, IsObjectInStringsAsCategory ],
               
  function( cat, source, string, range )
    
    return CreateCapCategoryMorphismWithAttributes( cat,
                                                    source,
                                                    range,
                                                    UnderlyingString, string );
    
end );

#############################
##
## Basic operations
##
#############################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_STRINGS_AS_CATEGORY,
  
  function( category )
    local vec, tunit, vowels;
    
    vowels := "aeiou";
    
    ##
    AddIsEqualForObjects( category,
      function( cat, a, b )
      
        return UnderlyingString( a ) = UnderlyingString( b );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( cat, alpha, beta )
        
        return UnderlyingString( alpha ) = UnderlyingString( beta );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( cat, alpha, beta )
        
        return RemovedCharacters( UnderlyingString( alpha ), vowels ) = RemovedCharacters( UnderlyingString( beta ), vowels );
      
    end );
    
    AddIsWellDefinedForObjects( category,
      function( cat, a )
          
          return true;
          
    end);
    
    ##
    AddIsWellDefinedForMorphisms( category,
        function( cat, alpha )
            
            return RemovedCharacters( Concatenation( UnderlyingString( Source( alpha ) ), UnderlyingString( alpha ) ), vowels )
                = RemovedCharacters( UnderlyingString( Range( alpha ) ), vowels );
            
    end );
    
    ##
    AddPreCompose( category,
      function( cat, alpha, beta )
        
        return StringsAsCategoryMorphism( cat,
                                          Source( alpha ),
                                          Concatenation( UnderlyingString( alpha ), UnderlyingString( beta ) ),
                                          Range( beta ) );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( cat, a )
        
        return StringsAsCategoryMorphism( cat, a, "", a );
        
    end );
    
    ## SimplifyObject*
    ##
    AddSimplifyObject( category,
        function( cat, a, n )
            local min;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            min := Minimum( Length( vowels ), n );
            
            return StringsAsCategoryObject( cat, RemovedCharacters( UnderlyingString( a ) , vowels{[1..min]} ) );
            
    end );
    
    ##
    AddSimplifyObject_IsoFromInputObject( category,
        function( cat, a, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat, a, "", SimplifyObject( a, n ) );
            
    end );
    
    ##
    AddSimplifyObject_IsoToInputObject( category,
        function( cat, a, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat, SimplifyObject( a, n ), "", a);
            
    end );
    
    ## SimplifyMorphism
    ##
    AddSimplifyMorphism( category,
        function( cat, alpha, n )
            local min;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            min := Minimum( Length( vowels ), n );
            
            return StringsAsCategoryMorphism( cat,
                                              Source( alpha ),
                                              RemovedCharacters( UnderlyingString( alpha ) , vowels{[1..min]} ),
                                              Range( alpha ) );
            
    end );
    
    ## SimplifySource
    ##
    AddSimplifySource( category,
        function( cat, alpha, n )
            local new_source;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_source := StringsAsCategoryObject( cat, DeleteVowels( UnderlyingString( Source( alpha ) ), n ) );
            
            return StringsAsCategoryMorphism( cat,
                                              new_source,
                                              UnderlyingString( alpha ),
                                              Range( alpha ) );
            
    end );
    
    ##
    AddSimplifySource_IsoToInputObject( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Source( SimplifySource( alpha, n ) ),
                                              "",
                                              Source( alpha ) );
            
    end );
    
    ##
    AddSimplifySource_IsoFromInputObject( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Source( alpha ),
                                              "",
                                              Source( SimplifySource( alpha, n ) ) );
            
    end );
    
    ## SimplifyRange
    ##
    AddSimplifyRange( category,
        function( cat, alpha, n )
            local new_range;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_range := StringsAsCategoryObject( cat, DeleteVowels( UnderlyingString( Range( alpha ) ), n ) );
            
            return StringsAsCategoryMorphism( cat,
                                              Source( alpha ),
                                              UnderlyingString( alpha ),
                                              new_range );
            
    end );
    
    ##
    AddSimplifyRange_IsoToInputObject( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Range( SimplifyRange( alpha, n ) ),
                                              "",
                                              Range( alpha ) );
            
    end );
    
    ##
    AddSimplifyRange_IsoFromInputObject( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Range( alpha ),
                                              "",
                                              Range( SimplifyRange( alpha, n ) ) );
            
    end );
    
    ## SimplifySourceAndRange
    ##
    AddSimplifySourceAndRange( category,
        function( cat, alpha, n )
            local new_source, new_range;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_source := StringsAsCategoryObject( cat, DeleteVowels( UnderlyingString( Source( alpha ) ), n ) );
            
            new_range := StringsAsCategoryObject( cat, DeleteVowels( UnderlyingString( Range( alpha ) ), n ) );
            
            return StringsAsCategoryMorphism( cat,
                                              new_source,
                                              UnderlyingString( alpha ),
                                              new_range );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Source( SimplifySourceAndRange( alpha, n ) ),
                                              "",
                                              Source( alpha ) );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Source( alpha ),
                                              "",
                                              Source( SimplifySourceAndRange( alpha, n ) ) );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Range( SimplifySourceAndRange( alpha, n ) ),
                                              "",
                                              Range( alpha ) );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( category,
        function( cat, alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Range( alpha ),
                                              "",
                                              Range( SimplifySourceAndRange( alpha, n ) ) );
            
    end );
    
    ## SimplifyEndo
    ##
    AddSimplifyEndo( category,
        function( cat, endo, n )
            local new_object;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_object := StringsAsCategoryObject( category, DeleteVowels( UnderlyingString( Source( endo ) ), n ) );
            
            return StringsAsCategoryMorphism( cat,
                                              new_object,
                                              UnderlyingString( endo ),
                                              new_object );
            
    end );
    
     ##
    AddSimplifyEndo_IsoToInputObject( category,
        function( cat, endo, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Source( SimplifyEndo( endo, n ) ),
                                              "",
                                              Source( endo ) );
            
    end );
    
    ##
    AddSimplifyEndo_IsoFromInputObject( category,
        function( cat, endo, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( cat,
                                              Source( endo ),
                                              "",
                                              Source( SimplifyEndo( endo, n ) ) );
            
    end );
    
end );

#############################
##
## View
##
#############################

##
InstallMethod( ViewString,
               [ IsMorphismInStringsAsCategory ],

  function( alpha )
    
    return Concatenation( ViewString( Source( alpha ) ), " -- ", String( UnderlyingString( alpha ) ), " --> ", ViewString( Range( alpha ) ) );
    
end );

##
InstallMethod( ViewString,
               [ IsObjectInStringsAsCategory ],

  function( a )

    return String( UnderlyingString( a ) );

end );

