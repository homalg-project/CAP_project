LoadPackage( "CAP" );

##
DeclareCategory( "IsStringsAsCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsStringsAsCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_STRINGS_AS_CATEGORY" );

DeclareGlobalFunction( "RemovedCharacters" );

DeclareGlobalFunction( "DeleteVowels" );

DeclareGlobalVariable( "STRINGS_AS_CATEGORY" );

DeclareCategory( "IsStringsAsCategory",
                 IsCapCategory );

## Constructors
DeclareOperation( "StringsAsCategory",
                  [] );

DeclareOperation( "StringsAsCategoryObject",
                  [ IsString, IsCapCategory ] );

DeclareOperation( "StringsAsCategoryMorphism",
                  [ IsStringsAsCategoryObject, IsString, IsStringsAsCategoryObject ] );

## Attributes

DeclareAttribute( "UnderlyingString",
                  IsStringsAsCategoryObject );

DeclareAttribute( "UnderlyingString",
                  IsStringsAsCategoryMorphism );

## Constructors

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
    
    category := CreateCapCategory( "Category of strings up to vowels" );
    
    SetFilterObj( category, IsStringsAsCategory );
    
    AddObjectRepresentation( category, IsStringsAsCategoryObject );
    
    AddMorphismRepresentation( category, IsStringsAsCategoryMorphism and HasUnderlyingString );

    INSTALL_FUNCTIONS_FOR_STRINGS_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );


##
InstallMethod( ViewObj,
               [ IsStringsAsCategoryMorphism ],

  function( alpha )
    ViewObj( Source( alpha ) );
    
    Print( Concatenation( " -- ", String( UnderlyingString( alpha ) ), " --> " ) );
    
    ViewObj( Range( alpha ) );
    
end );

##
InstallMethod( ViewObj,
               [ IsStringsAsCategoryObject ],

  function( a )

    Print( String( UnderlyingString( a ) ) );

end );

