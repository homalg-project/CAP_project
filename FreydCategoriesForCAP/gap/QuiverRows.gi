#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#############################################################################

####################################
##
## Constructors
##
####################################

##
InstallMethod( QuiverRows,
               [ IsQuiverAlgebra ],
               
  function( underlying_quiver_algebra )
    local underlying_quiver, category;
    
    underlying_quiver := QuiverOfAlgebra( underlying_quiver_algebra );
    
    category := CreateCapCategory( Concatenation( "QuiverRows( ", String( underlying_quiver_algebra )," )"  ) );
    
    DeactivateCachingOfCategory( category );
    
    CapCategorySwitchLogicOff( category );
    
    SetFilterObj( category, IsQuiverRowsCategory );
    
    SetIsAdditiveCategory( category, true );
    
    SetUnderlyingQuiverAlgebra( category, underlying_quiver_algebra );
    
    SetUnderlyingQuiver( category, underlying_quiver );
    
    AddObjectRepresentation( category, IsQuiverRowsObject );
    
    AddMorphismRepresentation( category, IsQuiverRowsMorphism );
    
    INSTALL_FUNCTIONS_FOR_QUIVER_ROWS( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( QuiverRowsObject,
               [ IsList, IsQuiverRowsCategory ],
               
  function( list_of_vertices, category )
    local quiver_rows_object, s, L, v, vertex, current;
    
    quiver_rows_object := rec( );
    
    ## create normal form of list_of_vertices
    ## every object will be constructed via this constructor, thus,
    ## every object can be assumed to be in normal form
    ## [ [ vertex, multiplicity ], ... ]
    ## multiplicites > 0
    
    ## get rid of zeros (and negative integers)
    list_of_vertices := Filtered( list_of_vertices, l -> IsPosInt( l[2] ) );
    
    ## collect consecutive vertices
    s := Size( list_of_vertices );
    
    if s > 1 then
        
        L := [];
        
        current := ShallowCopy( list_of_vertices[1] );
        
        for v in [ 2 .. s ] do
            
            vertex := list_of_vertices[v];
            
            if vertex[1] = current[1] then
                
                current[2] := current[2] + vertex[2];
                
            else
                
                Add( L, current );
                
                current := ShallowCopy( vertex );
                
            fi;
            
        od;
        
        Add( L, current );
        
    else
        
        L := list_of_vertices;
        
    fi;
    
    ObjectifyObjectForCAPWithAttributes(
        quiver_rows_object, category,
        ListOfQuiverVertices, L
    );

    Add( category, quiver_rows_object );
    
    return quiver_rows_object;
    
end );

##
InstallMethod( QuiverRowsMorphism,
               [ IsQuiverRowsObject, IsList, IsQuiverRowsObject ],
               
  function( source, matrix, range )
    local quiver_rows_morphism, category;
    
    quiver_rows_morphism := rec( );
    
    category := CapCategory( source );

    ObjectifyMorphismForCAPWithAttributes( 
                             quiver_rows_morphism, category,
                             Source, source,
                             Range, range,
                             MorphismMatrix, matrix
    );

    Add( category, quiver_rows_morphism );
    
    return quiver_rows_morphism;
    
end );

##
InstallMethod( NrRows,
               [ IsQuiverRowsMorphism ],
               
  function( morphism )
    
    return NrSummands( Source( morphism ) );
    
end );

##
InstallMethod( NrColumns,
               [ IsQuiverRowsMorphism ],
               
  function( morphism )
    
    return NrSummands( Range( morphism ) );
    
end );

##
InstallMethod( \[\],
               [ IsQuiverRowsMorphism, IsInt ],
               
  function( morphism, i )
    
    if not ( i >= 1 ) and ( i <= NrRows( morphism ) ) then
        
        Error( "bad index" );
        
    fi;
    
    if NrColumns( morphism ) = 0 then
        
        return [ ];
        
    fi;
    
    return MorphismMatrix( morphism )[i];
    
end );

##
InstallMethod( NrSummands,
               [ IsQuiverRowsObject ],
               
    function( object )
      
      return Sum( List( ListOfQuiverVertices( object ), l -> l[2] ) );
      
end );

##
InstallMethod( \[\],
               [ IsQuiverRowsObject, IsInt ],
               
  function( object, i )
    local list, current, l;
    
    if not ( ( i >= 1 ) and ( i <= NrSummands( object ) ) ) then
        
        Error( "bad index" );
        
    fi;
    
    list := ListOfQuiverVertices( object );
    
    current := 0;
    
    for l in list do
        
        current := current + l[2];
        
        if current >= i then
            
            return l[1];
            
        fi;
        
    od;
    
    Error( "Bug in []-Operator for IsQuiverRowsObject" );
    
end );



####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_QUIVER_ROWS,
  
  function( category )
    local algebra, quiver, zero, IDENTITY_MATRIX_QUIVER_ROWS, ZERO_MATRIX_QUIVER_ROWS;
    
    algebra := UnderlyingQuiverAlgebra( category );
    
    quiver := UnderlyingQuiver( category );
    
    zero := Zero( algebra );
    
    ##
    ZERO_MATRIX_QUIVER_ROWS := function( nr_rows, nr_cols )
        
        if nr_rows = 0 or nr_cols = 0 then
            
            return [];
            
        fi;
        
        return NullMat( nr_rows, nr_cols, algebra );
        
    end;
    
    ##
    IDENTITY_MATRIX_QUIVER_ROWS := function( object )
        local size, list, l, mat, row, counter, v, id, j;
        
        size := NrSummands( object );
        
        if size = 0 then
            
            return [];
            
        fi;
        
        list := ListOfQuiverVertices( object );
        
        mat := [];
        
        counter := 1;
        
        for l in list do
            
            v := l[1];
            
            id := PathAsAlgebraElement( algebra, v );
            
            for j in [ counter .. counter + (l[2] - 1) ] do
                
                row := List( [ 1 .. size ], i -> zero );
                
                row[j] := id;
                
                Add( mat, row );
                
            od;
            
            counter := counter + l[2];
            
        od;
        
        return mat;
        
    end;
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        local list;
        
        list := ListOfQuiverVertices( object );
        
        if IsEmpty( list ) then
            
            return true;
            
        fi;
        
        if not ForAll( list, l -> IsList( l ) and Size( l ) = 2 ) then
            
            return false;
            
        fi;
        
        if not ForAll( list, l -> IsQuiverVertex( l[1] ) and IsPosInt( l[2] ) ) then
            
            return false;
            
        fi;
        
        if not ForAll( list, l -> l[1] in quiver ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local matrix, nr_rows, nr_cols, source, range, i, j, m, v, w;
        
        matrix := MorphismMatrix( morphism );
        
        nr_rows := NrRows( morphism );
        
        nr_cols := NrColumns( morphism );
        
        if nr_rows = 0 or nr_cols = 0 then
            
            return IsEmpty( matrix );
            
        fi;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        for i in [ 1 .. nr_rows ] do
            
            for j in [ 1 .. nr_cols ] do
                
                m := matrix[i][j];
                
                if not (m in algebra) then
                    Print( "1");
                    return false;
                    
                fi;
                
                if not IsZero( m ) then
                    
                    if not IsUniform( m ) then
                        
                        return false;
                        
                    fi;
                    
                    if IsQuotientOfPathAlgebraElement( m ) then
                        
                        m := Representative( m );
                        
                    fi;
                    
                    v := Source( LeadingPath( m ) ); 
                        
                    if not ( source[i] = v ) then
                        
                        return false;
                        
                    fi;
                    
                    w := Target( LeadingPath( m ) );
                    
                    if not ( range[j] = w ) then
                        
                        return false;
                        
                    fi;
                    
                fi;
                
            od;
            
        od;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( A, B )
        
        return ListOfQuiverVertices( A ) = ListOfQuiverVertices( B );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( alpha, beta )
        
        return MorphismMatrix( alpha ) = MorphismMatrix( beta );
        
    end );
    
    ## Basic Operations for a Category
    
    ##
    AddIdentityMorphism( category,
      
      function( object )
        
        return QuiverRowsMorphism( object, IDENTITY_MATRIX_QUIVER_ROWS( object ), object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        
        return QuiverRowsMorphism( source, ZERO_MATRIX_QUIVER_ROWS( NrSummands( source ), NrSummands( range ) ), range );
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        local A, B, C, mat;
        
        A := Source( alpha );
        
        B := Range( alpha );
        
        C := Range( beta );
        
        if NrSummands( A ) = 0 or NrSummands( B ) = 0 or NrSummands( C ) = 0 then
            
            return QuiverRowsMorphism( A, [], C );
            
        fi;
        
        mat := MorphismMatrix( alpha ) * MorphismMatrix( beta );
        
        return QuiverRowsMorphism( A, mat, C );
        
    end );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( alpha )
        local matrix, r, c;
        
        matrix := MorphismMatrix( alpha );
        
        if IsEmpty( matrix ) then
            
            return true;
            
        fi;
        
        for r in matrix do
            
            for c in r do
                
                if not IsZero( c ) then
                    
                    return false;
                    
                fi;
                
            od;
            
        od;
        
        return true;
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( alpha, beta )
        
        return QuiverRowsMorphism( Source( alpha ),
                                   MorphismMatrix( alpha ) + MorphismMatrix( beta ),
                                   Range( beta ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( alpha )
        
        return QuiverRowsMorphism( Source( alpha ),
                                   -MorphismMatrix( alpha ),
                                   Range( alpha ) );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return QuiverRowsObject( [ ], category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        
        return QuiverRowsMorphism( sink, [ ], zero_object );
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        
        return QuiverRowsMorphism( zero_object, [ ], source );
        
    end );
    
    ##
    AddDirectSum( category,
      function( list )
        
        return QuiverRowsObject( Concatenation( List( list, ListOfQuiverVertices ) ), category );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( list, projection_number, direct_sum_object )
        local range, nr_cols, pre_matrix, id_matrix, post_matrix;
        
        range := list[projection_number];
        
        nr_cols := NrSummands( range );
        
        if NrSummands( direct_sum_object ) = 0 or nr_cols = 0 then
            
            return QuiverRowsMorphism( direct_sum_object, [], range );
            
        fi;
        
        pre_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [ 1 .. projection_number - 1 ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        id_matrix := IDENTITY_MATRIX_QUIVER_ROWS( range );
        
        post_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [projection_number + 1 .. Size( list ) ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        return QuiverRowsMorphism( direct_sum_object,
                                   Concatenation( pre_matrix, id_matrix, post_matrix ),
                                   range );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( list, injection_number, direct_sum_object )
        local source, nr_cols, pre_matrix, id_matrix, post_matrix;
        
        source := list[injection_number];
        
        nr_cols := NrSummands( source );
        
        if NrSummands( direct_sum_object ) = 0 or nr_cols = 0 then
            
            return QuiverRowsMorphism( source, [], direct_sum_object );
            
        fi;
        
        pre_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [ 1 .. injection_number - 1 ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        id_matrix := IDENTITY_MATRIX_QUIVER_ROWS( source );
        
        post_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [injection_number + 1 .. Size( list ) ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        return QuiverRowsMorphism( source,
                                   Transpose( Concatenation( pre_matrix, id_matrix, post_matrix ) ),
                                   direct_sum_object );
        
    end );
    
    # ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum )
        local test_object, mat;
        
        test_object := Source( source[1] );
        
        nr_rows := NrSummands( test_object );
        
        if NrSummands( direct_sum ) = 0 or nr_rows = 0 then
            
            return QuiverRowsMorphism( test_object, [], direct_sum );
            
        fi;
        
        mat := List( [ 1 .. nr_rows ], i -> Concatenation( List( source, tau -> tau[i] ) ) );
        
        return QuiverRowsMorphism( test_object, mat, direct_sum );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local test_object, mat;
        
        test_object := Range( sink[1] );
        
        if NrSummands( direct_sum ) = 0 or NrSummands( test_object ) = 0 then
            
            return QuiverRowsMorphism( direct_sum, [], test_object );
            
        fi;
        
        mat := Concatenation( List( sink, MorphismMatrix ) );
        
        return QuiverRowsMorphism( direct_sum, mat, test_object );
        
    end );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsQuiverRowsObject ],
               
  function( object )
    
    Display( ListOfQuiverVertices( object ) );
    
end );

##
InstallMethod( Display,
               [ IsQuiverRowsMorphism ],
               
  function( morphism )
    
    Display( MorphismMatrix( morphism ) );
    
end );