## Basic operations

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_STRINGS_AS_CATEGORY,
  
  function( category )
    local vec, tunit, vowels;
    
    vowels := "aeiou";
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForObjects( category,
      function( a, b )
      
        return UnderlyingString( a ) = UnderlyingString( b );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( alpha, beta )
        
        return UnderlyingString( alpha ) = UnderlyingString( beta );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( alpha, beta )
        
        return RemovedCharacters( UnderlyingString( alpha ), vowels ) = RemovedCharacters( UnderlyingString( beta ), vowels );
      
    end );
    
    AddIsWellDefinedForObjects( category, ReturnTrue );
    
    ##
    AddIsWellDefinedForMorphisms( category,
        function( alpha )
            
            return RemovedCharacters( Concatenation( UnderlyingString( Source( alpha ) ), UnderlyingString( alpha ) ), vowels )
                = RemovedCharacters( UnderlyingString( Range( alpha ) ), vowels );
            
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        
        return StringsAsCategoryMorphism(
                Source( alpha ),
                Concatenation( UnderlyingString( alpha ), UnderlyingString( beta ) ),
                Range( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( a )
        
        return StringsAsCategoryMorphism(
           a,
           "",
           a
        );
        
    end );
    
    ## SimplifyObject*
    ##
    AddSimplifyObject( category,
        function( a, n )
            local min;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            min := Minimum( Length( vowels ), n );
            
            return StringsAsCategoryObject( RemovedCharacters( UnderlyingString( a ) , vowels{[1..min]} ), category );
            
    end );
    
    ##
    AddSimplifyObject_IsoFromInputObject( category,
        function( a, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                a,
                "",
                SimplifyObject( a, n )
            );
            
    end );
    
    ##
    AddSimplifyObject_IsoToInputObject( category,
        function( a, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                SimplifyObject( a, n ),
                "",
                a
            );
            
    end );
    
    ## SimplifyMorphism
    ##
    AddSimplifyMorphism( category,
        function( alpha, n )
            local min;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            min := Minimum( Length( vowels ), n );
            
            return StringsAsCategoryMorphism( 
                    Source( alpha ),
                    RemovedCharacters( UnderlyingString( alpha ) , vowels{[1..min]} ),
                    Range( alpha )
             );
            
    end );
    
    ## SimplifySource
    ##
    AddSimplifySource( category,
        function( alpha, n )
            local new_source;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_source := StringsAsCategoryObject( DeleteVowels( UnderlyingString( Source( alpha ) ), n ), category );
            
            return StringsAsCategoryMorphism( 
                    new_source,
                    UnderlyingString( alpha ),
                    Range( alpha )
             );
            
    end );
    
    ##
    AddSimplifySource_IsoToInputObject( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Source( SimplifySource( alpha, n ) ),
                "",
                Source( alpha )
            );
            
    end );
    
    ##
    AddSimplifySource_IsoFromInputObject( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Source( alpha ),
                "",
                Source( SimplifySource( alpha, n ) )
            );
            
    end );
    
    ## SimplifyRange
    ##
    AddSimplifyRange( category,
        function( alpha, n )
            local new_range;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_range := StringsAsCategoryObject( DeleteVowels( UnderlyingString( Range( alpha ) ), n ), category );
            
            return StringsAsCategoryMorphism( 
                    Source( alpha ),
                    UnderlyingString( alpha ),
                    new_range
                    
             );
            
    end );
    
    ##
    AddSimplifyRange_IsoToInputObject( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Range( SimplifyRange( alpha, n ) ),
                "",
                Range( alpha )
            );
            
    end );
    
    ##
    AddSimplifyRange_IsoFromInputObject( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Range( alpha ),
                "",
                Range( SimplifyRange( alpha, n ) )
            );
            
    end );
    
    ## SimplifySourceAndRange
    ##
    AddSimplifySourceAndRange( category,
        function( alpha, n )
            local new_source, new_range;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_source := StringsAsCategoryObject( DeleteVowels( UnderlyingString( Source( alpha ) ), n ), category ); 
            
            new_range := StringsAsCategoryObject( DeleteVowels( UnderlyingString( Range( alpha ) ), n ), category );
            
            return StringsAsCategoryMorphism( 
                    new_source,
                    UnderlyingString( alpha ),
                    new_range
                    
             );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Source( SimplifySourceAndRange( alpha, n ) ),
                "",
                Source( alpha )
            );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Source( alpha ),
                "",
                Source( SimplifySourceAndRange( alpha, n ) )
            );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Range( SimplifySourceAndRange( alpha, n ) ),
                "",
                Range( alpha )
            );
            
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( category,
        function( alpha, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Range( alpha ),
                "",
                Range( SimplifySourceAndRange( alpha, n ) )
            );
            
    end );
    
    ## SimplifyEndo
    ##
    AddSimplifyEndo( category,
        function( endo, n )
            local new_object;
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            new_object := StringsAsCategoryObject( DeleteVowels( UnderlyingString( Source( endo ) ), n ), category ); 
            
            return StringsAsCategoryMorphism( 
                    new_object,
                    UnderlyingString( endo ),
                    new_object
                    
             );
            
    end );
    
     ##
    AddSimplifyEndo_IsoToInputObject( category,
        function( endo, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Source( SimplifyEndo( endo, n ) ),
                "",
                Source( endo )
            );
            
    end );
    
    ##
    AddSimplifyEndo_IsoFromInputObject( category,
        function( endo, n )
            
            if n = 0 then
                Print( "this case must not be handled here" );
            fi;
            
            return StringsAsCategoryMorphism( 
                Source( endo ),
                "",
                Source( SimplifyEndo( endo, n ) )
            );
            
    end );
    
end );


##
InstallMethod( StringsAsCategoryObject,
               [ IsString, IsCapCategory ],
               
  function( string, category )
    local object;
    
    object := ObjectifyObjectForCAPWithAttributes( rec( ), category,
                                                   UnderlyingString, string
    );
    
    Add( category, object );
    
    return object;
    
end );

##
InstallMethod( StringsAsCategoryMorphism,
               [ IsStringsAsCategoryObject, IsString, IsStringsAsCategoryObject ],
               
  function( source, string, range )
    local morphism, category;
    
    category := CapCategory( source );
    
    morphism := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), category,
                                           source,
                                           range,
                                           UnderlyingString, string
    );
    
    Add( category, morphism );
    
    return morphism;
    
end );

